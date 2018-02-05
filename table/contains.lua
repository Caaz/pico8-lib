function contains(table,element)
  for value in all(table) do
    if value == element then
      return true
    end
  end
  return false
end

-- expect contains
