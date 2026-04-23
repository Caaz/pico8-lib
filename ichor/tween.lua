-- requires lerp, unless something else is defined

_tween = _{
  extends = _node,
  new = function(t,...)
    _node.new(t,{
      -- lifetime in frames
      length = 1,
      tick = 0,
      interpolator = lerp
    },...)
  end,
  update = function(t)
    t.tick += 1
    local life_percent = min(t.tick / t.length, 1)
    t.object[t.property] = t.interpolator(t.from, t.to, life_percent)
    if (life_percent == 1) t:free()
  end
}
-- _tween_test = _{
--   extends = _node,
--   new = function(t, ...)
--     _node.new(t, {
--       points = {},
--       tween = {freed=true}
--     }, ...)
--   end,
--   update = function(t)
--     if t.tween.freed then
--       local angle = rnd()
--       t.tween = t:create_tween{
--         object=t,
--         property='position',
--         from=t.position(),
--         to=_vec2(sin(angle), cos(angle)):multiply(20):add(_vec2(64,64)),
--         length = _stats.stat.fps*2,
--         interpolator = lerp_vec2
--       }
--     end
--   end,
--   draw = function(t)
--     local g = t:global_position()
--     circfill(g.x, g.y, 5, 7)
--   end
-- }
