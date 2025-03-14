local text = Class("britui_text", _BRITUI.BASE)

function text:initialize(transform, args, style)
    self.T = "text"
    self.option = "text"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.text = args.text or "no text"

    if args.autofit then self:Fit() end
end

function text:Link(element)
    self.link = element
    element.linked = self
end

function text:GetColor()
    if self.link and self.link.T == "input" then
        if self.link.inputting then return "click" end
        return "gray"
    end
    if self.clicking.is then return "click" end
    if self.hovering.is then return "hover" end
    return "base"
end

function text:Update(dt)
    if self.link then
        self.text = self.link:GetValue()
    end
end

function text:Draw()
    self.style:DrawText(self.option,self,{text=self.text, state=self:GetColor()})
end
function text:DebugDraw()
    self:BaseDebugDraw()
    love.graphics.setColor(0,1,0,0.4)
    self.style:TextForEachLine(self.option,self,{text=self.text},function(_,tx,ty,tw,th)
        love.graphics.rectangle("line",tx,ty,tw,th)
    end)
end

function text:GetLines(text)
    local r = self.style:Init(self.option,self,{text=text})
    local _, lines = r.font:getWrap(r.text,(r.W-(r.marginX*2))/r.scale)
    return lines
end

function text:Mousepressed(x,y,b) end
function text:Mousereleased(x,y,b) end

return text