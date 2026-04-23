function set_layer_2bit(top, colors, transparent_zero)
  -- local layer = shl(0b11, (layer_index-1)*2)
  local palette = {}
  palt(0, false)
  for i=0, 15 do
    local id = (top and i % 4 or flr(i / 4))
    if (transparent_zero and id==0) palt(i, true)
    palette[i] = colors[id]
  end
  pal(palette)
end
