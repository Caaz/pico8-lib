-- require table/forall
_ps = {
  s =  {},
  all = function(t,...) forall(t.s,...) end
}
-- expect _ps
