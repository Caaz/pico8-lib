function reverse(t)
  local new_t = {}
  for i = 1, #t/2, 1 do
    new_t[i] = t[#t-i+1]
    new_t[#t-i+1] = t[i]
  end
  return new_t
end
