EFFECT = Class("effect")

-- Yes, I stole this for reverse polarity. Teehee
function EFFECT:initialize(t, x, y)
    self.x, self.y = x, y
    self.vx, self.vy = 0, 0

    if t == "dust" or t == "dustl" or t == "dustr" or t == "fan" or t == "dustltitle" then
        self.group = "dust"
        self.frames = {frames={1,2,3,4}, frame=1, timer=0, time=0.1}
        if t == "dustl" then self.vx = -2 end
        if t == "dustltitle" then self.vx = -64 end
        if t == "dustr" then self.vx = 2 end
        self.lifetime = 0.4
        if t == "fan" then
            self.vx = math.random(-2,2)
            self.vy = math.random(16,24)
        end
        self.fade = true
    end
    if t == "starul" or t == "starur" or t == "stardl" or t == "stardr" then
        self.group = "star"
        self.frames = {frames={1,2,3,4}, frame=1, timer=0, time=0.1}
        if t == "starul" then self.vx, self.vy = -6, -6 end
        if t == "starur" then self.vx, self.vy = 6, -6 end
        if t == "stardl" then self.vx, self.vy = -6, 6 end
        if t == "stardr" then self.vx, self.vy = 6, 6 end
        self.lifetime = 0.4
        self.fade = true
    end
    self.color = {1,1,1,1}

    self.lifetimer = 0
end

function EFFECT:update(dt)
    self.lifetimer = self.lifetimer + dt
    if self.lifetimer >= self.lifetime then
        return true -- Delete
    end

    local f = self.frames
    if #f.frames > 1 then
        f.timer = f.timer + dt
        if f.timer >= f.time then
            f.frame = f.frame + 1
            f.timer = f.timer - f.time
            if f.frame > #f.frames then
                f.frame = 1
            end
        end
    end

    if self.fade then
        self.color[4] = 1 - self.lifetimer/self.lifetime
    end

    self.x = self.x + self.vx*dt
    self.y = self.y + self.vy*dt
end

function EFFECT:draw()
    love.graphics.setColor(self.color)
    love.graphics.draw(EffectImg, EffectQuads[self.group][self.frames.frame], self.x, self.y, 0, 1, 1, 2, 2)
end