function forall(t,f,...)
  for e in all(t) do
    e[f](e,...)
  end
end
