function class(base)
  setmetatable(base, {
    __call = instantiate,
    __index = base.extends
  })
  return base
end

function instantiate(class, ...)
  local instance = {}
  setmetatable(instance,{ __index = class })
  instance:new(...)
  return instance
end

-- expect class
