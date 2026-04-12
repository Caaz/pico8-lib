_fade_clear = _{
  extends=_node,
  draw = function(t)
    for i=1, t.steps do
      circ(rnd(127),rnd(127), rnd(64), t.color and t.color or 0)
    end
  end,
}
