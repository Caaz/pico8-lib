function key_of(element,table)
  for key, value in pairs(table) do
    if value == element then
      return key
    end
  end
  return -1
end
-- expect key_of
