_vec2 = _{
	new = function(t, x, y)
		merge(t, {
			x=x,
			y=y
		})
	end,
	abs = function(_ENV) x, y = abs(x), abs(y) end,
	floor = function(_ENV) x, y = flr(x), flr(y) end,
	length_squared = function(_ENV) return abs(x * x) + abs(y * y) end,
	normalize = function(_ENV)
		local m = #_ENV
		x/=m
		y/=m
	end,
	__len = function(t) return sqrt(t:length_squared()) end,
	__add = function(_ENV, b) return _vec2(x + b.x, y + b.y) end,
	__sub = function(_ENV, b) return _vec2(x - b.x, y - b.y) end,
	__mul = function(_ENV, b)
		if (type(b) == "number") return _vec2(x * b, y * b)
		return _vec2(x * b.x, y * b.y)
	end,
	__unm = function(_ENV) return _vec2(-x, -y) end,
	__call = function(_ENV) return _vec2(x, y) end
}
_vec2.zero = _vec2(0,0)
