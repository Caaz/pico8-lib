-- require binary/pull
-- require binary/itb
-- require table/concat
-- require string/index_of
-- require string/string_rle
-- require string/string_rld

local encoding = '=abcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()[]{}<>./;"\\|`~-_+'

function bits_to_string(bits)
  local string = ''
  while(#bits > 0) do
    local id = pull(bits,6)+1
    string = string..sub(encoding,id,id)
  end
  return string_rle(string)
end

function bits_from_string(string)
  local bits = {}
  for i, char in characters(string_rld(string)) do
    concat(bits, itb(index_of(char, encoding)-1, 6))
  end
  return bits
end

-- expect bits_to_string
-- expect bits_from_string
