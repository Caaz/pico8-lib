-- require table/concat
-- require binary/itb

function bits_from(size,values)
  local bits = {}
  for v in all(values) do concat(bits,itb(v,size)) end
  return bits
end

-- expect bits_from
