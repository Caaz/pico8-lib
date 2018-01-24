function class(base)
  setmetatable(base, {
    __call = instantiate,
    __index = base.extends
  })
  return base
end

function instantiate(class, arguments)
  local instance = {}
  setmetatable(instance,{ __index = class })
  instance:new(arguments)
  return instance
end

-- expect class
