
function merge(a,b,c)
  for k, v in pairs(b) do a[k] = v end
  if c then merge(a,c) end
end
-- expect merge
