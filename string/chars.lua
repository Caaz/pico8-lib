function chars(s)
	return function(a,i)
		i+=1
		if (i <= #s) return i, sub(s,i,i)
	end, nil, 0
end
