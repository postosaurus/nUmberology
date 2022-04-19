PlayState = Class{__includes = BaseState}

function PlayState:init()
  self.Stack = gStack
  --setting player, his StateMachine and the player relevant states
  self.player = Player(ENTITYDEFS['player'])
  self.room = Room(self.player, self)
  self.player.StateMachine = StateMachine{
    ['idle'] = function() return PlayerIdleState(self.player, self.room) end,
    ['walk'] = function() return PlayerWalkState(self.player, self.room) end,
    ['sword'] = function() return PlayerSwingSwordState(self.player, self.room) end,
  }
  self.player:ChangeState('idle')
end

function PlayState:enter(params)
  -- print(params.player)
  if not params.player == nil then
    self.player = params.player
    self.room = params.room
  end
end

function PlayState:update(dt)
    if self.Stack:Top() then
      if self.Stack:update(dt) then
        self.room:update(dt)
      end
    else
      if love.keyboard.wasPressed('escape') then
          love.event.quit()
      end
      if love.keyboard.wasPressed('tab') then
        local state = EnterTextState(self)
        self.Stack:Push(state)
      end

      self.room:update(dt)

    end
end

function PlayState:render()
    if SCALE_FLAG then
      -- print(SCALE_FAKOTR)
    end
    love.graphics.scale(SCALE_FAKOTR)
    love.graphics.setColor(0.2, 0.4, 0.6, 0.8)
    love.graphics.rectangle('fill', 0, MAP_OFFSET_Y, VIRTUAL_WIDTH, VIRTUAL_HEIGHT - MAP_OFFSET_Y)
    love.graphics.setColor(WHITE)

    self.room:draw()
    self.Stack:render()

    love.graphics.scale(.75)
    love.graphics.setColor(WHITE)
    love.graphics.rectangle('line', 0, 0, VIRTUAL_WIDTH, MAP_OFFSET_Y)
    for i = self.player.health, 1, -1 do
      love.graphics.draw(TEXTURES['hearts'], FRAMES['hearts'][5], (i-1)*16  - 1, 0)
    end
    for i = 6, self.player.health +1, -1 do
      love.graphics.draw(TEXTURES['hearts'], FRAMES['hearts'][1], (i-1)*16 - 1, 0)
    end
    love.graphics.scale(1)
end
