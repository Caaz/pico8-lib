function slice(t, first, last)
  local sliced = {}

  for i = first, last, 1 do
    add(sliced,t[i])
  end

  return sliced
end
