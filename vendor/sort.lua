function sort(a)
 function qpart(lo,hi)
  local pivot=a[hi]
  local i=lo
  for j=lo,hi-1 do
   if a[j]<=pivot then
    a[i],a[j]=a[j],a[i]
    i+=1
   end
  end
  a[i],a[hi]=a[hi],a[i]
  return i
 end
 function qsort(lo,hi)
  if lo<hi then
   local p=qpart(lo,hi)
   qsort(lo,p-1)
   qsort(p+1,hi)
  end
 end
 qsort(1,#a)
 return a
end
-- expect sort
