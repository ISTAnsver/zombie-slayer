require "esc/system"

SpriteRendererSystem = System:new{ requirements = { components = { "body", "sprite", "rect" }, tags = {} } }

function SpriteRendererSystem:new(o)
  o = o or { }
  setmetatable(o, self)
  self.__index = self
  return o
end

function SpriteRendererSystem:draw(entities)
  for i, entity in ipairs(entities) do
    local body = entity:getComponent("body")
    local sprite = entity:getComponent("sprite")
    local rect = entity:getComponent("rect")
    
    -- need to create UI tool to calculate offset and size of sprite
    -- sprite must be centered in rect or rect must be equal to the sprite size
    love.graphics.draw(
      sprite.srcImage,
      sprite.frame,
      math.floor(body.position.x + rect.center.x - sprite.dimensions.center.x),
      math.floor(body.position.y + rect.center.y - sprite.dimensions.center.y),
      0,
      1,
      1
      )
  end
end