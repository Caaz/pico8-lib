_label = _{
  extends = _control,
  new = function(t, ...)
    _control.new(t, {
      text="hello, world",
      color=7,
    }, ...)
    t:reflow()
  end,
  -- set_text = function(t, text)
  --   t.text = text
  --   t:reflow()
  -- end,
  reflow = function(t)
    t.size.x = string_width(t.text) + t.margin.x*2
    t.size.y = 5 + t.margin.y*2
  end,
  draw = function(t) 
    local g_position = t:global_position()
    -- rect(t.position.x, t.position.y, t.size.x-1, t.size.y-1, 5)
    print(t.text, g_position.x+t.margin.x, g_position.y+t.margin.y, t.color)
  end
}
