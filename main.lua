-- require "world/world"
-- local sti = require "modules/sti"
-- local sprite_loader = require "sprite-loader/sprite-loader"

require "esc/entity"
require "esc/component"
require "esc/system"
require "esc/engine"

ENGINE = Engine:new()

function love.load()
    local entity = Entity:new()
    local body_component = Component:new{
        name = "body",
        data = {
            position = { x = 100, y = 100 }
        }
    }
    local sprite_component = Component:new{
        name = "sprite",
        data = {
            image = "assets/characters/player.png",
            quad = love.graphics.newQuad(1, 1, 48, 64, 192, 256),
            offset = { x = 24, y = 32 }
        }
    }
    local renderer_system = System:new{ requirements = { "body", "sprite" } }
    function renderer_system:draw(entity)
        local body = entity:getComponents("body")[1]
        local sprite = entity:getComponents("sprite")[1]
        local image = love.graphics.newImage(sprite.image)
        for k, v in pairs(body) do
            print(k)
        end
        print(body.position)
        print(sprite.image)
        print(sprite.offset.x)
        love.graphics.draw(
            image,
            sprite.quad,
            math.floor(body.position.x),
            math.floor(body.position.y),
            0,
            1,
            1,
            sprite.offset.x,
            sprite.offset.y
        )
    end
    entity:addComponent(body_component)
    entity:addComponent(sprite_component)
    ENGINE:load({ renderer_system }, { entity })
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
    -- local direction = Vec2:new()
    -- if love.keyboard.isDown("w") then
    --     direction.y = direction.y - 1
    --     PLAYER.sprite = FORWARD
    -- end
    -- if love.keyboard.isDown("s") then
    --     direction.y = direction.y + 1
    --     PLAYER.sprite = DOWN
    -- end
    -- if love.keyboard.isDown("d") then
    --     direction.x = direction.x + 1
    --     PLAYER.sprite = RIGTH
    -- end
    -- if love.keyboard.isDown("a") then
    --     direction.x = direction.x - 1
    --     PLAYER.sprite = LEFT
    -- end

    -- local directions = (math.abs(direction.x) + math.abs(direction.y))
    -- local value = directions > 1 and 4.9497474683058 or 7
    -- local force = Vec2:new{ x = value * direction.x, y = value * direction.y }
    -- PLAYER:applyForce(force)
    -- WORLD:update(dt)
end

function love.draw()
    ENGINE:draw()
    -- MAP:draw(40, 0, 2, 2)
    -- love.graphics.push()
    -- love.graphics.scale(2, 2)
    -- WORLD:draw()
    -- love.graphics.pop()
end