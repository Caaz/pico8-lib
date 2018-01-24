
function shift(table)
  local element = table[1]
  del(table,element)
  return element
end

function concat(a,b)
  for v in all(b) do
    a[#a+1] = v
  end
end

function merge(a,b)
  for k, v in pairs(b) do
    a[k] = v
  end
end

function contains(table,element)
  for value in all(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- expect shift
-- expect concat
-- expect merge
