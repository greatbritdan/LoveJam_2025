local spacer = Class("britui_spacer", _BRITUI.BASE)

function spacer:initialize(transform, args, style)
    self.T = "spacer"
    args = args or {}
    _BRITUI.BASE.initialize(self, transform, args, style)
end

function spacer:Draw() end
function spacer:Update(dt) end
function spacer:Mousepressed(x,y,b) end
function spacer:Mousereleased(x,y,b) end

return spacer