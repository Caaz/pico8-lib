.add('loading', {
  value = 0,
  set_value = function(this,v)
    this.value = v
    _ichor('draw')
    flip()
  end,
  draw = function(this)
    print('loading...',14,110)
    rect(14,116,114,118,7)
    rectfill(14,116,14+this.value*100,118,7)
  end
})
