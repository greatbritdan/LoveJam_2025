local slider = Class("britui_slider", _BRITUI.BASE)

function slider:initialize(transform, args, style)
    self.T = "slider"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.direction = args.direction or "horizontal" -- horizontal, vertical
    self.limit = args.limit or {0,100,1} -- min, max, step
    self.value = args.value or self.limit[1]

    self.headfill = args.headfill or 0.1
    if self.direction == "vertical" then
        self.head = {X=self.X,Y=self.Y,W=self.W,H=(self.H*self.headfill)}
    else
        self.head = {X=self.X,Y=self.Y,W=(self.W*self.headfill),H=self.H}
    end
    self:Recaclulate()

    self.func = args.func
    
    if self.style.initializeElement then
        self.style:initializeElement(self)
    end
end

function slider:Draw()
    self.style:DrawBox(self.option,self,{state="backbase"})
    self.style:DrawBox(self.option,self,{X=self.head.X,Y=self.head.Y,W=self.head.W,H=self.head.H, state=self:GetColor()})
    self:BaseDraw(true)
end
function slider:DebugDraw()
    love.graphics.setColor(1,0,0,0.4)
    love.graphics.rectangle("line",self.X,self.Y,self.W,self.H)
    love.graphics.setColor(0,1,0,0.4)
    love.graphics.rectangle("line",self.head.X,self.head.Y,self.head.W,self.head.H)
end

function slider:Click(x,y,b)
    if b ~= 1 then return end
    self.clicking.offX = x - self.head.X
    self.clicking.offY = y - self.head.Y
end
function slider:Held()
    self.value = self:ValueFromPosition()
    if self.value < self.limit[1] then self.value = self.limit[1] end
    if self.value > self.limit[2] then self.value = self.limit[2] end
    self.value = math.floor((self.value - self.limit[1]) / self.limit[3]) * self.limit[3] + self.limit[1]
    self:Recaclulate()
end
function slider:Release()
    if self.func then self.func(self) end
end

function slider:PositionFromValue()
    if self.direction == "vertical" then
        return self.Y + (self.value - self.limit[1]) / (self.limit[2] - self.limit[1]) * (self.H - self.H*self.headfill)
    else
        return self.X + (self.value - self.limit[1]) / (self.limit[2] - self.limit[1]) * (self.W - self.W*self.headfill)
    end
end
function slider:ValueFromPosition()
    if self.direction == "vertical" then
        return self.limit[1] + (love.mouse.getY() - self.Y - self.clicking.offY) / (self.H - self.H*self.headfill) * (self.limit[2] - self.limit[1])
    else
        return self.limit[1] + (love.mouse.getX() - self.X - self.clicking.offX) / (self.W - self.W*self.headfill) * (self.limit[2] - self.limit[1])
    end
end

function slider:GetValue()
    return self.value
end

function slider:Highlight()
    return AABB(love.mouse.getX(), love.mouse.getY(), 1, 1, self.head.X, self.head.Y, self.head.W, self.head.H)
end
function slider:Recaclulate()
    if self.direction == "vertical" then
        self.head.X = self.X
        self.head.Y = self:PositionFromValue()
    else
        self.head.X = self:PositionFromValue()
        self.head.Y = self.Y
    end
end

return slider