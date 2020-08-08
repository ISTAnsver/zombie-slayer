Sprite = {}

function Sprite:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    return o
end

function Sprite:draw(position)
    love.graphics.draw(
        self.image,
        self.quad,
        math.floor(position.x),
        math.floor(position.y),
        0,
        1,
        1,
        self.offset.x,
        self.offset.y
    )
end