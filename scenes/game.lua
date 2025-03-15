local scene = {}

local loadobject = function(data)
    if data.class == "place_allow" then
        local tilex, tiley = GetTileAtPos(data.X,data.Y,true)
        local xcount, ycount = data.W/16, data.H/16
        for x = 1, xcount do
            for y = 1, ycount do
                GAME.ITEMS_ALLOW[(tilex+x).."-"..(tiley+y)] = true
            end
        end
    end

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
    GAME.ITEMS_ALLOW = {}
    GAME.MAPPOS = {X=8,Y=8}

    GAME.WORLD = BUMP.newWorld(16)
    GAME.MAP = MAP:new("maps/test.lua",{LoadObject=loadobject})

    -- Level bounderies
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,-16,352,16,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,320,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,256,352,16,{}))

    -- Load inventory
    local inv_data = GAME.MAP.raw.properties
    GAME.INVENTORY = INVENTORY:new()
    for _,itemname in pairs(_ITEMS_ORDER) do
        if inv_data[_ITEMS[itemname].name] and inv_data[_ITEMS[itemname].name] > 0 then
            GAME.INVENTORY:addItem(_ITEMS[itemname].name,inv_data[_ITEMS[itemname].name])
        end
    end
    GAME.ITEMS = {}

    GAME.LEVEL_NAME = inv_data.level_name or "no name"

    -- Load UI
    GAME.UI = {}
    GAME.UI.PLAY = UI.BUTTON:new({W=118,H=20},{children={{text="play"}}})

    GAME.UI.SIDEBAR = UI.MATRIX:new({X=345,Y=99,W=126,H=166})
    GAME.UI.SIDEBAR:Setup{TC={{GAME.UI.PLAY}}}
    GAME.UI.SIDEBAR:Recaclulate()
end

function scene.Update(dt)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.update then data.obj:update(dt) end
        if data.obj.updatePhysics then
            if (not data.obj.class == "player") or (GAME.SIMULATING) then
                data.obj:updatePhysics(dt)
            end
        end
    end)

    GAME.UI.SIDEBAR:Update(dt)
end

function scene.Draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(BackgroundImg,GAME.MAPPOS.X,GAME.MAPPOS.Y)

    love.graphics.push()
    love.graphics.translate(GAME.MAPPOS.X,GAME.MAPPOS.Y)

    GAME.MAP:GetLayer("BackTiles"):LoopThrough(function(data)
        love.graphics.draw(data.image,data.quad,(data.X-1)*16,(data.Y-1)*16)
    end)
    GAME.MAP:GetLayer("Tiles"):LoopThrough(function(data)
        love.graphics.draw(data.image,data.quad,(data.X-1)*16,(data.Y-1)*16)
    end)

    DrawObject("ground")
    DrawObject("exit")
    DrawObject("player")
    for _,item in pairs(_ITEMS) do
        DrawObject(item.name)
    end

    if not GAME.SIMULATING then
        -- draw allowed spots
        love.graphics.setColor(1,1,1,0.2)
        for k,_ in pairs(GAME.ITEMS_ALLOW) do
            local x,y = k:match("(%d+)-(%d+)")
            love.graphics.rectangle("fill",((x-1)*16)+1,((y-1)*16)+1,14,14)
        end
    end

    love.graphics.pop()

    love.graphics.setColor(1,1,1)
    love.graphics.draw(FrameImg,0,0)
    love.graphics.print("level 1:",348,10)
    love.graphics.print(GAME.LEVEL_NAME,348,25)

    GAME.UI.SIDEBAR:Draw()
    if GAME.DEBUGDRAW then
        GAME.UI.SIDEBAR:DebugDraw()
    end

    GAME.INVENTORY:draw()

    if not GAME.SIMULATING then
        for i = 1, #GAME.ITEMS do
            GAME.ITEMS[i]:draw()
        end
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

function HasItem(tilex,tiley,otheritem)
    for _,item in pairs(GAME.ITEMS) do
        if item ~= otheritem and item.X == (tilex-1)*16 and item.Y == (tiley-1)*16 then
            return true
        end
    end
    return false
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
                v.oldx, v.oldy = v.X, v.Y
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
                if ((not GAME.ITEMS_ALLOW[tilex.."-"..tiley]) or HasItem(tilex,tiley,v)) then
                    if v.oldx then
                        v.X, v.Y = v.oldx, v.oldy
                    else
                        GAME.INVENTORY:addItem(v.name,1)
                        table.remove(GAME.ITEMS,i)
                    end
                else
                    v.X, v.Y = (tilex-1)*16, (tiley-1)*16
                end
                v.moving = false
            else
                GAME.INVENTORY:addItem(v.name,1)
                table.remove(GAME.ITEMS,i)
            end
        end
    end
end

function scene.Keypressed(key)
    if key == "space" then
        if not GAME.SIMULATING then
            StartSimulation()
        else
            StopSimulation()
        end
    end
    if key == "tab" then
        GAME.DEBUGDRAW = not GAME.DEBUGDRAW
    end
end

function StartSimulation()
    -- Create all items
    for i = 1, #GAME.ITEMS do
        local v = GAME.ITEMS[i]
        if TableContains(v.name,_ITEMS,"name") then
            local item = _ITEMS[v.name]
            table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS[item.name]:new(GAME.WORLD,v.X+item.spawn.ox,v.Y+item.spawn.oy,item.spawn.w,item.spawn.h,{}))
        end
    end

    GAME.PLAYER:start()
    GAME.SIMULATING = true
end

function StopSimulation()
    -- Remove all items, but only the ones placed
    for _,item in pairs(_ITEMS) do
        local delete = {}
        GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
            if data.obj.class == item.name then
                GAME.WORLD:remove(data.obj)
                table.insert(delete,data.idx)
            end
        end)
        table.sort(delete,function(a,b) return a > b end)
        for _,idx in ipairs(delete) do
            table.remove(GAME.MAP:GetLayer("Objects").objects,idx)
        end
    end

    GAME.PLAYER:stop()
    GAME.SIMULATING = false
end

return scene