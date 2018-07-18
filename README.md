# PICO-8 Libraries!

## What is this?

This is just a small collection of libraries and a compiler script for PICO-8. Code not by me is in the vendor folder, these can be any number of things and hopefully credit is given in the files. If not, I fully apologize and will try my best to fix that.

## Usage

### Installing via Submodule

If you're working in a git project, then you can add this project as a git submodule. This is the preferred method.

- `git submodule add https://github.com/Caaz/pico8-lib lib`
  - lib is important here, as the compiler script expects these files to be in a folder called lib.

You can update the libraries by using submodule commands as well

- `git submodule update --recursive --remote`

### Installing via ZIP

Otherwise, simply download the project and place it in a folder called lib at whatever working directory you might want. Your current working directory matters as that's what the compile script looks at for the library.

### Compiling

To compile a distributable cart, use the compile script like so

- `perl lib/compile.pl your_base_cart.p8 output.p8`

Alternatively, if you're working on a cart, you can instead use `lib/live-compile.pl`, which will create a FIFO cart, which will compile the cart when you load or reload the cart from PICO-8

## Example

Here's an example of use in a cart, though this very much might be an outdated example function wise, the require statements are exactly the same, and likely will not change.

```lua

-- require table
-- require ichor
-- require string_encode
function expand(size,table)
  for k,v in pairs(table) do
    -- these functions are imported from other things!
    table[k] = bits_to(size, bits_from_string(v))
  end
  return table
end

_ichor
-- require ichor/cls
-- require ichor/stats
.add('fade', {
  level = 0,
  pals = expand(4,{
    '=da=p=pd=da',
    'ptu=qequqtb',
    'phueukem2ih',
    'phsu(6t)28n'
  }),
  update = function(this)
    if btnp(0) then
      this.level = max(this.level-1,0)
    elseif btnp(1) then
      this.level = min(this.level+1,5)
    end
  end,
  draw = function(this)
    print(this.level,84,0,7)
    if this.level == 0 then
      for i = 0, 16 do
        pal(i,0)
      end
    elseif this.level < 5 then
      for k,v in pairs(this.pals[this.level]) do
        pal(k-1,v)
      end
    else
      pal()
    end
    palt(11,true)
    spr(6,0,0,10,2)
    spr(2,0,16,4,4)
  end
})
.set_order('test',{'cls','fade','stats'})
.set_state('test')
```
