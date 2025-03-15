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

    local inv_data = GAME.MAP.raw.properties
    GAME.INVENTORY = INVENTORY:new()
    if inv_data.springboard then
        GAME.INVENTORY:addItem("springboard",inv_data.springboard)
    end

    GAME.ITEMS = {}

    -- Level bounderies
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,-16,352,16,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,320,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,256,352,16,{}))
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

    love.graphics.pop()

    GAME.INVENTORY:draw()
    for i = 1, #GAME.ITEMS do
        GAME.ITEMS[i]:draw()
    end
end

function DrawObject(class)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == class then data.obj:draw() end
    end)
end

function GetTileAtPos(x,y,mapadjust)
    if mapadjust then x,y = x+GAME.MAPPOS.X, y+GAME.MAPPOS.Y end
    return math.floor(x/16), math.floor(y/16)
end
function InMap(tilex,tiley)
    return tilex >= 1 and tilex <= 20 and tiley >= 1 and tiley <= 16
end

function scene.Mousepressed(mx,my,b)
    if b ~= 1 then return end
    local idx, item = GAME.INVENTORY:hover(mx,my)
    if idx and item then
        if item.amount > 0 then
            GAME.INVENTORY:removeItem(item.name,1)
            GAME.ITEMS[#GAME.ITEMS+1] = ITEM:new(item.name)
        end
    else
        for i = #GAME.ITEMS, 1, -1 do
            local v = GAME.ITEMS[i]
            if AABB(mx,my,1,1,v.X+GAME.MAPPOS.X,v.Y+GAME.MAPPOS.Y,16,16) then
                v.moving = true
                break
            end
        end
    end
end
function scene.Mousereleased(mx,my,b)
    for i = #GAME.ITEMS, 1, -1 do
        local v = GAME.ITEMS[i]
        if v.moving then
            local tilex, tiley = GetTileAtPos(mx,my,true)
            if InMap(tilex,tiley) then
                v.X, v.Y = (tilex-1)*16, (tiley-1)*16
                print("Dropped item at",tilex,tiley)
                v.moving = false
            else
                GAME.INVENTORY:addItem(v.name,1)
                GAME.ITEMS[i] = nil
            end
        end
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