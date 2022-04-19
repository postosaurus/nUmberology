EntityWalkState = Class{__includes = BaseState}

function EntityWalkState:init(entity)
  self.entity = entity

  self.moveDuration = 0
  self.movementTimer = 0
end

function EntityWalkState:update(dt)
  if self.entity.direction == 'up' then
    self.entity.y = self.entity.y - self.entity.walkSpeed * dt

    if self.entity.y < 32 then
      self.entity.y = 32
      self.entity.bumped = true
    end

  elseif self.entity.direction == 'right' then
    self.entity.x = self.entity.x + self.entity.walkSpeed * dt

    if self.entity.x > VIRTUAL_WIDTH - self.entity.width then
      self.entity.x = VIRTUAL_WIDTH - self.entity.width
      self.entity.bumped = true
    end

  elseif self.entity.direction == 'down' then
    self.entity.y = self.entity.y + self.entity.walkSpeed * dt

    if self.entity.y > VIRTUAL_HEIGHT - self.entity.height then
      self.entity.y = VIRTUAL_HEIGHT - self.entity.height
      self.entity.bumped = true
    end

  elseif self.entity.direction == 'left' then
    self.entity.x = self.entity.x - self.entity.walkSpeed * dt

    if self.entity.x < 0 then
      self.entity.x = 0
      self.entity.bumped = true
    end
  end
end

function EntityWalkState:ProcessAI(params, dt)
  local room = params.room
  local directions = {'up', 'right', 'down', 'left'}

  if self.moveDuration == 0 or self.entity.bumped then

    --initiate timer
    self.moveDuration = math.random(5)
    self.entity.direction = directions[math.random(#directions)]
    self.entity:ChangeAnimation('walk_' .. tostring(self.entity.direction))

  elseif self.movementTimer > self.moveDuration then
    self.movementTimer = 0

    --chance to go idle
    if math.random(3) == 1 then
      self.entity:ChangeState('idle')
    else
      self.moveDuration = math.random(5)
      self.entity.direction = directions[math.random(#directions)]
      self.entity:ChangeAnimation('walk_' .. tostring(self.entity.direction))
    end
  end

  self.movementTimer = self.movementTimer + dt
end

function EntityWalkState:render()
  local anim = self.entity.currentAnimation
  love.graphics.draw(
    TEXTURES[anim.texture],
    FRAMES[anim.texture][anim:GetCurrentFrame()],
    math.floor(self.entity.x - self.entity.offsetX),
    math.floor(self.entity.y - self.entity.offsetY))

    if DEBUG_HITBOX then
      love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    end
end
