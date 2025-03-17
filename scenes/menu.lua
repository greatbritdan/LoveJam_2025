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
    MENU.UI.levelselect = UI.BUTTON:new({W=166,H=30},{children={{text="level select"}},repeating=false,func=function() MENU.STATE = "levelselect" end},"basic")
    MENU.UI.settings = UI.BUTTON:new({W=166,H=30},{children={{text="settings"}},repeating=false,func=function() MENU.STATE = "settings" end},"basic")

    MENU.UI.MENU:Setup{MC={{MENU.UI.start},{MENU.UI.levelselect},{MENU.UI.settings}}}
    MENU.UI.MENU:Recaclulate()


    -- LEVEL SELECT
    MENU.UI.LEVELSELECT = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.levelselect = UI.TEXT:new({W=166,H=12},{text="level select!"},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.levelselect,"MC","horizontal")

    local i = 0
    for _ = 1, 3 do
        for x = 1, 5 do
            i = i + 1

            local text = i
            if SETTINGS:GetInside("levelsbeaten",i) then
                text = i.."*"
            end

            MENU.UI["level"..i] = UI.BUTTON:new({W=30,H=30},{children={{text=text}},repeating=false,func=function(e) ChooseLevel(e.levelno) end},"basic")
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


    -- SETTINGS
    MENU.UI.SETTINGS = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.settings = UI.TEXT:new({W=166,H=12},{text="settings!"},"basic")

    MENU.UI.music_left = UI.TEXT:new({W=83,H=30},{text="music:",margin=0,alignX="right"},"basic")
    MENU.UI.music = UI.SLIDER:new({W=166,H=30},{value=SETTINGS:Get("music"),limit={0,1,0.1},func=function(e)
        SETTINGS:Set("music",e.value); SETTINGS:SAVE()
    end},"basic")
    MENU.UI.music_right = UI.TEXT:new({W=83,H=30},{text="test",margin=0,alignX="left"},"basic")
    MENU.UI.music_right:Link(MENU.UI.music)
    -- Override GetValue to return a percentage
    MENU.UI.music.GetValue = function (self)
        return math.floor(self.value*100).."%"
    end

    MENU.UI.sounds_left = UI.TEXT:new({W=83,H=30},{text="sounds:",margin=0,alignX="right"},"basic")
    MENU.UI.sounds = UI.SLIDER:new({W=166,H=30},{value=SETTINGS:Get("sounds"),limit={0,1,0.1},func=function(e)
        SETTINGS:Set("sounds",e.value); SETTINGS:SAVE()
    end},"basic")
    MENU.UI.sounds_right = UI.TEXT:new({W=83,H=30},{text="test",margin=0,alignX="left"},"basic")
    MENU.UI.sounds_right:Link(MENU.UI.sounds)
    MENU.UI.sounds.GetValue = function (self)
        return math.floor(self.value*100).."%"
    end
    
    MENU.UI.spacer_setting = UI.SPACER:new({W=166,H=12},{},"basic")
    MENU.UI.back_settings = UI.BUTTON:new({W=166,H=30},{children={{text="back to menu"}},repeating=false,func=function() MENU.STATE = "title" end},"basic")

    MENU.UI.SETTINGS:Setup{MC={
        {MENU.UI.settings},
        {MENU.UI.music_left,MENU.UI.music,MENU.UI.music_right},
        {MENU.UI.sounds_left,MENU.UI.sounds,MENU.UI.sounds_right},
        {MENU.UI.spacer_setting},
        {MENU.UI.back_settings}
    }}
    MENU.UI.SETTINGS:Recaclulate()
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
    elseif MENU.STATE == "settings" then
        MENU.UI.SETTINGS:Update(dt)
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
    elseif MENU.STATE == "settings" then
        MENU.UI.SETTINGS:Draw()
        if MENU.DEBUGDRAW then
            MENU.UI.SETTINGS:DebugDraw()
        end
    end
end

function scene.Mousepressed(mx,my,b)
    if b ~= 1 then return end
    if MENU.STATE == "title" then
        MENU.UI.MENU:Mousepressed(mx,my,b)
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Mousepressed(mx,my,b)
    elseif MENU.STATE == "settings" then
        MENU.UI.SETTINGS:Mousepressed(mx,my,b)
    end
end
function scene.Mousereleased(mx,my,b)
    if b ~= 1 then return end
    if MENU.STATE == "title" then
        MENU.UI.MENU:Mousereleased(mx,my,b)
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Mousereleased(mx,my,b)
    elseif MENU.STATE == "settings" then
        MENU.UI.SETTINGS:Mousereleased(mx,my,b)
    end
end

function scene.Keypressed(key)
    if key == "tab" then MENU.DEBUGDRAW = not MENU.DEBUGDRAW end
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