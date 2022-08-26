CollisionNotifier = {}

function CollisionNotifier:new(systems)
    local o = { systems = { } }
    for k, system in pairs(systems) do
        -- add only systems that handle collision
        if system["onCollision"] then
            table.insert(o.systems, system)
        end
    end
    setmetatable(o, self)
    self.__index = self

    return o
end

function CollisionNotifier:notify(entity1, entity2)
    for k, system in pairs(self.systems) do
        system:onCollision(entity1, entity2)
    end
end