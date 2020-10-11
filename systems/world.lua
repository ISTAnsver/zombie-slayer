require "esc/system"
require "vec2/vec2"

WorldSystem = System:new{ requirements = { components = { "body" }, tags = {} } }

function WorldSystem:new(o)
    o = o or { meter = 100, gravity = 9.8 }
    setmetatable(o, self)
    self.__index = self
    return o
end

function WorldSystem:update(dt, entities)
    for i, entity in ipairs(entities) do
        local body = entity:getComponent("body")
        for j = 1,table.getn(body.forces) do
            body.velocity = body.velocity + body.forces[j] * self.meter * dt
        end
        body.forces = {}

        local direction = body.velocity:unit()
        local fr_force = Vec2:new()

        if body.velocity.x ~= 0 or body.velocity.y ~= 0 then
            fr_force = self.gravity * 0.5 * -direction * self.meter
        end

        if body.velocity.x ~= 0 then
            if body.velocity.x < 0 and body.velocity.x + fr_force.x * dt > 0 then
                body.velocity.x = 0
            elseif body.velocity.x > 0 and body.velocity.x + fr_force.x * dt < 0 then
                body.velocity.x = 0
            else
                body.velocity.x = body.velocity.x + fr_force.x * dt
            end
        end

        if body.velocity.y ~= 0 then
            if body.velocity.y < 0 and body.velocity.y + fr_force.y * dt > 0 then
                body.velocity.y = 0
            elseif body.velocity.y > 0 and body.velocity.y + fr_force.y * dt < 0 then
                body.velocity.y = 0
            else
                body.velocity.y = body.velocity.y + fr_force.y * dt
            end
        end

        if body.velocity_limit ~= nil then
            if body.velocity.x > body.velocity_limit then
                body.velocity.x = body.velocity_limit
            end
            if body.velocity.x < -body.velocity_limit then
                body.velocity.x = -body.velocity_limit
            end
            if body.velocity.y > body.velocity_limit then
                body.velocity.y = body.velocity_limit
            end
            if body.velocity.y < -body.velocity_limit then
                body.velocity.y = -body.velocity_limit
            end
        end

        body.position = body.position + body.velocity * dt
    end
end

function WorldSystem:onCollision(entity_1, entity_2)
    -- do physic changes here (like velocity changing and so on) in the next iteration
end

function WorldSystem:setGravity(number)
    self.gravity = number
end

function WorldSystem:setMeter(pixels)
    self.meter = pixels
end