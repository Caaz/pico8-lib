function index_of(char,string)
	for i, c in chars(string) do
		if (char == c) return i
	end
	return -1
end
