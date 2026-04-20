_particle = _{
  extends = _node,
  new = function(t, a)
    _node.new(t, {
      active = false,
      size = 3,
      life = 0,
      -- max lifetime in frames
      lifetime = 10,
      color = 7,
      velocity = _vec2.zero,
      square = false,
    })
    merge(t,a)
  end,
  deactivate = function(t)
    t.active = false
  end,
  update = function(t)
    if (not t.active) return
    t.life += 1
    if t.life > t.lifetime then
      t:deactivate()
      return
    end
    t.position:add(t.velocity)
  end,
  draw = function(t)
    if (not t.active) return
    local life_percent = t.life/t.lifetime
    local size= type(t.size) == 'number' and t.size-1 or lerp(t.size[1], t.size[2], life_percent)
    if size <=0 then
      return
    end
    local color = type(t.color) == 'number' and t.color or t.color[ceil(life_percent*#t.color)]
    local position = t:global_position()
    if t.square then
      local half = size/2
      rectfill(position.x-half, position.y-half, position.x-half+size, position.y-half+size, color)
    else
      circfill(position.x, position.y, (size+1)/2, color)
    end
  end,
}

_particle_system = _{
  extends = _node,
  new = function(t, class, count)
    _node.new(t, {
      count = count or 64,
      class = class or _particle,
    })
  end,
  ready = function(t)
    for i = 1, t.count do 
      t:add(t.class()) 
    end 
  end,
  spawn = function(t,...)
    for particle in all(t.children) do
      if not particle.active then
        t.class.new(particle, ...)
        particle.active = true
        return particle
      end
    end
  end,
}
