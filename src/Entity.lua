--ENTITY as a base class for all other gameobjects like the player, NPC and items
Entity = Class{}

function Entity:init(def)
  self.height = def.height or 16
  self.width = def.width or 16
  self.x = def.x or VIRTUAL_WIDTH / 2
  self.y = def.y or VIRTUAL_HEIGHT / 2

  self.offsetX = def.offsetX or 0
  self.offsetY = def.offsetY or 0

  self.texture = def.texture
  self.animations = self:GenerateAnimations(def.animations)
  -- print(self.animations)

  self.currentAnimation = self.animations['idle_down']
  -- print(self.currentAnimation)
  self.direction = 'down'
  self.walkSpeed = def.walkSpeed
  self.bumped = false

  self.health = def.health
  self.damage = def.damage
  self.invulnerableTime = def.invulnerableTime
  self.dead = false
  self.invulnerable = false
  self.invulnerableDuration = 0
  self.invulnerableTimer = 0
  self.flashTimer = 0
end

function Entity:HandleInput(dt) end

function Entity:GenerateAnimations(animations)
  local animationsReturned = {}

  for k, animationDef in pairs(animations) do
    -- print(k)
    animationsReturned[k] = Animation{
      texture = animationDef.texture or self.texture,
      interval = animationDef.interval or 0.2,
      frames = animationDef.frames
    }
  end

  return animationsReturned
end

function Entity:ChangeAnimation(name)
  self.currentAnimation = self.animations[name]
end

function Entity:ChangeState(name, enterParams)
  self.StateMachine:change(name, enterParams)
end

function Entity:Collides(target)
  return not (self.x + self.width < target.x or self.x > target.x + target.width or
            self.y + self.height < target.y or self.y > target.y + target.height)
end

function Entity:ProcessAI(params, dt)
  self.StateMachine:ProcessAI(params, dt)
end

function Entity:Damage(amount)
  self.health = self.health - amount
  -- self:GoInvulnerable(1.5)
  -- if self.health <= 0 then
  --   self.dead = true
  -- end
end

function Entity:GoInvulnerable(duration)
  self.invulnerable = true
  self.invulnerableDuration = duration
end

function Entity:update(dt)
  if self.invulnerable then
        self.flashTimer = self.flashTimer + dt
        self.invulnerableTimer = self.invulnerableTimer + dt

        if self.invulnerableTimer > self.invulnerableDuration then
            self.invulnerable = false
            self.invulnerableTimer = 0
            self.invulnerableDuration = 0
            self.flashTimer = 0
        end
    end
  self.StateMachine:update(dt)

  if self.animations then
    self.currentAnimation:update(dt)
  end
end

function Entity:draw()
  if self.invulnerable and self.flashTimer > 0.06 then
    self.flashTimer = 0
    love.graphics.setColor(1, 1, 1, .1)
end

  self.StateMachine:render()
  love.graphics.setColor(WHITE)
end
