require "world/object"

World = {}

function World:new(o)
    o = o or { objects = {} }
    setmetatable(o, self)
    self.__index = self
    return o
end

function World:createObject()
    local object = Object:new()
    table.insert(self.objects, object)
    return object
end