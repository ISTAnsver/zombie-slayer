Engine = {}

function Engine:new()
    local o = { systems = {}, entities = {} }
    setmetatable(o, self)
    self.__index = self;
    return o;
end

function Engine:load(systems, entities)
    self.systems = systems
    self.entities = entities
end

function Engine:update(dt)
    for j, system in ipairs(self.systems) do
        local entities = {}
        for i, entity in ipairs(self.entities) do
            if system:match(entity) then
                table.insert(entities, entity)
            end
        end
        system:update(dt, entities)
    end
end

function Engine:draw()
    for j, system in ipairs(self.systems) do
        local entities = {}
        for i, entity in ipairs(self.entities) do
            if system:match(entity) then
                table.insert(entities, entity)
            end
        end
        system:draw(entities);
    end
end