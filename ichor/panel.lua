_panel = _{
  new = function(_ENV,fi,bo)
		f = fi and fi or -1
		b = bo and bo or -1
		printh(f)
  end,
  draw = function(_ENV, x, y, ex, ey)
    rectfill(x, y, ex, ey, f)
    if (b!=-1) rect(x, y, ex, ey, b)
  end
}
