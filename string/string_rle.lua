-- require string/characters

function string_rle(string)
  local buffer,output,last_char = '',''
  for i, char in characters(string) do
    if char == last_char then
      buffer = buffer..char
    else
      if #buffer > 3 then buffer = ':'..#buffer..':' end
      output = output..buffer..char
      buffer = ''
    end
    last_char = char
  end
  if #buffer > 3 then output = output..':'..#buffer..':' end
  return output
end

-- expect string_rle
