require "world/object"

World = {}

function World:new(o)
    o = o or { objects = {}, meter = 100, gravity = 9.8 }
    setmetatable(o, self)
    self.__index = self
    return o
end

function World:setGravity(number)
    self.gravity = number
end

function World:setMeter(pixels)
    self.meter = pixels
end

function World:update(dt)
    for i = 1,table.getn(self.objects) do
        local object = self.objects[i]
        local forces = object:popForces()
        for j = 1,table.getn(forces) do
            object.velocity = object.velocity + forces[j] * self.meter * dt
        end

       -- print(object.velocity.x .. " " .. object.velocity.y)

        local direction = self.objects[i].velocity:unit()
        local fr_force = Vec2:new()

        if object.velocity.x ~= 0 or object.velocity.y ~= 0 then
            fr_force = self.gravity * 0.5 * -direction * self.meter
        end

        if object.velocity.x ~= 0 then
            if object.velocity.x < 0 and object.velocity.x + fr_force.x * dt > 0 then
                object.velocity.x = 0
            elseif object.velocity.x > 0 and object.velocity.x + fr_force.x * dt < 0 then
                object.velocity.x = 0
            else
                object.velocity.x = object.velocity.x + fr_force.x * dt
            end
        end

        if object.velocity.y ~= 0 then
            if object.velocity.y < 0 and object.velocity.y + fr_force.y * dt > 0 then
                object.velocity.y = 0
            elseif object.velocity.y > 0 and object.velocity.y + fr_force.y * dt < 0 then
                object.velocity.y = 0
            else
                object.velocity.y = object.velocity.y + fr_force.y * dt
            end
        end

        object.position = object.position + object.velocity * dt
    end
end

function World:draw()
    for i = 1,table.getn(self.objects) do
        self.objects[i]:draw()
    end
end

function World:createObject()
    local object = Object:new()
    table.insert(self.objects, object)
    return object
end