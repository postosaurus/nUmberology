function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight
    local counter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            quads[counter] = love.graphics.newQuad(
                x * tilewidth,
                y * tileheight,
                tilewidth,
                tileheight,
                atlas:getDimensions()
            )
            counter = counter + 1
        end
    end

    return quads
end

function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end
    return sliced
end


function StretchTexture(texture, x, y, width, height)
    local textureWidth = texture:getWidth()
    local textureHeight = texture:getHeight()
    love.graphics.draw(texture, x, y ,0,
        width / (textureWidth - 1),
        height / (textureHeight - 1)
    )
end

function math.clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

function Teleport(entity, map)
    entity:SetTilePos(entity.tileX, entity.tileY, entity.layer, map)
    -- local x, y = map:getTileFoot(entity.tileX, entity.tileY)
    -- entity:setPostion(x, y)
end

function CreateCharacter(def, map)
    local entityDef = gEntities[def.entity]
    assert(entityDef)

    local Entity = Entity(entityDef)
    Entity:SetAnimation(def.anims)
    Entity:setFacing(def.facing)

    local states = {}
    local Controller = StateMachine(states)

    for _, name in ipairs(def.controller) do
        -- print(name)
        local state = gCharacterStates[name]
        assert(state)
        assert(state.name == nil)
        local instance = state(Entity, map)
        states[name] = function() return instance end
    end

    Controller.states = states
    Entity.controller = Controller
    Entity.controller:Change(def.state)

    return Entity
end
