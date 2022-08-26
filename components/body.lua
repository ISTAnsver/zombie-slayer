require "esc/component"
require "math/vec2"

local function createBodyComponent(o)
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
    createBodyComponent = createBodyComponent
}
