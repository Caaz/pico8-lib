-- merges an arbitrary amount of tables together.
-- merge({a=1}, {b=2}, {a=3}) == {a=3, b=2}
function merge(a, ...)
  for b in all({...}) do 
    for k, v in pairs(b) do a[k] = v end
  end
end
