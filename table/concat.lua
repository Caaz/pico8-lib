-- concatenates an arbitrary set of tables together
-- concat({1},{2},{3}) == {1,2,3}
function concat(a, ...)
  for b in all({...}) do 
    for v in all(b) do a[#a+1] = v end
  end
end
