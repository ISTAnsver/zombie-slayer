require "esc/component"

local function createAnimationComponent(o)
  local animation = Component:new{
    name = "animation",
    data = o or {
      duration = 0,
      animator = nil
    }
  }
  animation.data.passedTime = 0
  animation.data.currentFrameIndex = 1
  animation.data.state = nil
  animation.data.current = nil
  return animation
end

return {
  createAnimationComponent = createAnimationComponent
}