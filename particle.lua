-- require table/merge

_particle = _{
  new = function(this, args)
    merge(this,{{
      vel_x = 0,
      vel_y = 0,
      x = 0,
      y = 0,
      size = 3,
      decay = .5,
      color = 7,
    },args})
  end,
  init = function(this) end,
  destroy = function(this) end,
  update = function(this)
    -- printh('aaaaa!')
    this.x += this.vel_x
    this.y += this.vel_y
    if rnd() < this.decay then this.size -= .5 end
    if this.life then
      this.life -= 1
      if this.life == 0 then this.parent:del(this) end
    end
    if this.size < 0 then this.parent:del(this) end
  end,
  draw = function(this)
    if this.size < 1 then pset(this.x,this.y,this.color)
    else circfill(this.x,this.y,this.size,this.color) end
  end
}
