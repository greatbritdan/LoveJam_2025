local scene = {}

LEVELNO = 0

MENU = {DEBUGDRAW=false}
function scene.LoadScene()
    -- Load UI
    MENU.UI = {}
    MENU.UI.LEVELSELECT = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.levelselect = UI.TEXT:new({W=166,H=12},{text="levelselect"},"basic")
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

    MENU.UI.LEVELSELECT:Recaclulate()

    MENU.BACKGROUNDSCROLL = 0
end

function scene.Update(dt)
    MENU.BACKGROUNDSCROLL = MENU.BACKGROUNDSCROLL + dt * 25
    if MENU.BACKGROUNDSCROLL > 320 then
        MENU.BACKGROUNDSCROLL = MENU.BACKGROUNDSCROLL - 320
    end

    MENU.UI.LEVELSELECT:Update(dt)
end

function scene.Draw()
    love.graphics.setColor(1,1,1,0.5)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL,8)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL+320,8)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL+640,8)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(FrameMenuImg,0,0)

    MENU.UI.LEVELSELECT:Draw()
    if MENU.DEBUGDRAW then
        MENU.UI.LEVELSELECT:DebugDraw()
    end
end

function scene.Mousepressed(mx,my,b)
    if b ~= 1 then return end
    MENU.UI.LEVELSELECT:Mousepressed(mx,my,b)
end
function scene.Mousereleased(mx,my,b)
    if b ~= 1 then return end
    MENU.UI.LEVELSELECT:Mousereleased(mx,my,b)
end

function scene.Keypressed(key)
    if key == "tab" then GAME.DEBUGDRAW = not GAME.DEBUGDRAW end
end

function ChooseLevel(levelno)
    LEVELNO = levelno

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