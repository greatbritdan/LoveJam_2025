EFFECT = Class("effect")

-- HSL code from https://stackoverflow.com/questions/63314851/how-to-convert-hsl-to-rbg-in-lua

local function hue2rgb(p, q, t)
    if t < 0   then t = t + 1 end
    if t > 1   then t = t - 1 end
    if t < 1/6 then return p + (q - p) * 6 * t end
    if t < 1/2 then return q end
    if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
    return p
end

local function hsl2rgb(h, s, l)
    local r, g, b

    local h = h / 360

    if s == 0 then
        r, g, b = l, l, l
    else
        local q = (l < 0.5) and l * (1 + s) or l + s - l * s
        local p = l * 2 - q

        r = hue2rgb(p, q, h + 1/3)
        g = hue2rgb(p, q, h)
        b = hue2rgb(p, q, h - 1/3)
    end

    return r,g,b,1 -- modified to return as color
end

---

-- Yes, I stole this for reverse polarity... which I stole from seismic shakup... which I stole fro-
function EFFECT:initialize(t, x, y)
    self.x, self.y = x, y
    self.vx, self.vy = 0, 0

    self.color = {1,1,1,1}
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
    if t == "redstarul" or t == "redstarur" or t == "redstardl" or t == "redstardr" then
        self.group = "redstar"
        self.frames = {frames={1,2,3,4}, frame=1, timer=0, time=0.1}
        if t == "redstarul" then self.vx, self.vy = -6, -6 end
        if t == "redstarur" then self.vx, self.vy = 6, -6 end
        if t == "redstardl" then self.vx, self.vy = -6, 6 end
        if t == "redstardr" then self.vx, self.vy = 6, 6 end
        self.lifetime = 0.4
        self.fade = true
    end
    if t == "confetti" then
        self.group = "confetti"
        self.frame = math.random(1,4)
        self.color[1], self.color[2], self.color[3] = hsl2rgb(math.random(0,360),0.8,0.5)
        self.vx = math.random(-32,32)
        self.vy = math.random(-96,-32)
        self.lifetime = 99
        self.gravity = true
        self.removeifoffscreen = true
    end
    if t == "blood" then -- just red confetti :p
        self.group = "confetti"
        self.frame = math.random(1,4)
        self.color[1], self.color[2], self.color[3] = hsl2rgb(0,0.8,0.5)
        self.vx = math.random(-64,64)
        self.vy = math.random(-64,64)
        self.lifetime = 99
        self.gravity = true
        self.removeifoffscreen = true
    end

    self.lifetimer = 0
end

function EFFECT:update(dt)
    if self.removeifoffscreen then
        if self.x < -16 or self.x > Env.width+16 or self.y < -16 or self.y > Env.height+16 then
            return true -- Delete
        end
    end

    self.lifetimer = self.lifetimer + dt
    if self.lifetimer >= self.lifetime then
        return true -- Delete
    end

    if self.group ~= "confetti" then
        local f = self.frames
        if f and #f.frames > 1 then
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
    end

    if self.gravity then
        self.vy = self.vy + 90*dt
    end
    self.x = self.x + self.vx*dt
    self.y = self.y + self.vy*dt
end

function EFFECT:draw()
    love.graphics.setColor(self.color)
    if self.frame then
        love.graphics.draw(EffectImg, EffectQuads[self.group][self.frame], self.x, self.y, 0, 1, 1, 2, 2)
    else
        love.graphics.draw(EffectImg, EffectQuads[self.group][self.frames.frame], self.x, self.y, 0, 1, 1, 2, 2)
    end
end