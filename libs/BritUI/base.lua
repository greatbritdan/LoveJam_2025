local base = Class("britui_base")

function base:initialize(transform, args, style)
    args = args or {}
    args.children = args.children or {}
    if not self.option then
        self.option = "box"
    end

    self.originalargs = DeepCopy(args) -- for style changing
    self.X, self.Y, self.W, self.H = transform.X or 0, transform.Y or 0, transform.W, transform.H
    self.style = _BRITUI.STYLES[style] or _BRITUI.STYLES["default"]
    self.style:Overrides(self, args)

    -- I didn't want to reference slider here but had no choice :(
    -- TODO: find a way to not do that
    if self.style.initializeElement and self.T ~= "slider" and self.T ~= "dropdown" then
        self.style:initializeElement(self)
    end

    self.hovering = {is=false, time=0}
    self.clicking = {is=false, time=0}

    self.active = true; if args.active == false then self.active = false end
    self.hidden = args.hidden or false

    self.children = {}
    for _,v in pairs(args.children) do
        if v.text then
            local elm = _BRITUI.TEXT:new(transform, v, style)
            elm.parent = self
            if v.autolink then elm:Link(self) end
            table.insert(self.children, elm)
        end
        if v.image then
            local elm = _BRITUI.IMAGE:new(transform, v, style)
            elm.parent = self
            table.insert(self.children, elm)
        end
        if v.dotsize then
            local elm = _BRITUI.CYCLEDOTS:new(transform, v, style)
            elm.parent = self
            if v.autolink then elm:Link(self) end
            table.insert(self.children, elm)
        end
    end
end

function base:Update(dt)
    self:BaseUpdate(dt)
end

function base:BaseUpdate(dt)
    if self.hidden then return end
    if not self.active then return end

    for _,v in pairs(self.children) do v:Update(dt) end

    self.hovering.is = self:Highlight()
    if self.hovering.is then
        self.hovering.time = self.hovering.time + dt
    else
        self.hovering.time = 0
    end

    if self.clicking.is then
        if (not self.hovering.is) and self.T ~= "slider" then
            self.clicking.is = false; self.clicking.time = 0
        else
            self.clicking.time = self.clicking.time + dt
            if self.Held then self:Held(dt) end
        end
    end
end

function base:GetColor()
    if self.clicking.is then return "click" end
    if self.hovering.is then return "hover" end
    return "base"
end

function base:PreDraw()
    if self.hidden then return end
    self:Draw()
end
function base:Draw()
    self:BaseDraw()
end
function base:BaseDraw(empty)
    if (not empty) then
        self.style:DrawBox(self.option,self,{state=self:GetColor()})
    end
    for _,v in pairs(self.children) do v:Draw() end
end

function base:PreDebugDraw()
    if self.hidden then return end
    self:DebugDraw()
end
function base:DebugDraw()
    self:BaseDebugDraw()
end
function base:BaseDebugDraw()
    love.graphics.setColor(1,0,0,0.4)
    love.graphics.rectangle("line", self.X, self.Y, self.W, self.H)
    for _,v in pairs(self.children) do if v.DebugDraw then v:DebugDraw() end end
end

function base:Mousepressed(x,y,b)
    if self.hidden then return end
    --if not self.active then return end
    if self.hovering.is then
        self.clicking.is = true
        self.clicking.id = b
        self.clicking.time = 0
        if self.Click then self:Click(x,y,b) end
    end
end

function base:Mousereleased(x,y,b)
    if self.hidden then return end
    if not self.active then return end
    if self.clicking.is then
        self.clicking.is = false
        self.clicking.time = 0
        if self.Release then self:Release(x,y,b) end
    end
end

function base:Wheelmoved(y)
    if self.hidden then return end
    if not self.active then return end
    if self.hovering.is then
        if self.Scroll then self:Scroll(y); return true end
    end
    return false
end

function base:Highlight()
    return AABB(love.mouse.getX(), love.mouse.getY(), 1, 1, self.X, self.Y, self.W, self.H)
end

function base:GetValue()
    return "no value"
end

function base:BaseRecaclulate()
    for _,v in pairs(self.children) do
        v.X, v.Y, v.W, v.H = self.X, self.Y, self.W, self.H
    end
    if self.Recaclulate then
        self:Recaclulate()
    end
end

---

function base:Show()
    self.hidden = false
    if self._matrix then self._matrix:Recaclulate() end
end
function base:Hide()
    self.hidden = true
    if self._matrix then self._matrix:Recaclulate() end
end

function base:ChangeStyle(style)
    self.style = _BRITUI.STYLES[style] or _BRITUI.STYLES["default"]
    self.style:Overrides(self,self.originalargs)
    if self.style.initializeElement then -- Remake image button spritebatches
        self.style:initializeElement(self)
    end

    for _,v in pairs(self.children) do
        v:ChangeStyle(style)
    end

    if self._matrix then self._matrix:Recaclulate() end
end

return base