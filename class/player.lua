local player = Class("player",OBJECTS.box)
function player:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=128})
    self.class = "player"
    self.startX, self.startY = x, y
    self.started = false
end

function player:update(dt)
    if not self.started then return end
    local tilex, tiley = GetTileAtPos(self.X+8+GAME.MAPPOS.X,self.Y+8+GAME.MAPPOS.Y)
    if tilex ~= self.lastTile.X or tiley ~= self.lastTile.Y then
        self.lastTile = {X=tilex,Y=tiley}
        local chip = GetChipAtTile(tilex,tiley)
        if chip then
            if chip.action == "jump" then
                self.VY = -96
            end
            if chip.action == "move_left" then
                self.VX = -40
            end
            if chip.action == "move_right" then
                self.VX = 40
            end
        end
    end
end

function player:draw()
    love.graphics.setColor(1,1,1,0.75)
    love.graphics.rectangle("line",GAME.MAPPOS.X+self.X,GAME.MAPPOS.Y+self.Y,self.W,self.H)
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill",GAME.MAPPOS.X+self.X+7,GAME.MAPPOS.Y+self.Y+7,2,2)
end

function player:start()
    self.VX = 40
    local tilex, tiley = GetTileAtPos(self.X+8+GAME.MAPPOS.X,self.Y+8+GAME.MAPPOS.Y)
    self.lastTile = {X=tilex,Y=tiley}
    self.started = true
end

function player:stop()
    self.VX = 0
    self.X, self.Y = self.startX, self.startY
    self.started = false
end

OBJECTS.player = player