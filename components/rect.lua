require "esc/component"
require "math/rect"

local function createRectComponent(o)
    return Component:new{
        name = "rect",
        data = o or Rect:new(nil)
    }
end

return {
    createRectComponent = createRectComponent
}