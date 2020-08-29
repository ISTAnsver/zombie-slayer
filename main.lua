require "world/world"
local sti = require "modules/sti"
local sprite_loader = require "sprite-loader/sprite-loader"


function love.load()
    local image = love.graphics.newImage("assets/characters/player.png")
    local sprites = sprite_loader.load(image, { cols = 4, rows = 4})
    
    WORLD = World:new()
    PLAYER = WORLD:createObject()
    PLAYER.sprite = DOWN

    DOWN = sprites[1][1]
    LEFT = sprites[2][1]
    RIGTH = sprites[3][1]
    FORWARD = sprites[4][1]
end

function love.update(dt)
    local direction = Vec2:new()
    if love.keyboard.isDown("w") then
        direction.y = direction.y - 1
        PLAYER.sprite = FORWARD
    end
    if love.keyboard.isDown("s") then
        direction.y = direction.y + 1
        PLAYER.sprite = DOWN
    end
    if love.keyboard.isDown("d") then
        direction.x = direction.x + 1
        PLAYER.sprite = RIGTH
    end
    if love.keyboard.isDown("a") then
        direction.x = direction.x - 1
        PLAYER.sprite = LEFT
    end

    local directions = (math.abs(direction.x) + math.abs(direction.y))
    local value = directions > 1 and 4.9497474683058 or 7
    local force = Vec2:new{ x = value * direction.x, y = value * direction.y }
    PLAYER:applyForce(force)
    WORLD:update(dt)
end

function love.draw()
    map:draw(40, 0, 2, 2)
    love.graphics.push()
    love.graphics.scale(2, 2)
    WORLD:draw()
    love.graphics.pop()
end