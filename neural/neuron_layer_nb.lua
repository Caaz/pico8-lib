-- require table/merge
-- require neural/neuron_nb
_neuron_layer = _{
  new = function(t,a)
    merge(t,{
      bias = rnd(),
      neurons = {},
    },a)
    for i = 1, t.count or #t.neurons do
      local arg = {bias = t.bias}
      merge(arg,t.neurons[i])
      t.neurons[i] = _neuron(arg)
    end
  end,
  ff = function(t,inputs)
    local o = {}
    for i,n in pairs(t.neurons) do
      o[i] = n:co(inputs)
    end
    return o
  end,
}
