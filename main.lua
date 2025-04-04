function love.load()
    math.randomseed(os.time());math.random();math.random()
    
    -- Load Graphics --
    love.graphics.setDefaultFilter("nearest","nearest")
    Font = love.graphics.newImageFont("graphics/font.png","abcdefghijklmnopqrstuvwxyz |.,:;!?_-/\\<>'\"0123456789",1)
    SmallFont = love.graphics.newImageFont("graphics/smallfont.png","abcdefghijklmnopqrstuvwxyz 0123456789.,!?'():/%*",1)
    love.graphics.setFont(SmallFont)

    TitleImg = love.graphics.newImage("graphics/title.png")
    FrameImg = love.graphics.newImage("graphics/frame.png")
    FrameMenuImg = love.graphics.newImage("graphics/framemenu.png")
    InventoryImg, InventoryQuads = LoadSprites{path="graphics/inventory.png",xquads=10,yquads=1,xquadnames={"slot",1,2,3,4,5,6,7,8,9}}
    ItemselecterImg, ItemselecterQuads = LoadSprites{path="graphics/itemselecter.png",xquads=3,yquads=1}
    DialogImg = love.graphics.newImage("graphics/dialog.png")

    WaterImg, WaterQuads = LoadSprites{path="graphics/water.png",xquads=4,yquads=2}

    BackgroundImg = love.graphics.newImage("graphics/background.png")
    TitleTilesImg = love.graphics.newImage("graphics/titletiles.png")
    PlayerImg, PlayerQuads = LoadSprites{path="graphics/player.png",xquads=9,yquads=1}
    ExitImg, ExitQuads = LoadSprites{path="graphics/exit.png",xquads=4,yquads=1}

    KeyImg, KeyQuads = LoadSprites{path="graphics/key.png",xquads=4,yquads=1,xquadnames={"yellow","red","green","blue"}}
    DoorHorImg, DoorHorQuads = LoadSprites{path="graphics/doorhor.png",xquads=1,yquads=4,yquadnames={"yellow","red","green","blue"}}
    DoorVerImg, DoorVerQuads = LoadSprites{path="graphics/doorver.png",xquads=4,yquads=1,xquadnames={"yellow","red","green","blue"}}

    SpringboardImg, SpringboardQuads = LoadSprites{path="graphics/springboard.png",xquads=4,yquads=1}
    CrateImg = love.graphics.newImage("graphics/crate.png")
    PlatformImg, PlatformQuads = LoadSprites{path="graphics/platform.png",xquads=4,yquads=1}
    OrbImg, OrbQuads = LoadSprites{path="graphics/orb.png",xquads=5,yquads=1}
    TeleporterImg, TeleporterQuads = LoadSprites{path="graphics/teleporter.png",xquads=6,yquads=1}
    BallImg, BallQuads = LoadSprites{path="graphics/ball.png",xquads=3,yquads=1}

    EffectImg, EffectQuads = LoadSprites{path="graphics/particle.png",xquads=4,yquads=4,yquadnames={"dust","star","confetti","redstar"}}

    -- Load Sounds --
    DiscardSound = love.audio.newSource("audio/discard.mp3","static")
    DoorSound = love.audio.newSource("audio/door.mp3","static")
    JumpSound = love.audio.newSource("audio/jump.mp3","static")
    DeathSound = love.audio.newSource("audio/death.wav","static")
    KeySounds = {
        love.audio.newSource("audio/key1.mp3","static"),
        love.audio.newSource("audio/key2.mp3","static"),
        love.audio.newSource("audio/key3.mp3","static")
    }
    LandSound = love.audio.newSource("audio/land.mp3","static")
    PickupSound = love.audio.newSource("audio/pickup.mp3","static")
    PlaceSound = love.audio.newSource("audio/place.mp3","static")
    StepSounds = {
        love.audio.newSource("audio/step1.mp3","static"),
        love.audio.newSource("audio/step2.mp3","static"),
        love.audio.newSource("audio/step3.mp3","static"),
        love.audio.newSource("audio/step4.mp3","static"),
        love.audio.newSource("audio/step5.mp3","static")
    }
    TalkSounds = {
        love.audio.newSource("audio/talk1.mp3","static"),
        love.audio.newSource("audio/talk2.mp3","static"),
        love.audio.newSource("audio/talk3.mp3","static"),
        love.audio.newSource("audio/talk4.mp3","static"),
        love.audio.newSource("audio/talk5.mp3","static"),
        love.audio.newSource("audio/talk6.mp3","static"),
        love.audio.newSource("audio/talk7.mp3","static"),
        love.audio.newSource("audio/talk8.mp3","static"),
        love.audio.newSource("audio/talk9.mp3","static")
    }
    TeleportSound = love.audio.newSource("audio/teleport.mp3","static")
    HuhSound = love.audio.newSource("audio/itsvictoryorthegrave.mp3","static")

    MainThemeMusic = love.audio.newSource("audio/maintheme.mp3","stream")
    MainThemeMusic:setLooping(true)
    EditThemeMusic = love.audio.newSource("audio/edittheme.mp3","stream")
    EditThemeMusic:setLooping(true)
    PlaceMusic = love.audio.newSource("audio/place.mp3","static")

    SOUNDS = {DiscardSound,DoorSound,JumpSound,DeathSound,LandSound,PickupSound,PlaceSound,KeySounds,StepSounds,TalkSounds,TeleportSound}
    MUSIC = {PlaceMusic,MainThemeMusic,EditThemeMusic}

    -- Load Items --
    ItemsImg, ItemsQuads = LoadSprites{path="graphics/items.png",xquads=14,yquads=1}

    _ITEMS_ORDER = {"springboard","crate","platform","yellowkey","redkey","orb","yellowdoorver","yellowdoorhor","reddoorver","reddoorhor","teleporterbluein","teleporterblueout","teleporterorangein","teleporterorangeout"}
    _ITEM_CLASSES = {"key","orb","teleporter","springboard","platform","crate","door"}
    _ITEMS = {}
    _ITEMS.springboard =         {displayname="springboard",            name="springboard",        class="springboard",img=ItemsImg,quad=ItemsQuads[1], spawn={ox=1,oy=14,w=14,h=2}}
    _ITEMS.crate =               {displayname="crate",                  name="crate",              class="crate",      img=ItemsImg,quad=ItemsQuads[2], spawn={ox=0,oy=0,w=16,h=16}}
    _ITEMS.platform =            {displayname="platform",               name="platform",           class="platform",   img=ItemsImg,quad=ItemsQuads[3], spawn={ox=0,oy=0,w=16,h=16}}
    _ITEMS.yellowkey =           {displayname="yellow key",             name="yellowkey",          class="key",        img=ItemsImg,quad=ItemsQuads[4], spawn={ox=4,oy=2,w=8,h=12}, args={color="yellow"}}
    _ITEMS.redkey =              {displayname="red key",                name="redkey",             class="key",        img=ItemsImg,quad=ItemsQuads[5], spawn={ox=4,oy=2,w=8,h=12}, args={color="red"}}
    _ITEMS.orb =                 {displayname="orb",                    name="orb",                class="orb",        img=ItemsImg,quad=ItemsQuads[6], spawn={ox=2,oy=2,w=12,h=12}}
    _ITEMS.yellowdoorver =       {displayname="yellow door (hor)",      name="yellowdoorver",      class="door",       img=ItemsImg,quad=ItemsQuads[7], spawn={ox=4,oy=0,w=8,h=32}, args={color="yellow"}}
    _ITEMS.yellowdoorhor =       {displayname="yellow door (ver)",      name="yellowdoorhor",      class="door",       img=ItemsImg,quad=ItemsQuads[9], spawn={ox=0,oy=4,w=32,h=8}, args={color="yellow",dir="hor"}}
    _ITEMS.reddoorver =          {displayname="red door (hor)",         name="reddoorver",         class="door",       img=ItemsImg,quad=ItemsQuads[8], spawn={ox=4,oy=0,w=8,h=32}, args={color="red"}}
    _ITEMS.reddoorhor =          {displayname="red door (ver)",         name="reddoorhor",         class="door",       img=ItemsImg,quad=ItemsQuads[10],spawn={ox=0,oy=4,w=32,h=8}, args={color="red",dir="hor"}}
    _ITEMS.teleporterbluein =    {displayname="teleporter blue (in)",   name="teleporterbluein",   class="teleporter", img=ItemsImg,quad=ItemsQuads[11],spawn={ox=2,oy=2,w=12,h=14},args={id="blue",other=false}}
    _ITEMS.teleporterblueout =   {displayname="teleporter blue (out)",  name="teleporterblueout",  class="teleporter", img=ItemsImg,quad=ItemsQuads[12],spawn={ox=2,oy=2,w=12,h=14},args={id="blue",other=true}}
    _ITEMS.teleporterorangein =  {displayname="teleporter orange (in)", name="teleporterorangein", class="teleporter", img=ItemsImg,quad=ItemsQuads[13],spawn={ox=2,oy=2,w=12,h=14},args={id="orange",other=false}}
    _ITEMS.teleporterorangeout = {displayname="teleporter orange (out)",name="teleporterorangeout",class="teleporter", img=ItemsImg,quad=ItemsQuads[14],spawn={ox=2,oy=2,w=12,h=14},args={id="orange",other=true}}

    -- Load Libraries --
    Class = require("libs.middleclass")
    JSON = require("libs.JSON")
    BUMP = require("libs.bump")

    UI = require("libs.BritUI")
    SCENE = require("libs.BritScene")
    SAVE = require("libs.BritSaveManager")
    MAP = require("libs.BritMap")
    --INPUT = require("libs.BritInput") -- unused

    -- Load Classes -- 
    OBJECTS = {}
    require("class.dialog")
    require("class.inventory")
    require("class.base")

    require("class.effects")
    require("class.misc")
    require("class.player")
    require("class.items")

    -- Load Save --
    SETTINGS = SAVE:new{path="settings.json",config="save_settings"}
    SETTINGS:LOAD()
    UpdateVolume(SOUNDS,SETTINGS:Get("sounds"))
    UpdateVolume(MUSIC,SETTINGS:Get("music"))
    DEVMODE = SETTINGS:Get("devmode")

    TRANSITION = {timer=0.5,time=1,to=false,x=0,dir=1}
    SCENE:LoadScene("menu")
end

function UpdateVolume(list,value)
    for i, v in pairs(list) do
        if type(v) == "table" then
            UpdateVolume(v,value) -- oooo recursion, scary!
        else
            v:setVolume(value)
        end
    end
end

function love.update(dt)
    dt = math.min(dt, 1/60) -- no falling through the world

    if TRANSITION then
        if TRANSITION.dir == 1 then
            TRANSITION.x = TRANSITION.x + ((Env.width*2)/TRANSITION.time)*dt
        else
            TRANSITION.x = TRANSITION.x - ((Env.width*2)/TRANSITION.time)*dt
        end
        TRANSITION.timer = TRANSITION.timer + dt
        if TRANSITION.timer >= TRANSITION.time/2 and TRANSITION.to then
            SCENE:LoadScene(TRANSITION.to)
            TRANSITION.to = false
        end
        if TRANSITION.timer >= TRANSITION.time then
            TRANSITION.timer = 0
            TRANSITION = false
        end
    end

    --INPUT:Update()
    SCENE:Update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(Env.scale,Env.scale)

    SCENE:Draw()
    if TRANSITION then
        love.graphics.setColor(31/255,16/255,42/255)
        love.graphics.rectangle("fill",0+TRANSITION.x,0,Env.width,Env.height)
    end

    love.graphics.pop()
end

function love.mousepressed(x,y,b)
    if TRANSITION then return end
    x, y = x/Env.scale, y/Env.scale
    if _BRITUI.INPUTTING and _BRITUI.INPUTTING.inputting then
        _BRITUI.INPUTTING:StopInputting()
        ---@diagnostic disable-next-line: inject-field
        _BRITUI.INPUTTING.inputting = false
    end
    _BRITUI.INPUTTING = nil
    --INPUT:Mousepressed(b)
    SCENE:Run("Mousepressed",{x,y,b})
end
function love.mousereleased(x,y,b)
    if TRANSITION then return end
    x, y = x/Env.scale, y/Env.scale
    --INPUT:Mousereleased(b)
    SCENE:Run("Mousereleased",{x,y,b})
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
    if TRANSITION then return end
    --INPUT:Keypressed(key)
    SCENE:Run("Keypressed",{key})
end
function love.keyreleased(key)
    if TRANSITION then return end
    --INPUT:Keyreleased(key)
    SCENE:Run("Keyreleased",{key})
end

function love.gamepadpressed(s,b)
    if TRANSITION then return end
    --INPUT:Gamepadpressed(s,b)
end
function love.gamepadreleased(s,b)
    if TRANSITION then return end
    --INPUT:Gamepadreleased(s,b)
end
function love.gamepadaxis(s,a,v)
    if TRANSITION then return end
    --INPUT:Gamepadaxis(s,a,v)
end

function InputPressed(name,dir)
    if TRANSITION then return end
    SCENE:Run("InputPressed",{name,dir})
end
function InputReleased(name,dir)
    if TRANSITION then return end
    SCENE:Run("InputReleased",{name,dir})
end

function love:wheelmoved(y) SCENE:Run("Wheelmoved",{y}) end
function love.textinput(key) SCENE:Run("Textinput",{key}) end

local gx = love.mouse.getX
function love.mouse.getX()
    return gx()/Env.scale
end
local gy = love.mouse.getY
function love.mouse.getY()
    return gy()/Env.scale
end
local gxy = love.mouse.getPosition
function love.mouse.getPosition()
    return gx()/Env.scale, gy()/Env.scale
end

-----------------------------

function Round(value)
    return math.floor(value+0.5)
end
function Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end
function AABB(x1,y1,w1,h1,x2,y2,w2,h2)
    return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function Split(str, d)
	local data = {}
	local from, to = 1, string.find(str, d)
	while to do
		table.insert(data, string.sub(str, from, to-1))
		from = to+d:len()
		to = string.find(str, d, from)
	end
	table.insert(data, string.sub(str, from))
	return data
end

function TableContains(text, table, key)
    for i, v in pairs(table) do
        if (key and v[key] == text) or ((not key) and v == text) then
            return i
        end
    end
    return false
end

function DeepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[DeepCopy(orig_key)] = DeepCopy(orig_value)
        end
        setmetatable(copy, DeepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

-- Get a value from a table using a string
-- e.g. GetFromTable(_G, "love.graphics.rectangle") returns love.graphics.rectangle
function GetFromTable(table, name)
    local parts = {}
    for part in string.gmatch(name, "[^%.]+") do
        table.insert(parts, part)
    end
    local value = table
    for _, part in ipairs(parts) do
        value = value[part]
        if value == nil then
            return nil
        end
    end
    return value
end

function LoadSprites(args)
    local path = args.path
    local img = love.graphics.newImage(path)
    if args.noquads then
        return img -- Avoid unnecessary quad creation
    end
    local quads = {}

    local fullw, fullh = img:getDimensions()
    local xquads, yquads = args.xquads or 1, args.yquads or 1
    local quadw, quadh = fullw/xquads, fullh/yquads

    local function getname(idx,names)
        if names then
            return names[idx]
        end
        return idx
    end

    if xquads > 1 and yquads > 1 then
        for y = 1, yquads do
            local yname = getname(y,args.yquadnames)
            quads[yname] = {}
            for x = 1, xquads do
                local xname = getname(x,args.xquadnames)
                quads[yname][xname] = love.graphics.newQuad((x-1)*quadw, (y-1)*quadh, quadw, quadh, fullw, fullh)
            end
        end
    elseif xquads > 1 and yquads <= 1 then
        for x = 1, xquads do
            local xname = getname(x,args.xquadnames)
            quads[xname] = love.graphics.newQuad((x-1)*quadw, 0, quadw, quadh, fullw, fullh)
        end
    elseif xquads <= 1 and yquads > 1 then
        for y = 1, yquads do
            local yname = getname(y,args.yquadnames)
            quads[yname] = love.graphics.newQuad(0, (y-1)*quadh, quadw, quadh, fullw, fullh)
        end
    else
        quads = love.graphics.newQuad(0, 0, quadw, quadh, fullw, fullh)
    end

    return img, quads
end

function LoadTileset(args)
    local path = args.path
    local img = love.graphics.newImage(path)

    local fullw, fullh = img:getDimensions()
    local tilew, tileh = args.tilew or 16, args.tileh or 16
    local spacex, spacey = args.spacex or 0, args.spacey or 0
    local xquads, yquads = fullw/(tilew+spacex), fullh/(tileh+spacey)

    local i = 0
    local quads = {}
    for y = 1, yquads do
        for x = 1, xquads do
            quads[i] = love.graphics.newQuad((x-1)*(tilew+spacex), (y-1)*(tileh+spacey), tilew, tileh, fullw, fullh)
            i = i + 1
        end
    end

    return {image=img, quads=quads, count=#quads}
end

-- Better printing (with table support) - Inspired by WilliamFrog
Printold = print
function print(...)
    local vals = {...}
    local outvals = {}
    for i, t in pairs(vals) do
        if type(t) == "table" then
            outvals[i] = Tabletostring(t)
        elseif type(t) == "function" then
            outvals[i] = "function"
        else
            outvals[i] = tostring(t)
        end
    end
    ---@diagnostic disable-next-line: deprecated
    Printold(unpack(outvals))
end
function Tabletostring(t)
    local array = true
    local ai = 0
    local outtable = {}
    for i, v in pairs(t) do
        if type(v) == "table" then
            outtable[i] = Tabletostring(v)
        elseif type(v) == "function" then
            outtable[i] = "function"
        else
            outtable[i] = tostring(v)
        end

        ai = ai + 1
        if t[ai] == nil then
            array = false
        end
    end
    local out = ""
    if array then
        out = "[" .. table.concat(outtable,",") .. "]"
    else
        for i, v in pairs(outtable) do
            out = string.format("%s%s: %s, ", out, i, v)
        end
        out = "{" .. out .. "}"
    end
    return out
end