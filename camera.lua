-- we're gonna use an anonymous function here, to contain the scope of our shenanigans
camera = (function(width, height)
  -- let's get a reference to the original pico8 camera, so we can use it later.
  local p8camera = camera
  -- alright let's make our table
  local camera_enhanced = {
    -- our current camera position
    x = 0, y = 0,
    -- what we'll be attempting to focus on
    focus_x = 0, focus_y = 0,
    -- set the camera immediately to what we'll focus on
    jump = function(this)
      this.x = this.focus_x
      this.y = this.focus_y
    end,
    -- smooth the camera movement towards our focus position
    update = function(this)
      -- the 10s here can be changed to a lower value to speed it up
      -- local x,y = this.x, this.y
      this.x = this.x + (this.focus_x - this.x)/5--+.5
      this.y = this.y + (this.focus_y - this.y)/5--+.5
      -- return x == this.x and y == this.y
    end,
    -- set our focus to some point
    focus = function(this,x,y)
      this.focus_x = x
      this.focus_y = y
    end,
    -- apply the canvas' camera!
    apply = function(this)
      -- we use -64 here because we want whatever we're trying to focus on in the center of the screen.
      camera(this.x - width/2, this.y - height/2)
    end
  }
  -- set our metatable with a __call value set to use the original camera.
  -- this will ensure our normal calls to camera() will remain the same.
  setmetatable(camera_enhanced,{ __call = function(this,x,y) p8camera(x,y) end })
  -- return the enhanced camera!
  return camera_enhanced
end)(screen_width and screen_width or 128, screen_height and screen_height or 128)
