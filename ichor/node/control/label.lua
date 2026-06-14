_label = _{
  _control,
  new = function(_ENV, at,ac,ao)
    _control.new(_ENV, {
      text=at,
      c=ac or 7,
			o=ao or 0
    })
    _ENV:reflow()
  end,
  reflow = function(_ENV)
    size = _vec2(
      string_width(text) + margin.x*2,
      5 + margin.y*2
    )
  end,
  draw = function(_ENV)
    local g,output = _ENV:global_position(),text
		_control.draw(_ENV)
		if o != 1 then
			output = "\^o"..hex(o).."ff"..text
		end
    print(output, g.x+margin.x, g.y+margin.y, o==1 and 14 or c)
  end
}
