require "esc/component"

local function createAnimationComponent(o)
  local animation = Component:new{
    name = "animation",
    data = o or {
      frames = nil,
      duration = 0
    }
  }
  animation.data.passedTime = 0
  animation.data.currentFrameIndex = 1
  return animation
end

return {
  createAnimationComponent = createAnimationComponent
}