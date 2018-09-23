-- require table/merge
-- require neural/neuron
_neuron_layer = _{
  new = function(t,a)
    merge(t,{
      bias = rnd(),
      neurons = {},
    },a)
    for i = 1, t.count do
      add(t.neurons, _neuron{bias = t.bias})
    end
  end,
  -- inspect = function(t)
  --   printh('neurons: '..t.count)
  --   for i,n in pairs(t.neurons) do
  --     printh('neuron '..i..':')
  --     for j, w in pairs(n.weights) do
  --       printh(' weight '..j..': '..w)
  --     end
  --     printh(' bias: '..t.bias)
  --   end
  -- end,
  ff = function(t,inputs)
    -- printh('feeding forward with')
    -- printh(inputs)
    local o = {}
    for i,n in pairs(t.neurons) do
      o[i] = n:co(inputs)
    end
    return o
  end,
  get_outputs = function(t)
    local o = {}
    for i,n in pairs(t.neurons) do
      o[i] = n.output
    end
    return o
  end
}
