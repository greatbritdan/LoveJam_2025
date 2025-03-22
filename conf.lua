function love.conf(t)
    local scale = 3
    Env = {windowwidth=(1920/4)*scale, windowheight=(1088/4)*scale, scale=scale}
    Env.width, Env.height = Env.windowwidth/Env.scale, Env.windowheight/Env.scale
    t.identity = "Pre-Meditated"
    t.window.title = "Pre-Meditated"
    t.window.icon = "graphics/icon.png"

    t.window.width = Env.windowwidth
    t.window.height = Env.windowheight
end