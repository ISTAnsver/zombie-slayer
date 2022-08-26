-- require "world/world"
-- local sti = require "modules/sti"
-- local sprite_loader = require "sprite-loader/sprite-loader"

require "esc/entity"
require "esc/component"
require "esc/system"
require "esc/engine"

require "systems/world"
require "systems/sprite-animation"
require "systems/sprite-renderer"
require "systems/controller"
require "systems/collision/collision"
require "systems/collision/collision-notifier"

require "entities/player"
require "entities/dummy"

local engine = Engine:new()

function love.load()
  local player = Player:new()
  local dummy = Dummy:new()
  
  local worldSystem = WorldSystem:new()
  local spriteRendererSystem = SpriteRendererSystem:new()
  local collisionNotifier = CollisionNotifier:new{ worldSystem }
  engine:load({
    SpriteAnimationSystem:new(),
    spriteRendererSystem,
    worldSystem,
    ControllerSystem:new(),
    CollisionSystem:new{
      collisionNotifier = collisionNotifier
      }
    }, {
      player,
      dummy
    }
  )
  -- local image = love.graphics.newImage("assets/characters/player.png")
  -- local sprites = sprite_loader.load(image, { cols = 4, rows = 4})
  
  -- WORLD = World:new()
  -- PLAYER = WORLD:createObject()
  -- PLAYER.sprite = DOWN

  -- DOWN = sprites[1][1]
  -- LEFT = sprites[2][1]
  -- RIGTH = sprites[3][1]
  -- FORWARD = sprites[4][1]

  -- MAP = sti("assets/levels/level_0.lua")
end

function love.update(dt)
  engine:input()
  engine:update(dt)
end

function love.draw()
  engine:draw()
end