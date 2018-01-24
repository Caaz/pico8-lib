-- require table.lua
function pull(data,size)
  local bits = {}
  for i = 1, size do add(bits,shift(data)) end
  return bti(bits)
end

function itb(number,size)
  local bits = {}
  if size then for i=1, size do bits[i] = false end end
  local i = 0
  while number > 0 do
    i += 1
    remainder = number % 2
    bits[i] = remainder == 1
    number = (number - remainder) / 2
  end
  return bits
end

function bti(bits)
  local total = 0
  for i, v in pairs(bits) do
    if v then
      local add = shl(1,i-1)
      total += add
    end
  end
  return total
end

function bits_from(size,values)
  local bits = {}
  for v in all(values) do concat(bits,itb(v,size)) end
  return bits
end

function bits_to(size,bits)
  local chunks = {}
  local chunk = {}
  for bit in all(bits) do
    add(chunk, bit)
    if #chunk >= size then
      add(chunks, bti(chunk))
      chunk = {}
    end
  end
  if #chunk != 0 then
    add(chunks,bti(chunk))
  end
  return chunks
end

-- expect itb
-- expect bti
-- expect bits_from
-- expect bits_to
-- expect pull
