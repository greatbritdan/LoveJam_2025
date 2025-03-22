-- BritInput, a simple input manager for Love2d, made by Britdan

local britinput = {
    inputmap = {
        jump = {
            "key:space","key:w","key:up","button:a","button:b","key:z"
        },
        left = {
            "key:a","key:left","button:dpleft","axis:leftx:-","axis:triggerleft:-"
        },
        right = {
            "key:d","key:right","button:dpright","axis:leftx:+","axis:triggerleft:+"
        },
    },
    held = {}, -- table to store held inputs
    heldaxis = {}, -- table to store held axis values
    addmapping = false, -- flag to add new mappings (will be set to input name)
}

function britinput:SplitMapping(string)
    local results = {}
    for i in string.gmatch(string, "[^:]+") do
        table.insert(results, i)
    end
    ---@diagnostic disable-next-line: deprecated
    return unpack(results)
end
function britinput:ResetMappings(name)
    self.inputmap[name] = nil
end
function britinput:AwaitNewMapping(name, callback)
    self.addmapping = name
    self.callback = callback
end

-- typ = "key","mouse","button","axis"
function britinput:EvaluateInput(typ,id,dir)
    if self.addmapping then
        local newmapping = typ..":"..id..(dir and ":"..dir or "")
        table.insert(self.inputmap[self.addmapping], newmapping)
        if self.callback then self.callback(newmapping) end
        self.addmapping = false
        return false
    end
    for name,mappings in pairs(self.inputmap) do
        for _,mapping in ipairs(mappings) do
            local inputtyp, inputid, inputdir = self:SplitMapping(mapping)
            if inputtyp == typ and inputid == id and ((not dir) or inputdir == dir) then
                return name, inputdir
            end
        end
    end
    return false
end

function britinput:GetAxisKey(v)
    local nv = Round(v)
    local vkey = ""
    if nv > 0 then vkey = "+" elseif nv < 0 then vkey = "-" end
    return vkey
end

function britinput:ReleaseAxis(typ,id,lastdir)
    for name,mappings in pairs(self.inputmap) do
        for _,mapping in ipairs(mappings) do
            local inputtyp, inputid, inputdir = self:SplitMapping(mapping)
            if inputtyp == typ and inputid == id and inputdir == lastdir then
                InputReleased(name, lastdir)
            end
        end
    end
end

function britinput:GetStick()
    local sticks = love.joystick.getJoysticks()
    if sticks[1] then return sticks[1] end
end

function britinput:Update()
    -- Continue is broken in lovejs and since im not using it, why keep it?
    --[[for name,mappings in pairs(self.inputmap) do
        self.held[name] = nil
        for _,mapping in ipairs(mappings) do
            local inputtyp, inputid, inputdir = self:SplitMapping(mapping)
            if inputtyp == "key" then
                if not inputdir then inputdir = true end
                if love.keyboard.isDown(inputid) then self.held[name] = inputdir; goto continue end
            end
            if inputtyp == "mouse" then
                if not inputdir then inputdir = true end
                if love.mouse.isDown(inputid) then self.held[name] = inputdir; goto continue end
            end
            if inputtyp == "button" or inputtyp == "axis" then
                local stick = self:GetStick()
                if stick and inputtyp == "button" then
                    if not inputdir then inputdir = true end
                    if stick:isGamepadDown(inputid) then self.held[name] = inputdir; goto continue end
                end
                if stick and inputtyp == "axis" then
                    local vkey = self:GetAxisKey(stick:getGamepadAxis(inputid))
                    if (inputdir and vkey == inputdir) or ((not inputdir) and vkey ~= "") then self.held[name] = vkey; goto continue end
                end
            end
        end
        ::continue::
    end]]
end
function britinput:Holding(name)
    return self.held[name]
end

function britinput:Keypressed(key)
    local name, dir = self:EvaluateInput("key",key)
    if name then InputPressed(name, dir) end
end
function britinput:Keyreleased(key)
    local name, dir = self:EvaluateInput("key",key)
    if name then InputReleased(name, dir) end
end
function britinput:Mousepressed(b)
    local name, dir = self:EvaluateInput("mouse",b)
    if name then InputPressed(name, dir) end
end
function britinput:Mousereleased(b)
    local name, dir = self:EvaluateInput("mouse",b)
    if name then InputReleased(name, dir) end
end
function britinput:Gamepadpressed(s,b)
    local name, dir = self:EvaluateInput("button",b)
    if name then InputPressed(name, dir) end
end
function britinput:Gamepadreleased(s,b)
    local name, dir = self:EvaluateInput("button",b)
    if name then InputReleased(name, dir) end
end
function britinput:Gamepadaxis(s,a,v)
    local vkey = self:GetAxisKey(v)
    if not self.heldaxis[a] then self.heldaxis[a] = "" end
    if vkey ~= self.heldaxis[a] then
        local name, dir = self:EvaluateInput("axis",a,vkey)
        self:ReleaseAxis("axis",a,self.heldaxis[a]) -- type, id, lastdir
        if name then InputPressed(name, dir) end
        self.heldaxis[a] = vkey
    end
end

return britinput