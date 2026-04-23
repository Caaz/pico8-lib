function set_layer_1bit(layer_index, color, anti_color, transparent_anticolor)
  local layer = shl(0b1, layer_index-1)
  local palette = {}
  palt(0, false)
  for i=0, 15 do
    local c = band(i, layer) == layer and color or anti_color
    if(transparent_anticolor) palt(i, c == anti_color)
    palette[i] = c
  end
  pal(palette)
end
