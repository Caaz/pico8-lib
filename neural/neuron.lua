-- require vendor/pow
_neuron = _{
  new = function(t,a)
    merge(t,{bias = 0,weights ={}},a)
  end,
  co = function(t,inputs)
    t.inputs = inputs
    t.output = t:squash(t:ctni())
    return t.output
  end,
  ctni = function(t)
    local total = 0
    for k,i in pairs(t.inputs) do
      total += i * t.weights[k]
    end
    return total + t.bias
  end,
  squash=function(t,x)return 1/(1+pow(2.71828,-x))end,
  cpewtni = function(t,to)
    return t:cpewo(to)*t:cptniwi()
  end,
  ce = function(t,o)
    return .5*(o-t.output)*(o-t.output)
  end,
  cpewo = function(t,to)
    return -(to-t.output)
  end,
  cptniwi = function(t)
    return t.output*(1-t.output)
  end,
  cptniww = function(t,i)
    return t.inputs[i]
  end
}
-- expect _neuron
