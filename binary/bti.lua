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

-- expect bti
