local player = Class("player",OBJECTS.box)
function player:initialize(world,x,y,w,h)
    OBJECTS.box.initialize(self,world,x,y,w,h,{gravity=128})
    self.started = false
end

function player:update(dt)
    if not self.started then return end
    local tilex, tiley = GetTileAtPos(self.X+15,self.Y+15)
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

function player:start()
    self.VX = 40
    local tilex, tiley = GetTileAtPos(self.X+15,self.Y+15)
    self.lastTile = {X=tilex,Y=tiley}
    self.started = true
end

OBJECTS.player = player