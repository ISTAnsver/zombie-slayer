System = {}

function System:new(o)
    o = o or { requirements = {} }
    setmetatable(o, self)
    self.__index = self
    return o
end

function System:match(entity)
    for i=1,table.getn(self.requirements) do
        if entity:getComponents(self.requirements[i]) == nil then
            return false
        end
    end
    return true
end

function System:update(dt, entities)
end

function System:draw(entities)
end