function merge(a,b)
  for k, v in pairs(b) do
    a[k] = v
  end
end
-- function merge(a, ...)
--   for b in all(arg) do
--     for k, v in pairs(b) do
--       a[k] = v
--     end
--   end
-- end
-- expect merge
