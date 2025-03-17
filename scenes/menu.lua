local scene = {}

LEVELNO = 0

MENU = {DEBUGDRAW=false}
function scene.LoadScene()
    MENU.STATE = "title"
    MENU.BACKGROUNDSCROLL = 0
    MENU.UI = {}


    -- TITLE
    MENU.UI.MENU = UI.MATRIX:new({X=124,Y=90,W=232,H=162},{},"basic")

    MENU.UI.start = UI.BUTTON:new({W=166,H=30},{children={{text="play!"}},repeating=false,func=function() ChooseLevel(1) end},"basic")
    MENU.UI.MENU:Add(MENU.UI.start,"MC","horizontal")

    MENU.UI.levelselect = UI.BUTTON:new({W=166,H=30},{children={{text="level select"}},repeating=false,func=function() MENU.STATE = "levelselect" end},"basic")
    MENU.UI.MENU:Add(MENU.UI.levelselect,"MC","vertical")

    MENU.UI.settings = UI.BUTTON:new({W=166,H=30},{children={{text="settings"}},repeating=false,func=function() end},"basic")
    MENU.UI.MENU:Add(MENU.UI.settings,"MC","vertical")

    MENU.UI.MENU:Recaclulate()


    -- LEVEL SELECT
    MENU.UI.LEVELSELECT = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.levelselect = UI.TEXT:new({W=166,H=12},{text="level select!"},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.levelselect,"MC","horizontal")

    local i = 0
    for _ = 1, 3 do
        for x = 1, 5 do
            i = i + 1
            MENU.UI["level"..i] = UI.BUTTON:new({W=30,H=30},{children={{text=i}},repeating=false,func=function(e) ChooseLevel(e.levelno) end},"basic")
            MENU.UI["level"..i].levelno = i
            local dir = "horizontal"
            if (x == 1) then dir = "vertical" end
            MENU.UI.LEVELSELECT:Add(MENU.UI["level"..i],"MC",dir)
        end
    end

    MENU.UI.leveltest = UI.BUTTON:new({W=166,H=30},{children={{text="test"}},repeating=false,func=function() ChooseLevel(0) end},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.leveltest,"MC","vertical")

    MENU.UI.spacer = UI.SPACER:new({W=166,H=12},{},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.spacer,"MC","vertical")

    MENU.UI.back = UI.BUTTON:new({W=166,H=30},{children={{text="back to menu"}},repeating=false,func=function() MENU.STATE = "title" end},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.back,"MC","vertical")

    MENU.UI.LEVELSELECT:Recaclulate()
end

function scene.Update(dt)
    MENU.BACKGROUNDSCROLL = MENU.BACKGROUNDSCROLL + dt * 25
    if MENU.BACKGROUNDSCROLL > 320 then
        MENU.BACKGROUNDSCROLL = MENU.BACKGROUNDSCROLL - 320
    end

    if MENU.STATE == "title" then
        MENU.UI.MENU:Update(dt)
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Update(dt)
    end
end

local function titletext(text,x,y)
    love.graphics.setColor(0,0,0)
    love.graphics.print(text,x+1,y+1)
    love.graphics.setColor(1,1,1)
    love.graphics.print(text,x,y)
end

function scene.Draw()
    love.graphics.setColor(1,1,1,0.75)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL,8)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL+320,8)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL+640,8)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(FrameMenuImg,0,0)

    if MENU.STATE == "title" then
        local x,y = (Env.width/2) - (TitleImg:getWidth()/2), 20
        love.graphics.draw(TitleImg,x,y)
        titletext("made by britdan",4,Env.height-30)
        titletext("for the love2d game jam 2025!",4,Env.height-20)

        MENU.UI.MENU:Draw()
        if MENU.DEBUGDRAW then
            MENU.UI.MENU:DebugDraw()
        end
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Draw()
        if MENU.DEBUGDRAW then
            MENU.UI.LEVELSELECT:DebugDraw()
        end
    end
end

function scene.Mousepressed(mx,my,b)
    if b ~= 1 then return end
    if MENU.STATE == "title" then
        MENU.UI.MENU:Mousepressed(mx,my,b)
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Mousepressed(mx,my,b)
    end
end
function scene.Mousereleased(mx,my,b)
    if b ~= 1 then return end
    if MENU.STATE == "title" then
        MENU.UI.MENU:Mousereleased(mx,my,b)
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Mousereleased(mx,my,b)
    end
end

function scene.Keypressed(key)
    if key == "tab" then GAME.DEBUGDRAW = not GAME.DEBUGDRAW end
end

function ChooseLevel(levelno)
    LEVELNO = levelno

    GAME = {} -- Clear game
    MENU = {} -- Clear menu
    SCENE:LoadScene("game")
end

function NextLevel()
    if not LEVELNO then
        LEVELNO = 0
    end
    LEVELNO = LEVELNO + 1

    GAME = {} -- Clear game
    MENU = {} -- Clear menu
    SCENE:LoadScene("game")
end

return scene