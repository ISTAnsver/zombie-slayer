Component = {}

function Component:new(o)
    o = o or { name = "unnamed", data = {} }
    setmetatable(o, self)
    self.__index = self
    return o
end