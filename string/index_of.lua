-- require string/characters

function index_of(char,string)
  for i, c in characters(string) do
    if char == c then
      return i
    end
  end
  return -1
end

-- expect index_of
