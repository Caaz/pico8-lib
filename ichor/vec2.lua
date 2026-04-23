_vec2 = _{
  new = function(t, x, y)
    merge(t, {
      x=x,
      y=y
    })
  end,
  abs = function(t)
    t.x = abs(t.x)
    t.y = abs(t.y)
  end,
  floor = function(t)
    t.x = flr(t.x)
    t.y = flr(t.y)
  end,
  length = function(t)
    return sqrt(t:length_squared())
  end,
  length_squared = function(t)
    return abs(t.x * t.x) + abs(t.y * t.y)
  end,
  normalize = function(t)
    local mag = t:length()
    t.x/=mag
    t.y/=mag
  end,
  normalized = function(t)
    local mag = t:length()
    return _vec2(t.x/mag, t.y/mag)
  end,
  multiply = function(t, by)
    t.x *= by
    t.y *= by
    return t
  end,
  add = function(t,by)
    t.x += by.x
    t.y += by.y
    return t
  end,
  sub = function(t,by)
    t.x -= by.x
    t.y -= by.y
    return t
  end,
  meta = {
    __add = function(a, b)
      return _vec2(a.x + b.x, a.y + b.y)
    end,
    __sub = function(a, b)
      return _vec2(a.x - b.x, a.y - b.y)
    end,
    __mul = function(a, b)
      if type(b) == "number" then
        return _vec2(a.x * b, a.y * b)
      end
      return _vec2(a.x * b.x, a.y * b.y)
    end,
    __unm = function(a) 
      return _vec2(-a.x, -a.y)
    end,
    __call = function(a)
      return _vec2(a.x, a.y)
    end
  }
}
_vec2.zero = _vec2(0,0)
