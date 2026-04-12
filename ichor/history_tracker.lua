_history_tracker = _{
  new = function(t, length)
    t.length = length
    t.history = {}
  end,
  get = function(t, index, default, from_front)
    local i = from_front and index or #t.history-index
    if i > #t.history or i < 1 then
      return default
    end
    return t.history[i]
  end,
  add = function(t, value)
    add(t.history, value)
    while(#t.history > t.length) do
      deli(t.history, 1)
    end
  end,
  average = function(t)
    local average = 0
    for value in all(t.history) do
      average += value
    end
    return average / #t.history
  end,
  clear = function(t) t.history = {} end,
}
