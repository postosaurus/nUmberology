-- PLAYER OBJECT
Player = Class{__includes = Entity}

function Player:init(def)
  Entity.init(self, def)
end

function Player:Collides(target)
    local selfY, selfHeight = self.y + self.height / 2 - (self.height / 4), self.height - self.height / 2 + (self.height / 4)

    self.hurtbox = {
      x = self.x,
      y = selfY,
      width = self.width,
      height = selfHeight
    }

    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end


function Player:update(dt)
  Entity.update(self, dt)
end


function Player:draw()
  Entity.draw(self, dt)
  if DEBUG_HITBOX then
    love.graphics.setColor(GREEN)
    love.graphics.rectangle('line', self.hurtbox.x, self.hurtbox.y, self.hurtbox.width, self.hurtbox.height)
    love.graphics.setColor(WHITE)
  end
end
