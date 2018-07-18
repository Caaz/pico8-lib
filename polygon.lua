-- require class
-- require table/merge
class_polygon = class{
  new = function(this,args)
    merge(this,{
      points = {},
      lines = {}
    })
    merge(this,args)
  end,
  fill = function(this,x,y,color)
    local l = this.lines
    for i = 1, #l, 4 do
      line(l[i],l[i+1],l[i+2],l[i+3],color)
    end
  end,
  draw = function(this,x,y,color)
    for i,c in pairs(this.points) do
      local n = this.points[i+1]
      if not n then n = this.points[1] end
      line(c[1]+x,c[2]+y,n[1]+x,n[2]+y,color)
    end
  end,
  rasterize = function(this,adjust)
    this.lines = {}
    this:set_bounds(false)
    for x = this.min_x, this.max_x do
      local drawing_line = false
      for y = this.min_y, this.max_y do
        if this:contains(x, y) then
          if not drawing_line then
            drawing_line = true
            add(this.lines,x)
            add(this.lines,y)
          end
        elseif drawing_line then
          drawing_line = false
          add(this.lines,x)
          add(this.lines,y)
        end
      end
      if drawing_line then
        add(this.lines,x)
        add(this.lines,this.max_y)
      end
    end
  end,
  anti_raster = function(this)
    this.lines = {}
    this:set_bounds(false)
    for x = this.min_x, this.max_x do
      local drawing_line = false
      for y = this.min_y, this.max_y do
        if not this:contains(x, y) then
          if not drawing_line then
            drawing_line = true
            add(this.lines,x)
            add(this.lines,y)
            -- this:start_line(x,y)
          end
        elseif drawing_line then
          drawing_line = false
          add(this.lines,x)
          add(this.lines,y)
          -- this:end_line(x,y)
        end
      end
      if drawing_line then
        add(this.lines,x)
        add(this.lines,this.max_y)
        -- this:end_line(x,this.max_y)
      end
    end
  end,
  contains = function(this,x,y)
    if x < this.min_x or x > this.max_x or y < this.min_y or y > this.max_y then
      return false
    end
    local out, last_point = false, this.points[#this.points]
    for i, point in pairs(this.points) do
      if point[2] < y and last_point[2] >= y or last_point[2] < y and point[2] >= y then
        if point[1] + (y-point[2]) / (last_point[2] - point[2]) * (last_point[1] - point[1]) <= x then
          out = not out
        end
      end
      last_point = point
    end
    return out
  end,
  transpose = function(this,x,y)
    for point in all(this.points) do
      point[1] += x
      point[2] += y
    end
  end,
  set_bounds = function(this, can_adjust)
    local minx, miny = this.points[1][1], this.points[1][2]
    local maxx, maxy = minx, miny
    for i,c in pairs(this.points) do
      minx = min(minx,c[1])
      maxx = max(maxx,c[1])
      miny = min(miny,c[2])
      maxy = max(maxy,c[2])
    end
    if can_adjust then
      local adjust, adjustx, adjusty = false, 0,0
      if minx != 0 then
        adjustx = -minx
        adjust = true
      end
      if miny != 0 then
        adjusty = -miny
        adjust = true
      end
      if adjust then
        this:transpose(adjustx,adjusty)
      end
      maxx += adjustx
      maxy += adjusty
    end
    this.min_x = minx
    this.min_y = miny
    this.max_x = maxx
    this.max_y = maxy
  end
}
-- expect class_polygon
