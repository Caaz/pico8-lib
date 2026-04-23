_box_container = _{
  extends = _control,
  new = function(t, ...)
    _control.new(t, {
      gap = 2,
      -- 0: top, 1: center, 2: bottom
      alignment = 1,
      horizontal = true,
    }, ...)
  end,
  reflow = function(t)
    -- max height of children
    local axis = t.horizontal and 'y' or 'x'
    local anti_axis = t.horizontal and 'x' or 'y'
    local max_size = 0
    for child in all(t.children) do
      child:safe_call'reflow'
      max_size = max(max_size, child.size[axis])
    end
    t.size[axis] = max_size + t.margin[axis]*2
    -- set position of child nodes
    local offset = 0
    for child in all(t.children) do
      child.position[anti_axis] = offset + t.margin[anti_axis]
      child.position[axis] = (t.alignment == 0 and t.margin[axis] or t.alignment == 1 and t.size[axis]/2-child.size[axis]/2 or t.size[axis]-child.size[axis]) 
      offset += child.size[anti_axis] + t.gap
    end
    -- set size of self
    t.size[anti_axis] = offset - t.gap + t.margin[anti_axis]*2
  end
}
