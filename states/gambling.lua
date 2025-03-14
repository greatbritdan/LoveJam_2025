local gambling = {}

function gambling.LoadHud()
    GUI.HAND = {}
    GUI.HAND.roll = UI.BUTTON:new({W=120,H=40},{children={{text="roll <3>"}},func=function() RollDice() end})
    GUI.HAND.play = UI.BUTTON:new({W=120,H=40},{children={{text="play"}},func=function() ScoreDice() end})

    MATRIXES.HAND = UI.MATRIX:new({X=0,Y=Env.height-80,W=Env.width,H=80},{matrixmargin=4,matrixspacing=20})
    MATRIXES.HAND:Setup{MC={{GUI.HAND.roll,GUI.HAND.play}}}; MATRIXES.HAND:Recaclulate()
end

---------------------------------

function gambling.Load()
    VARS.ROLLS = VARS.MAXROLLS
    GUI.HAND.roll.active = true

    for _,dice in ipairs(DICES) do
        dice.unfolded = false
        dice:Roll()
    end
    SetDicePositions("",nil,108)
end

function gambling.Update(dt)
    MATRIXES.HAND:Update(dt)
    GUI.HAND.roll.children[1].text = "roll <"..VARS.ROLLS..">"
end

function gambling.BackDraw()
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(BackgroundImg, 0, 0)
end


function gambling.Draw(debug)
    MATRIXES.HAND:Draw()
    if debug then MATRIXES.HAND:DebugDraw() end
end

function gambling.Mousepressed(mx,my,b)
    for _,dice in ipairs(DICES) do
        if dice:Hover(mx,my) then
            dice.held = not dice.held
            return
        end
    end
    MATRIXES.HAND:Mousepressed(mx,my,b)
end
function gambling.Mousereleased(mx,my,b)
    MATRIXES.HAND:Mousereleased(mx,my,b)
end

---------------------------------

function RollDice(idx)
    if VARS.ROLLS <= 0 then return end
    if idx then DICES[idx]:Roll() return end
    for _,dice in ipairs(DICES) do
        dice:Roll()
    end
    VARS.ROLLS = VARS.ROLLS - 1
    if VARS.ROLLS <= 0 then
        GUI.HAND.roll.active = false
    end
end

function ScoreDice()
    local value = 0
    for _,dice in ipairs(DICES) do
        value = dice:Evaluate(value)
    end
    STATE = "Shopping"
    if _G[STATE] and _G[STATE].Load then
        _G[STATE].Load()
    end
end

---------------------------------

gambling.LoadHud()

return gambling