local exit = Class("exit")
function exit:initialize(world,x,y,w,h)
    self.class = "exit"
    self.X, self.Y, self.W, self.H = x,y,w,h
end

function exit:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(DoorImg,GAME.MAPPOS.X+self.X-4,GAME.MAPPOS.Y+self.Y-8)
end

OBJECTS.exit = exit