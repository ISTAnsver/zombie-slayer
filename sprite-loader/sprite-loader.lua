require "sprite-loader/sprite"

local function load(image, grid) -- should take sprite atlas description (image, cols, rows, and array of animation names) and return sprite atlas
    width, height = image:getDimensions()
    column_widht = width / grid.cols
    row_height = height / grid.rows
    local sprites = {}
    for row=0,height,row_height do
        local string = {} -- string of sprites
        for col=0,width,column_widht do
            local quad = love.graphics.newQuad(col, row, column_widht, row_height, width, height)
            table.insert(string, Sprite:new{ image = image, quad = quad, offset = { x = column_widht / 2, y = row_height / 2 }})
        end
        table.insert(sprites, string);
    end

    return sprites;
end

local sprite_loader = {
    load = load
}

return sprite_loader
