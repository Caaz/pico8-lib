_node = _{
	is_node=true,
	new=function(t,...)
		merge(t,{
			reverse_draw_order = false,
			top_level = false,
			position = _vec2.zero(),
			children = {}
		},...)
	end,
	global_position=function(_ENV)
		local p = position()
		if (top_level or not parent) return p
		return p + parent:global_position()
	end,
	_update=function(_ENV)
		_ENV:safe_call'update'
		forall(children, '_update')
	end,
	_draw=function(_ENV)
		if(not reverse_draw_order) _ENV:safe_call('draw')
		forall(children, '_draw')
		if(reverse_draw_order) _ENV:safe_call('draw')
	end,
	-- safe call, calls function only if it exists
	safe_call = function(t, f, ...)
		if (t[f]) t[f](t, ...)
	end,
	-- adds child to children
	add = function(_ENV, n)
		assert(n, "nil node added.")
		assert(n.is_node, 'non-node added')
		n.parent = _ENV
		add(children, n)
		n:safe_call'added'
		return _ENV
	end,
	-- removes child from children, but doesn't free it.
	del = function(t, child)
		child.parent = nil
		del(t.children, child)
		child:safe_call'removed'
	end,
	-- frees this node from memory.
	free = function(t)
		for child in all(t.children) do
			child:free()
		end
		t.parent:del(t)
		for key, value in pairs(t) do
			t[key] = nil
		end
		t.freed = true
	end
}
