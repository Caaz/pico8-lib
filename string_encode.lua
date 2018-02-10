-- require binary/pull
-- require binary/itb
-- require binary/bits_to
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
  -- print('run length encoding...')
  return string_rle(string)
end

-- function bytes_to_string(bytes)
--   local string = ''
--   local bits = {}
--   for byte in all(bytes) do
--     add(bits, itb(byte,8))
--     if(#bits >= 6) then
--       local id = pull(bits,6)+1
--       string = string..sub(encoding,id,id)
--     end
--   end
--   local id = pull(bits,6)+1
--   string = string..sub(encoding,id,id)
--   print('run length encoding...')
--   return string_rle(string)
-- end

function bits_from_string(string)
  local bits = {}
  for i, char in characters(string_rld(string)) do
    concat(bits, itb(index_of(char, encoding)-1, 6))
  end
  return bits
end

function expand(size,table)
  for k,v in pairs(table) do
    table[k] = bits_to(size, bits_from_string(v))
  end
  return table
end

-- expect bits_to_string
-- expect bits_from_string
-- expect expand
