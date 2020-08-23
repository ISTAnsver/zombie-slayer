Object = {}

function Object:new(o)
    o = o or { forces = {} }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Object:applyForce(vec2)
    table.insert(self.forces, vec2)
end

function Object:popForces()
    return table.unpack()
end