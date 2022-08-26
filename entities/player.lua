require "esc/component"
require "esc/entity"

require "math/rect"

local bodyFactory = require "components/body"
local rectFactory = require "components/rect"
local spriteFactory = require "components/sprite"
local animationFactory = require "components/animation"

Player = Entity:new()

function Player:new(o)
  o = o or { }
  setmetatable(o, self)
  self.__index = self
  o:addTag("player")
  local body = bodyFactory.createBodyComponent()
  body.data.velocityLimit = 1
  o:addComponent(body)
  o:addComponent(spriteFactory.createSpriteComponent{
    -- TODO preaload images and use the same preloaded in different places
    srcImage = love.graphics.newImage("assets/characters/player.png"),
    offset = { x = 10, y = 17 },
    dimensions = Rect:new({
      width = 27,
      height = 47
    })
  })
  o:addComponent(rectFactory.createRectComponent(
      Rect:new({
        width = 48,
        height = 64
      })))
  o:addComponent(animationFactory.createAnimationComponent{
    duration = 0.2,
    idle = {
      frames = {
        love.graphics.newQuad(10,  17, 27, 47, 192, 256),
      }
    },
    back = {
      frames = {
        love.graphics.newQuad(10,  17, 27, 47, 192, 256),
        love.graphics.newQuad(58,  17, 27, 47, 192, 256),
        love.graphics.newQuad(106, 17, 27, 47, 192, 256),
        love.graphics.newQuad(154, 17, 27, 47, 192, 256),
      }
    },
    left = {
      frames = {
        love.graphics.newQuad(10,  81, 27, 47, 192, 256),
        love.graphics.newQuad(58,  81, 27, 47, 192, 256),
        love.graphics.newQuad(106, 81, 27, 47, 192, 256),
        love.graphics.newQuad(154, 81, 27, 47, 192, 256),
      }
    },
    right = {
      frames = {
        love.graphics.newQuad(10,  145, 27, 47, 192, 256),
        love.graphics.newQuad(58,  145, 27, 47, 192, 256),
        love.graphics.newQuad(106, 145, 27, 47, 192, 256),
        love.graphics.newQuad(154, 145, 27, 47, 192, 256),
      }
    },
    forward = {
      frames = {
        love.graphics.newQuad(10,  209, 27, 47, 192, 256),
        love.graphics.newQuad(58,  209, 27, 47, 192, 256),
        love.graphics.newQuad(106, 209, 27, 47, 192, 256),
        love.graphics.newQuad(154, 209, 27, 47, 192, 256),
      }
    },
    animator = function(self)
      local animation = "idle"
    
      if self.state.direction.x > 0 then
        animation = "right"
      end
      
      if self.state.direction.x < 0 then
        animation = "left"
      end
      
      if self.state.direction.y > 0 then
        animation = "back"
      end
      
      if self.state.direction.y < 0 then
        animation = "forward"
      end
    
      return animation
    end
  })
  return o
end