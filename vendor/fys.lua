function fys(t)
  for i = 1, #t do
    local rand = flr(rnd(#t)+1)
    t[i], t[rand] = t[rand], t[i]
  end
  return t
end

-- expect fys
