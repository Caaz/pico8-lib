_ichor = {
  version = '0.99.99.32.2-rc7',
  order = {},
  modules = {},
  update = function() _ichor('update') end,
  draw = function() _ichor('draw') end,
  add = function(name,module)
    _ichor.modules[name] = module
    return _ichor
  end,
  set_order = function(state,order)
    _ichor.order[state] = order
    return _ichor
  end,
  set_state = function(key)
    _ichor('destroy')
    _ichor.state = key
    _ichor('init')
    return _ichor
  end,
  __call = function(this, call)
    for key in all(this.order[this.state]) do
      local module = this.modules[key]
      if module[call] then
        module[call](module)
      end
    end
  end,
}
setmetatable(_ichor,_ichor)
_update = _ichor.update
_draw = _ichor.draw
