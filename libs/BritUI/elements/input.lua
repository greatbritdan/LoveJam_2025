local input = Class("britui_input", _BRITUI.BASE)

function input:initialize(transform, args, style)
    self.T = "input"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.text = args.text or "no text"

    self.inputting = false
    self.holding = false
    self.holdingtime = 0
    self.cursor = 0
    self.cursortimer = 0

    self.maxlength = args.maxlength or nil
    self.allowedchars = args.allowedchars or "abcdefghijklmnopqrstuvwxyz |.,:;!?_-/\\<>\n'\"0123456789"
    self.func = args.func or nil
end

function input:GetColor()
    if self.inputting then return "hover" end
    if self.clicking.is then return "click" end
    if self.hovering.is then return "hover" end
    return "base"
end

function input:Update(dt)
    self:BaseUpdate(dt)
    if self.holding then
        local delay, interval = 0.4, 0.04
        self.holdingtime = self.holdingtime + dt
        if self.holdingtime > delay then
            self:Keypressed(self.holding)
            self.holdingtime = self.holdingtime - interval
        end
    end
    if self.inputting then
        self.cursortimer = self.cursortimer + dt
        if self.cursortimer > 1 then
            self.cursortimer = 0
        end
    end
end

function input:Draw()
    self:BaseDraw()
    if self.inputting and self.cursortimer < 0.5 and self.linked then
        local r = self.style:Init(self.linked.option,self.linked,{})
        local sx, sy = 0, 0
        self.style:TextForEachLine(self.linked.option,self.linked,{text=self.text},function(_,tx,ty,_,_,idx)
            if idx == 1 then sx, sy = tx, ty end
        end)
        sx = sx + (self.style:TextWidth(string.sub(self.text, 1, self.cursor))*r.scale)

        love.graphics.setColor(1,1,1)
        if r.font:hasGlyphs("|") then
            self.style:DefaultText("|", sx, sy, 0, r.scale, r.scale)
        else
            love.graphics.rectangle("fill", sx, sy, r.scale, (self.style:TextHeight()*r.scale))
        end
    end
end

function input:Click(x,y,b)
    if b == 1 then
        _BRITUI.INPUTTING = self
        self.inputting = true
        self.cursor = #self.text
    end
end
function input:StopInputting()
    if self.func then self.func(self,self.text) end
end

function input:Keypressed(key)
    if not self.inputting then return end
    if key == "return" or key == "escape" then
        self:StopInputting()
        self.inputting = false
        _BRITUI.INPUTTING = false
    elseif key == "backspace" then
        self.text = string.sub(self.text, 1, self.cursor-1) .. string.sub(self.text, self.cursor+1)
        self.cursor = math.max(0, self.cursor-1)
    elseif key == "delete" then
        self.text = string.sub(self.text, 1, self.cursor) .. string.sub(self.text, self.cursor+2)
    elseif key == "left" then
        self.cursor = math.max(0, self.cursor-1)
    elseif key == "right" then
        self.cursor = math.min(#self.text, self.cursor+1)
    end

    local canhold = {"backspace","delete","left","right"}
    if not self.holding and TableContains(key,canhold) then
        self.holding = key; self.holdingtime = 0
    end
end
function input:Keyreleased(key)
    if key == self.holding then
        self.holding = false; self.holdingtime = 0
    end
end

function input:Textinput(key)
    if not self.inputting then return end
    if not string.find(self.allowedchars, key) then return end
    if self.maxlength and #self.text >= self.maxlength then return end

    local newtext = string.sub(self.text, 1, self.cursor) .. key .. string.sub(self.text, self.cursor+1)
    if self.linked then
        if #self.linked:GetLines(newtext) > 1 then return end
    end
    self.text = newtext
    self.cursor = self.cursor + 1
end

function input:GetValue()
    return self.text
end

return input