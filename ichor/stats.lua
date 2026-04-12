_stats = _{
  extends=_node,
  info = {
    function() return 'mem '..(stat(0)/2048)..'%' end,
    function() return 'cpu '..(stat(1)*100)..'%' end,
  },
  ready = function(this)
    menuitem(1,'toggle stats', function()
      this.show = not this.show
    end)
  end,
  draw = function(t)
    if t.show then
      for i, call in pairs(t.info) do
        local label = call()
        local y = i*6-5
        rectfill(1,y,#label*4+1,i*6+1,0)
        print(label,2,y+1,7)
      end
    end
  end
}
