local cyclebutton = Class("britui_cyclebutton", _BRITUI.BUTTON)

function cyclebutton:initialize(transform, args, style)
    self.T = "cyclebutton"

    args = args or {}
    _BRITUI.BUTTON.initialize(self, transform, args, style)

    self.cycle = args.cycle or {}
    self.cycleidx = args.cycleidx or 1
end

function cyclebutton:Click(x,y,b)
    if b == 1 then self:CycleRight() end
end

function cyclebutton:CycleRight()
    self.cycleidx = self.cycleidx + 1
    if self.cycleidx > #self.cycle then self.cycleidx = 1 end
    if self.func then self.func(self,self:GetValue()) end
end
function cyclebutton:CycleLeft()
    self.cycleidx = self.cycleidx -1
    if self.cycleidx < 1 then self.cycleidx = #self.cycle end
    if self.func then self.func(self,self:GetValue()) end
end

function cyclebutton:GetValue()
    return self.cycle[self.cycleidx]
end

return cyclebutton