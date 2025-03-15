local exit = Class("exit")
function exit:initialize(_,x,y,w,h)
    self.class = "exit"
    self.X, self.Y, self.W, self.H = x,y,w,h
end

function exit:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(DoorImg,self.X-4,self.Y-8)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.exit = exit