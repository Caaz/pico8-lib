-- name: ichor
-- version: 2.0.1
-- description: handles game state, and provides object oriented functionality, and a node system.

_ = {
  -- object oriented programming interface
  __call=function(t,a)
    a.new = a.new or a.extends and a.extends.new or merge
    setmetatable(a,{
      __index=a.extends,
      __call=function(c,...)
        local t={}
        local meta = {__index=c}
        if (c.meta) merge(meta, c.meta)
        setmetatable(t,meta)
        c.new(t,...)
        return t
      end
    })
    return a
  end
}
setmetatable(_,_)

-- basic structure
-- _.root = node()
-- function _update() _.root:_update() end
-- function _draw() _.root:_draw() end
