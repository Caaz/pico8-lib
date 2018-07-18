-- polytest
-- by ktb

-- simple polygon stuff
-- meant as a basis to build
-- on, not a complete system

-- polygons are flat list of
-- sequential points:
-- {x0,y0,x1,y1,x2,y2,...}

-- each polygon has its own
-- origin and coordinates are
-- relative to that

-- you probably want to call
-- polydraw() after every
-- polyfill().

-- polyfill is not really
-- exact enough and has some
-- glitches on long sides.
-- not sure how to fix that atm.


-- require vendor/sort

polydraw, polyfill = (function()
  -- find the x-values of the
  -- polygon edges which intercept
  -- our horizontal raster
  function polybounds(pg)
    local l,t,r,b=0,0,0,0
    for i=1,#pg,2 do
      local x,y=pg[i],pg[i+1]
      if (x<l) l=x
      if (x>r) r=x
      if (y<t) t=y
      if (y>b) b=y
    end
    return l,t,r,b
  end
  function intercepts(pg,y)
    local ints={}
    local x0,y0=pg[#pg-1],pg[#pg]
    local y2
    for i=1,#pg-1,2 do
      x1,y1=pg[i],pg[i+1]
      -- this trick solves case
      -- of vertices on raster
      -- line that don't change
      -- in/out to cross
      if (y0==y) y0-=0.001
      if (y1==y) y1-=0.001
      if mid(y0,y,y1)==y then
        if x0==x1 then
          add(ints,x0)
        elseif y0==y1 then
          -- do nothing
        else
          local m=(y1-y0)/(x1-x0)
          local x=(y-y0)/m+x0
          add(ints,x)
        end
      end
      x0,y0=x1,y1
    end
    return sort(ints)
  end
  return function(pg,wx,wy,col)
    local lx,ly=pg[#pg-1],pg[#pg]
    for i=1,#pg-1,2 do
      local x,y=pg[i],pg[i+1]
      line(wx+lx,wy+ly,wx+x,wy+y,col)
      lx,ly=x,y
    end
  end,
  function(pg,wx,wy,fcol)
    local l,t,r,b=polybounds(pg)
    for y=t,b do
      local a=intercepts(pg,y)
      for i=2,#a,2 do
        local x0,x1=a[i-1],a[i]
        if abs(x1-x0)>=1 then
          line(wx+a[i-1]+1,wy+y,wx+a[i],wy+y,fcol)
        end
      end
    end
  end
end)()
