#!/usr/bin/perl
use File::Spec;
use File::Basename;
use POSIX;
use Cwd 'abs_path';

use warnings;
use strict;

no warnings 'experimental::smartmatch';

die("No argument provided for file\n") unless($ARGV[0]);
die("No file at $ARGV[0]\n") unless(-e $ARGV[0]);
my $fifo_name = $ARGV[1];
$fifo_name = 'fifo.p8' unless($ARGV[1]);

sub parse {
  my ($cart_file, $out, $required, $expected) = @_;
  my $base_path = dirname($cart_file);

  open(my $code, '<:encoding(Windows-1252)', $cart_file)
  or warn "Could not open file '$cart_file' for reading. $!";

  while(my $row = <$code>) {
    my @expect_copy = @$expected;
    my $i = 0;
    foreach my $pattern (@expect_copy) {
      if($row =~ /$pattern/) {
        # print "removing expected pattern $pattern\n";
        splice @$expected, $i, 1;
        $i--;
      }
      $i++;
    }
    if($row =~ /^\s*\-\- expect (.*?)$/) {
      my $expect
      = $1;
      push(@$expected,$expect);
      # print "Adding expected pattern $expect\n";
    } elsif($row =~ /^\s*\-\- require (.+?)$/) {
      my $original = $1;
      my $require = $original;
      if($require !~ /\.\w+$/){ $require .= '.lua'; }
      my $local = File::Spec->rel2abs($require, $base_path);
      if(-e $local) { $require = $local }
      else { $require = abs_path("lib/$require"); }
      if(!-e $require) {
        print "ERROR: $original doesn't exist!\a\n";
        return
      }
      unless($require ~~ @$required) {
        push(@$required,$require);
        # print "Requiring $original\n";
        open my ($output_row), '>', \$row;
        parse($require, $output_row, $required, $expected);
        close $output_row;
      }
    }
    print $out $row;
  }
  close $code;
}
sub death {
  unlink('fifo.p8');
  die "\nCaught interrupt, killed fifo.";
}

mkfifo($fifo_name,0777);
foreach('ABRT','QUIT','KILL','INT','ABRT','HUP') { $SIG{$_} = \&death; }
while(1) {
  open(my $fifo, '>:encoding(Windows-1252)', $fifo_name) or die $!;
  print localtime." -- Compiling...\n";
  my @required = ();
  my @expected = ();
  parse($ARGV[0],$fifo,\@required,\@expected);
  close($fifo);
  print localtime." -- Done!\n";

  print "Remaining expected patterns ".@expected."\n";
  if(@expected > 0) {
    foreach my $expected (@expected) {
      print "$expected\n";
    }
  }
  print "\n";
  sleep(1);
}
