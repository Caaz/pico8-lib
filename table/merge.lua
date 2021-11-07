
function merge(a,b,c)
  if(b) then for k, v in pairs(b) do a[k] = v end end
  if(c) then merge(a,c) end
end
-- expect merge
