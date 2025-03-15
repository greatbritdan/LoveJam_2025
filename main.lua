function love.load()
    -- Load Graphics --
    love.graphics.setDefaultFilter("nearest","nearest")
    Font = love.graphics.newImageFont("graphics/font.png","abcdefghijklmnopqrstuvwxyz |.,:;!?_-/\\<>'\"0123456789",1)
    love.graphics.setFont(Font)

    FrameImg = love.graphics.newImage("graphics/frame.png")
    InventoryImg, InventoryQuads = LoadSprites{path="graphics/inventory.png",xquads=10,yquads=1,xquadnames={"slot",1,2,3,4,5,6,7,8,9}}

    PlayerImg, PlayerQuads = LoadSprites{path="graphics/player.png",xquads=6,yquads=1}
    DoorImg = love.graphics.newImage("graphics/door.png")
    SpringboardImg, SpringboardQuads = LoadSprites{path="graphics/springboard.png",xquads=4,yquads=1}

    _ITEMS = {
        springboard = {name="springboard",img=SpringboardImg,quad=SpringboardQuads[2],spawn={ox=1,oy=14,w=14,h=2}}
    }

    -- Load Libraries --
    Class = require("libs.middleclass")
    JSON = require("libs.JSON")
    BUMP = require("libs.bump")

    UI = require("libs.BritUI")
    SCENE = require("libs.BritScene")
    SAVE = require("libs.BritSaveManager")
    MAP = require("libs.BritMap")
    INPUT = require("libs.BritInput")

    -- Load Classes -- 
    OBJECTS = {}
    require("class.inventory")
    require("class.base")

    require("class.misc")
    require("class.player")
    require("class.items")

    SCENE:LoadScene("game")
end

function love.update(dt)
    dt = math.min(dt, 1/60) -- no falling through the world
    INPUT:Update()
    SCENE:Update(dt)
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(Env.scale,Env.scale)
    SCENE:Draw()
    love.graphics.pop()
end

function love.mousepressed(x,y,b)
    x, y = x/Env.scale, y/Env.scale
    if _BRITUI.INPUTTING and _BRITUI.INPUTTING.inputting then
        _BRITUI.INPUTTING:StopInputting()
        ---@diagnostic disable-next-line: inject-field
        _BRITUI.INPUTTING.inputting = false
    end
    _BRITUI.INPUTTING = nil
    INPUT:Mousepressed(b)
    SCENE:Run("Mousepressed",{x,y,b})
end
function love.mousereleased(x,y,b)
    x, y = x/Env.scale, y/Env.scale
    INPUT:Mousereleased(b)
    SCENE:Run("Mousereleased",{x,y,b})
end

function love.keypressed(key)
    INPUT:Keypressed(key)
    SCENE:Run("Keypressed",{key})
end
function love.keyreleased(key)
    INPUT:Keyreleased(key)
    SCENE:Run("Keyreleased",{key})
end

function love.gamepadpressed(s,b)
    INPUT:Gamepadpressed(s,b)
end
function love.gamepadreleased(s,b)
    INPUT:Gamepadreleased(s,b)
end
function love.gamepadaxis(s,a,v)
    INPUT:Gamepadaxis(s,a,v)
end

function InputPressed(name,dir)
    SCENE:Run("InputPressed",{name,dir})
end
function InputReleased(name,dir)
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