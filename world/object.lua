require "vec2/vec2"

Object = {}

function Object:new(o)
    o = o or { forces = {}, velocity = Vec2:new(), position = Vec2:new(), sprite = nil }
    setmetatable(o, self)
    self.__index = self
    return o
end

function Object:draw()
    if (self.sprite) then
        self.sprite:draw(self.position);
    end
end

function Object:applyForce(vec2)
    table.insert(self.forces, vec2)
end

function Object:popForces()
    local forces = self.forces
    self.forces = {}
    return forces
end