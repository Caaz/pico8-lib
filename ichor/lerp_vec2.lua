function lerp_vec2(from, to, amount)
  return _vec2(
    lerp(from.x, to.x, amount),
    lerp(from.y, to.y, amount)
  )
end
