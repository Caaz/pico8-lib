class = (function()
  local i = function(c, ...)
    local t = {}
    setmetatable(t,{ __index = c })
    t:new(...)
    return t
  end
  return function(a)
    setmetatable(a, {
      __call = i,
      __index = a.extends
    })
    return a
  end
end)()
-- expect class
