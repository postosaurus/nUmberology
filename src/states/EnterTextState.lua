--This state helps execute the console. while in this state you can type commands
--in the bottom of the screen. These will be executed by the console. Afterwards the console pops
-- if the command is completed.
EnterTextState = Class{__includes = BaseState}

function EnterTextState:init(parent)
  self.parent = parent
  self.text = ''
end

function EnterTextState:enter()
  love.keyboard.textInput = ''
  print('EnterTextState')
end

function EnterTextState:exit()
  print('Exit EnterTextState')
end

function EnterTextState:HandleInput()
  if love.keyboard.wasPressed('escape')then
      love.event.quit()
  end
  if love.keyboard.wasPressed('backspace') then
    self.text = string.sub(self.text, 1, #self.text - 1)
  end
  if love.keyboard.wasPressed(BACKKEY) then
    self.parent.Stack:Pop()
  end
  if love.keyboard.wasPressed(CONFIRMKEY) then
    if gConsole:ExecuteString(self.text, self.parent) then
      self.parent.Stack:Pop()
    else
      self.text  = ''
    end
  end
end

function EnterTextState:update(dt)
  local text = love.keyboard.getTextInput()
  self.text = self.text .. text
end

function EnterTextState:render()
  love.graphics.setColor(RED)
  love.graphics.rectangle('fill', 0, VIRTUAL_HEIGHT - 48, VIRTUAL_WIDTH, 48)
  love.graphics.setColor(BLACK)
  love.graphics.printf(self.text, 0, VIRTUAL_HEIGHT - 48, VIRTUAL_WIDTH, left)
end
