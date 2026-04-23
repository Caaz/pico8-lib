function pack_spritesheet_1bit()
  local size = 32
  for x = 0, 127 do
    for y = 0, size-1 do
      local bitfield = 0
      -- bitfield += band(sget(x,y), 0b1)
      -- bitfield += band(sget(x,y+size), 0b10)
      -- bitfield += band(sget(x,y+size*2), 0b100)
      -- bitfield += band(sget(x,y+size*3), 0b1000)
      bitfield += sget(x,y) != 0 and 0b1 or 0
      bitfield += sget(x,y+size) != 0 and 0b10 or 0
      bitfield += sget(x,y+size*2) != 0 and 0b100 or 0
      bitfield += sget(x,y+size*3) != 0 and 0b1000 or 0
      sset(x,y,bitfield)
      for i=y+size,y+size*3,size do
        sset(x,i,0)
      end
    end
  end
  cstore(0,0,0x2000)
end

function pack_spritesheet_2bit()
  local size = 64
  for x = 0, 127 do
    for y = 0, size-1 do
      local bitfield = 0
      bitfield += band(sget(x,y), 0b11)
      bitfield += shl(band(sget(x,y+size), 0b11),2)
      sset(x,y,bitfield)
      for i=y+size,y+size*3,size do
        sset(x,i,0)
      end
    end
  end
  cstore(0,0,0x2000)
end
