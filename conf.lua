function love.conf(t)
    Env = {windowwidth=1920, windowheight=1080, scale=4}
    Env.width, Env.height = Env.windowwidth/Env.scale, Env.windowheight/Env.scale
    t.identity = "BritBase"
    t.window.icon = "graphics/icon.png"

    t.window.width = Env.windowwidth
    t.window.height = Env.windowheight
end