
function characters(string)
  return function(a,i)
    i+=1
    if i <= #string then
      return i, sub(string,i,i)
    end
  end, nil, 0
end

function index_of(char,string)
  for i, c in characters(string) do
    if char == c then
      return i
    end
  end
  return -1
end

function string_rle(string)
  local buffer,output,last_char = '',''
  for i, char in characters(string) do
    if char == last_char then
      buffer = buffer..char
    else
      if #buffer > 3 then buffer = ':'..#buffer..':' end
      output = output..buffer..char
      buffer = ''
    end
    last_char = char
  end
  if #buffer > 3 then output = output..':'..#buffer..':' end
  return output
end

function string_rld(string)
  local output,run,running,last_char = '','',false,''
  for i, char in characters(string) do
    if char == ':' then
      running = not running
      if not running then
        for i = 1, tonum(run) do
          output = output..last_char
        end
        run = ''
      end
    else
      if running then
        run = run..char
      else
        output = output..char
        last_char = char
      end
    end
  end
  return output
end

-- expect characters
-- expect index_of
-- expect string_rle
-- expect string_rld
