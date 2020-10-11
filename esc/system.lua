System = {}

function System:new(o)
    o = o or { requirements = { components = {}, tags = {} } }
    setmetatable(o, self)
    self.__index = self
    return o
end

function System:match(entity)
    for i=1,table.getn(self.requirements.components) do
        if entity:getComponents(self.requirements.components[i]) == nil then
            return false
        end
    end
    for i=1,table.getn(self.requirements.tags) do
        if entity:hasTag(self.requirements.tags[i]) == false then
            return false
        end
    end
    return true
end

function System:input(entities)
end

function System:update(dt, entities)
end

function System:draw(entities)
end