
function merge(a,b,c)
  if(b)for k, v in pairs(b) do a[k] = v end
  if(c)merge(a,c)
end
-- expect merge
