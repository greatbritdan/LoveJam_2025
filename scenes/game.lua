local scene = {}

local loadobject = function(data)
    if data.class == "ground" then
        return OBJECTS.ground:new(GAME.WORLD,data.X,data.Y,data.W,data.H,data.args)
    elseif data.class == "player" then
        local player = OBJECTS.player:new(GAME.WORLD,data.X,data.Y,16,16)
        if not GAME.PLAYER then GAME.PLAYER = player end
        return player
    end
end

GAME = {}
function scene.LoadScene()
    GAME.WORLD = BUMP.newWorld(16)
    GAME.MAP = MAP:new("maps/test.lua",{LoadObject=loadobject})
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,-16,288,16,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,256,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,256,288,16,{}))
    GAME.MAPPOS = {X=8,Y=8}

    GAME.CHIPS = {}
end
function scene.Update(dt)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.update then data.obj:update(dt) end
        data.obj:updatePhysics(dt)
    end)
end
function scene.Draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(FrameImg,0,0)

    GAME.MAP:GetLayer("Tiles"):LoopThrough(function(data)
        love.graphics.draw(data.image,data.quad,((GAME.MAPPOS.X/16)+data.X-1)*16,((GAME.MAPPOS.Y/16)+data.Y-1)*16)
    end)

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.draw then data.obj:draw() end
    end)

    if GAME.PLAYER.started then return end
    for i,v in pairs(GAME.CHIPS) do
        love.graphics.setColor(v.color)
        love.graphics.rectangle("line",(v.X+(GAME.MAPPOS.X/16))*16,(v.Y+(GAME.MAPPOS.Y/16))*16,16,16)
    end
end

function GetTileAtPos(x,y)
    return math.floor((x-GAME.MAPPOS.X)/16), math.floor((y-GAME.MAPPOS.Y)/16)
end

function GetChipAtTile(x,y)
    for i,v in pairs(GAME.CHIPS) do
        if v.X == x and v.Y == y then
            return v, i
        end
    end
end

function scene.Mousepressed(mx,my,b)
    local tilex, tiley = GetTileAtPos(mx,my)
    local _,chipi = GetChipAtTile(tilex,tiley)
    if chipi then
        table.remove(GAME.CHIPS,chipi); return
    end
    if b == 1 then
        table.insert(GAME.CHIPS,{X=tilex,Y=tiley,action="jump",color={0,1,0}})
    elseif b == 2 then
        table.insert(GAME.CHIPS,{X=tilex,Y=tiley,action="move_left",color={1,0,0}})
    elseif b == 3 then
        table.insert(GAME.CHIPS,{X=tilex,Y=tiley,action="move_right",color={0,0,1}})
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
end

return scene