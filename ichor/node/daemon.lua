_daemon = _{
	_node,
	new = function(_ENV,n,f,p,c)
		_node.new(_ENV)
		n:add(_ENV)
		r = cocreate(function ()
			for i=1, f do p(i) yield() end
			if (c) c()
		end)
	end,
	update = function(_ENV) if (not coresume(r)) _ENV:free() end
}
