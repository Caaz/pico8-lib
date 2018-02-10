-- require class
-- require table/merge
class_menu_option = class{
  new = function(this,args) merge(this,args) end,
  label = 'null label',
  on_dir = function() end,
  on_action = function() end,
}
class_menu = class{
  new = function(this,args)
    merge(this,{options = {}})
    merge(this,args)
  end,
  -- options = {},
  selected = 1,
  s_color = 8,
  d_color = 7,
  -- on_move = function() end,
  on_back = function() end,
  update = function(this)
    if btnp(2) then
      this.selected = max(this.selected-1,1)
      -- this:on_move(true, this.selected)
    elseif btnp(3) then
      this.selected = min(this.selected+1,#this.options)
      -- this:on_move(false, this.selected)
    end
    local option = this.options[this.selected]
    if btnp(0) or btnp(1) then option:on_dir(btnp(0))
    elseif btnp(4) then
      option:on_action(this)
      this.active = false
    elseif btnp(5) then this:on_back() end
  end,
  draw_backdrop = function(x,y,width,height)
    rectfill(x,y,width,height,0)
    rect(x,y,width,height,7)
  end,
  draw = function(this,x,y)
    local height = #this.options*6+2
    local width = 0
    for option in all(this.options) do
      width = max(width,#option.label*4+2)
    end
    x -= width/2
    width += x
    height += y
    this:draw_backdrop(x,y,width,height)
    for i, option in pairs(this.options) do
      local len = #option.label*4+1

      print(option.label,(width-x-len)/2+x+2,y+(i-1)*6+2,(this.selected == i and this.s_color or this.d_color))
    end
  end
}
