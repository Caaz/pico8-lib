-- require string_encode
-- require binary/bits_from

function debug(t,depth,indent)
  local depth = depth and depth or 2
  local tab = (indent and indent or '')
  local ty = type(t)
  if ty == 'table' then
    local s = ''
    for k,v in pairs(t) do
      if depth > 0 then
        s = s..'\n'..tab..k..':'..debug(v,depth-1,tab..' ')
      else
        s = s..'\n'..tab..k..':MAXDEPTH'
      end
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
