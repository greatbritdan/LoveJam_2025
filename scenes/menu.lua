local scene = {}

LEVELNO = 0
MENU = {}

DEBUGDRAW = false
GAMEWON = false

function scene.LoadScene()
    if GAMEWON then
        MENU.STATE = "win"
        GAMEWON = false
    else
        MENU.STATE = "title"
    end
    MENU.BACKGROUNDSCROLL = 0
    MENU.BACKGROUNDTILESSCROLL = 0
    MENU.TIMER = 0

    MENU.DUSTTIMER = 0
    MENU.EFFECTS = {}

    MENU.RESETTIMER = false

    MENU.UI = {}

    LASTLEVEL = false


    -- TITLE
    MENU.UI.MENU = UI.MATRIX:new({X=124,Y=90,W=232,H=122},{},"basic")

    MENU.CONTINUELEVEL = SETTINGS:Get("level")+1
    if MENU.CONTINUELEVEL > 15 then MENU.CONTINUELEVEL = 15 end

    if MENU.CONTINUELEVEL >= 2 then
        MENU.UI.start = UI.BUTTON:new({W=166,H=24},{children={{text="continue! ("..MENU.CONTINUELEVEL..")"}},repeating=false,func=function() ChooseLevel(MENU.CONTINUELEVEL) end},"basic")
    else
        MENU.UI.start = UI.BUTTON:new({W=166,H=24},{children={{text="play!"}},repeating=false,func=function() ChooseLevel(1) end},"basic")
    end
    MENU.UI.levelselect = UI.BUTTON:new({W=166,H=24},{children={{text="level select"}},repeating=false,func=function() MENU.STATE = "levelselect" end},"basic")
    MENU.UI.settings = UI.BUTTON:new({W=166,H=24},{children={{text="settings"}},repeating=false,func=function() MENU.STATE = "settings" end},"basic")

    MENU.UI.MENU:Setup{MC={{MENU.UI.start},{MENU.UI.levelselect},{MENU.UI.settings}}}
    MENU.UI.MENU:Recaclulate()

    MENU.TITLETEXTS = {
        "not the murder kind!", "made in 10 days!", "when the sun always shines!", "dicelatro died for this...", "send all bugs to keyslam!", "the theme was plan btw.",
        "don't click the secret button?", "0% bugs (give or take 100%)", "love is for all!", "it's jammin' time!", "no little guys we're harmed in the making of this game.",
        "quality approved by williamfrog.", "don't question the physics...", "collisons courtesy of bump.lua!", "impossible without middleclass!", "blam blam blam... blam?"
    }
    MENU.TITLETEXT = MENU.TITLETEXTS[math.random(1,#MENU.TITLETEXTS)]


    -- LEVEL SELECT
    MENU.UI.LEVELSELECT = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.levelselect = UI.TEXT:new({W=166,H=12},{text="level select!"},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.levelselect,"MC","horizontal")

    local i = 0
    for _ = 1, 3 do
        for x = 1, 5 do
            i = i + 1

            local text = tostring(i)
            if SETTINGS:GetInside("levelsbeaten",i) then
                text = i.."*"
            end

            MENU.UI["level"..i] = UI.BUTTON:new({W=30,H=24},{children={{text=text}},repeating=false,func=function(e) ChooseLevel(e.levelno) end},"basic")
            MENU.UI["level"..i].levelno = i
            local dir = "horizontal"
            if (x == 1) then dir = "vertical" end
            MENU.UI.LEVELSELECT:Add(MENU.UI["level"..i],"MC",dir)
        end
    end

    if DEVMODE then
        MENU.UI.leveltest = UI.BUTTON:new({W=166,H=24},{children={{text="test"}},repeating=false,func=function() ChooseLevel(0) end},"basic")
        MENU.UI.LEVELSELECT:Add(MENU.UI.leveltest,"MC","vertical")
    end

    MENU.UI.spacer = UI.SPACER:new({W=166,H=12},{},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.spacer,"MC","vertical")

    MENU.UI.back = UI.BUTTON:new({W=166,H=24},{children={{text="back to menu"}},repeating=false,func=function() MENU.STATE = "title" end},"basic")
    MENU.UI.LEVELSELECT:Add(MENU.UI.back,"MC","vertical")

    MENU.UI.LEVELSELECT:Recaclulate()


    -- SETTINGS
    MENU.UI.SETTINGS = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.settings = UI.TEXT:new({W=166,H=12},{text="settings!"},"basic")

    MENU.UI.music_left = UI.TEXT:new({W=83,H=24},{text="music:",margin=0,alignX="right"},"basic")
    MENU.UI.music = UI.SLIDER:new({W=166,H=24},{value=SETTINGS:Get("music"),limit={0,1,0.01},headfill=0.135,func=function(e)
        SETTINGS:Set("music",e.value); SETTINGS:SAVE(); UpdateVolume(MUSIC,e.value); PlaceMusic:play()
    end},"basic")
    MENU.UI.music_right = UI.TEXT:new({W=83,H=24},{text="test",margin=0,alignX="left"},"basic")
    MENU.UI.music_right:Link(MENU.UI.music)
    -- Override GetValue to return a percentage
    MENU.UI.music.GetValue = function (self)
        return math.floor(self.value*100).."%"
    end

    MENU.UI.sounds_left = UI.TEXT:new({W=83,H=24},{text="sounds:",margin=0,alignX="right"},"basic")
    MENU.UI.sounds = UI.SLIDER:new({W=166,H=24},{value=SETTINGS:Get("sounds"),limit={0,1,0.01},headfill=0.135,func=function(e)
        SETTINGS:Set("sounds",e.value); SETTINGS:SAVE(); UpdateVolume(SOUNDS,e.value); PlaceSound:play()
    end},"basic")
    MENU.UI.sounds_right = UI.TEXT:new({W=83,H=24},{text="test",margin=0,alignX="left"},"basic")
    MENU.UI.sounds_right:Link(MENU.UI.sounds)
    MENU.UI.sounds.GetValue = function (self)
        return math.floor(self.value*100).."%"
    end

    local idx = 1
    if SETTINGS:Get("skipdialog") then idx = 2 end
    MENU.UI.skipdialogtext = UI.TEXT:new({W=166,H=12},{text="skip dialog?"},"basic")
    MENU.UI.skipdialog = UI.CYCLEBUTTON:new({W=166,H=24},{children={{text="no",autolink=true}},cycle={"no","yes"},cycleidx=idx,func=function(e)
        local value = false
        if e:GetValue() == "yes" then value = true end
        SETTINGS:Set("skipdialog",value); SETTINGS:SAVE()
    end},"basic")
    
    MENU.UI.spacer_setting = UI.SPACER:new({W=166,H=12},{},"basic")
    MENU.UI.back_settings = UI.BUTTON:new({W=166,H=24},{children={{text="back to menu"}},repeating=false,func=function() MENU.STATE = "title" end},"basic") 

    MENU.UI.SETTINGS:Setup{MC={
        {MENU.UI.settings},
        {MENU.UI.music_left,MENU.UI.music,MENU.UI.music_right},
        {MENU.UI.sounds_left,MENU.UI.sounds,MENU.UI.sounds_right},
        {MENU.UI.skipdialogtext},
        {MENU.UI.skipdialog},
        {MENU.UI.spacer_setting},
        {MENU.UI.back_settings}
    }}
    MENU.UI.SETTINGS:Recaclulate()

    
    -- WIN, YIPEE!!
    MENU.UI.WIN = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=Env.height},{},"basic")

    MENU.UI.congratulations = UI.TEXT:new({W=206,H=18},{text="congratulations!",scale=2},"basic")
    MENU.UI.hype = UI.TEXT:new({W=206,H=12},{text="you've completed the game!"},"basic")
    MENU.UI.spacer_win = UI.SPACER:new({W=166,H=146},{},"basic")
    MENU.UI.back_win = UI.BUTTON:new({W=166,H=24},{children={{text="back to menu"}},repeating=false,func=function() MENU.STATE = "title" end},"basic") 

    MENU.UI.WIN:Setup{MC={
        {MENU.UI.congratulations},
        {MENU.UI.hype},
        {MENU.UI.spacer_win},
        {MENU.UI.back_win}
    }}
    MENU.UI.WIN:Recaclulate()


    MainThemeMusic:play()
end

function scene.Update(dt)
    if MENU.RESETTIMER then
        MENU.RESETTIMER = MENU.RESETTIMER + dt
        if MENU.RESETTIMER >= 3 then
            love.filesystem.remove("settings.json")
            SETTINGS:LOAD()

            -- Reset settings
            UpdateVolume(MUSIC,SETTINGS:Get("music"))
            MENU.UI.music.value = (SETTINGS:Get("music"))
            MENU.UI.music:Recaclulate()

            UpdateVolume(SOUNDS,SETTINGS:Get("sounds"))
            MENU.UI.sounds.value = (SETTINGS:Get("sounds"))
            MENU.UI.sounds:Recaclulate()

            MENU.UI.skipdialog.cycleidx = 1

            -- Reset level select
            for i = 1, 15 do
                MENU.UI["level"..i].children[1].text = tostring(i)
            end
            MENU.CONTINUELEVEL = 1
            MENU.UI.start.children[1].text = "play!"

            MENU.RESETTIMER = false
            DeathSound:play()
        end
    end

    MENU.TIMER = MENU.TIMER + dt

    -- Dust effect
    MENU.DUSTTIMER = MENU.DUSTTIMER + dt
    if MENU.DUSTTIMER >= 0.2 then
        table.insert(MENU.EFFECTS,EFFECT:new("dustltitle",56,Env.height-64))
        MENU.DUSTTIMER = 0
    end

    MENU.BACKGROUNDSCROLL = MENU.BACKGROUNDSCROLL + dt * 32
    if MENU.BACKGROUNDSCROLL > 320 then
        MENU.BACKGROUNDSCROLL = MENU.BACKGROUNDSCROLL - 320
    end
    MENU.BACKGROUNDTILESSCROLL = MENU.BACKGROUNDTILESSCROLL + dt * 64
    if MENU.BACKGROUNDTILESSCROLL > 480 then
        MENU.BACKGROUNDTILESSCROLL = MENU.BACKGROUNDTILESSCROLL - 480
    end

    local delete = {}
    for idx,v in pairs(MENU.EFFECTS) do
        if v:update(dt) then
            table.insert(delete,idx)
        end
    end
    table.sort(delete,function(a,b) return a > b end)
    for _,idx in ipairs(delete) do
        table.remove(MENU.EFFECTS,idx)
    end

    if MENU.STATE == "title" then
        MENU.UI.MENU:Update(dt)
    elseif MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Update(dt)
    elseif MENU.STATE == "settings" then
        MENU.UI.SETTINGS:Update(dt)
    elseif MENU.STATE == "win" then
        MENU.UI.WIN:Update(dt)
    end
end

local function titletext(text,x,y,color)
    love.graphics.setColor(0,0,0)
    love.graphics.print(text,x+1,y+1)
    color = color or {1,1,1}
    love.graphics.setColor(color)
    love.graphics.print(text,x,y)
end

function scene.Draw()
    love.graphics.setColor(1,1,1,0.75)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL,8)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL+320,8)
    love.graphics.draw(BackgroundImg,-MENU.BACKGROUNDSCROLL+640,8)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(TitleTilesImg,-MENU.BACKGROUNDTILESSCROLL,0)
    love.graphics.draw(TitleTilesImg,-MENU.BACKGROUNDTILESSCROLL+480,0)
    
    love.graphics.setColor(1,1,1)
    love.graphics.draw(FrameMenuImg,0,0)

    if MENU.STATE == "title" then
        local quad = 4
        if MENU.TIMER%0.2 >= 0.1 then quad = 5 end
        love.graphics.draw(PlayerImg,PlayerQuads[quad],48,Env.height-80)
        for i,v in pairs(MENU.EFFECTS) do
            v:draw()
        end
        love.graphics.setColor(1,1,1)

        local sin = math.sin(MENU.TIMER*4)*2

        local x,y = (Env.width/2) - (TitleImg:getWidth()/2), 20+sin
        love.graphics.draw(TitleImg,x,y)

        x = (Env.width/2) - ((SmallFont:getWidth(MENU.TITLETEXT)-1)/2)
        titletext(MENU.TITLETEXT,x,74+sin,{252/255,239/255,141/255})

        titletext("made by britdan",4,Env.height-30)
        titletext("for the love2d game jam 2025!",4,Env.height-20)

        local text = "version 1.0"
        x = Env.width - 4 - (SmallFont:getWidth(text)-1)
        titletext(text,x,Env.height-30)

        text = "hold q for 3 seconds to clear save"
        x = Env.width - 4 - (SmallFont:getWidth(text)-1)
        if MENU.RESETTIMER then
            titletext(text,x,Env.height-20,{1,0.4,0.4})
        else
            titletext(text,x,Env.height-20)
        end

        MENU.UI.MENU:Draw()
        if DEBUGDRAW then
            MENU.UI.MENU:DebugDraw()
        end
        return
    end

    love.graphics.setColor(0,0,0,0.5)
    love.graphics.rectangle("fill",16,24,Env.width-32,Env.height-48,8,8)

    if MENU.STATE == "levelselect" then
        MENU.UI.LEVELSELECT:Draw()
        if DEBUGDRAW then
            MENU.UI.LEVELSELECT:DebugDraw()
        end
    elseif MENU.STATE == "settings" then
        MENU.UI.SETTINGS:Draw()
        if DEBUGDRAW then
            MENU.UI.SETTINGS:DebugDraw()
        end
    elseif MENU.STATE == "win" then
        love.graphics.setColor(1,1,1)
        local sin = math.sin(MENU.TIMER*4)*2
        love.graphics.draw(PlayerImg,PlayerQuads[9],(Env.width/2)-32,(Env.height/2)-32+sin,0,4,4)

        MENU.UI.WIN:Draw()
        if DEBUGDRAW then
            MENU.UI.WIN:DebugDraw()
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
    elseif MENU.STATE == "secret" then
        MENU.UI.SECRET:Mousepressed(mx,my,b)
    elseif MENU.STATE == "win" then
        MENU.UI.WIN:Mousepressed(mx,my,b)
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
    elseif MENU.STATE == "secret" then
        MENU.UI.SECRET:Mousereleased(mx,my,b)
    elseif MENU.STATE == "win" then
        MENU.UI.WIN:Mousereleased(mx,my,b)
    end
end

function scene.Keypressed(key)
    if key == "q" then
        MENU.RESETTIMER = 0
    end
    if DEVMODE and key == "tab" then DEBUGDRAW = not DEBUGDRAW end
end

function scene.Keyreleased(key)
    if key == "q" then
        MENU.RESETTIMER = false
    end
end

function ChooseLevel(levelno)
    LEVELNO = levelno
    TRANSITION = {timer=0,time=1,to="game",x=Env.width,dir=-1}
end

function NextLevel()
    if not LEVELNO then LEVELNO = 0 end
    LEVELNO = LEVELNO + 1
    TRANSITION = {timer=0,time=1,to="game",x=Env.width,dir=-1}
end

return scene