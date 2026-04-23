_node = _{
  new=function(t,...)
    merge(t,{
      reverse_draw_order = false,
      top_level = false,
      position = _vec2.zero(),
      children = {}
    },...)
  end,
  global_position=function(t)
    local position = t.position()
    if (t.top_level) return position
    position:add(t.parent.position)
    return position
  end,
  _update=function(t)
    t:safe_call'update'
    forall(t.children, '_update')
  end,
  _draw=function(t, offset)
    if(not t.reverse_draw_order) t:safe_call('draw')
    forall(t.children, '_draw')
    if(t.reverse_draw_order) t:safe_call('draw')
  end,
  -- safe call, calls function only if it exists
  safe_call = function(t, f, ...)
    if (t[f]) t[f](t, ...)
  end,
  -- adds child to children
  add_child = function(t, n)
    assert(n, "nil node added.")
    n.parent = t
    add(t.children, n)
    n:safe_call'added'
  end,
  create_tween = function(t,...)
    local tween = _tween(...)
    t:add_child(tween)
    return tween
  end,
  -- removes child from children, but doesn't free it.
  remove_child = function(t, child)
    child.parent = nil
    del(t.children, child)
    t:safe_call'removed'
  end,
  -- frees this node from memory.
  free = function(t)
    for child in all(t.children) do
      child:free()
    end
    t.parent:remove_child(t)
    for key, value in pairs(t) do
      t[key] = nil
    end
    t.freed = true
  end
}
