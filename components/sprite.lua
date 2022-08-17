require "esc/component"

local function createSpriteComponent(o)
  return Component:new{
    name = "sprite",
    data = o or {
      src_image = nil,
      frame = nil
    }
  }
end

return {
  createSpriteComponent = createSpriteComponent
}