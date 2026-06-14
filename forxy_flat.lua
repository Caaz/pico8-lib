function forxy(x,y)
  local i = 0
  return function()
    local ly, lx = flr(i/y), i%x
    i += 1
    if ly < y then
      return lx, ly
    end
  end
end
