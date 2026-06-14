-- Josiah Winslow
function bind(f,v,...) return v==nil and f or bind(function(...) return f(v,...) end,...) end
