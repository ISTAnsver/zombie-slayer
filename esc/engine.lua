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
    for i, entity in ipairs(self.entities) do
        for j, system in ipairs(self.systems) do
            if system:match(entity) then
                system:update(dt, entity)
            end
        end
    end
end

function Engine:draw()
    for i, entity in ipairs(self.entities) do
        for j, system in ipairs(self.systems) do
            if system:match(entity) then
                system:draw(entity)
            end
        end
    end
end