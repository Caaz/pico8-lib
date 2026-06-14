_box_container = _{
  _control,
  new = function(t, ...)
    _control.new(t, {
      g = 2,
      -- 0: top, 1: center, 2: bottom
      alignment = 1,
      h = false,
    }, ...)
  end,
	added = function(t) t:reflow() end,
  reflow = function(_ENV)
    -- max height of children
    local a, aa, m = h and 'y' or 'x',  h and 'x' or 'y', 0
    foreach(children, function(c)
      c:safe_call'reflow'
      m = max(m, c.size[a])
    end)
    size[a] = m + margin[a]*2
    -- set position of child nodes
    local offset = 0
    foreach(children, function(c)
      c.position[aa] = offset + margin[aa]
      c.position[a] = (alignment == 0 and margin[a] or alignment == 1 and size[a]/2-c.size[a]/2 or size[a]-c.size[a]) 
      offset += c.size[aa] + g
    end)
    -- set size of self
    size[aa] = offset - g + margin[aa]*2
  end
}
