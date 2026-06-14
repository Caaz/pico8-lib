function sort(t)
	for i,ti in inext,t do
		for j,tj in inext, t do
			if ti<tj then
				ti,t[i],t[j]=tj,tj,ti
			end
		end
	end
end
