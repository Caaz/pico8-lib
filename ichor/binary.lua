_f = _{new = function(t,k,y,s)merge(t,{k=k,t=y,s=s})end}
_af = function(l,b) local t = {} for i=1,l do add(t, _f(i,0,b)) end return t end

_b = _{
	c="abcdefghijklmnopqrstuvwxyz ,.?!",
	new = function(t, b)
		t:reset_head()
		t.b = {}
		if type(b) == 'string' then
			t:write_string(b, true)
			t:reset_head()
		end
	end,
	reset_head = function(_ENV) h = -32768 end,
	read = function(_ENV)
		local bit = (h <= #b) and b[h] or false
		h += 1
		return bit
	end,
	read_int = function(_ENV,size)
		local bits = {}
		for i = 1, size do 
			local bit = _ENV:read()
			if (type(bit) =='nil') bit = false
			add(bits, bit)
		end
		local total = 0
		for i, v in pairs(bits) do
			if (v) total += shl(1,#bits-i)
		end
		return total
	end,
	read_string = function(t, e)
		local s = ""
		while(t:has_bits()) do
			local i,char = t:read_int(e and 8 or 5)
			if e then
				i = 255-i
				c = chr(i)
				if i < 16 or i == ord("\\") or i == ord("\"") then
					local h = hex(i)
					h = #h<2 and '0'..h or h
					c="\\x"..h
				end
			else
				if (i==0) break
				c = sub(t.c,i,i)
			end
			s = s..c
		end
		return s
	end,
	read_dynamic = function(t, s)
		local ty = t:read_int(2)
		if ty == 2 then
			local a = {}
			local l = t:read_int(8)
			for i=1, l do
				add(a, t:read_dynamic(s))
			end
			return a
		elseif ty == 1 then
			return t:read_string()
		elseif ty == 0 then
			return t:read_int(s)
		elseif ty == 3 then
			return t:read()
		end
	end,
	read_schema = function(t, s)
		local a = {}
		foreach(s,function(f)
			local y, k = f.t, f.k
			if y == 0 then
				a[k] =  t:read_int(f.s)
			elseif y == 1 then
				a[k] =  t:read_string()
			elseif y == 2 then
				a[k] = t:read()
			elseif y == 3 then
				a[k] = t:read_dynamic(f.s)
			else
				a[k] = t:read_schema(y)
			end
		end)
		return a
	end,
	write = function(_ENV, d)
		-- assert(t.head+#bits>t.head, t.head..' will overflow to '..(t.head+#bits))
		foreach(d,function(i)
			b[h],w = i,h
			h+=1
		end)
	end,
	write_int = function(t, n, s)
		local b = {}
		for i=1, s do
			local l = shl(0b1,s-i)
			b[i] = band(n, l) == l
		end
		t:write(b)
	end,
	write_string = function(t, s, e)
		for i=1, #s do
			if e then
				t:write_int(255-ord(s,i), 8)
			else
				t:write_int(index_of(s[i], t.c), 5)
			end
		end
		if (not e) t:write_int(0,5)
	end,
	types = {
		number=0,
		string=1,
		table=2,
		boolean=3
	},
	write_dynamic = function(t, object, size)
		local ty = type(object)
		t:write_int(t.types[ty],2)
		if (ty == 'table') then
			t:write_int(#object, 8)
			for item in all(object) do
				t:write_dynamic(item, size)
			end
		elseif (ty == 'string') then
			t:write_string(object)
		elseif (ty == 'number') then
			t:write_int(object, size)
		elseif (ty == 'boolean') then
			t:write{object}
		end
	end,
	write_schema = function(t, table, schema)
		foreach(schema, function(f)
			local ty,value,chunk = f.t,table[f.k],{}
			if ty == 0 then
				t:write_int(value, f.s)
			elseif ty == 1 then
				t:write_string(value)
			elseif ty == 2 then
				t:write{value}
			elseif ty == 3 then
				t:write_dynamic(value, f.s)
			else
				t:write_schema(value, ty)
			end
		end)
	end,
	has_bits = function(t)
		return t.h <= t.w
	end,
}
