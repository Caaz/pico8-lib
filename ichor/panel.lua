_panel = _{
  new = function(t,...)
    merge(t, {
      border_color = 7,
      fill_color = 1,
    }, ...)
  end,
  draw = function(t, x, y, ex, ey)
    rectfill(x, y, ex, ey, t.fill_color)
    rect(x, y, ex, ey, t.border_color)
  end
}
