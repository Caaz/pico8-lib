_vec2 = _{
  new = function(t, x, y)
    t.x = x
    t.y = y
  end,
  meta = {
    __add = function(a, b)
      if type(b) == "number" then
        return _vec2(a.x + b, a.y + b)
      else
        return _vec2(a.x + b.x, a.y + b.y)
      end
    end,
    __sub = function(a, b)
      return a + -b
    end,
    __mul = function(a, b)
      if type(b) == "number" then
        return _vec2(a.x * b, a.y * b)
      end
      return _vec2(a.x * b.x, a.y * b.y)
    end,
    __unm = function(a) 
      return _vec2(-a.x, -a.y)
    end
  }
}
_vec2.zero = _vec2(0,0)
