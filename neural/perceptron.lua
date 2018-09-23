-- require neural/neuron_layer
_mlp = _{
  new = function(t,a)
    merge(t,{
      learning_rate = 0.5,
    },a)
    -- inputs is a thing
    t.hidden_layer = _neuron_layer{count=t.hidden}
    t.output_layer = _neuron_layer{count=t.outputs}

    t:iwfithln(t.hidden_layer_weights)
    t:iwfhlntoln(t.output_layer_weights)
  end,
  iwfithln = function(t,hlw)
    for i, n in pairs(t.hidden_layer.neurons) do
      for j=1, t.inputs do
        n.weights[j] = (hlw and hlw[j] or rnd())
      end
    end
  end,
  iwfhlntoln = function(t,olw)
    for i, n in pairs(t.output_layer.neurons) do
      for j=1, t.hidden_layer.count do
        n.weights[j] = (olw and olw[j] or rnd())
      end
    end
  end,
  -- inspect = function(t)
  --   printh('-------')
  --   printh('inputs: '..t.inputs)
  --   printh('hidden layer:')
  --   t.hidden_layer:inspect()
  --   printh('output layer:')
  --   t.output_layer:inspect()
  --   printh('-----')
  -- end,
  ff = function(t,inputs)
    -- printh('feeding forward with')
    -- printh(inputs)
    local hlo = t.hidden_layer:ff(inputs)
    -- printh('hlo with')
    -- printh(hlo)
    return t.output_layer:ff(hlo)
  end,
  train = function(t,ti,to)
    -- printh('training with ')
    -- printh(ti)
    t:ff(ti)
    -- 1
    pewontni = {}
    for i,n in pairs(t.output_layer.neurons) do
      pewontni[i] = n:cpewtni(to[i])
    end
    -- printh('2?')
    -- 2
    pewhntni = {}
    for i,n in pairs(t.hidden_layer.neurons) do

      local dewhno = 0
      for j,on in pairs(t.output_layer.neurons) do
        dewhno += pewontni[j] * on.weights[i]

      end
      pewhntni[i] = dewhno * n:cptniwi()
      -- pewontni[i] = n:cpewtni(to[i])
    end
    -- 3
    for o,n in pairs(t.output_layer.neurons) do
      for w_ho,w in pairs(n.weights) do
        local pd_error_wrt_weight = pewontni[o] * n:cptniww(w_ho)
        n.weights[w_ho] -= t.learning_rate * pd_error_wrt_weight
      end
    end
    -- 4
    for h,n in pairs(t.hidden_layer.neurons) do
      for w_ih, w in pairs(n.weights) do
        local pd_error_wrt_weight = pewhntni[h] * n:cptniww(w_ih)
        n.weights[w_ih] -= t.learning_rate * pd_error_wrt_weight
      end
    end
  end,
  cte = function(t,ts)
    local te = 0
    -- for i, s in pairs(ts) do
      local ti, to = ts[1],ts[2]
      t:ff(ti)
      for o,v in pairs(to) do
        te += t.output_layer.neurons[o]:ce(v)
      end
    -- end
    return te
  end
}
