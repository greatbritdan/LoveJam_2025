INVENTORY = Class("inventory")
function INVENTORY:initialize()
    self.items = {}
    self.size = 4
end

function INVENTORY:update(dt)
end

function INVENTORY:draw()
    local x,y = 342, 52
    for i = 1, self.size do
        love.graphics.setColor(1,1,1)
        love.graphics.draw(InventoryImg,InventoryQuads.slot,x,y)
        if self.items[i] then
            if self.items[i].amount == 0 then
                love.graphics.setColor(1,1,1,0.4)
                love.graphics.draw(ItemsImg,ItemsQuad[self.items[i].name],x+7,y+7)
            else
                love.graphics.draw(ItemsImg,ItemsQuad[self.items[i].name],x+7,y+7)
                if self.items[i].amount < 10 then
                    love.graphics.draw(InventoryImg,InventoryQuads[self.items[i].amount],x,y)
                end
            end
        end
        x = x + 34
    end
end

function INVENTORY:addItem(name,amount)
    local idx = TableContains(name,self.items,"name")
    if idx then
        self.items[idx].amount = self.items[idx].amount + amount
    else
        self.items[#self.items+1] = {name=name,amount=amount}
    end
end
function INVENTORY:removeItem(name,amount)
    local idx = TableContains(name,self.items,"name")
    if idx then
        self.items[idx].amount = self.items[idx].amount - amount
        if self.items[idx].amount <= 0 then
            table.remove(self.items,idx)
        end
    end
end

function INVENTORY:hover(mx,my)
    local x,y = 342, 52
    for i = 1, self.size do
        if AABB(mx,my,1,1,x,y,30,30) then
            return i, self.items[i]
        end
        x = x + 34
    end
    return false, false
end

------------------------

ITEM = Class("item")
function ITEM:initialize(name)
    self.name = name
    self.moving = true

    self.X, self.Y = 0, 0
end

function ITEM:draw()
    local x,y = self.X+GAME.MAPPOS.X,self.Y+GAME.MAPPOS.Y
    if self.moving then
        x,y = love.mouse.getX()-8, love.mouse.getY()-8
    end

    love.graphics.setColor(1,1,1)
    love.graphics.draw(ItemsImg,ItemsQuad[self.name],x,y)
end