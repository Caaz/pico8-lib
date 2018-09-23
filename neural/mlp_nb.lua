-- require neural/neuron_layer_nb
_mlp = _{
  new = function(t,a)
    merge(t,{
      learning_rate = 0.5,
      layers = {}
    },a)
    -- if t.layers[1] then
    --   for i,#t.layers then
    for i=1, #t.map-1 do
      local has_data = t.layers[i]
      local layer = _neuron_layer(has_data or {count=t.map[i+1]})
      -- local layer = _neuron_layer{ count=t.map[i+1] }
      if not has_data then
        for k, n in pairs(layer.neurons) do
          for j = 1, t.map[i] do
            n.weights[j] = rnd()
          end
        end
      end
      t.layers[i] = layer
    end
  end,
  ff = function(t,i)
    for k, l in pairs(t.layers) do
      i = l:ff(i)
    end
    return i
  end,
  save = function(t,i)
    local o = {map=t.map,layers={}}
    for i,l in pairs(t.layers) do
      o.layers[i] = {
        -- map = t.map
        bias = l.bias,
        neurons = {}
      }
      for j,n in pairs(l.neurons) do
        o.layers[i].neurons[j] = {weights={}}
        for k,w in pairs(n.weights) do
          o.layers[i].neurons[j].weights[k] = w
        end
      end
    end
    return o
  end,
  mutate = function(t,rate)
    for i,l in pairs(t.layers) do
      for j,n in pairs(l.neurons) do
        for k,w in pairs(n.weights) do
          n.weights[k] += rnd(rate*2)-rate
        end
      end
    end
  end
}
