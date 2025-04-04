-- Dialog! It displays text and highlights key ares

DIALOGS = {
    level1 = {
        {text="level 1? &should be a piece of cake, &the goal is simple!"},
        {text="you need to get this little guy from point a &to point b.",highlight="player"},
        {text="point b being this exit door...",highlight="exit"},
        {text="to do so you can use these items in your inventory.",highlight="inventory"},
        {text="click and hold an item to move it around. &if you want to discard it you can simply drop it somewhere off the map.",highlight="inventory"},
        {text="you can place the item in any of these highlighted spots, &you can also move items you've already placed.",highlight="available"},
        {text="this is a springboard, &this will launch the player upwards. &place it in one of the available spots to bring the guy to the exit.",highlight="slot1"},
        {text="once you're ready, &click the play button to start the simulation, &good luck!",highlight="play"},
    },
    level2 = {
        {text="oh no! &looks like someone has put a conveniently square hole in the floor."},
        {text="you can use this crate to fill the hole, &you can place them directly over the area or higher up as they are affected by gravity.",highlight="slot1"},
        {text="sometimes you might be given more items than you need, &don't feel the need to use every single one!",highlight="slot1"},
    },
    level3 = {
        {text="looks like someone has put spikes on the floor, &looks like you'll have to use a platform."},
        {text="platforms will hover in the air, &you can use it to hold up springboards, &or crates &or even yourself!",highlight="slot3"},
        {text="keep in mind sprinboards will get destroyed if they touch the spikes, &be careful!",highlight="slot1"},
    },
    level3_spike = {
        {text="ouch, &that has got to hurt, &at least you've learned now."},
    },
    level4 = {
        {text="don't hit the spike wall, &i don't know what else to tell you. &&don't &&be &&dumb!"},
    },
    level4_dumb = {
        {text="you hit the spike wall, &&you're dumb."},
    },
    level5 = {
        {text="keys can be used to unlock doors, &it will automatically unlock all the doors of the same color when picked up.",highlight="slot1"},
    },
    level7 = {
        {text="this is an anti-gravity orb, &when you touch it you will no longer be affected by gravity until you touch something else.",highlight="slot1"},
        {text="use it to float over this pit."},
    },
    level12 = {
        {text="these are teleporters, &they take you from one side to the other.",highlight="slot1"},
        {text="you can use it to get to areas otherwise impossible to reach, &or go back to areas you previously were."},
    },
}

DIALOG = {}
function DIALOG:initialize(dialog)
    self.textspeed = 0.03
    self.finished = true
    self.timer = 0
    self.hightimer = 0
    self.sintimer = 0
end

function DIALOG:update(dt)
    self.sintimer = self.sintimer + dt

    if not GAME.INDIALOG then return end
    self.hightimer = self.hightimer + dt

    if self.waittimer then
        self.waittimer = self.waittimer - dt
        if self.waittimer <= 0 then
            self.waittimer = nil
        end
        return
    end

    if self.finished then
        return
    end

    self.talktimer = self.talktimer + dt
    if self.talktimer > 0.15 then
        self.talk = true
    end

    self.timer = self.timer + dt
    if self.timer > self.textspeed then
        self.timer = self.timer - self.textspeed
        self.char = self.char + 1
        local next = self.fulltext:sub(self.char,self.char)
        if next == "&" then -- & is used for breff pauses
            self.waittimer = 0.3
        else
            self.text = self.text .. next
            if self.talk then
                local sound = TalkSounds[math.random(1,#TalkSounds)]
                sound:setPitch(1.15)
                sound:play()
                self.talktimer = 0
                self.talk = false
            end
        end
        if self.char >= #self.fulltext then
            self.finished = true
        end
    end
end

function DIALOG:draw()
    if not GAME.INDIALOG then return end

    local siny = math.sin(self.sintimer*3)
    love.graphics.push()
    love.graphics.translate(0,siny)

    love.graphics.setColor(1,1,1)
    love.graphics.draw(DialogImg,12,12)
    love.graphics.printf(self.text,17,17,302,"left")

    if self.finished then
        local opacity = math.abs(math.sin(self.hightimer*4))
        love.graphics.setColor(1,1,1,opacity)
        love.graphics.printf("click to continue",17,59,302,"right")
    end

    if self.highlight then
        local opacity = math.abs(math.sin(self.hightimer*4))

        local x,y,w,h = self:getHighlight()
        love.graphics.setColor(1,1,1,opacity)
        love.graphics.rectangle("line",x,y,w,h)
    end

    love.graphics.pop()
end

function DIALOG:start(dialog,delay)
    self.dialogs = DIALOGS[dialog]
    GAME.INDIALOG = true
    if delay then
        self.waittimer = delay
    end
    self:play(1)
end

function DIALOG:play(idx)
    self.current = idx
    self.fulltext = self.dialogs[self.current].text
    self.highlight = self.dialogs[self.current].highlight

    self.timer = 0
    self.talktimer = 9999; self.talk = true
    self.text = ""
    self.char = 0
    self.finished = false
    self.hightimer = 0
end

function DIALOG:next()
    if self.current < #self.dialogs then
        self:play(self.current+1)
    else
        self.finished = true
        GAME.INDIALOG = false
    end
end

function DIALOG:getHighlight()
    if self.highlight == "player" then
        return GAME.PLAYER.X+GAME.MAPPOS.X-6, GAME.PLAYER.Y+GAME.MAPPOS.Y-6, 24, 24
    end
    if self.highlight == "exit" then
        local x,y = 0,0
        -- This kinda sucks, but I'm not giving it a whole 1 new variable.
        GAME.MAP:GetLayer("Objects"):LoopThrough(function(data)
            if data.obj.class == "exit" then
                x,y = data.obj.X,data.obj.Y
            end
        end)
        return x+GAME.MAPPOS.X-8, y+GAME.MAPPOS.Y-12, 32, 32
    end
    if self.highlight == "inventory" then
        return 342-4, 59-4, 132+8, 30+8
    end
    if self.highlight == "available" then
        return 120-4, 152-4, 48+8, 32+8
    end
    if self.highlight == "slot1" then
        return 342-4, 59-4, 30+8, 30+8
    end
    if self.highlight == "slot2" then
        return 376-4, 59-4, 30+8, 30+8
    end
    if self.highlight == "slot3" then
        return 410-4, 59-4, 30+8, 30+8
    end
    if self.highlight == "play" then
        local ui = GAME.UI.PLAY
        return ui.X-4, ui.Y-4, ui.W+8, ui.H+8
    end
end

DIALOG:initialize()
