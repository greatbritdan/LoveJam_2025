local ground = Class("ground",OBJECTS.box)
function ground:initialize(world,x,y,w,h,args,spike)
    OBJECTS.box.initialize(self,world,x,y,w,h,{static=true})
    if spike then
        self.class = "spike"
        self.spike = true
    else
        self.class = "ground"
        self.oneway = args.oneway
    end
end

function ground:draw()
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,0.5,0.5,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.ground = ground

------------------------

local exit = Class("exit")
function exit:initialize(_,x,y,w,h)
    self.class = "exit"
    self.X, self.Y, self.W, self.H = x,y,w,h
end

function exit:draw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(DoorImg,DoorQuads[4],self.X-4,self.Y-8)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.exit = exit