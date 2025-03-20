local player = Class("player",OBJECTS.box)
function player:initialize(world,x,y,w,h,args)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=180})
    self.class = "player"
    self.startX, self.startY = x, y
    --print("spawned player at",x,y)

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 6
    self.offsety = 6

    self.acceleration = 128
    self.maxspeed = 64
    self.jumpspeed = -152

    self.dir = 1
    self.idletimer = 0
    self.walktimer = 0
    self.grasseffecttimer = 0
    self.inair = false

    self.dying = false -- for when you know you're fu##ed but not yet
    self.dead = false

    self.win = false
    self.winpos = 0
    self.wintimer = 0

    self.teleportcooldown = false
    self.balls = false

    args = args or {}
    if args.startleft then
        self.startleft = true
        self.dir = -1
    end
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

    if self.win == "walking" then
        if (self.dir == 1 and self.X < self.winpos) or (self.dir == -1 and self.X > self.winpos) then
            self.VX = math.max(math.min(self.VX + self.acceleration * dt * self.dir, self.maxspeed), -self.maxspeed)
        else
            self.X = self.winpos
            self.VX = 0
            self.win = "wink"
        end
        return
    elseif self.win == "wink" or self.win == "hide" then
        self.wintimer = self.wintimer + dt
        if self.wintimer > 1 and self.win == "wink" then
            self.win = "hide"
            self.windoor:trigger(self,"close")
        end
        if self.wintimer > 2 then
            self.wintimer = 0
            self.win = "transition"
            GAME.QueueNextLevel = true
        end
        return
    elseif self.win == "transition" then
        return
    end

    self.VX = math.max(math.min(self.VX + self.acceleration * dt * self.dir, self.maxspeed), -self.maxspeed)

    self.walktimer = self.walktimer + dt
    if self.walktimer > 0.2 then
        self.walktimer = self.walktimer - 0.2
    end
    if math.abs(self.VX) > 5 and (not self.inair) and (not self.orbed) then
        self.grasseffecttimer = self.grasseffecttimer + dt
        if self.grasseffecttimer > 0.25 then
            self.grasseffecttimer = self.grasseffecttimer - 0.25
            local x,y = self.X+self.W/2,self.Y+self.H
            NewEffect("dust",x,y)
            local sound = StepSounds[math.random(1,#StepSounds)]
            --sound:setVolume(0.5)
            sound:setPitch(math.random(90,110)/100)
            sound:play()
        end
    else
        self.grasseffecttimer = 0
    end

    if not self.inair and self.VY > 0 then
        self.inair = true
    end

    if self.teleportcooldown then
        self.teleportcooldown = self.teleportcooldown - dt
        if self.teleportcooldown <= 0 then
            self.teleportcooldown = false
            self.balls = false
        end
    end

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "exit" then
            if AABB(self.X+self.W/2-1,self.Y+self.H/2-1,2,2,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                self.windoor = data.obj
                data.obj:trigger(self,"open")
                self.win = "walking"
                self.winpos = data.obj.X+2
                if self.orbed then
                    self.orbed:trigger(self,false)
                end
                self.orbed = false
            end
        end
        if data.obj.class == "springboard" then
            if data.obj.active and AABB(self.X,self.Y,self.W,self.H,data.obj.X-2,data.obj.Y-1,data.obj.W+4,data.obj.H+1) then
                data.obj:trigger(self)
                self.VY = self.jumpspeed; self.inair = true
            end
        end
        if data.obj.class == "key" then
            if data.obj.active and AABB(self.X,self.Y,self.W,self.H,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                GAME.KEYSGOT[data.obj.color] = true
                data.obj:trigger(self)
                GAME.MAP:GetLayer("Objects"):LoopThrough(function(odata)
                    if (odata.obj.class == "door" or odata.obj.class == "key") and data.obj.color == odata.obj.color then
                        odata.obj.active = false
                        if odata.obj.class == "door" then
                            odata.obj.opentimer = 0 -- open animation
                        end
                    end
                end)
            end
        end
        if data.obj.class == "orb" then
            if (not self.orbed) and AABB(self.X+self.W/2-1,self.Y+self.H/2-1,2,2,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                if self.orbed then
                    self.orbed:trigger(self,false)
                end
                data.obj:trigger(self,true)
                self.orbed = data.obj -- IT'S MORBIN' TIME! (Orbing time)
                self.gravity = 0
            end
        end
        if data.obj.class == "teleporter" and (not self.teleportcooldown) then
            if AABB(self.X+self.W/2-1,self.Y+self.H/2-1,2,2,data.obj.X+(data.obj.W/2)-1,data.obj.Y+(data.obj.H/2)-1,2,2) then
                local other = GetOtherTeleporter(data.obj.id,data.obj.other)
                if other then
                    self.balls = {{X=data.obj.X-10,Y=data.obj.Y-10},{X=other.X-10,Y=other.Y-10}}
                    self.X, self.Y = other.X, other.Y
                    -- Hacky fix because bump doesn't update the rect when setting the position manually
                    GAME.WORLD.rects[self] = {x=self.X,y=self.Y,w=self.W,h=self.H}
                    self.teleportcooldown = 0.2
                    TeleportSound:play()
                end
            end
        end
    end)
end

function GetOtherTeleporter(id,isother)
    local other = false
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "teleporter" and id == data.obj.id then
            if isother == true and data.obj.other == false then
                other = data.obj
            elseif isother == false and data.obj.other == true then
                other = data.obj
            end
        end
    end)
    return other
end

function player:collided(data)
    if self.orbed then
        self.gravity = 180
        self.orbed:trigger(self,false)
        self.orbed = false
    end
    if data.other.class == "spike" and (not self.dying) and (not self.dead) then
        self.dying = true
        DeathSound:play()
        if data.col.normal.x ~= 0 then self.VY = -64 end
        if GAME.DIALOGSPIKEHIT then
            DIALOG:start(GAME.DIALOGSPIKEHIT)
        end
    end
    if data.col.normal.y == -1 then
        self.inair = false
        if self.dying then
            self.dead = true
            self.dying = false
            self.VX = 0
        end
        if data.VY > 5 then
            LandSound:play()
            local x,y = self.X+self.W/2,self.Y+self.H
            NewEffect("dustl",x-3,y); NewEffect("dustr",x+3,y)
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
        if self.win == "wink" then quad = 9 end
        if self.win == "hide"or self.win == "transition" then return end
    end

    love.graphics.setColor(1,1,1)
    love.graphics.draw(PlayerImg,PlayerQuads[quad],self.X+self.offsetx,self.Y+self.offsety,0,scale,1,self.quadcenterx,self.quadcentery)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("fill",self.X+self.W/2-1,self.Y+self.H/2-1,2,2)
    end

    if self.balls then
        love.graphics.setColor(1,1,1,self.teleportcooldown*5)
        for i,ball in ipairs(self.balls) do
            love.graphics.draw(BallImg,ball.X,ball.Y)
        end
    end
end

function player:start()
    self.dir = 1
    if self.startleft then
        self.dir = -1
    end
    local tilex, tiley = GetTileAtPos(self.X+(self.W/2),self.Y+(self.H/2))
    self.lastTile = {X=tilex,Y=tiley}
end

function player:stop()
    self.VX, self.VY = 0, 0
    self.X, self.Y = self.startX, self.startY
    -- Hacky fix because bump doesn't update the rect when setting the position manually
    GAME.WORLD.rects[self] = {x=self.X,y=self.Y,w=self.W,h=self.H}

    self.dir = 1
    if self.startleft then
        self.dir = -1
    end

    self.inair = false
    self.orbed = false
    self.gravity = 180

    self.dying = false
    self.dead = false
    self.win = false
    self.winpos = 0
    self.wintimer = 0
end

OBJECTS.player = player