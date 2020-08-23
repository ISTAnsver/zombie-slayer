Object = {}

function Object:new(o)
    o = o or { forces = {} }
    setmetatable(o, self)
    self.__index = self
    return o
end