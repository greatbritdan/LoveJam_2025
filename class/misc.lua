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

    self.opentimer = false
end

function exit:update(dt)
    if self.opentimer and self.opentimer < 1 then
        self.opentimer = self.opentimer + dt*10
        if self.opentimer >= 1 then
            self.opentimer = 1
        end
    end
end

function exit:draw()
    --local quad = 1 (Unused locked door)
    local quad = 2
    if self.opentimer then
        quad = math.floor(self.opentimer)+3
    end
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(ExitImg,ExitQuads[quad],self.X-4,self.Y-8)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

function exit:trigger(player)
    self.opentimer = 0
end

OBJECTS.exit = exit

------------------------

local key = Class("key")
function key:initialize(_,x,y,w,h,args)
    self.class = "key"
    self.X, self.Y, self.W, self.H = x,y,w,h

    self.active = true
    self.color = args.color
end

function key:draw()
    if not self.active then return end
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(KeyImg,KeyQuads[self.color],self.X-4,self.Y-2)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.key = key

------------------------

local door = Class("door",OBJECTS.box)
function door:initialize(world,x,y,w,h,args)
    OBJECTS.box.initialize(self,world,x,y,w,h,{static=true})
    self.class = "door"
    self.X, self.Y, self.W, self.H = x,y,w,h

    self.dir = args.dir
    self.color = args.color
end

function door:draw()
    if not self.active then return end
    love.graphics.setColor(1,1,1,1)
    love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    if self.dir == "hor" then
        love.graphics.draw(DoorHorImg,DoorHorQuads[self.color],self.X,self.Y)
    else
        love.graphics.draw(DoorVerImg,DoorVerQuads[self.color],self.X,self.Y)
    end
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.door = door