local scene = {}

local loadobject = function(data)
    if data.class == "ground" then
        return OBJECTS.ground:new(GAME.WORLD,data.X,data.Y,data.W,data.H,data.args)
    elseif data.class == "player" then
        return OBJECTS.player:new(GAME.WORLD,data.X,data.Y,16,16)
    end
end

GAME = {}
function scene.LoadScene()
    GAME.WORLD = BUMP.newWorld(16)
    GAME.MAP = MAP:new("maps/test.lua",{LoadObject=loadobject})
    table.insert(GAME.MAP:GetLayer("Objects").objects,OBJECTS.player:new(GAME.WORLD,0,0,16,16))

    GAME.MAPPOS = {X=7,Y=7}
end
function scene.Update(dt)
    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        if data.obj.update then data.obj:update(dt) end
        data.obj:updatePhysics(dt)
    end)
end
function scene.Draw()
    love.graphics.setColor(1,1,1)
    GAME.MAP:GetLayer("Tiles"):LoopThrough(function(data)
        love.graphics.draw(data.image,data.quad,((GAME.MAPPOS.X/16)+data.X-1)*16,((GAME.MAPPOS.Y/16)+data.Y-1)*16)
    end)

    GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
        love.graphics.setColor(1,0.3,0.3)
        love.graphics.rectangle("line",GAME.MAPPOS.X+data.obj.X,GAME.MAPPOS.Y+data.obj.Y,data.obj.W,data.obj.H)
    end)
end

function scene.InputPressed(name,dir)
    if name == "jump" then
        GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
            if data.obj.jump then data.obj:jump() end
        end)
    end
end

return scene