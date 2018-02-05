function shift(table)
  local element = table[1]
  del(table,element)
  return element
end

-- expect shift
