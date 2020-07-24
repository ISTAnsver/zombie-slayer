local sti = require "modules/sti"

function love.load()
    sprite_sheet = { sprite = { width = 48, height = 64 }, columns_count = 4, rows_count = 4 }
    image = love.graphics.newImage("assets/characters/player.png")
    quad = love.graphics.newQuad(0, 0, sprite_sheet.sprite.width, sprite_sheet.sprite.height, image:getDimensions())
    map = sti("assets/levels/level_0.lua")
    spawn = {}
    for k, object in pairs(map.objects) do
        if object.name == "player_spawn" then
            spawn = object
            break
        end
    end

    local sprites = map:addCustomLayer("Sprites", 4)
    local sw, sh = quad:getTextureDimensions()
    sprites.player = {
        sprite = image,
        x = spawn.x,
        y = spawn.y,
        ox = 48 / 2,
        oy = 64 / 2
    }

    sprites.draw = function(self)
		love.graphics.draw(
            self.player.sprite,
            quad,
			math.floor(self.player.x),
			math.floor(self.player.y),
			0,
			1,
			1,
			self.player.ox,
			self.player.oy
		)

		-- Temporarily draw a point at our location so we know
		-- that our sprite is offset properly
		love.graphics.setPointSize(5)
		love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
	end

end

function love.update(dt)
    map:update(dt)
end

function love.draw()
    map:draw(40, 0, 2, 2)
end