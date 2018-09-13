-- use: merge(table, {table_b,table_c)
function merge(a,b)
  for i, c in pairs(b) do
    for k, v in pairs(c) do
      a[k] = v
    end
  end
end
-- expect merge
