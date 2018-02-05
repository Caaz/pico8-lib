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

-- expect bits_to
