Rect = {}

function Rect:new(o)
  o = o or {
    width = 0,
    height = 0,
  }
  o.center = { x = o.width / 2, y = o.height / 2 }
  setmetatable(o, self)
  self.__index = self
  return o
end