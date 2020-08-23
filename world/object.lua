require "vec2/vec2"

Object = {}

function Object:new(o)
    o = o or { forces = {}, velocity = Vec2:new{0, 0}, position = Vec2:new{0, 0} }
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