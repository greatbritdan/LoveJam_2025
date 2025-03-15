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

        if self.items[i] and TableContains(self.items[i].name,_ITEMS,"name") then
            local ammount = self.items[i].amount
            local item = _ITEMS[self.items[i].name]

            if ammount == 0 then
                love.graphics.setColor(1,1,1,0.4)
                self:drawimage(item.img,item.quad,x+7,y+7)
            else
                self:drawimage(item.img,item.quad,x+7,y+7)
                if ammount < 10 then
                    love.graphics.draw(InventoryImg,InventoryQuads[ammount],x,y)
                end
            end
        end

        x = x + 34
    end
end

function INVENTORY:drawimage(img,quad,x,y)
    if quad then
        love.graphics.draw(img,quad,x,y)
    else
        love.graphics.draw(img,x,y)
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
        --[[if self.items[idx].amount <= 0 then
            table.remove(self.items,idx)
        end]]
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
    if TableContains(self.name,_ITEMS,"name") then
        local item = _ITEMS[self.name]
        local x,y = self.X+GAME.MAPPOS.X,self.Y+GAME.MAPPOS.Y
        if self.moving then
            x,y = love.mouse.getX()-8, love.mouse.getY()-8
        end

        love.graphics.setColor(1,1,1)
        if item.quad then
            love.graphics.draw(item.img,item.quad,x,y)
        else
            love.graphics.draw(item.img,x,y)
        end
        love.graphics.draw(ItemselecterImg,x-1,y-1)
    end
end