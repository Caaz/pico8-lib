_control = _{
  extends = _node,
  new = function(t, ...)
    _node.new(t, {
      size = _vec2(4,4),
      margin = _vec2.zero(),
      debug_color = flr(rnd(16)),
      hide = false,
    }, ...)
  end,
  _draw=function(t)
    if (t.hide) return
    _node._draw(t)
  end,
  draw_bounds = function(t)
    local g = t:global_position()
    rect(g.x, g.y, g.x+t.size.x-1, g.y+t.size.y-1, t.debug_color)
  end,
  draw_panel = function(t)
    local g = t:global_position()
    t.panel:draw(g.x, g.y, g.x+t.size.x-1, g.y+t.size.y-1, t.debug_color)
  end,
  draw = function(t)
    if (t.panel) t:draw_panel()
  end
}
-- rules
-- Controls and elements should grow with their children.
-- Reflow should set the size.
