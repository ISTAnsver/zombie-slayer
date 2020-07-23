local sti = require "modules/sti"

function love.load()
    sprite_sheet = { sprite = { width = 48, height = 64 }, columns_count = 4, rows_count = 4 }
    image = love.graphics.newImage("assets/characters/player.png")
    quad = love.graphics.newQuad(0, 0, sprite_sheet.sprite.width, sprite_sheet.sprite.height, image:getDimensions())
    map = sti("assets/levels/level_0.lua")
end

function love.update(dt)
    map:update(dt)
end

function love.draw()
    love.graphics.scale(2, 2)
    map:draw(40, 0, 2, 2)
    love.graphics.draw(image, quad, 200, 200)
end