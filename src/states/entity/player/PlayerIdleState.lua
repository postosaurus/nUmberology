PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(entity, parent)
  self.parent = parent
  self.entity = entity
end

function PlayerIdleState:enter()
  self.entity:ChangeAnimation('idle_' .. self.entity.direction)
end

function PlayerIdleState:update(dt)
  EntityIdleState.update(self, dt)
end

function PlayerIdleState:update(dt)
  if love.keyboard.isDown(UPKEY) or love.keyboard.isDown(RIGHTKEY) or love.keyboard.isDown(DOWNKEY) or love.keyboard.isDown(LEFTKEY) then
    self.entity:ChangeState('walk')
  end

  if love.keyboard.isDown(ACTIONKEY) then
    --if no other action
    self.entity.StateMachine:change('sword')
  end
end

function PlayerIdleState:render()
  love.graphics.draw(TEXTURES[self.entity.texture], FRAMES[self.entity.texture][self.entity.currentAnimation:GetCurrentFrame()],
  math.floor(self.entity.x - self.entity.offsetX),
  math.floor(self.entity.y - self.entity.offsetY))

  if DEBUG_HITBOX then
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
  end
end
