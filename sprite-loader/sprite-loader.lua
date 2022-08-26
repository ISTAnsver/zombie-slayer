require "sprite-loader/sprite"

local function load(image, grid) -- should take sprite atlas description (image, cols, rows, and array of animation names) and return sprite atlas
    local width, height = image:getDimensions()
    local columnWidht = width / grid.cols
    local rowHeight = height / grid.rows
    local sprites = {}
    for row=0,height,rowHeight do
        local string = {} -- string of sprites
        for col=0,width,columnWidht do
            local quad = love.graphics.newQuad(col, row, columnWidht, rowHeight, width, height)
            table.insert(string, Sprite:new{ image = image, quad = quad, offset = { x = columnWidht / 2, y = rowHeight / 2 }})
        end
        table.insert(sprites, string);
    end

    return sprites;
end

local spriteLoader = {
    load = load
}

return spriteLoader
