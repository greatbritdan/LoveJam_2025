local style = Class("britui_basicstyle", _BRITUI.STYLE)

function style:initialize()
    _BRITUI.STYLE.initialize(self)
    self.name = "basic"
    self.font = SmallFont

    self.margin = 4
    self.spacing = 4
    self.matrixmargin = 4
    self.matrixspacing = 4
    self.scale = 1

    self.colors = {
        fill =  {base={0,0,0},       hover={0,0,0},       click={0,0,0},       backbase={0,0,0}},
        line =  {base={0.6,0.6,0.6}, hover={0.8,0.8,0.8}, click={0.4,0.4,0.4}, backbase={0,0,0}},
        text =  {base={0,0,0},       hover={0,0,0},       click={0,0,0},       backbase={1,1,1}, gray={1,1,1,0.5}},
        image = {base={0,0,0},       hover={0,0,0},       click={0,0,0},       backbase={1,1,1}, gray={1,1,1,0.5}},
    }

    local buttonimg, buttonquads, buttoncornersize = self:CreateImageButton("graphics/UIstyles/basic.png",11)
    self.box.imagebutton = {image=buttonimg, quads=buttonquads, cornersize=buttoncornersize}
end

function style:DefaultText(text,x,y,r,sx,sy,element)
    -- Offset text if element is clicked
    local oy = 1
    if element and element.parent and element.parent:GetColor() == "click" then
        oy = 0
    end
    love.graphics.print(text,x,y-oy,r,sx,sy)
end

return style