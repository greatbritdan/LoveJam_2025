local scene = {}

local loadobject = function(data)
    if data.class == "ground" then
        return OBJECTS.ground:new(GAME.WORLD,data.X,data.Y,data.W,data.H,data.args)
    elseif data.class == "player" then
        local player = OBJECTS.player:new(GAME.WORLD,data.X+2,data.Y+2,12,14)
        if not GAME.PLAYER then GAME.PLAYER = player end
        return player
    elseif data.class == "exit" then
        return OBJECTS.exit:new(GAME.WORLD,data.X,data.Y,16,16)
    end
end

GAME = {DEBUGDRAW=false}
function scene.LoadScene()
    GAME.WORLD = BUMP.newWorld(16)
    GAME.MAP = MAP:new("maps/test.lua",{LoadObject=loadobject})
    GAME.MAPPOS = {X=8,Y=8}

    -- Level bounderies
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,-16,352,16,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,320,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,256,352,16,{}))

    -- Chips are how you control the player
    GAME.CHIPS = {}
    GAME.ALLOWEDCHIPS = {jump=1,move_left=0,move_right=0}
    GAME.USEDCHIPS = {jump=0,move_left=0,move_right=0}
end
function scene.Update(dt)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.update then data.obj:update(dt) end
        if data.obj.updatePhysics then
            if (not data.obj.class == "player") or (GAME.PLAYER.started) then
                data.obj:updatePhysics(dt)
            end
        end
    end)
end
function scene.Draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(FrameImg,0,0)

    love.graphics.push()
    love.graphics.translate(GAME.MAPPOS.X,GAME.MAPPOS.Y)

    GAME.MAP:GetLayer("Tiles"):LoopThrough(function(data)
        love.graphics.draw(data.image,data.quad,(data.X-1)*16,(data.Y-1)*16)
    end)

    DrawObject("ground")
    DrawObject("exit")
    DrawObject("player")

    --if not GAME.PLAYER.started then
        for i,v in pairs(GAME.CHIPS) do
            love.graphics.setColor(v.color)
            love.graphics.rectangle("line",v.X*16,v.Y*16,16,16)
        end
    --end

    love.graphics.pop()
end
function DrawObject(class)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == class then data.obj:draw() end
    end)
end

function GetTileAtPos(x,y)
    return math.floor(x/16), math.floor(y/16)
end

function GetChipAtTile(x,y)
    for i,v in pairs(GAME.CHIPS) do
        if v.X == x and v.Y == y then
            return v, i
        end
    end
end

function scene.Mousepressed(mx,my,b)
    local tilex, tiley = GetTileAtPos(mx-GAME.MAPPOS.X,my-GAME.MAPPOS.Y)
    local chip,chipi = GetChipAtTile(tilex,tiley)
    if chipi then
        if chip.action == "jump" then GAME.USEDCHIPS.jump = GAME.USEDCHIPS.jump - 1 end
        if chip.action == "move_left" then GAME.USEDCHIPS.move_left = GAME.USEDCHIPS.move_left - 1 end
        if chip.action == "move_right" then GAME.USEDCHIPS.move_right = GAME.USEDCHIPS.move_right - 1 end
        table.remove(GAME.CHIPS,chipi); return
    end
    if b == 1 and GAME.USEDCHIPS.jump < GAME.ALLOWEDCHIPS.jump then
        table.insert(GAME.CHIPS,{X=tilex,Y=tiley,action="jump",color={0,1,0}})
        GAME.USEDCHIPS.jump = GAME.USEDCHIPS.jump + 1
    elseif b == 2 and GAME.USEDCHIPS.move_left < GAME.ALLOWEDCHIPS.move_left then
        table.insert(GAME.CHIPS,{X=tilex,Y=tiley,action="move_left",color={1,0,0}})
        GAME.USEDCHIPS.move_left = GAME.USEDCHIPS.move_left + 1
    elseif b == 3 and GAME.USEDCHIPS.move_right < GAME.ALLOWEDCHIPS.move_right then
        table.insert(GAME.CHIPS,{X=tilex,Y=tiley,action="move_right",color={0,0,1}})
        GAME.USEDCHIPS.move_right = GAME.USEDCHIPS.move_right + 1
    end
end

function scene.Keypressed(key)
    if key == "space" then
        if not GAME.PLAYER.started then
            GAME.PLAYER:start()
        else
            GAME.PLAYER:stop()
        end
    end
    if key == "tab" then
        GAME.DEBUGDRAW = not GAME.DEBUGDRAW
    end
end

return scene