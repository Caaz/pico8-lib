function forxy(t, c)
	for x in pairs(t) do
		for y in pairs(t[x]) do
			c(t[x][y], x, y)
		end
	end
end
