require "esc/system"

CollisionSystem = System:new{ requirements = { components = { "body", "rect" }, tags = {} } }

function CollisionSystem:new(o)
    assert(o, "cannot create CollisionSystem ctor argument is nil")
    assert(o.collisionNotifier, "cannot create CollisionSystem table hasn't 'collisionNotifier' field")
    setmetatable(o, self)
    self.__index = self
    return o
end

function CollisionSystem:update(dt, entities)
    for i, entity1 in ipairs(entities) do
        local body1 = entity1:getComponent("body")
        local rect1 = entity1:getComponent("rect")
        for j=i+1,table.getn(entities) do
            local entity2 = entities[j]
            local body2 = entity2:getComponent("body")
            local rect2 = entity2:getComponent("rect")

            if body1.position.x < body2.position.x + rect2.width and
               body1.position.x + rect1.width > body2.position.x and
               body1.position.y < body2.position.y + rect2.height and
               body1.position.y + rect1.height > body2.position.y then

                local relationAB1 = rect1.width / rect1.height
                local relationBA1 = rect1.height / rect1.width
                local relationAB2 = rect2.width / rect2.height
                local relationBA2 = rect2.height / rect2.width
                local midX1 = (body1.position.x + rect1.width) / 2
                local midY1 = (body1.position.y + rect1.height) / 2
                local midX2 = (body2.position.x + rect2.width) / 2
                local midY2 = (body2.position.x + rect2.height) / 2

                if rect1.width < rect1.height then
                    midX1 = midX1 * relationBA1
                else
                    midY1 = midY1 * relationAB1
                end
                if rect2.width < rect1.height then
                    midX2 = midX2 * relationBA2
                else
                    midY2 = midY2 * relationAB2
                end
                local diffMidX = midX1 - midX2
                local diffMidY = midY1 - midY2

                local diffMidXAbs = math.abs(diffMidX)
                local diffMidYAbs = math.abs(diffMidY)

                if diffMidXAbs > diffMidYAbs then
                    if diffMidX < 0 then
                        body1.position.x = body2.position.x - rect1.width
                    else
                        body1.position.x = body2.position.x + rect2.width
                    end
                    body1.velocity.x = 0
                    body2.velocity.x = 0
                else
                    if diffMidY < 0 then
                        body1.position.y = body2.position.y - rect1.height
                    else
                        body1.position.y = body2.position.y + rect2.height
                    end
                    body1.velocity.y = 0
                    body2.velocity.y = 0
                end

                self.collisionNotifier:notify(entity1, entity2)
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