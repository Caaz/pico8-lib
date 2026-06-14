function paired(...)
	local a,b,c = {},{},{...}
	for i=1,#c,2 do
		add(a,c[i])
		add(b,c[i+1])
	end
	return a, b
end
