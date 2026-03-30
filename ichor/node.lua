node = _{
  new=function(t,a)
    merge(t,{
      top_level = false,
      position = _vec2(0,0),
      children = {}
    },a)
  end,
  add = function(t, n)
    add(t.children, n)
    n:_s_call'ready'
  end,
  _update=function(t)
    t:_s_call'update'
    forall(t.children, '_update')
  end,
  _draw=function(t, offset)
    local o = offset and offset or _vec2.zero
    if (not t.top_level) t.position += o
    t:_s_call('draw')
    forall(t.children, '_draw', t.position)
    if (not t.top_level) t.position -= o
  end,
  -- safe call, calls function only if it exists
  _s_call = function(t, f, ...)
    if (t[f]) t[f](t, ...)
  end,
}
