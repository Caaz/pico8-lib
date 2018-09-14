-- name: ichor
-- version: 1.2.1
-- description: handles game state, and provides object oriented functionality.

-- require table/merge

_ = {
  -- state management
  states={},
  main=function(f)local s=_.states[_.s]if s[f]then s[f](s)end end,
  state=function(s)_.s=s _.main'init'end,

  -- object oriented programming interface
  __call=function(t,a)
    a.new=a.new or merge
    setmetatable(a,{
      __index=a.extends,
      __call=function(c,...)
        local t={}
        setmetatable(t,{__index=c})
        c.new(t,...)
        return t
      end
    })
    return a
  end
}
setmetatable(_,_)
function _update() _.main'update' end
function _draw() _.main'draw' end
