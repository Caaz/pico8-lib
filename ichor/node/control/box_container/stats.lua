_stats = {value={fps=1}}
_stats = _{
  _box_container,
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
        delta=function() return 1/_stats.value.fps end,
        mem=function() return stat(0)/20.48 end,
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
      value = {},
      tick = 0,
      hide = true,
    },...)
    t:update()
    menuitem(1,'toggle stats', function() t.hide = not t.hide end)
  end,
  update= function(t)
    local index = 0
    for key, value in pairs(t.stat) do
      index += 1
      local result = type(value) == 'number' and stat(value) or value()
      t.value[key] = result
      if #t.children < index then
        t:add(_label{})
      end
      t.children[index].text = key..": "..result
    end
    t.tick += 1
    if (t.hide) return
    t:reflow()
  end,
}()
