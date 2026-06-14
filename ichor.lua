-- name: ichor
-- version: 3.1
-- description: basically just classes now.
function _(a)
	local e = a[1]
	a.new,a.sup,a.__index = a.new or e and e.new or merge,e,a
	setmetatable(a,{
		__index=e or _ENV,
		__call=function(_ENV,...)
			local t={}
			setmetatable(t,a)
			new(t,...)
			return t
		end
	})
	return a
end
