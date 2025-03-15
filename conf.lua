function love.conf(t)
    local scale = 4
    Env = {windowwidth=(1920/4)*scale, windowheight=(1088/4)*scale, scale=scale}
    Env.width, Env.height = Env.windowwidth/Env.scale, Env.windowheight/Env.scale
    t.identity = "BritBase"
    t.window.icon = "graphics/icon.png"

    t.window.width = Env.windowwidth
    t.window.height = Env.windowheight
end