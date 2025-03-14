-- BritUI - A UI library for Love2d, made by Britdan

local path = (...) and (...):gsub('%.init$', '') .. "." or ""
local dirpath = path:gsub('%.', '/')

_BRITUI = {INPUTTING = nil, STYLES = {}}

function _BRITUI.NewStyle(path, default)
    local styleclass = require(path)
    if default then
        _BRITUI.STYLE = styleclass -- Used for inheritance
    end
    local style = styleclass:new()
    _BRITUI.STYLES[style.name] = style
    _BRITUI.STYLES[style.name]:initialize()
end

_BRITUI.NewStyle(path .. "basestyle", true)

local files = love.filesystem.getDirectoryItems("graphics/UIstyles")
for k, file in ipairs(files) do
    if file:match(".lua$") then
        _BRITUI.NewStyle("graphics.UIstyles." .. file:gsub(".lua$", ""))
    end
end

_BRITUI.MATRIX = require(path .. "matrix")
_BRITUI.BASE = require(path .. "base")

_BRITUI.SPACER = require(path .. "elements.spacer")
_BRITUI.TEXT = require(path .. "elements.text")
_BRITUI.IMAGE = require(path .. "elements.image")
_BRITUI.CYCLEDOTS = require(path .. "elements.cycledots")
_BRITUI.COUNTER = require(path .. "elements.counter")

_BRITUI.BUTTON = require(path .. "elements.button")
_BRITUI.CYCLEBUTTON = require(path .. "elements.cyclebutton")
_BRITUI.INPUT = require(path .. "elements.input")
_BRITUI.SLIDER = require(path .. "elements.slider")
_BRITUI.DROPDOWN = require(path .. "elements.dropdown")

return _BRITUI