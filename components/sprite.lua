require "esc/component"
require "math/rect"

local function createSpriteComponent(o)
  local sprite = Component:new{
    name = "sprite",
    data = o or {
      srcImage = nil,
      frame = nil,
      offset = nil,
      dimensions = Rect:new(nil)
    }
  }
  if sprite.data.srcImage ~= nil and 
     sprite.data.offset ~= nil and
     sprite.data.dimensions ~= nil then
    local imageWidth, imageHeight = sprite.data.srcImage:getPixelDimensions()
    sprite.data.frame = love.graphics.newQuad(
      sprite.data.offset.x, 
      sprite.data.offset.y, 
      sprite.data.dimensions.width, 
      sprite.data.dimensions.height,
      imageWidth,
      imageHeight)
  end
  return sprite
end

return {
  createSpriteComponent = createSpriteComponent
}