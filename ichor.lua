_ichor = {
  version = '1.1.0',
  states = {},
  main = function(f)
    local s = _ichor.states[_ichor.state]
    if s[f] then s[f](s) end
  end,
  __call = function(a,b)
    if b then
      a.state = b a.main'init'
    end
  end
}
setmetatable(_ichor,_ichor)
function _update() _ichor.main'update' end
function _draw() _ichor.main'draw' end
