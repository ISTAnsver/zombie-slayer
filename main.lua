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

ENGINE = Engine:new()

BODY_FACTORY = require "components/body"
RECT_FACTORY = require "components/rect"
SPRITE_FACTORY = require "components/sprite"
ANIMATION_FACTORY = require "components/animation"

BODY = BODY_FACTORY.create_body_component()
BODY.data.velocity_limit = 100

function love.load()
    local entity = Entity:new()
    local entity_2 = Entity:new()
    local sprite_component = SPRITE_FACTORY.createSpriteComponent{
      src_image = love.graphics.newImage("assets/characters/player.png"),
      frame = love.graphics.newQuad(10, 17, 27, 47, 192, 256)
    }
    
    entity:addComponent(BODY)
    entity:addComponent(sprite_component)
    entity:addComponent(RECT_FACTORY.create_rect_component{ width = 48, height = 64 })
    entity:addComponent(ANIMATION_FACTORY.createAnimationComponent{
      duration = 0.2,
      frames = {
        love.graphics.newQuad(10,  17, 27, 47, 192, 256),
        love.graphics.newQuad(58,  17, 48, 64, 192, 256),
        love.graphics.newQuad(106, 17, 48, 64, 192, 256),
        love.graphics.newQuad(154, 17, 48, 64, 192, 256),
      }
    })
    entity:addTag("player")
    entity_2:addComponent(BODY_FACTORY.create_body_component{
        position = Vec2:new{ x = 300, y = 300 },
        velocity = Vec2:new(),
        forces = { },
        velocity_limit = nil
    })
    entity_2:addComponent(sprite_component)
    entity_2:addComponent(RECT_FACTORY.create_rect_component{ width = 48, height = 64 })
    local world_system = WorldSystem:new()
    local sprite_renderer_system = SpriteRendererSystem:new()
    local collision_notifier = CollisionNotifier:new{ renderer_system, world_system }
    ENGINE:load({
      SpriteAnimationSystem:new(),
      sprite_renderer_system,
      world_system,
      ControllerSystem:new(),
      CollisionSystem:new{
        collision_notifier = collision_notifier
        }
      }, {
        entity,
        entity_2 
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
    ENGINE:input()
    ENGINE:update(dt)
end

function love.draw()
    ENGINE:draw()
end