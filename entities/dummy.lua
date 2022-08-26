require "esc/component"
require "esc/entity"

require "math/rect"

local bodyFactory = require "components/body"
local rectFactory = require "components/rect"
local spriteFactory = require "components/sprite"

Dummy = Entity:new()

function Dummy:new(o)
  o = o or { }
  setmetatable(o, self)
  self.__index = self
  
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local collisionRect = Rect:new({
        width = 48,
        height = 64
      })
  o:addComponent(bodyFactory.createBodyComponent{
    position = Vec2:new{
      x = windowWidth / 2 - collisionRect.width / 2,
      y = windowHeight / 2 - collisionRect.height / 2
    },
    velocity = Vec2:new(),
    forces = { },
    velocity_limit = nil
  })
  o:addComponent(spriteFactory.createSpriteComponent{
    -- TODO preaload images and use the same preloaded in different places
    srcImage = love.graphics.newImage("assets/characters/player.png"),
    offset = { x = 10, y = 17 },
    dimensions = Rect:new({
      width = 27,
      height = 47
    })
  })
  o:addComponent(rectFactory.createRectComponent(collisionRect))
  return o
end