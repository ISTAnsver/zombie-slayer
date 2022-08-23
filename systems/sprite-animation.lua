require "esc/system"

SpriteAnimationSystem = System:new{ requirements = { components = { "sprite", "animation" }, tags = {} } }
local changeCurrent
local updateSpriteFrame

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
    
    if animation.animator == nil then
      goto continue
    end
    
    changeCurrent(animation, dt)
    updateSpriteFrame(sprite, animation)
    ::continue::
  end
end

changeCurrent = function(animation, dt)
  local nextAnimation = animation:animator()
  if animation.current ~= nextAnimation then
    animation.passedTime = 0
    animation.currentFrameIndex = 1
    animation.current = nextAnimation
  else
    animation.passedTime = animation.passedTime + dt
  end
end

updateSpriteFrame = function(sprite, animation)
  if animation.passedTime < animation.duration then
    return
  end

  local frames = animation[animation.current].frames
  animation.currentFrameIndex = animation.currentFrameIndex + 1
  if animation.currentFrameIndex > table.getn(frames) then
    animation.currentFrameIndex = 1
  end
  sprite.frame = frames[animation.currentFrameIndex]
  animation.passedTime = animation.passedTime - animation.duration
end