-- joins items in a table to a string
function join(t, j, p)
	j = j and j or ","
	local s = ""
	for i in all(t) do
		local v = p and i[p] or i
		s = s..j..tostring(type(v)=="function" and v(i) or v)
	end
	return s
end
