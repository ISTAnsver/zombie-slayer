require "esc/system"

SpriteAnimationSystem = System:new{ requirements = { components = { "sprite", "animation" }, tags = {} } }

function SpriteAnimationSystem:new(o)
  o = o or { }
  setmetatable(o, self)
  self.__index = self
  return o
end

function SpriteAnimationSystem:update(dt, entities)
  for i, entity in ipairs(entities) do
    local sprite = entity:getComponent("sprite")
    local animation = entity:getComponent("animation")
    
    animation.passedTime = animation.passedTime + dt
    if animation.passedTime >= animation.duration then
      animation.currentFrameIndex = animation.currentFrameIndex + 1
      if animation.currentFrameIndex > table.getn(animation.frames) then
        animation.currentFrameIndex = 1
      end
      sprite.frame = animation.frames[animation.currentFrameIndex]
      animation.passedTime = animation.passedTime - animation.duration
    end
  end
end