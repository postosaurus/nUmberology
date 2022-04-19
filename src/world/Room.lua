Room = Class{}

function Room:init(player, parent)
  self.player = player
  self.parent = parent

  self.entities = {}
  self:GenerateEnities()

  self.objects = {}
  self:GenerateObjects()
end

function Room:GenerateEnities()
  local types = {'skeleton', 'bat', 'slime', 'spider', 'ghost'}

  for i = 1, 10 do
    local type = types[math.random(#types)]
    local def = ENTITYDEFS[type]
    table.insert(self.entities, Entity{
      width = def.width or TILESIZE,
      height = def.height or TILESIZE,
      x = math.random(0, VIRTUAL_WIDTH),
      y = math.random(32, VIRTUAL_HEIGHT),
      offsetX = def.offsetX or 0,
      offsetY = def.offsetY or 0,
      texture = def.texture,
      walkSpeed = def.walkSpeed,
      health = def.healt or 3,
      damage = def.damage or 1,
      invulnerableTime = def.invulnerableTime or 1,
      animations = def.animations,
    })
    self.entities[i].StateMachine = StateMachine {
      ['idle'] = function() return EntityIdleState(self.entities[i]) end,
      ['walk'] = function() return EntityWalkState(self.entities[i]) end,
    }
    self.entities[i]:ChangeState('walk')
  end
end

function Room:GenerateObjects()
  local types = {'switch'}

  self.objects[1] = GameObject(GAMEOBJECTDEFS['switch'])
  local switch = self.objects[1]
  switch.onCollide = function()
    if switch.state == 'unpressed' then
      switch.state = 'pressed'
    end
  end

  self.objects[2] = GameObject(GAMEOBJECTDEFS['pot'])
  local pot = self.objects[2]
  pot.onCollide = function()
    if pot.state == 'closed' then
      pot.state = 'open'
    elseif pot.state == 'open' then
      pot.state = 'broken'
    end
  end

end

function Room:update(dt)
  self.player:update(dt)

  for i = #self.entities, 1, -1 do
    local entity = self.entities[i]

    if entity.health < 0 then
      entity.dead = true
    elseif not entity.dead then
      if not ENTITY_FREEZE then
        entity:ProcessAI({room = nil}, dt)
        entity:update(dt)
      end
    end

    if not entity.dead and self.player:Collides(entity)
      and not self.player.invulnerable and not entity.invulnerable then
      self.player:Damage(entity.damage)
      self.player:GoInvulnerable(1.5)
    end
  end

  for i = #self.objects, 1, -1 do
    local object = self.objects[i]

    if self.player:Collides(object) then
      object:onCollide()
    end

    object:update()
  end

  if self.player.health == 0 then
    local state = EnterTextState(self.parent)
    gStack:Push(state)
  end
end

function Room:draw()
  for i = #self.objects, 1, -1 do
    self.objects[i]:draw()
  end

  for i = #self.entities, 1, -1 do
    local entity = self.entities[i]
    if not entity.dead then
      entity:draw()
    end
  end

  self.player:draw()
end
