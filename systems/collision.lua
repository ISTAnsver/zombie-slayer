require "esc/system"

CollisionSystem = System:new{ requirements = { "body", "rect" } }

function CollisionSystem:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function CollisionSystem:update(dt, entities)
    for i, entity_1 in ipairs(entities) do
        local body_1 = entity_1:getComponent("body")
        local rect_1 = entity_1:getComponent("rect")
        for j=i+1,table.getn(entities) do
            local entity_2 = entities[j]
            local body_2 = entity_2:getComponent("body")
            local rect_2 = entity_2:getComponent("rect")

            if body_1.position.x < body_2.position.x + rect_2.width and
               body_1.position.x + rect_1.width > body_2.position.x and
               body_1.position.y < body_2.position.y + rect_2.height and
               body_1.position.y + rect_1.height > body_2.position.y then
                print("Collision detected!")
            end
        end
    end
end

function CollisionSystem:draw(entities)
    for i, entity in ipairs(entities) do
        local body = entity:getComponent("body")
        local rect = entity:getComponent("rect")
        love.graphics.rectangle("line", body.position.x, body.position.y, rect.width, rect.height)
    end
end