_node = _{
  new=function(t,...)
    merge(t,{
      reverse_draw_order = false,
      top_level = false,
      position = _vec2.zero(),
      children = {}
    },...)
  end,
  deli = function(t, i)
    local n = t.children[i]
    if n then
      deli(t.children, i)
      n.parent = nil
      n:_s_call'removed'
      return n
    end
  end,
  add = function(t, n)
    add(t.children, n)
    n.parent = t
    n:_s_call'ready'
  end,
  global_position=function(t)
    local position = t.position()
    if (t.top_level) return position
    position:add(t.parent.position)
    return position
  end,
  _update=function(t)
    t:_s_call'update'
    forall(t.children, '_update')
  end,
  _draw=function(t, offset)
    if(not t.reverse_draw_order) t:_s_call('draw')
    forall(t.children, '_draw')
    if(t.reverse_draw_order) t:_s_call('draw')
  end,
  -- safe call, calls function only if it exists
  _s_call = function(t, f, ...)
    if (t[f]) t[f](t, ...)
  end,
  free = function(t)
    del(t.parent.children, t)
    t:_s_call'removed'
  end
}
