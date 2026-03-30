function forall(t,f,...)
  for e in all(t) do
    if (e[f]) e[f](e,...)
  end
end
