_stats = _{
  extends = _box_container,
  stats = {},
  new = function(t,...)
    _box_container.new(t, {
      panel = _panel{},
      horizontal = false,
      alignment = 0,
      position = _vec2(1,1),
      margin = _vec2(2,2),
      gap = 1,
      stat = {
        mem=function() return stat(0)/1024 end,
        cpu=function() return stat(1)*100 end,
        fps=7,
        -- local times
        year=90,
        month=91,
        day=92,
        hour=93,
        minute=94,
        second=95,
        -- tick = function() return _stats.tick end,
      },
      tick = 0,
      hide = true,
    },...)
    menuitem(1,'toggle stats', function() t.hide = not t.hide end)
  end,
  update= function(t)
    if (t.hide) return
    local index = 0
    for key, value in pairs(t.stat) do
      index += 1
      local result = type(value) == 'number' and stat(value) or value()
      t.stats[key] = result
      if #t.children < index then
        t:add_child(_label{})
      end
      t.children[index].text = key..": "..result
    end
    t.tick += 1
    t:reflow()
    
  end,
}()
_map = _{
  extends = _node,
  draw = function(t)
    cls()
    -- map(0,0,0,0,16,16)
    -- print()
  end,
}
