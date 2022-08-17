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
    
    -- 13 and 23 are consts calculated from real size of player sprite
    -- 27(width) / 2 - center of sprite by x
    -- 47(height) / 2 - center of sprite by y
    -- 10 and 17 are offsets by x and y
    -- need to create desc structure of this thing and after UI tool
    -- sprite must be centered in rect or rect must be equal to the sprite size
    love.graphics.draw(
      sprite.src_image,
      sprite.frame,
      math.floor(body.position.x + rect.width / 2 - 13),
      math.floor(body.position.y + rect.height / 2 - 23),
      0,
      1,
      1
      )
  end
end