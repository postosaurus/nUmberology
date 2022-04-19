require 'src/Dependencies'

math.randomseed(os.time())
--setting global StateStack
gStack = StateStack()
--setting global console for callback functions and commands
gConsole = Console(COMMANDS)

function love.load()
  --setting graphics and window, initialzing push for having good arcade game resolutuon
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('DUNGEON')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable =  true})

    --setting global StateMachine with all game relevant states
    gStateMachine = StateMachine({
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['freeze'] = function() return FreezeGameState() end,})
    gStateMachine:change('play', {})



    love.keyboard.keysPressed = {}
    love.keyboard.textInput = ''
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.keyreleased(key)
  return key
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.textinput(t)
  love.keyboard.textInput = love.keyboard.textInput .. t
end

function love.keyboard.getTextInput()
  local text = love.keyboard.textInput
  love.keyboard.textInput = ''
  return text
end


function love.update(dt)
    gStateMachine:update(dt)
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    gStateMachine:render()

    push:finish()
end
