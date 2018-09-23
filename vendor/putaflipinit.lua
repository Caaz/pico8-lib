-- 1. Paste this at the very bottom of your PICO-8
--    cart
-- 2. Hit return and select the menu item to save
--    a slow render gif (it's all automatic!)
-- 3. Tweet the gif with #PutAFlipInIt
--
-- Notes:
--
-- This relies on the max gif length being long
-- enough. This can be set with the -gif_len
-- command line option, e.g.:
--
--   pico8.exe -gif_len 30
--
-- The gif is where it would be when you hit F9.
-- Splore doesn't play nicely with this, you
-- need to save the splore cart locally and load
-- it.
--
-- You might need to remove unnecessary
-- overrides to save tokens. pset() override
-- flips every 4th pset() call.
--
-- This doesn't always play nicely with optional
-- parameters, e.g. when leaving out the color
-- param.
--
-- Name clashes might happen, didn't bother
-- to namespace etc.

function cflip() if(slowflip)flip()
end
ospr=spr
function spr(...)
ospr(...)
cflip()
end
osspr=sspr
function sspr(...)
osspr(...)
cflip()
end
omap=map
function map(...)
omap(...)
cflip()
end
orect=rect
function rect(...)
orect(...)
cflip()
end
orectfill=rectfill
function rectfill(...)
orectfill(...)
cflip()
end
ocircfill=circfill
function circfill(...)
ocircfill(...)
cflip()
end
ocirc=circ
function circ(...)
ocirc(...)
cflip()
end
oline=line
function line(...)
oline(...)
cflip()
end
opset=pset
psetctr=0
function pset(...)
opset(...)
psetctr+=1
if(slowflip and psetctr%4==0)flip()
end
odraw=_draw
function _draw()
if(slowflip)extcmd("rec")
odraw()
if(slowflip)for i=0,99 do flip() end extcmd("video")cls()stop("gif saved")
end
menuitem(1,"put a flip in it!",function() slowflip=not slowflip end)
