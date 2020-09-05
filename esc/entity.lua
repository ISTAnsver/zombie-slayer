local id = 0

Entity = {}

function Entity:new(o)
    o = o or { id = id, components = {} }
    id = id + 1
    setmetatable(o, self)
    self.__index = self
    return o;
end