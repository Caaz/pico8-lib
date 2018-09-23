_ps = {
  s =  {},
  -- number, class
  init = function(t, n, c) for i = 1, n do add(t.s,c()) end end,
  all = function(t,c,...)
    t.c = 0
    for k,p in pairs(t.s) do
      if p.active then
        if(p[c])p[c](p,...)
        if(p.active)t.c+=1
      end
    end
  end,
  add = function(t,...)
    t.c+=1
    for k,p in pairs(t.s) do
      if not p.active then
        merge(p,...)
        p.active = true
        return true
      end
    end
  end
}
