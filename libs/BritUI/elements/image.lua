local image = Class("britui_image", _BRITUI.BASE)

function image:initialize(transform, args, style)
    self.T = "image"
    self.option = "image"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.image = args.image
    self.quad = args.quad or nil

    if args.autofit then self:Fit() end
end

function image:Draw()
    self.style:DrawImage(self.option,self,{image=self.image, quad=self.quad, state=self:GetColor()})
end
function image:DebugDraw()
    self:BaseDebugDraw()
    love.graphics.setColor(0,1,0,0.4)
    local r = self.style:Init(self.option,self,{image=self.image, quad=self.quad})
    local w, h = self.style:ImageWidth(self.image,self.quad), self.style:ImageHeight(self.image,self.quad)
    local x = self.style:AlignHor(self.X,self.W,w,r.alignX,r.marginX)
    local y = self.style:AlignVer(self.Y,self.H,h,r.alignY,r.marginY)
    love.graphics.rectangle("line",x,y,w,h)
end

function image:Update(dt) end
function image:Mousepressed(x,y,b) end
function image:Mousereleased(x,y,b) end

return image