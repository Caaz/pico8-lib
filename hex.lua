function hex(v) 
  local s,l,r=tostr(v,true),3,11
  while(ord(s,l)==48) l+=1
  while(ord(s,r)==48) r-=1
  return sub(s,min(l,6),r>7 and r or 6)
end
