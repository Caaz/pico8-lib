_control = _{
  _node,
  new = function(t, ...)
    _node.new(t, {
      size = _vec2(4,4),
      margin = _vec2.zero(),
      debug_color = flr(rnd(16)),
      hide = false,
    }, ...)
  end,
  _draw=function(_ENV)
    if (hide) return
    _node._draw(_ENV)
  end,
  -- draw_bounds = function(_ENV)
  --   local g = _ENV:global_position()
  --   rect(g.x, g.y, g.x+size.x-1, g.y+size.y-1, debug_color)
  -- end,
  draw_panel = function(_ENV)
    local g = _ENV:global_position()
    panel:draw(g.x, g.y, g.x+size.x-1+margin.x*2, g.y+size.y-1+margin.y*2)
  end,
  draw = function(_ENV)
    if (panel) _ENV:draw_panel()
  end
}
-- rules
-- Controls and elements should grow with their children.
-- Reflow should set the size.
