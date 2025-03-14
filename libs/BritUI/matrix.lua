-- Matrix - organizes and manages a list of UI elements
local matrix = Class("britui_matrix")

function matrix:initialize(transform, args, style)
    args = args or {}
    self.T = "matrix"
    
    self.originalargs = DeepCopy(args) -- for style changing
    self.X, self.Y, self.W, self.H = transform.X, transform.Y, transform.W, transform.H
    self.style = _BRITUI.STYLES[style] or _BRITUI.STYLES["default"]
    self.style:Overrides(self, args)

    -- Each corner has it's own 2d matrix of elements that will be calculated wheb self:Recaclulate() is called
    self.TL = {{}}; self.TC = {{}}; self.TR = {{}}
    self.ML = {{}}; self.MC = {{}}; self.MR = {{}}
    self.BL = {{}}; self.BC = {{}}; self.BR = {{}}
    self.ALL = {"TL","TC","TR","ML","MC","MR","BL","BC","BR"}
end

function matrix:ForAll(func)
    local returntrue = false
    for i,v in ipairs(self.ALL) do
        for j,k in ipairs(self[v]) do
            for l,m in ipairs(k) do
                if func(m) then returntrue = true end
            end
        end
    end
    return returntrue
end

function matrix:Update(dt)
    self:ForAll(function(e) e:Update(dt) end)
end
function matrix:Draw()
    self:ForAll(function(e) e:PreDraw() end)
end
function matrix:DebugDraw()
    love.graphics.setColor(0,0,1,0.4)
    love.graphics.rectangle("line", self.X, self.Y, self.W, self.H)
    self:ForAll(function(e) e:PreDebugDraw() end)
end
function matrix:Mousepressed(x,y,b)
    if AABB(x,y,0,0,self.X,self.Y,self.W,self.H) then
        self:ForAll(function(e) e:Mousepressed(x,y,b) end)
    end
end
function matrix:Mousereleased(x,y,b)
    self:ForAll(function(e) e:Mousereleased(x,y,b) end)
end

function matrix:Keypressed(key)
    self:ForAll(function(e) if e.Keypressed then e:Keypressed(key) end end)
end
function matrix:Keyreleased(key)
    self:ForAll(function(e) if e.Keyreleased then e:Keyreleased(key) end end)
end
function matrix:Wheelmoved(y)
    local scrolled = self:ForAll(function(e) if e.Wheelmoved then e:Wheelmoved(y) end end)
end

function matrix:Textinput(key)
    self:ForAll(function(e) if e.Textinput then e:Textinput(key) end end)
end

function matrix:Add(element,position,direction)
    if direction == "horizontal" then
        table.insert(self[position][#self[position]],element)
    elseif direction == "vertical" then
        table.insert(self[position],{element})
    end
    element._matrix = self
end

function matrix:Setup(groups)
    for i,v in ipairs(self.ALL) do
        if groups[v] then
            self[v] = groups[v]
        end
    end
end

-- Recaclulate and reposition all elements in the matrix
function matrix:Recaclulate()
    for i,v in ipairs(self.ALL) do
        self:CalculateGroup(self[v],v)
    end
end

function matrix:CalculateGroup(group,name)
    if #group[1] == 0 then return end
    local r = self.style:Init(nil,self,{})

    local fh = self:GetGroupHeight(group,r)
    local y = self.Y+r.matrixmarginY
    if string.find(name,"B") then
        y = (self.Y+self.H-r.matrixmarginY)-fh
    elseif string.find(name,"M") then
        y = (self.Y+self.H/2)-(fh/2)
    end

    for yi = 1, #group do
        local fw = self:GetGroupWidth(group[yi],r)
        local x = self.X+r.matrixmarginX
        if string.find(name,"R") then
            x = (self.X+self.W-r.matrixmarginX)-fw
        elseif string.find(name,"C") then
            x = (self.X+self.W/2)-(fw/2)
        end

        for xi = 1, #group[yi] do
            local e = group[yi][xi]
            if not e.hidden then
                e.X, e.Y = x, y
                if e.BaseRecaclulate then
                    e:BaseRecaclulate()
                end
                x = x + e.W + r.matrixspacingX
            end
        end
        if not group[yi][1].hidden then
            y = y + group[yi][1].H + r.matrixspacingY
        end
    end
end

function matrix:GetGroupWidth(group,r)
    local w = -r.matrixspacingX
    for i = 1, #group do
        local e = group[i]
        w = w + e.W + r.matrixspacingX
    end
    return w
end
function matrix:GetGroupHeight(group,r)
    local h = -r.matrixspacingY
    for i = 1, #group do
        local e = group[i][1]
        h = h + e.H + r.matrixspacingY
    end
    return h
end

---

function matrix:ChangeStyle(style)
    self.style = _BRITUI.STYLES[style] or _BRITUI.STYLES["default"]
    self.style:Overrides(self,self.originalargs)
    self:Recaclulate()
end

return matrix