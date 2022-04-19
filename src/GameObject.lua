GameObject = Class{}

function GameObject:init(def)
  self.x = math.random(0, VIRTUAL_WIDTH)
  self.y = math.random(32, VIRTUAL_HEIGHT)
  self.width = def.width
  self.height = def.height

  self.texture = def.texture
  self.frame = def.frame or 1

  self.state = def.defaultState
  self.states = def.states
  self.defaultState = def.defaultState

  self.type = def.type
  self.solid = def.solid

  self.onCollide = function() end
end

function GameObject:update(dt)

end

function GameObject:draw()

  love.graphics.draw(
    TEXTURES[self.texture],
    FRAMES[self.texture][self.states[self.state].frame or self.frame],
    self.x,
    self.y)

  if DEBUG_OBJECTS then
    love.graphics.setColor(BLUE)
    love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    love.graphics.setColor(WHITE)
  end
end
