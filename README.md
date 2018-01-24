# PICO-8 Libraries!

This is just a small collection of libraries and a compiler script for PICO-8

I have this repository at the root of my carts folder, labeled libs.

Here's an example of use in a cart

```lua

-- require table
-- require ichor
-- require string_encode
function expand(size,table)
  for k,v in pairs(table) do
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
To compile, I run the script `compile.pl` with an argument pointing at this cart, like so

`perl lib/compile.pl fade.p8`

in PICO-8 I can then load the fifo.p8 cart it produces and the script will compile it automagically.
