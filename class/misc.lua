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

local conveyorbelt = Class("conveyorbelt",OBJECTS.box)
function conveyorbelt:initialize(world,x,y,w,h,args)
    OBJECTS.box.initialize(self,world,x,y,w,h,{static=true})
    self.class = "conveyorbelt"
    self.X, self.Y, self.W, self.H = x,y,w,h

    self.speed = args.speed
end

function conveyorbelt:update(dt)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "player" or data.obj.class == "crate" or data.obj.class == "springboard" then
            if AABB(self.X,self.Y-2,self.W,2,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                data.obj.X = data.obj.X + self.speed *dt
            end
        end
    end)
end

function conveyorbelt:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,0.5,0.5,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.conveyorbelt = conveyorbelt

------------------------

local exit = Class("exit")
function exit:initialize(_,x,y,w,h)
    self.class = "exit"
    self.X, self.Y, self.W, self.H = x,y,w,h

    self.open = false
    self.opentimer = false
end

function exit:update(dt)
    if self.open == "open" then
        if self.opentimer and self.opentimer < 1 then
            self.opentimer = self.opentimer + dt*10
            if self.opentimer >= 1 then
                self.opentimer = 1
                self.open = false
            end
        end
    elseif self.open == "close" then
        if self.opentimer and self.opentimer > 0 then
            self.opentimer = self.opentimer - dt*10
            if self.opentimer <= 0 then
                self.opentimer = false
                self.open = false
            end
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

function exit:trigger(player,open)
    if open == "open" then
        self.open = "open"
        self.opentimer = 0
    else
        self.open = "close"
        self.opentimer = 1
    end
    DoorSound:play()
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

function key:trigger(player)
    local x,y = self.X+(self.W/2),self.Y+(self.H/2)
    NewEffect("starul",x-3,y-3); NewEffect("starur",x+3,y-3)
    NewEffect("stardl",x-3,y+3); NewEffect("stardr",x+3,y+3)
    self.opentimer = 0
    local sound = KeySounds[math.random(1,#KeySounds)]
    sound:play()
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
    self.opentimer = false
end

function door:update(dt)
    if (not self.opentimer) or self.opentimer > 0.5 then return end
    self.opentimer = self.opentimer + dt
end

function door:draw()
    if (not self.active) and self.opentimer > 0.5 then return end
    local off = 0
    if self.opentimer then
        off = 0 - 32*self.opentimer*2
        love.graphics.setScissor((self.X+GAME.MAPPOS.X)*Env.scale,(self.Y+GAME.MAPPOS.Y)*Env.scale,self.W*Env.scale,self.H*Env.scale)
    end
    love.graphics.setColor(1,1,1,1)
    if self.dir == "hor" then
        love.graphics.draw(DoorHorImg,DoorHorQuads[self.color],self.X+off,self.Y)
    else
        love.graphics.draw(DoorVerImg,DoorVerQuads[self.color],self.X,self.Y+off)
    end
    if self.opentimer then
        love.graphics.setScissor()
    end
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.door = door