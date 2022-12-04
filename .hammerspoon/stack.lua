local Stack = {}
function Stack:new(max)
  local obj = {}
  setmetatable(obj, self)
  self.__index = self
  self.data = {}
  self.maxSize = max
  return obj
end

function Stack:push(obj)
  while self:length() >= self.maxSize
  do
    table.remove(self.data, 1)
  end

  self.data[#(self.data)+1] = obj -- this is Lua's `append`
end

function Stack:pop()
  return table.remove(self.data)
end

function Stack:length()
  return #(self.data)
end

return Stack
