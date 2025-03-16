local player = Class("player",OBJECTS.box)
function player:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=180})
    self.class = "player"
    self.startX, self.startY = x, y

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 6
    self.offsety = 6

    self.dir = 1
    self.idletimer = 0
    self.walktimer = 0
    self.inair = false

    self.dying = false -- for when you know you're fu##ed but not yet
    self.dead = false

    self.acceleration = 128
    self.maxspeed = 64
end

function player:update(dt)
    if not GAME.SIMULATING then
        self.idletimer = self.idletimer + dt
        if self.idletimer > 5 then
            self.idletimer = 0
            self.VX = -self.VX
            self.dir = -self.dir
        end
        return
    end

    if self.dying or self.dead then
        return
    end

    self.VX = math.max(math.min(self.VX + self.acceleration * dt * self.dir, self.maxspeed), -self.maxspeed)

    self.walktimer = self.walktimer + dt
    if self.walktimer > 0.2 then
        self.walktimer = self.walktimer - 0.2
    end

    if not self.inair and self.VY > 0 then
        self.inair = true
    end

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "exit" then
            if AABB(self.X+self.W/2-1,self.Y+self.H/2-1,2,2,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                StopSimulation(true)
            end
        end
        if data.obj.class == "springboard" then
            if AABB(self.X,self.Y,self.W,self.H,data.obj.X-2,data.obj.Y-1,data.obj.W+4,data.obj.H+1) then
                data.obj:trigger(self)
                self.VY = -148; self.inair = true
            end
        end
    end)
end

function player:collided(data)
    if data.other.class == "spike" then
        self.dying = true
        self.VY = -64
    end
    if data.col.normal.y == -1 then
        self.inair = false
        if self.dying then
            self.dead = true
            self.dying = false
            self.VX = 0
        end
    end
    -- Flip direction when hitting a wall
    if data.col.normal.x ~= 0 and (not data.other.oneway) then
        self.VX = -data.VX
        self.dir = -self.dir
    end
end

function player:draw()
    local scale = self.dir
    local quad = 1
    if not GAME.SIMULATING then
        if self.idletimer >= 4 then quad = 3 end
    else
        quad = 4
        if self.walktimer >= 0.1 then quad = 5 end
        if self.inair then quad = 6 end
        if self.dying then quad = 7 end
        if self.dead then quad = 8 end
    end

    love.graphics.setColor(1,1,1)
    love.graphics.draw(PlayerImg,PlayerQuads[quad],self.X+self.offsetx,self.Y+self.offsety,0,scale,1,self.quadcenterx,self.quadcentery)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill",self.X+self.W/2-1,self.Y+self.H/2-1,2,2)
    end
end

function player:start()
    self.dir = 1
    local tilex, tiley = GetTileAtPos(self.X+(self.W/2),self.Y+(self.H/2))
    self.lastTile = {X=tilex,Y=tiley}
end

function player:stop()
    self.VX, self.VY = 0, 0
    self.X, self.Y = self.startX, self.startY
    -- Hacky fix because bump doesn't update the rect when setting the position manually
    GAME.WORLD.rects[self] = {x=self.X,y=self.Y,w=self.W,h=self.H}

    self.inair = false
    self.dying = false
    self.dead = false
end

OBJECTS.player = player