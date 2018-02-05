function characters(string)
  return function(a,i)
    i+=1
    if i <= #string then
      return i, sub(string,i,i)
    end
  end, nil, 0
end

-- expect characters
