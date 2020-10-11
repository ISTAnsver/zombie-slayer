require "esc/system"

ControllerSystem = System:new{ requirements = { components = { "body" }, tags = { "player" } } }

function ControllerSystem:new(o)
    o = o or { }
    setmetatable(o, self)
    self.__index = self
    return o
end

function ControllerSystem:input(entities)
    local direction = Vec2:new()
    if love.keyboard.isDown("w") then
        direction.y = direction.y - 1
    end
    if love.keyboard.isDown("s") then
        direction.y = direction.y + 1
    end
    if love.keyboard.isDown("d") then
        direction.x = direction.x + 1
    end
    if love.keyboard.isDown("a") then
        direction.x = direction.x - 1
    end

    local directions = (math.abs(direction.x) + math.abs(direction.y))
    local value = directions > 1 and 4.9497474683058 or 7
    local force = Vec2:new{ x = value * direction.x, y = value * direction.y }

    for k, entity in pairs(entities) do
        local body = entity:getComponent("body")
        table.insert(body.forces, force)
    end
end