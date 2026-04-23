-- gets the width in pixels for a given string, accounting for large printing characters
function string_width(string)
  local x = 0
  for k, v in characters(string) do
    x += ord(v) < 128 and 4 or 8
  end
  return x - 1
end
