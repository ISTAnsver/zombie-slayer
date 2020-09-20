require "esc/component"

local function create_rect_component(o)
    return Component:new{
        name = "rect",
        data = o or {
            width = 0,
            height = 0
        }
    }
end

return {
    create_rect_component = create_rect_component
}