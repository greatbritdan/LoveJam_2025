local box = Class("box")
function box:initialize(world,x,y,w,h,extra)
    extra = extra or {}
    self.world = world
    self.world:add(self,x,y,w,h)

    self.X, self.Y, self.W, self.H = x,y,w,h
    self.VX, self.VY = 0,0

    self.static = extra.static or false
    self.gravity = extra.gravity or 0

    self.defaultmovement = "slide"
end

--[[function box:draw()
    love.graphics.setColor(255,255,255)
    love.graphics.rectangle("line",self.X,self.Y,self.W,self.H)
end]]

function box:setBox(x,y,w,h)
    if x and y then
        self.world:update(self,x,y,w,h)
        self.X, self.Y, self.W, self.H = x,y,w,h
    end
end
function box:delete()
    self.world:remove(self)
end

function box:updatePhysics(dt)
    if self.static then return end

    local oldX, oldY = self.X, self.Y
    self.VY = self.VY + self.gravity*dt
    local newX, newY, cols = self.world:move(self, self.X+(self.VX*dt), self.Y+(self.VY*dt), self.filter)
    self.X, self.Y = newX, newY

    if #cols > 0 then
        for i,v in ipairs(cols) do
            local col = cols[i]
            -- if cross then dont reset velocity
            if col.type == "touch" then
                self.VX = 0; self.VY = 0
            end
            if col.type == "slide" then
                if col.normal.x ~= 0 then self.VX = 0 end
                if col.normal.y ~= 0 then self.VY = 0 end
            end
            if col.type == "bounce" then
                if col.normal.x ~= 0 then self.VX = -self.VX end
                if col.normal.y ~= 0 then self.VY = -self.VY end
            end
            if self.collided then
                self:collided{other=col.other, col=col}
            end
        end
    end
    
    if self.moved then
        self:moved{ox=oldX, oy=oldY, x=newX, y=newY, cols=cols}
    end
end

function box:filter(other)
    local oneway = self:filter_oneway(other)
    if oneway then return oneway end
    if self.filter_other then
        local additional = self:filter_other(other)
        if additional then return additional end
    end
    return self.defaultmovement
end
function box:filter_oneway(other)
    if other.oneway == "up" and self.Y > other.Y-other.H then
        return "cross"
    end
    if other.oneway == "down" and self.Y < other.Y+other.H then
        return "cross"
    end
    if other.oneway == "left" and self.X > other.X-other.W then
        return "cross"
    end
    if other.oneway == "right" and self.X < other.X+other.W then
        return "cross"
    end
    return false
end

OBJECTS.box = box

----------------------

local ground = Class("ground",box)
function ground:initialize(world,x,y,w,h,args)
    box.initialize(self,world,x,y,w,h,{static=true})
    self.class = "ground"
    self.oneway = args.oneway
end

function ground:draw()
    if GAME.DEBUGDRAW then
        love.graphics.setColor(1,0.5,0.5,0.5)
        love.graphics.rectangle("fill",self.X,self.Y,self.W,self.H)
    end
end

OBJECTS.ground = ground