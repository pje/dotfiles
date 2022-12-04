-- brew install luarocks
-- luarocks install luaunit
-- lua stack_test.lua

local Stack = require("./stack")
local lu = require('luaunit')

TestStack = {}
  function TestStack:testStack()
    local st = Stack:new(2)
    lu.assertEquals(st:length(), 0)

    st:push("a")
    lu.assertEquals( #(st.data), 1)

    st:push("b")
    lu.assertEquals(st:length(), 2)

    st:push("c")
    lu.assertEquals(st:length(), 2)

    local val = st:pop()
    lu.assertEquals(val, "c")
    lu.assertEquals(st:length(), 1)

    val = st:pop()
    lu.assertEquals(val, "b")
    lu.assertEquals(st:length(), 0)

    val = st:pop()
    lu.assertEquals(val, nil)
    lu.assertEquals(st:length(), 0)
  end

local runner = lu.LuaUnit.new()
runner:setOutputType("tap")
os.exit( runner:runSuite() )
