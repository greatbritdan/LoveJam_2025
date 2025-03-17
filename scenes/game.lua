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
    elseif data.class == "spike" then
        return OBJECTS.ground:new(GAME.WORLD,data.X,data.Y,data.W,data.H,{},true)
    elseif data.class == "player" then
        local player = OBJECTS.player:new(GAME.WORLD,data.X+2,data.Y+2,12,14,data.args)
        if not GAME.PLAYER then GAME.PLAYER = player end
        return player
    elseif data.class == "exit" then
        return OBJECTS.exit:new(GAME.WORLD,data.X,data.Y,16,16)
    elseif data.class == "key" then
        return OBJECTS.key:new(GAME.WORLD,data.X+4,data.Y+2,8,12,data.args)
    elseif data.class == "door" then
        if data.args.dir == "hor" then
            return OBJECTS.door:new(GAME.WORLD,data.X,data.Y+4,32,8,data.args)
        else
            return OBJECTS.door:new(GAME.WORLD,data.X+4,data.Y,8,32,data.args)
        end
    elseif data.class == "orb" then
        return OBJECTS.orb:new(GAME.WORLD,data.X,data.Y,data.W,data.H)
    end
end

GAME = {}
function scene.LoadScene()
    GAME.TIMER = 0

    GAME.ITEMS_ALLOW = {}
    GAME.MAPPOS = {X=8,Y=8}

    GAME.DEBUG = false
    GAME.DEBUGDRAW = false
    GAME.NOTUTORIAL = false --true

    GAME.WORLD = BUMP.newWorld(16)
    if LEVELNO == 0 then
        GAME.MAP = MAP:new("maps/test.lua",{LoadObject=loadobject})
    else
        GAME.MAP = MAP:new("maps/level"..LEVELNO..".lua",{LoadObject=loadobject})
    end

    -- Level bounderies
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,-16,352,16,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,320,0,16,256,{}))
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.ground:new(GAME.WORLD,-16,256,352,16,{}))

    -- Load inventory
    local inv_data = GAME.MAP.raw.properties
    if inv_data.DEBUG then GAME.DEBUG = true end

    GAME.INVENTORY = INVENTORY:new()
    for _,itemname in pairs(_ITEMS_ORDER) do
        if GAME.DEBUG then
            GAME.INVENTORY:addItem(_ITEMS[itemname].name,99999999) -- Add all items
        else
            if inv_data[_ITEMS[itemname].name] and inv_data[_ITEMS[itemname].name] > 0 then
                GAME.INVENTORY:addItem(_ITEMS[itemname].name,inv_data[_ITEMS[itemname].name])
            end
        end
    end
    GAME.ITEMS = {}
    GAME.EFFECTS = {}

    GAME.KEYSGOT = {yellow=false,red=false,green=false,blue=false}

    GAME.LEVEL_NAME = inv_data.level_name or "no name"
    GAME.LEVEL_NO = LEVELNO

    -- Load UI
    GAME.UI = {}
    GAME.UI.PLAY = UI.BUTTON:new({W=118,H=19},{children={{text="play!"}},repeating=false,func=function() ToggleSimulation() end},"basic")
    GAME.UI.MENU = UI.BUTTON:new({X=8,Y=8,W=118,H=19},{children={{text="menu"}},repeating=false,func=function() ExitGame() end},"basic")

    GAME.UI.SIDEBAR = UI.MATRIX:new({X=345,Y=99,W=126,H=166},{},"basic")
    if GAME.DEBUG or 1 == 1 then
        GAME.UI.RELOAD = UI.BUTTON:new({X=8,Y=30,W=118,H=19},{children={{text="reload"}},repeating=false,func=function() ChooseLevel(LEVELNO) end},"basic")
        GAME.UI.SIDEBAR:Setup{BC={{GAME.UI.PLAY},{GAME.UI.MENU},{GAME.UI.RELOAD}}}
    else
        GAME.UI.SIDEBAR:Setup{BC={{GAME.UI.PLAY},{GAME.UI.MENU}}}
    end

    GAME.UI.SIDEBAR:Recaclulate()

    if GAME.NOTUTORIAL then return end
    if inv_data.dialog_name and inv_data.dialog_name ~= "none" then
        DIALOG:start(inv_data.dialog_name)
    end
end

function scene.Update(dt)
    GAME.TIMER = GAME.TIMER + dt

    DIALOG:update(dt)

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.update then data.obj:update(dt) end
        if data.obj.updatePhysics then
            if (not data.obj.class == "player") or (GAME.SIMULATING) then
                data.obj:updatePhysics(dt)
            end
        end
    end)

    local delete = {}
    for idx,v in pairs(GAME.EFFECTS) do
        if v:update(dt) then
            table.insert(delete,idx)
        end
    end
    table.sort(delete,function(a,b) return a > b end)
    for _,idx in ipairs(delete) do
        table.remove(GAME.EFFECTS,idx)
    end

    if GAME.SIMULATING then
        GAME.UI.PLAY.children[1].text = "stop!"
    else
        GAME.UI.PLAY.children[1].text = "play!"
    end
    local wasactive = GAME.UI.MENU.active
    GAME.UI.MENU.active = not GAME.SIMULATING
    if wasactive ~= GAME.UI.MENU.active then
        if GAME.UI.MENU.active then
            GAME.UI.MENU:ChangeStyle("basic")
        else
            GAME.UI.MENU:ChangeStyle("basic disable")
        end
    end

    GAME.UI.SIDEBAR:Update(dt)

    if GAME.QueueNextLevel then
        NextLevel()
    end
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
    DrawObject("spike")
    DrawObject("exit")
    DrawObject("key")
    DrawObject("door")

    for _,item in pairs(_ITEMS) do
        DrawObject(item.name)
    end
    DrawObject("player")
    
    for idx,v in pairs(GAME.EFFECTS) do
        v:draw()
    end

    if not GAME.SIMULATING then
        -- draw allowed spots
        love.graphics.setColor(1,1,1,0.2)
        for k,_ in pairs(GAME.ITEMS_ALLOW) do
            local x,y = k:match("(%d+)-(%d+)")
            love.graphics.rectangle("fill",((x-1)*16)+1,((y-1)*16)+1,14,14)
        end
    end

    love.graphics.setColor(1,1,1,0.8)
    for i = 1, 20 do
        local siny = math.sin((GAME.TIMER*2)+i)*2
        local frame = math.floor(GAME.TIMER*4)%4+1
        love.graphics.draw(WaterImg,WaterQuads[1][frame],((i-1)*16),224+siny)
        love.graphics.draw(WaterImg,WaterQuads[2][frame],((i-1)*16),240+siny)
        love.graphics.draw(WaterImg,WaterQuads[2][frame],((i-1)*16),256+siny)
    end

    love.graphics.pop()

    love.graphics.setColor(1,1,1)
    if not GAME.DEBUGDRAW then love.graphics.draw(FrameImg,0,0) end
    love.graphics.print("level "..GAME.LEVEL_NO.." / 15:",348,10)
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

    love.graphics.setColor(1,1,1)
    DIALOG:draw()
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
    if GAME.INDIALOG then
        DIALOG:next()
        return
    end
    if GAME.SIMULATING then
        GAME.UI.SIDEBAR:Mousepressed(mx,my,b) -- Only register clicks if no item is clicked
        return
    end
    if b ~= 1 then return end
    local idx, item = GAME.INVENTORY:hover(mx,my)
    if idx and item then
        if item.amount > 0 then
            GAME.INVENTORY:removeItem(item.name,1)
            GAME.ITEMS[#GAME.ITEMS+1] = ITEM:new(item.name)
            PickupSound:play()
        end
    else
        local click = false
        for i = #GAME.ITEMS, 1, -1 do
            local v = GAME.ITEMS[i]
            if AABB(mx,my,1,1,v.X+GAME.MAPPOS.X,v.Y+GAME.MAPPOS.Y,16,16) then
                v.moving = true
                v.oldx, v.oldy = v.X, v.Y
                PickupSound:play()
                click = true
                break
            end
        end
        if not click then
            GAME.UI.SIDEBAR:Mousepressed(mx,my,b) -- Only register clicks if no item is clicked
        end
    end
end
function scene.Mousereleased(mx,my,b)
    --if b ~= 1 then return end
    for i = #GAME.ITEMS, 1, -1 do
        local v = GAME.ITEMS[i]
        if v.moving then
            local tilex, tiley = GetTileAtPos(mx,my,true)
            if InMap(tilex,tiley) then
                if (not GAME.DEBUG) and ((not GAME.ITEMS_ALLOW[tilex.."-"..tiley]) or HasItem(tilex,tiley,v)) then
                    if v.oldx then
                        v.X, v.Y = v.oldx, v.oldy
                        PlaceSound:play()
                    else
                        GAME.INVENTORY:addItem(v.name,1)
                        table.remove(GAME.ITEMS,i)
                        DiscardSound:play()
                    end
                else
                    v.X, v.Y = (tilex-1)*16, (tiley-1)*16
                    PlaceSound:play()
                end
                v.moving = false
            else
                GAME.INVENTORY:addItem(v.name,1)
                table.remove(GAME.ITEMS,i)
                DiscardSound:play()
            end
        end
    end
    GAME.UI.SIDEBAR:Mousereleased(mx,my,b)
end

function scene.Keypressed(key)
    if GAME.INDIALOG then
        DIALOG:next()
        return
    end
    if key == "space" then ToggleSimulation() end
    if key == "tab" then GAME.DEBUGDRAW = not GAME.DEBUGDRAW end
end

function ToggleSimulation()
    if not GAME.SIMULATING then
        StartSimulation()
    else
        StopSimulation()
    end
end

function StartSimulation()
    -- Create all items
    for i = 1, #GAME.ITEMS do
        local v = GAME.ITEMS[i]
        if TableContains(v.name,_ITEMS,"name") then
            local item = _ITEMS[v.name]
            local args = {}
            if item.args then args = DeepCopy(item.args) end
            local temp = OBJECTS[item.class]:new(GAME.WORLD,v.X+item.spawn.ox,v.Y+item.spawn.oy,item.spawn.w,item.spawn.h,args)
            table.insert(GAME.MAP:GetLayer("Objects").objects,temp)
            temp.placedbyplayer = true -- Used to delete the item when stopping simulation
        end
    end

    GAME.PLAYER:start()
    GAME.SIMULATING = true
end

function StopSimulation(won)
    -- Remove all items, but only the ones placed
    local delete = {}
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.placedbyplayer then
            if data.obj.world then GAME.WORLD:remove(data.obj) end
            table.insert(delete,data.idx)
        end
    end)
    table.sort(delete,function(a,b) return a > b end)
    for _,idx in ipairs(delete) do
        table.remove(GAME.MAP:GetLayer("Objects").objects,idx)
    end

    GAME.KEYSGOT = {yellow=false,red=false,green=false,blue=false}

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "door" or data.obj.class == "key" then
            data.obj.active = true
            if data.obj.class == "door" then
                data.obj.opentimer = false
            end
        end
        if data.obj.class == "exit" then
            data.obj.opentimer = false
        end
    end)

    GAME.PLAYER:stop()
    GAME.SIMULATING = false
end

function ExitGame()
    GAME = {} -- Clear game data
    SCENE:LoadScene("menu")
end

function NewEffect(t,x,y)
    table.insert(GAME.EFFECTS,EFFECT:new(t,x,y))
end

return scene