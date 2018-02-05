-- require table/shift
-- require binary/bti

function pull(data,size)
  local bits = {}
  for i = 1, size do add(bits,shift(data)) end
  return bti(bits)
end

-- expect pull
