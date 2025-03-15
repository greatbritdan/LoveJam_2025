local player = Class("player",OBJECTS.box)
function player:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=128})
    self.class = "player"
    self.startX, self.startY = x, y
    self.started = false

    self.quadcenterx = 8
    self.quadcentery = 8
    self.offsetx = 6
    self.offsety = 6

    self.idletimer = 0
    self.walktimer = 0
    self.inair = false
end

function player:update(dt)
    if not self.started then
        self.idletimer = self.idletimer + dt
        if self.idletimer > 5 then
            self.idletimer = 0
            self.VX = -self.VX
        end
        return
    end

    self.walktimer = self.walktimer + dt
    if self.walktimer > 0.4 then
        self.walktimer = self.walktimer - 0.4
    end

    if not self.inair and self.VY > 0 then
        self.inair = true
    end

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.class == "exit" then
            if AABB(self.X+self.W/2-1,self.Y+self.H/2-1,2,2,data.obj.X,data.obj.Y,data.obj.W,data.obj.H) then
                print("winner is you")
            end
        end
    end)
end

function player:collided(data)
    if data.col.normal.y == -1 then
        self.inair = false
    end
end

function player:draw()
    local scale = 1
    if self.VX < 0 then scale = -1 end
    local quad = 1
    if not self.started then
        if self.idletimer >= 4 then quad = 3 end
    else
        quad = 4
        if self.walktimer >= 0.2 then quad = 5 end
        if self.inair then quad = 6 end
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
    self.VX = 40
    local tilex, tiley = GetTileAtPos(self.X+(self.W/2),self.Y+(self.H/2))
    self.lastTile = {X=tilex,Y=tiley}
    self.started = true
end

function player:stop()
    self.VX, self.VY = 0, 0
    self.inair = false
    self.X, self.Y = self.startX, self.startY
    -- Hacky fix because bump doesn't update the rect when setting the position manually
    GAME.WORLD.rects[self] = {x=self.X,y=self.Y,w=self.W,h=self.H}
    self.started = false
end

OBJECTS.player = player