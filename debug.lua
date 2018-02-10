-- require string_encode
-- require binary/bits_from

function debug(t,indent)
  local tab = (indent and indent or '')
  local ty = type(t)
  if ty == 'table' then
    local s = ''
    for k,v in pairs(t) do
      s = s..'\n'..tab..k..':'..debug(v,tab..' ')
    end
    return s
  elseif ty == 'string' or ty == 'number' then
    return tab..t
  elseif ty == 'boolean' then
    return tab..(t and 'true' or 'false')
  else
    return '('..ty..')'
  end
end
function debugp(t) printh(debug(t)) end

function bits_as_string(bits)
  local string = ''
  for bit in all(bits) do
    string = string..(bit and 1 or 0)
  end
  return string
end

function compress(size,table)
  for k,v in pairs(table) do
    table[k] = bits_to_string(bits_from(size,v))
  end
  return table
end

-- expect debug
-- expect debugp
-- expect bits_as_string
-- expect compress
