local springboard = Class("springboard",OBJECTS.box)
function springboard:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=180})
    self.class = "springboard"

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 7
    self.offsety = -6

    self.animtimer = false
end

function springboard:update(dt)
    if self.animtimer then
        self.animtimer = self.animtimer + dt
        if self.animtimer > 0.15 then
            self.animtimer = false
        end
    end
end

function springboard:draw()
    local quad = 1
    if self.animtimer then
        quad = math.floor(self.animtimer/0.15*3)+2
    end

    love.graphics.setColor(1,1,1)
    love.graphics.draw(SpringboardImg,SpringboardQuads[quad],self.X+self.offsetx,self.Y+self.offsety,0,1,1,self.quadcenterx,self.quadcentery)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

function springboard:trigger(player)
    self.animtimer = 0
end

OBJECTS.springboard = springboard