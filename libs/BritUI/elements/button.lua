local button = Class("britui_button", _BRITUI.BASE)

function button:initialize(transform, args, style)
    self.T = "button"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.func = args.func
    self.repeating = true
    if args.repeating ~= nil then self.repeating = args.repeating end
    self.repeattime = 0
end

function button:Update(dt)
    self:BaseUpdate(dt)

    if self.repeating then
        if self.clicking.is then
            self.repeattime = self.repeattime + dt
            if self.repeattime > 0.4 then
                self:Click(love.mouse.getX(), love.mouse.getY(), self.clicking.id)
                self.repeattime = self.repeattime - 0.04
            end
        else
            self.repeattime = 0
        end
    end
end

function button:Click(x,y,b)
    if b == 1 and self.func then self.func(self) end
end

return button