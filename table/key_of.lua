function key_of(e,t)
	for k,v in next,t do
		if (v == e) return k
	end
	return -1
end
