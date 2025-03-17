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
    if not self.active then return end
    if self.animtimer then
        self.animtimer = self.animtimer + dt
        if self.animtimer > 0.15 then
            self.animtimer = false
        end
    end
end

function springboard:draw()
    if not self.active then return end
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
    local x,y = self.X+self.W/2,self.Y
    NewEffect("dustl",x-6,y); NewEffect("dustr",x+6,y)
    JumpSound:play()
end

function springboard:collided(data)
    if data.other.class == "spike" then
        if self.active then
            DeathSound:play()
        end
        self.active = false
    end
    if data.col.normal.y == -1 and data.VY > 5 then
        LandSound:play()
    end
end

OBJECTS.springboard = springboard

------------------------

local crate = Class("crate",OBJECTS.box)
function crate:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=180})
    self.class = "crate"

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 8
    self.offsety = 8
end

function crate:update(dt)
    -- too many issues with them bouncing
    --[[GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "springboard" then
            if AABB(self.X,self.Y,self.W,self.H,data.obj.X,data.obj.Y-1,data.obj.W,data.obj.H+1) then
                data.obj:trigger(self)
                self.VY = -148
            end
        end
    end)]]
end

function crate:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(CrateImg,self.X+self.offsetx,self.Y+self.offsety,0,1,1,self.quadcenterx,self.quadcentery)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

function crate:collided(data)
    if data.col.normal.y == -1 and data.VY > 5 then
        LandSound:play()
    end
end

OBJECTS.crate = crate

------------------------

local platform = Class("platform",OBJECTS.box)
function platform:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{static=true})
    self.class = "platform"

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 8
    self.offsety = 8

    self.animtimer = 0
    self.fantimer = 0
    self.oneway = "up"
end

function platform:update(dt)
    self.animtimer = self.animtimer + dt
    if self.animtimer > 0.2 then
        self.animtimer = 0
    end

    if self.fantimer then
        self.fantimer = self.fantimer + dt
        if self.fantimer > 0.2 then
            self.fantimer = self.fantimer - 0.2
            NewEffect("fan",self.X+self.W/2,self.Y+10)
        end
    end
end

function platform:draw()
    local quad = math.floor(self.animtimer/0.2*4)+1

    love.graphics.setColor(1,1,1)
    love.graphics.draw(PlatformImg,PlatformQuads[quad],self.X+self.offsetx,self.Y+self.offsety,0,1,1,self.quadcenterx,self.quadcentery)
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.platform = platform

------------------------

local orb = Class("orb")
function orb:initialize(_,x,y,w,h)
    self.class = "orb"
    self.X, self.Y, self.W, self.H = x,y,w,h

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 6
    self.offsety = 6

    self.used = false
    self.animtimer = 0

    self.hasbase = false
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "ground" then
            if data.obj.class == "ground"  and AABB(self.X,self.Y+16,self.W,self.H,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                self.hasbase = true
                return true
            end
        end
    end)
end

function orb:update(dt)
    self.animtimer = self.animtimer + dt
    if self.animtimer > 0.2 then
        self.animtimer = 0
    end
end

function orb:draw()
    love.graphics.setColor(1,1,1)
    if self.hasbase then
        love.graphics.draw(OrbImg,OrbQuads[1],self.X+self.offsetx,self.Y+self.offsety,0,1,1,self.quadcenterx,self.quadcentery)
    end

    local quad = math.floor(self.animtimer/0.2*2)+2
    if self.used then quad = quad + 2 end

    local siny = math.sin(GAME.TIMER*2)*2
    love.graphics.draw(OrbImg,OrbQuads[quad],self.X+self.offsetx,self.Y+self.offsety-2+siny,0,1,1,self.quadcenterx,self.quadcentery)

    if self.used and self.usedplayer then
        local _linewidth = love.graphics.getLineWidth()
        love.graphics.setLineWidth(4)
        love.graphics.setColor(91/255,91/255,236/255)
        local p = self.usedplayer
        love.graphics.line(self.X+(self.W/2), self.Y+(self.H/2), p.X+(p.W/2), p.Y+(p.H/2))
        love.graphics.setLineWidth(_linewidth)
    end

    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,1,1,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

function orb:trigger(player,start)
    self.used = start
    self.usedplayer = false
    if start then
        self.usedplayer = player
        PlaceSound:play()
    end
end

OBJECTS.orb = orb