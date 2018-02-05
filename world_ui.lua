-- require class
-- require table/merge

class_world_ui = class{
  new = function(this, args)
    merge(this,{
      x = 1,
      y = 1,
      width = 1,
      height = 1,
      tile_size = 8,
    })
    merge(this,args)
  end,
  on_move = function() return true end,
  move = function(this,key,clamp,clamp_v)
    local new_value = clamp(this[key] + (clamp == max and -1 or 1), clamp_v)
    if this.on_move(((key == 'x') and new_value or this.x),((key == 'y') and new_value or this.y)) then
      this[key] = new_value
    end
  end,
  update = function(this)
    if btnp(0) then
      this:move('x',max,1)
    elseif btnp(1) then
      this:move('x',min,this.width)
    end
    if btnp(2) then
      this:move('y',max,1)
    elseif btnp(3) then
      this:move('y',min,this.height)
    end
    if btnp(5) then this.on_action(false,this.x,this.y) end
    if btnp(4) then this.on_action(true,this.x,this.y) end
    return this.x, this.y
  end,
  draw = function(this)
    -- local x = this.x - 1
    -- local y = this.y - 1
    local size = this.tile_size


    local x = (this.x-1)*size - 1
    local y = (this.y-1)*size - 1
    line(x,y,x+1,y,7)
    line(x,y,x,y+1,7)

    line(x,y+size+1,x+1,y+size+1,7)
    line(x,y+size+1,x,y+size,7)
    x += size+1
    line(x,y,x-1,y,7)
    line(x,y,x,y+1,7)
    y += 9
    line(x,y,x-1,y,7)
    line(x,y,x,y-1,7)

    -- rect(x*size-1,y*size-1,x*size+size,y*size+size,8)
  end
}
