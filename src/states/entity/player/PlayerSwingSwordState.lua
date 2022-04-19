PlayerSwingSwordState = Class{__includes = BaseState}



function PlayerSwingSwordState:init(entity, parent)
  self.entity = entity
  self.parent = parent

  self.entity.offsetX = 8
  self.entity.offsetY = 5

  local direction = self.entity.direction
  local hitboxX, hitboxY, hitboxWidth, hitboxHeight

  if direction == 'left' then
    hitboxWidth = 8
    hitboxHeight = 16
    hitboxX = self.entity.x - hitboxWidth
    hitboxY = self.entity.y + 2
  elseif direction == 'right' then
    hitboxWidth = 8
    hitboxHeight = 16
    hitboxX = self.entity.x + (self.entity.width / 2) + hitboxWidth
    hitboxY = self.entity.y + 2
  elseif direction == 'up' then
    hitboxWidth = 16
    hitboxHeight = 8
    hitboxX = self.entity.x
    hitboxY = self.entity.y - hitboxHeight
  else
    hitboxWidth = 16
    hitboxHeight = 8
    hitboxX = self.entity.x
    hitboxY = self.entity.y + self.entity.height
  end

  self.swordHitbox = Hitbox(hitboxX, hitboxY, hitboxWidth, hitboxHeight)
  self.entity:ChangeAnimation('sword_' .. direction)
end

function PlayerSwingSwordState:enter()
  self.entity:ChangeAnimation('sword_' .. self.entity.direction)
  self.entity.currentAnimation:Refresh()
end

function PlayerSwingSwordState:exit()
  self.entity.offsetX = 0
end

function PlayerSwingSwordState:update(dt)
  for k, entity in pairs(self.parent.entities) do
    if entity:Collides(self.swordHitbox) and not entity.invulnerable then
      entity:Damage(self.entity.damage)
      entity:GoInvulnerable(entity.invulnerableTime)

    end
  end

  if self.entity.currentAnimation.timesPlayed > 0 then
    self.entity.currentAnimation.timesPlayed = 0
    self.entity:ChangeState('idle')
  end

  if love.keyboard.wasPressed('space') then
      self.entity:ChangeState('sword')
  end
end

function PlayerSwingSwordState:render()
  local anim = self.entity.currentAnimation
  love.graphics.draw(TEXTURES[anim.texture], FRAMES[anim.texture][anim:GetCurrentFrame()],
  math.floor(self.entity.x - self.entity.offsetX),
  math.floor(self.entity.y - self.entity.offsetY))

  if DEBUG_HITBOX then
    love.graphics.setColor(RED)
    love.graphics.rectangle('line', self.swordHitbox.x, self.swordHitbox.y, self.swordHitbox.width, self.swordHitbox.height)
    love.graphics.setColor(WHITE)
    love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
  end
end
