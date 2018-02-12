-- require particle
_ichor.add('particle_system', {
  init = function(this)
    this.particles = {}
  end,
  add = function(this, particle)
    particle.system = this
    add(this.particles, particle)
    particle:init()
  end,
  del = function(this, particle)
    del(this.particles, particle)
    particle:destroy()
  end,
  update = function(this)
    this:all('update')
  end,
  draw = function(this)
    this:all('draw')
  end,
  all = function(this, key)
    for particle in all(this.particles) do
      particle[key](particle,key)
    end
  end
})
