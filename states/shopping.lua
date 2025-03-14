local shopping = {}

function shopping.LoadHud()
    GUI.SHOP = {}
    GUI.SHOP.one =   UI.BUTTON:new({W=32,H=32},{children={{text="6",margin=0}},func=function() Purchace("value",6) end})
    GUI.SHOP.two =   UI.BUTTON:new({W=32,H=32},{children={{text="",margin=0}},func=function() end})
    GUI.SHOP.three = UI.BUTTON:new({W=32,H=32},{children={{text="g",margin=0}},func=function() Purchace("back","glass") end})
    GUI.SHOP.four =  UI.BUTTON:new({W=32,H=32},{children={{text="r",margin=0}},func=function() Purchace("back","retrigger") end})
    GUI.SHOP.five =  UI.BUTTON:new({W=32,H=32},{children={{text="m",margin=0}},func=function() Purchace("back","mult") end})
    GUI.SHOP.six =   UI.BUTTON:new({W=32,H=32},{children={{text="?",margin=0}},func=function() Purchace("value",math.random(1,9)) end})

    MATRIXES.SHOP = UI.MATRIX:new({X=0,Y=28,W=Env.width,H=120},{matrixmargin=4})
    MATRIXES.SHOP:Setup{MC={{GUI.SHOP.one,GUI.SHOP.two,GUI.SHOP.three},{GUI.SHOP.four,GUI.SHOP.five,GUI.SHOP.six}}}; MATRIXES.SHOP:Recaclulate()

    GUI.NEXT = {}
    GUI.NEXT.next = UI.BUTTON:new({W=120,H=20},{children={{text="next"}},func=function() ChangeState("Gambling") end})

    MATRIXES.NEXT = UI.MATRIX:new({X=0,Y=0,W=Env.width,H=28},{matrixmargin=4})
    MATRIXES.NEXT:Setup{TR={{GUI.NEXT.next}}}; MATRIXES.NEXT:Recaclulate()
end

---------------------------------

function shopping.Load()
    for _,dice in ipairs(DICES) do
        dice.hold = false
        dice.unfolded = true
    end
    SetDicePositions("unfolded",nil,209)
end

function shopping.Update(dt)
    MATRIXES.SHOP:Update(dt)
    MATRIXES.NEXT:Update(dt)
end

function shopping.BackDraw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(BackgroundShopImg, 0, 0)
end

function shopping.Draw(debug)
    MATRIXES.SHOP:Draw()
    MATRIXES.NEXT:Draw()
    if debug then
        MATRIXES.SHOP:DebugDraw()
        MATRIXES.NEXT:DebugDraw()
    end
end

function shopping.Mousepressed(mx,my,b)
    for _,dice in ipairs(DICES) do
        local face = dice:Hover(mx,my)
        if face and dice.faces[face] then
            dice.faces[face].selected = not dice.faces[face].selected
            return
        end
    end
    MATRIXES.SHOP:Mousepressed(mx,my,b)
    MATRIXES.NEXT:Mousepressed(mx,my,b)
end
function shopping.Mousereleased(mx,my,b)
    MATRIXES.SHOP:Mousereleased(mx,my,b)
    MATRIXES.NEXT:Mousereleased(mx,my,b)
end

---------------------------------

function Purchace(_type,value)
    for _,dice in ipairs(DICES) do
        for _,face in ipairs(dice.faces) do
            if face.selected then
                face.selected = false
                if _type == "back" then
                    face.back = value
                    print("back",value)
                elseif _type == "value" then
                    face.value = value
                end
            end
        end
    end
end

---------------------------------

shopping.LoadHud()

return shopping