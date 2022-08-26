Vec2 = {}

function Vec2:new(o)
    o = o or { x = 0, y = 0 }
    setmetatable(o, self)
    self.__index = self
    self.__add = self.add
    self.__sub = self.subtract
    self.__unm = self.reverse
    self.__mul = self.multiply
    return o
end

function Vec2:reverse()
    return Vec2:new{ x = -self.x, y = -self.y }
end

function Vec2.add(vec2l, vec2r)
    return Vec2:new{ x = vec2l.x + vec2r.x, y = vec2l.y + vec2r.y }
end

function Vec2.subtract(vec2l, vec2r)
    return Vec2:new{ x = vec2l.x - vec2r.x, y = vec2l.y - vec2r.y }
end

function Vec2.multiply(argl, argr)
    local num, vec2
    assert((type(argl) == "number" or type(argr) == "number") and type(argl) ~= type(argr), "Multiply support only number argument")
    if (type(argl) == "number") then
        num = argl
        vec2 = argr
    else
        num = argr
        vec2 = argl
    end

    return Vec2:new{ x = vec2.x * num, y = vec2.y * num }
end

function Vec2:length()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vec2:unit()
    local length = Vec2.length(self);
    return Vec2:new{ x = self.x / length, y = self.y / length }
end