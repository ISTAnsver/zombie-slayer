require "esc/component"
require "vec2/vec2"

local function create_body_component(o)
    return Component:new{
        name = "body",
        data = o or {
            position = Vec2:new(),
            velocity = Vec2:new(),
            forces = { },
            velocity_limit = nil
        }
    }
end

return {
    create_body_component = create_body_component
}
