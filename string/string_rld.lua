-- require characters

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

--expect string_rld
