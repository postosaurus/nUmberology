--loading resources from library
  push =  require 'lib/push'
  Class = require 'lib/class'
  os = require('os')


--CONSTANTS
      --Window settings
      WINDOW_WIDTH = 1024
      WINDOW_HEIGHT = 686
      VIRTUAL_WIDTH = 432
      VIRTUAL_HEIGHT = 234

      --Key settings
      UPKEY = 'w'
      RIGHTKEY = 'd'
      DOWNKEY = 's'
      LEFTKEY = 'a'
      ACTIONKEY = 'space'
      MENUKEY = 'return'
      MAPKEY = 'm'
      BACKKEY = 'rshift'
      CONFIRMKEY = 'return'

      --Color settings
      RED = {1, 0, 0, 1}
      WHITE = {1, 1, 1, 1}
      GREEN = {0, 1, 0, 1}
      BLUE = {0, 0, 1, 1}
      BLACK = {0, 0, 0, 1}

      --Entity settings
      PLAYERWIDTH = 16
      PLAYERHEIGHT = 22
      PLAYERSPEED = 75
      ENTITYSPEED_SLOW = PLAYERSPEED - 25
      ENTITYSPEED_MEDIUM = PLAYERSPEED
      ENTITYSPEED_FAST = PLAYERSPEED + 25


      --Map Settings
      TILESIZE = 16
      MAP_OFFSET_X = 0
      MAP_OFFSET_Y = 32

--CONSOLE
      --Flags for scaling
      SCALE_FLAG = false
      SCALE_FAKOTR = 1
      DEBUG_HITBOX = false
      DEBUG_OBJECTS = false
      ENTITY_FREEZE = false

--LOADING SOURCES
  --Tools
  require 'src/Util'

  --StateMachine relevant and game states
  require 'src/StateMachine'
  require 'src/StateStack'
  require 'src/states/BaseState'
  require 'src/states/game/StartState'
  require 'src/states/game/PlayState'
  require 'src/states/game/FreezeGameState'

  --ENTITY relevant
  require 'src/Entity'
  require 'src/Player'
  require 'src/Animation'
  require 'src/entity_defs'
  --Entity states
  require 'src/states/entity/EntityIdleState'
  require 'src/states/entity/EntityWalkState'
  require 'src/states/entity/player/PlayerIdleState'
  require 'src/states/entity/player/PlayerWalkState'
  require 'src/states/entity/player/PlayerSwingSwordState'

  --World related states
  require 'src/world/Room'

  --Menus and other states
  require 'src/Console'
  require 'src/Hitbox'
  require 'src/GameObject'
  require 'src/gameobject_defs'

  --Stack states
  require 'src/states/EnterTextState'

--ASSETS
  TEXTURES = {
    ['character_walk'] = love.graphics.newImage('graphics/character_walk.png'),
    ['character_sword'] = love.graphics.newImage('graphics/character_swing_sword.png'),
    ['entities'] = love.graphics.newImage('graphics/entities.png'),
    ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
    ['switches'] = love.graphics.newImage('graphics/switches.png'),
    ['tiles'] = love.graphics.newImage('graphics/tilesheet.png')
  }

  FRAMES = {
    ['character_walk'] = GenerateQuads(TEXTURES['character_walk'], 16, 32),
    ['character_sword'] = GenerateQuads(TEXTURES['character_sword'], 32, 32),
    ['entities'] = GenerateQuads(TEXTURES['entities'], 16, 16),
    ['hearts'] = GenerateQuads(TEXTURES['hearts'], 16, 16),
    ['switches'] = GenerateQuads(TEXTURES['switches'], 16, 16),
    ['tiles'] = GenerateQuads(TEXTURES['tiles'], 16, 16)
  }

--COMMANDS for the Console
COMMANDS = {
  ['reset'] = function()
    love.event.quit('restart')
  end,

  ['quit'] = function()
    love.event.quit()
  end,

  ['debug'] = function()
    DEBUG_HITBOX = not DEBUG_HITBOX
    DEBUG_OBJECTS = not DEBUG_OBJECTS
    ENTITY_FREEZE = not ENTITY_FREEZE

    return true
  end,

  ['dbg_'] = function(str)
    if string.find(str, 'hitbox') then
      DEBUG_HITBOX = not DEBUG_HITBOX

    elseif string.find(str, 'objects') then
      DEBUG_OBJECTS = not DEBUG_OBJECTS

    elseif string.find(str, 'freeze') then
      ENTITY_FREEZE = not ENTITY_FREEZE
    end

    return false
  end,

  ['scale_'] = function(factor)
      SCALE_FLAG = true
      SCALE_FAKOTR = tonumber(factor)
      return true
  end,

  ['tp_'] = function(str, state)
    local a, b = string.find(str, ',')
    -- print(a, b, str)
    local x = string.sub(str, 1, a-1)
    local y = string.sub(str, b+1, #str)
    -- print(x, y)
    state.player.x = tonumber(x * TILESIZE)
    state.player.y = tonumber(y * TILESIZE)
    return true
  end,

  ['health_'] = function(health, state)
    state.player.health = health
    return true
  end,

  ['inv_'] = function(flag, state)
    state.player:GoInvulnerable(tonumber(flag))
    return true
  end


}
