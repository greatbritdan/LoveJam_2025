local counter = Class("britui_counter",_BRITUI.BASE)

function counter:initialize(transform, args, style)
    self.T = "counter"
    self.option = "image"

    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)

    self.count = args.count or 0
    self.func = args.func

    if args.autofit then self:Fit() end
end

function counter:Draw()
    local r = self.style:Init(self.option,self,{})
    local store, x, y = self:GetAll()
    for i = 1, self.count do
        self.style:DrawImage(self.option,self,{X=x, Y=y, W=store[i].imgw, H=store[i].imgh, image=store[i].img, quad=store[i].quad, alignX="left", alignY="top", margin=0, state=self:GetColor()})
        x = x + (store[i].imgw*r.scale) + r.spacingX
    end
end

function counter:DebugDraw()
    self:BaseDebugDraw()
    love.graphics.setColor(0,1,0,0.4)
    local r = self.style:Init(self.option,self,{})
    local _, x, y, w, h = self:GetAll()
    local fw = w + (r.spacingX*(self.count-1))
    love.graphics.rectangle("line",x,y,fw,h)
end

function counter:GetAll()
    local r = self.style:Init(self.option,self,{})

    local store, w, h = {}, 0, 0
    for i = 1, self.count do
        local img, quad = self.func(i)
        local imgw, imgh = self.style:ImageWidth(img,quad), self.style:ImageHeight(img,quad)
        store[i] = {img=img, quad=quad, imgw=imgw, imgh=imgh}
        if imgh*r.scale > h then h = imgh*r.scale end
        w = w + (imgw*r.scale) + r.spacingX
    end

    local x = self.style:AlignHor(self.X,self.W,w,r.alignX,r.marginX)
    local y = self.style:AlignVer(self.Y,self.H,h,r.alignY,r.marginY)
    return store, x, y, w, h
end

function counter:Fit()
    local r = self.style:Init(self.option,self,{})
    local _, _, _, w = self:GetAll()
    self.W = w + (r.marginX*2)
end

function counter:Update(dt) end
function counter:Mousepressed(x,y,b) end
function counter:Mousereleased(x,y,b) end

return counter