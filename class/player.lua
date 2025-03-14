local player = Class("player",OBJECTS.box)
function player:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=128})
end

function player:update(dt)
    self.VX = 0
    local speed = 32
    if INPUT:Holding("left")  then self.VX = -speed end
    if INPUT:Holding("right") then self.VX = speed end
end

function player:jump()
    self.VY = -96
end

OBJECTS.player = player