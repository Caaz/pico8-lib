function forxy(table, callback)
  for x in pairs(table) do
    for y in pairs(table[x]) do
      callback(table[x][y], x, y)
    end
  end
end
