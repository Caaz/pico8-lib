-- require class
-- require table/merge

class_animation = class{
  new = function(this, args)
    merge(this,{
      frame = 1,
      speed = 1,
      tick = 0
    })
    merge(this,args)
  end,
  on_end = function() end,
  init = function(this)
    this.frame = 1
    this.tick = 0
  end,
  draw = function(this, x, y, width, height, flip_x, flip_y)
    this.tick = (this.tick + 1) % this.speed
    if this.tick == 0 then
      this.frame = (this.frame + 1) % #this.frames
      if this.frame == 0 then this:on_end() end
    end
    -- this is awful but I assure you it's fine.
    local frame = this.frames[this.frame+1]
    -- printh(width)
    sspr(frame[1], frame[2], frame[3], frame[4], (frame[5] or 0)+x, (frame[6] or 0)+y, (width or frame[3]), (height or frame[4]), flip_x, flip_y)
  end
}

class_animator = class{
  new = function(this, args)
    merge(this, { animation = 1 })
    merge(this, args)
  end,
  set_animation = function(this,id)
    if this.animation != id then
      this.animations[id]:init()
    end
    this.animation = id
  end,
  draw = function(this, x, y, width, height, flip_x, flip_y)
    this.animations[this.animation]:draw(x,y,width,height,flip_x,flip_y)
  end
}
