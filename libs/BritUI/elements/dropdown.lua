-- NOT FULLY IMPLEMENTED, USE WITH CAUTION
-- TODO: make scrollbar work by clicking and dragging.

local dropdown = Class("britui_dropdown", _BRITUI.BASE)

function dropdown:initialize(transform, args, style)
    self.T = "dropdown"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.open = false
    self.selection = args.selectionidx or 1
    self.selections = args.selections or {"no selections"}
    self.scroll = 0
    
    self.selectionH = args.selectionH or self.H/2
    self.selectionmax = args.selectionmax or 5
    self.scrollW = args.scrollW or 16

    self.func = args.func

    if self.style.initializeElement then
        self.style:initializeElement(self)
    end
end

function dropdown:GetColorSelection(selected)
    if selected then return "click" end
    return "base"
end

function dropdown:OpenHeight()
    local count = #self.selections
    if count > self.selectionmax then count = self.selectionmax end
    return self.H + (count * self.selectionH)
end

function dropdown:Draw()
    if self.open then
        local textclass = self
        if self.linked then
            textclass = self.linked
        end

        -- Draw selections & text
        self.style:DrawBox(self.option,self,{X=self.X,Y=self.Y,W=self.W,H=self:OpenHeight(), state="backbase"})
        local starti, endi = self.scroll + 1, self.scroll + self.selectionmax
        local yo = 0
        for i = starti, endi do
            local v = self.selections[i]
            local selected = self:HighlightSelection(yo)
            if selected then
                love.graphics.setColor(1,1,1,0.1)
                self.style:DefaultBox("fill",self.X,self.Y+self.H+(self.selectionH*yo),self.W-self.scrollW,self.selectionH)
            end
            local state = self:GetColorSelection(selected)
            textclass.style:DrawText(textclass.option,textclass,{X=self.X,Y=self.Y+self.H+(self.selectionH*yo),W=self.W,H=self.selectionH,text=v,marginY=0,state=state})
            yo = yo + 1
        end

        -- Draw scrollbar
        local scrollh = (self.selectionmax * self.selectionH) / (#self.selections / self.selectionmax)
        local scrolly = (self.scroll / (#self.selections - self.selectionmax)) * ((self:OpenHeight()-self.H) - scrollh)
        love.graphics.setColor(1,1,1,0.1)
        self.style:DefaultBox("fill",self.X+self.W-self.scrollW,self.Y+self.H+scrolly,self.scrollW,scrollh)
    end
    self.style:DrawBox(self.option,self,{state=self:GetColor()})
    self:BaseDraw(true)
end

function dropdown:GetValue()
    return self.selections[self.selection]
end

function dropdown:Highlight()
    if self.open then
        local sh = self.selectionH
        return AABB(love.mouse.getX(), love.mouse.getY(), 1, 1, self.X, self.Y, self.W, self:OpenHeight())
    end
    return AABB(love.mouse.getX(), love.mouse.getY(), 1, 1, self.X, self.Y, self.W, self.H)
end

function dropdown:Click(x,y,b)
    if b ~= 1 then return end
    if self.open then
        local starti, endi = self.scroll + 1, self.scroll + self.selectionmax
        local yo = 0
        for i = starti, endi do
            if self:HighlightSelection(yo) then
                self.selection = i
                if self.func then self.func(self) end
                break
            end
            yo = yo + 1
        end
        self.open = false
    else
        self.open = true
    end
end

function dropdown:Scroll(y)
    if y > 0 then
        self.scroll = self.scroll - 1
        if self.scroll < 0 then self.scroll = 0 end
    else
        self.scroll = self.scroll + 1
        if self.scroll > #self.selections - self.selectionmax then self.scroll = #self.selections - self.selectionmax end
    end
end

function dropdown:HighlightSelection(yo)
    return AABB(love.mouse.getX(), love.mouse.getY(), 1, 1, self.X, self.Y+self.H+(self.selectionH*yo), self.W, self.selectionH)
end

return dropdown