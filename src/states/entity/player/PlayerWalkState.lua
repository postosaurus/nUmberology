PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(entity)
  EntityWalkState.init(self, entity)
  self.entity = entity
end

function PlayerWalkState:update(dt)
  if love.keyboard:wasPressed(ACTIONKEY) then
    self.entity:ChangeState('sword')
  elseif love.keyboard.isDown(UPKEY) then
    self.entity.direction = 'up'
    self.entity:ChangeAnimation('walk_up')
  elseif love.keyboard.isDown(RIGHTKEY) then
    self.entity.direction = 'right'
    self.entity:ChangeAnimation('walk_right')
  elseif love.keyboard.isDown(DOWNKEY) then
    self.entity.direction = 'down'
    self.entity:ChangeAnimation('walk_down')
  elseif love.keyboard.isDown(LEFTKEY) then
    self.entity.direction = 'left'
    self.entity:ChangeAnimation('walk_left')
  else
    self.entity:ChangeState('idle')
  end

  EntityWalkState.update(self, dt)

  if self.entity.bumped then

  end
end
