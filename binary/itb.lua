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

-- expect itb
