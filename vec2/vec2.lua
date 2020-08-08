Vec2 = {}

function Vec2:new(o)
    o = o or { x = 0, y = 0 }
    setmetatable(o, self)
    self.__index = self
    self.__add = self.add
    self.__unm = self.reverse
    return o
end

function Vec2:reverse()
    return Vec2:new{ x = -self.x, y = -self.y }
end

function Vec2:add(vec)
    return Vec2:new{ x = self.x + vec.x, y = self.y + vec.y }
end