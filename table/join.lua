-- joins items in a table to a string
function join(table, joiner, property)
  local string
  for item in all(table) do
    value = property and item[property] or item
    value = type(value)=="function" and value(item) or value
    if not string then
      string = ""..value
    else
      string = string..joiner..value
    end
  end
  return string
end
