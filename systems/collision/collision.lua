require "esc/system"

CollisionSystem = System:new{ requirements = { components = { "body", "rect" }, tags = {} } }

function CollisionSystem:new(o)
    assert(o, "cannot create CollisionSystem ctor argument is nil")
    assert(o.collision_notifier, "cannot create CollisionSystem table hasn't 'collision_notifier' field")
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

                local relation_a_b_1 = rect_1.width / rect_1.height
                local relation_b_a_1 = rect_1.height / rect_1.width
                local relation_a_b_2 = rect_2.width / rect_2.height
                local relation_b_a_2 = rect_2.height / rect_2.width
                local mid_x_1 = (body_1.position.x + rect_1.width) / 2
                local mid_y_1 = (body_1.position.y + rect_1.height) / 2
                local mid_x_2 = (body_2.position.x + rect_2.width) / 2
                local mid_y_2 = (body_2.position.x + rect_2.height) / 2

                if rect_1.width < rect_1.height then
                    mid_x_1 = mid_x_1 * relation_b_a_1
                else
                    mid_y_1 = mid_y_1 * relation_a_b_1
                end
                if rect_2.width < rect_1.height then
                    mid_x_2 = mid_x_2 * relation_b_a_2
                else
                    mid_y_2 = mid_y_2 * relation_a_b_2
                end
                local diff_mid_x = mid_x_1 - mid_x_2
                local diff_mid_y = mid_y_1 - mid_y_2

                local diff_mid_x_abs = math.abs(diff_mid_x)
                local diff_mid_y_abs = math.abs(diff_mid_y)

                if diff_mid_x_abs > diff_mid_y_abs then
                    if diff_mid_x < 0 then
                        body_1.position.x = body_2.position.x - rect_1.width
                    else
                        body_1.position.x = body_2.position.x + rect_2.width
                    end
                    body_1.velocity.x = 0
                else
                    if diff_mid_y < 0 then
                        body_1.position.y = body_2.position.y - rect_1.height
                    else
                        body_1.position.y = body_2.position.y + rect_2.height
                    end
                    body_1.velocity.y = 0
                end

                self.collision_notifier:notify(entity_1, entity_2)
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