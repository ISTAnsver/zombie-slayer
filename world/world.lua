require "world/object"

World = {}

function World:new(o)
    o = o or { objects = {}, meter = 100 }
    setmetatable(o, self)
    self.__index = self
    return o
end

function World:setMeter(pixels)
    self.meter = pixels
end

function World:createObject()
    local object = Object:new()
    table.insert(self.objects, object)
    return object
end