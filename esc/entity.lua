require "esc/component-data-proxy"

local id = 0

Entity = {}

function Entity:new(o)
    o = o or { id = id, components = {}, tags = {} }
    id = id + 1
    setmetatable(o, self)
    self.__index = self
    return o;
end

function Entity:addComponent(component)
    if self.components[component.name] == nil then
        self.components[component.name] = {}
    end
    table.insert(self.components[component.name], ComponentDataProxy:new(component))
end

-- use to get list of components a specified type
function Entity:getComponents(name)
    return self.components[name]
end

-- use if you sure that entity has exactly one component a specified type
function Entity:getComponent(name)
    return self.components[name][1]
end

function Entity:removeComponent(component)
    for i=1,table.getn(self.components[component.name]) do
        if self.components[component.name][i] == component then
            table.remove(self.components[component.name], i)
            return
        end
    end
    if table.getn(self.components[component.name]) == 0 then
        self.components[component.name] = nil
    end
end

function Entity:addTag(tag)
    assert(type(tag) == "string", "Argument tag should be string value")
    table.insert(self.tags, tag)
end

function Entity:hasTag(tag)
    assert(type(tag) == "string", "Argument tag should be string value")
    for i=1,table.getn(self.tags) do
        if self.tags[i] == tag then
            table.remove(self.tags, i)
            return true
        end
    end

    return false
end

function Entity:removeTag(tag)
    assert(type(tag) == "string", "Argument tag should be string value")
    for i=1,table.getn(self.tags) do
        if self.tags[i] == tag then
            table.remove(self.tags, i)
            return
        end
    end
end