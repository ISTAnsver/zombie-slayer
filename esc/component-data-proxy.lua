ComponentDataProxy = {}

function ComponentDataProxy:new(component)
    local o = component.data
    setmetatable(o, self)
    self.__index = self
    return o
end