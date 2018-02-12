-- require class
-- require table/merge

class_particle = class{
  new = function(this, args)
    merge(this,{
      vel_x = 0,
      vel_y = 0,
      x = 0,
      y = 0,
      size = 3,
      decay = .5,
      color = 7,
    })
    merge(this,args)
  end,
  init = function(this) end,
  destroy = function(this) end,
  update = function(this)
    this.x += this.vel_x
    this.y += this.vel_y
    if rnd() < this.decay then this.size -= .5 end
    if this.size < 0 then this.system:del(this) end
  end,
  draw = function(this)
    if this.size < 1 then pset(this.x,this.y,this.color)
    else circfill(this.x,this.y,this.size,this.color) end
  end
}
