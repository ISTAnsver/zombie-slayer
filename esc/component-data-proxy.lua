ComponentDataProxy = {}

function ComponentDataProxy:new(component)
    local o = {}
    setmetatable(o, self)
    self.__index = component.data
    return o
end