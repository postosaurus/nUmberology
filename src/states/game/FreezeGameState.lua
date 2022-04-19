FreezeGameState = Class{__includes = BaseState}

function FreezeGameState:init()
  self.Stack = gStack
end

function FreezeGameState:enter(params)
  self.player = params.player
  self.room = params.room
  print(self.player)
  self.state = params.state or false

  if self.state then
    self.Stack:Push(self.state)
  end
end

function FreezeGameState:update(dt)
  if self.Stack:Top() then
    self.Stack:update()
  else
    gStateMachine:change('play', {player = self.player})
  end
end

function FreezeGameState:render(dt)
    love.graphics.setColor(0.2, 0.4, 0.6, 0.8)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(WHITE)

    self.room:draw()

    self.Stack:render()
end
