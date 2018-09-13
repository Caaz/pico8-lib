-- require particle
-- require table/forall
_ps = {
  ps =  {},
  add = function(t, p)
    -- printh('adding '..p)
    p.parent = t
    add(t.ps, p)
    p:init()
  end,
  del = function(t, p)
    del(t.ps, p)
    p:destroy()
  end,
  update = function(t)
    forall(t.ps,'update')
  end,
  draw = function(t)
    forall(t.ps,'draw')
  end
}
