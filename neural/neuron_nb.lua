-- require vendor/pow
_neuron = _{
  new = function(t,a)
    merge(t,{weights={}},a)
  end,
  co = function(t,inputs)
    local total = 0
    for k,i in pairs(inputs) do
      total += i * t.weights[k]
    end
    return t:squash(total+t.bias)
  end,
  squash=function(t,x)return 1/(1+pow(2.71828,-x))end,
}
-- expect _neuron
