local cycledots = Class("britui_cycledots", _BRITUI.BASE)

function cycledots:initialize(transform, args, style)
    self.T = "cycledots"
    self.option = "text"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.dotsize = args.dotsize or 4
end

function cycledots:Link(element)
    self.link = element
    element.linked = self
end

function cycledots:Draw()
    if self.link then
        local r = self.style:Init(self.option,self,{})
        local w = self.dotsize*r.scale
        local fw = ((w+r.spacingX)*#self.link.cycle)-r.spacingX

        local x = self.style:AlignHor(self.X,self.W,fw,r.alignX,r.marginX)
        local y = self.style:AlignVer(self.Y,self.H,w,r.alignY,r.marginY)
        for idx,_ in pairs(self.link.cycle) do
            love.graphics.setColor(1,1,1,0.3)
            if idx == self.link.cycleidx then love.graphics.setColor(1,1,1) end
            love.graphics.circle("fill", x+((w+r.spacingX)*(idx-1)) + w/2, y + w/2, w/2)
        end
    end
end
function cycledots:DebugDraw()
    self:BaseDebugDraw()
    
    local r = self.style:Init(self.option,self,{})
    local w = self.dotsize*r.scale
    local fw = ((w+r.spacingX)*#self.link.cycle)-r.spacingX

    local x = self.style:AlignHor(self.X,self.W,fw,r.alignX,r.marginX)
    local y = self.style:AlignVer(self.Y,self.H,w,r.alignY,r.marginY)

    love.graphics.setColor(0,1,0,0.4)
    love.graphics.rectangle("line",x,y,fw,w)
end

function cycledots:Update(dt) end
function cycledots:Mousepressed(x,y,b) end
function cycledots:Mousereleased(x,y,b) end

return cycledots