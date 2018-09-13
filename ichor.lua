-- name: ichor
-- version: 1.2.0
-- description: handles game state, and provides object oriented functionality.
-- require debug
_ = {
  -- state management
  states = {},
  main = function(f) local s = _.states[_.s] if s[f] then s[f](s) end end,
  state = function(s) _.s = s _.main'init' end,

  -- object oriented programming interface
  __call = (function()
    local i = function(c, ...)
      local t = {}
      setmetatable(t,{ __index = c })
      -- printh('c')
      -- debugp(c)
      t:new(...)
      return t
    end
    return function(t,a)
      -- printh('a')
      -- debugp(a)
      setmetatable(a, {
        __call = i,
        __index = a.extends
      })
      return a
    end
  end)()
}
setmetatable(_,_)
function _update() _.main'update' end
function _draw() _.main'draw' end
