local springboard = Class("springboard",OBJECTS.box)
function springboard:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=128})
    self.class = "springboard"
end

function springboard:update(dt)
end

function springboard:draw()
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.springboard = springboard