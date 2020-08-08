Vec2 = {}

function Vec2:new(o)
    o = o or { x = 0, y = 0 }
    setmetatable(o, self)
    self.__index = self
    self.__add = self.add
    return o
end

function Vec2:add(vec)
    return Vec2:new{ x = self.x + vec.x, y = self.x + vec.y }
end