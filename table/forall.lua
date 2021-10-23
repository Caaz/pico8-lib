function forall(t,f,...)
  for e in all(t) do
    if e[f] then e[f](e,...) end
  end
end
