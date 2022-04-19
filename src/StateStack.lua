StateStack = Class{}

function StateStack:init()
    self.states = {}
    -- return self
end

function StateStack:update(dt)
    for k = #self.states, 1, -1 do
        local v = self.states[k]
        local continue = v:update(dt)
        if not continue then
            break
        end
    end

    -- For First IN First Out(FIFO)
    -- local pointer = #self.states - 1
    -- local top = self.states[#self.states- pointer]

    --LIFO(Last in first out)
    local top = self.states[#self.states]

    if not top then
        return false
    end

    -- if top:IsDead() then
    --     --FIFO
    --     -- table.remove(self.states, #self.states - pointer)
    --     --LIFO
    --     table.remove(self.states)
    --     return
    -- end

    top:HandleInput()
end

function StateStack:render()
    for _, v in ipairs(self.states) do
        v:render()
    end
end

function StateStack:Push(state)
    table.insert(self.states, state)
    state:enter()
end

function StateStack:Pop()
    local top = self.states[#self.states]
    table.remove(self.states)
    top:exit()
    return top
end

function StateStack:Top()
    return self.states[#self.states]
end
