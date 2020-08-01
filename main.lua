local sti = require "modules/sti"

function love.load()

    mv_force_delta = 7; 

    image = love.graphics.newImage("assets/characters/player.png")

    down = love.graphics.newQuad(48 * 0, 64 * 0, 48, 64, image:getDimensions())
    left = love.graphics.newQuad(48 * 0, 64 * 1, 48, 64, image:getDimensions())
    right = love.graphics.newQuad(48 * 0, 64 * 2, 48, 64, image:getDimensions())
    forward = love.graphics.newQuad(48 * 0, 64 * 3, 48, 64, image:getDimensions())

    current_quad = down

    map = sti("assets/levels/level_0.lua")
    spawn = {}
    for k, object in pairs(map.objects) do
        if object.name == "player_spawn" then
            spawn = object
            break
        end
    end

    local sprites = map:addCustomLayer("Sprites", 4)
    sprites.player = {
        sprite = image,
        x = spawn.x,
        y = spawn.y,
        ox = 48 / 2,
        oy = 64 / 2,
        speed = {
            x = 0,
            y = 0
        },
        max_speed = {
            x = 100,
            y = 100
        },
        mv_force = {
            x = 0,
            y = 0
        },
        fr_force = {
            x = 0,
            y = 0
        }
    }

    sprites.update = function(self, dt)
        -- calculate movement
        direction = {
            horizontal = 0,
            vertical = 0
        }
        if love.keyboard.isDown("w") then
            if direction.horizontal == 0 then
                direction.vertical = direction.vertical - 1
            else
                direction.vertical = direction.vertical - 0.5
                direction.horizontal = direction.horizontal * 0.5
            end
        end
        if love.keyboard.isDown("s") then
            if direction.horizontal == 0 then
                direction.vertical = direction.vertical + 1
            else
                direction.vertical = direction.vertical + 0.5
                direction.horizontal = direction.horizontal * 0.5
            end
        end
        if love.keyboard.isDown("d") then
            if direction.vertical == 0 then
                direction.horizontal = direction.horizontal + 1
            else
                direction.horizontal = direction.horizontal + 0.5
                direction.vertical = direction.vertical * 0.5
            end
        end
        if love.keyboard.isDown("a") then
            if direction.vertical == 0 then
                direction.horizontal = direction.horizontal - 1
            else
                direction.horizontal = direction.horizontal - 0.5
                direction.vertical = direction.vertical * 0.5
            end
        end

        direction_affection = {
            horizontal = direction.horizontal ~= 0 and math.abs(direction.horizontal) or 1,
            vertical = direction.vertical ~= 0 and math.abs(direction.vertical) or 1
        }

        self.player.mv_force.x = mv_force_delta * direction.horizontal
        self.player.mv_force.y = mv_force_delta * direction.vertical

        self.player.speed.x = self.player.speed.x + self.player.mv_force.x * dt * 100
        self.player.speed.y = self.player.speed.y + self.player.mv_force.y * dt * 100

        -- calculate friction
        if self.player.speed.x ~= 0 then
            self.player.fr_force.x = 9.8 * direction_affection.horizontal * 0.5 * self.player.speed.x / math.sqrt(self.player.speed.x^2 + self.player.speed.y^2) * 100
        end
        if self.player.speed.y ~= 0 then
            self.player.fr_force.y = 9.8 * direction_affection.vertical * 0.5 * self.player.speed.y / math.sqrt(self.player.speed.x^2 + self.player.speed.y^2) * 100
        end

        if self.player.speed.x ~= 0 then
            if self.player.speed.x < 0 and self.player.speed.x - self.player.fr_force.x * dt > 0 then
                self.player.speed.x = 0
            elseif self.player.speed.x > 0 and self.player.speed.x - self.player.fr_force.x * dt < 0 then
                self.player.speed.x = 0
            else
                self.player.speed.x = self.player.speed.x - self.player.fr_force.x * dt
            end
        end

        if self.player.speed.y ~= 0 then
            if self.player.speed.y < 0 and self.player.speed.y - self.player.fr_force.y * dt > 0 then
                self.player.speed.y = 0
            elseif self.player.speed.y > 0 and self.player.speed.y - self.player.fr_force.y * dt < 0 then
                self.player.speed.y = 0
            else
                self.player.speed.y = self.player.speed.y - self.player.fr_force.y * dt
            end
        end

        -- limit max speed
        if self.player.speed.x > self.player.max_speed.x * direction_affection.horizontal then
            self.player.speed.x = self.player.max_speed.x * direction_affection.horizontal
        end
        if self.player.speed.x < - self.player.max_speed.x * direction_affection.horizontal then
            self.player.speed.x = - self.player.max_speed.x * direction_affection.horizontal
        end
        if self.player.speed.y > self.player.max_speed.y * direction_affection.vertical then
            self.player.speed.y = self.player.max_speed.y * direction_affection.vertical
        end
        if self.player.speed.y < - self.player.max_speed.y * direction_affection.vertical then
            self.player.speed.y = - self.player.max_speed.y * direction_affection.vertical
        end

        --calculate position
        self.player.x = self.player.x + self.player.speed.x * dt
        self.player.y = self.player.y + self.player.speed.y * dt
    end

    sprites.draw = function(self)
        local quad = current_quad
        if direction.horizontal == 1 and sprites.player.speed.x > 0 then
            quad = right
        end
        if direction.horizontal == -1 and sprites.player.speed.x < 0 then
            quad = left
        end
        if direction.vertical == 1 and sprites.player.speed.y > 0 then
            quad = down
        end
        if direction.vertical == -1 and sprites.player.speed.y < 0 then
            quad = forward
        end
        current_quad = quad

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
	end

end

function love.update(dt)
    map:update(dt)
end

function love.draw()
    map:draw(40, 0, 2, 2)
end