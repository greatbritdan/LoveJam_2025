local style = Class("britui_style")

function style:initialize()
    self.name = "default"
    self.font = Font

    self.colors = {
        fill =  {base={0,0,0},       hover={0,0,0},       click={0,0,0},       backbase={0,0,0}},
        line =  {base={0.6,0.6,0.6}, hover={0.8,0.8,0.8}, click={0.4,0.4,0.4}, backbase={0,0,0}},
        text =  {base={1,1,1},       hover={1,1,1},       click={1,1,1},       backbase={0,0,0}, gray={1,1,1,0.5}},
        image = {base={1,1,1},       hover={1,1,1},       click={1,1,1},       backbase={0,0,0}, gray={1,1,1,0.5}},
    }
    self.box  = {fill="fill",line="line"}
    self.text = {fill="text"}
    self.image = {fill="image"}

    self.margin = 16
    self.linewidth = 1
    self.fontheightgap = 2
end

function style:Overrides(element,args)
    element.scale = args.scale
    element.corner = args.corner
    element.linewidth = args.linewidth
    element.alignX = args.alignX
    element.alignY = args.alignY
    element.margin = args.margin
    element.marginX = args.marginX
    element.marginY = args.marginY
    element.spacing = args.spacing
    element.spacingX = args.spacingX
    element.spacingY = args.spacingY

    element.matrixmargin = args.matrixmargin
    element.matrixmarginX = args.matrixmarginX
    element.matrixmarginY = args.matrixmarginY
    element.matrixspacing = args.matrixspacing
    element.matrixspacingX = args.matrixspacingX
    element.matrixspacingY = args.matrixspacingY
end

-- TODO: Image button scaling, instead of resizing the image
function style:CreateImageButton(path, cs) -- path, corner size
    local w, h = 15+(8*cs), 3+(2*cs)
    local function creatquads(x)
        return {
            top = {
                left =  love.graphics.newQuad(x,    0, cs, cs, w, h),
                mid =   love.graphics.newQuad(x+cs+1, 0, 1,  cs, w, h),
                right = love.graphics.newQuad(x+cs+3, 0, cs, cs, w, h)
            },
            mid = {
                left =  love.graphics.newQuad(x,    cs+1, cs, 1, w, h),
                mid =   love.graphics.newQuad(x+cs+1, cs+1, 1,  1, w, h),
                right = love.graphics.newQuad(x+cs+3, cs+1, cs, 1, w, h)
            },
            bottom = {
                left =  love.graphics.newQuad(x,    cs+3, cs, cs, w, h),
                mid =   love.graphics.newQuad(x+cs+1, cs+3, 1,  cs, w, h),
                right = love.graphics.newQuad(x+cs+3, cs+3, cs, cs, w, h)
            }
        }
    end

    local img = love.graphics.newImage(path)
    local iw = 4+(2*cs)
    local quads = { base = creatquads(0), hover = creatquads(iw), click = creatquads(iw*2), backbase = creatquads(iw*3) }
    return img, quads, cs
end
function style:initializeElement(element)
    if element.option and self[element.option].imagebutton then
        self:InitializeImageButton(element,self[element.option].imagebutton)
    end
end
function style:InitializeImageButton(element,data)
    element.spritebatches = {}
    if element.T == "slider" then
        element.spritebatches.base = self:GenerateImageButtonSB(element.head.W,element.head.H,data,"base")
        element.spritebatches.hover = self:GenerateImageButtonSB(element.head.W,element.head.H,data,"hover")
        element.spritebatches.click = self:GenerateImageButtonSB(element.head.W,element.head.H,data,"click")
        element.spritebatches.backbase = self:GenerateImageButtonSB(element.W,element.H,data,"backbase")
    else
        element.spritebatches.base = self:GenerateImageButtonSB(element.W,element.H,data,"base")
        element.spritebatches.hover = self:GenerateImageButtonSB(element.W,element.H,data,"hover")
        element.spritebatches.click = self:GenerateImageButtonSB(element.W,element.H,data,"click")
        if element.T == "dropdown" then
            element.spritebatches.backbase = self:GenerateImageButtonSB(element.W,element:OpenHeight(),data,"backbase")
        end
    end
end
function style:GenerateImageButtonSB(w,h,data,state)
    local cs = data.cornersize
    local inw, inh = math.ceil(w-(cs*2))+1, math.ceil(h-(cs*2)) -- had to modify as looks bad in lovejs
    local spritebatch = love.graphics.newSpriteBatch(data.image, 9)
    spritebatch:add(data.quads[state].top.left, 0, 0, 0, 1, 1)
    spritebatch:add(data.quads[state].top.mid, cs, 0, 0, inw, 1)
    spritebatch:add(data.quads[state].top.right, w-cs, 0, 0, 1, 1)
    spritebatch:add(data.quads[state].mid.left, 0, cs, 0, 1, inh)
    spritebatch:add(data.quads[state].mid.mid, cs, cs, 0, inw, inh)
    spritebatch:add(data.quads[state].mid.right, w-cs, cs, 0, 1, inh)
    spritebatch:add(data.quads[state].bottom.left, 0, h-cs, 0, 1, 1)
    spritebatch:add(data.quads[state].bottom.mid, cs, h-cs, 0, inw, 1)
    spritebatch:add(data.quads[state].bottom.right, w-cs, h-cs, 0, 1, 1)
    return spritebatch
end

-- Setup --

function style:GetResult(type,element,args,default,option)
    if args[type] then return args[type] end
    if element[type] then return element[type] end
    if option and self[option][type] then return self[option][type] end
    if self[type] then return self[type] end
    return default
end
function style:GetResultXY(basetype,type,element,args,default,option)
    if args[basetype] then return args[basetype] end
    if args[type] then return args[type] end
    if element[basetype] then return element[basetype] end
    if element[type] then return element[type] end
    if option and self[option][basetype] then return self[option][basetype] end
    if option and self[option][type] then return self[option][type] end
    if self[basetype] then return self[basetype] end
    if self[type] then return self[type] end
    return default
end

function style:Init(option,element,args)
    local result = {option=option,args=args}
    result.X = self:GetResult("X",element,args,0)
    result.Y = self:GetResult("Y",element,args,0)
    result.W = self:GetResult("W",element,args,0)
    result.H = self:GetResult("H",element,args,0)
    result.state = self:GetResult("state",element,args,"base")
    result.fill = self:GetResult("fill",element,args,"fill",option)
    result.line = self:GetResult("line",element,args,"line",option)
    result.imagebuttoncolor = args.imagebuttoncolor or {1,1,1}

    result.font = self.font
    result.scale = self:GetResult("scale",element,args,1,option)
    result.corner = self:GetResult("corner",element,args,0,option)
    result.linewidth = self:GetResult("linewidth",element,args,1,option)
    result.text = self:GetResult("text",element,args,"no text")
    result.image = self:GetResult("image",element,args,nil)
    result.quad = self:GetResult("quad",element,args,nil)
    result.dotsize = self:GetResult("dotsize",element,args,4)

    result.alignX = self:GetResult("alignX",element,args,"center",option)
    result.alignY = self:GetResult("alignY",element,args,"center",option)
    result.marginX = self:GetResultXY("margin","marginX",element,args,4,option)
    result.marginY = self:GetResultXY("margin","marginY",element,args,4,option)
    result.spacingX = self:GetResultXY("spacing","spacingX",element,args,4,option)
    result.spacingY = self:GetResultXY("spacing","spacingY",element,args,4,option)
    result.matrixmarginX = self:GetResultXY("matrixmargin","matrixmarginX",element,args,16,option)
    result.matrixmarginY = self:GetResultXY("matrixmargin","matrixmarginY",element,args,16,option)
    result.matrixspacingX = self:GetResultXY("matrixspacing","matrixspacingX",element,args,16,option)
    result.matrixspacingY = self:GetResultXY("matrixspacing","matrixspacingY",element,args,16,option)
    return result
end

function style:AlignHor(x,w,ew,align,margin)
    local nx = x
    if align == "left" then
        nx = x + margin
    elseif align == "center" then
        nx = x + (w/2) - (ew/2)
    elseif align == "right" then
        nx = x + w - margin - ew
    end
    return nx
end

function style:AlignVer(y,h,eh,align,margin)
    local ny = y
    if align == "top" then
        ny = y + margin
    elseif align == "center" then
        ny = y + (h/2) - (eh/2)
    elseif align == "bottom" then
        ny = y + h - margin - eh
    end
    return ny
end

-- Made to be replaced
function style:DefaultBox(fill,x,y,w,h,rx,ry,_)
    love.graphics.rectangle(fill,x,y,w,h,rx,ry)
end
function style:DefaultBoxImage(image,x,y,r,sx,sy,_)
    love.graphics.draw(image,x,y,r,sx,sy)
end
function style:DefaultImage(image,x,y,r,sx,sy,_)
    love.graphics.draw(image,x,y,r,sx,sy)
end
function style:DefaultImageQ(image,quad,x,y,r,sx,sy,_)
    love.graphics.draw(image,quad,x,y,r,sx,sy)
end
function style:DefaultText(text,x,y,r,sx,sy,_)
    love.graphics.print(text,x,y,r,sx,sy)
end

-- Box --

function style:DrawBox(option,element,args)
    local r = self:Init(option,element,args)

    if self[option].imagebutton then
        love.graphics.setColor(r.imagebuttoncolor)
        self:DefaultBoxImage(element.spritebatches[r.state], r.X, r.Y, 0, 1, 1, element)
    else
        love.graphics.setColor(self.colors[r.fill][r.state])
        self:DefaultBox("fill", r.X, r.Y, r.W, r.H, r.corner, r.corner, element)
    
        love.graphics.setColor(self.colors[r.line][r.state])
        love.graphics.setLineWidth(r.linewidth)
        self:DefaultBox("line", r.X, r.Y, r.W, r.H, r.corner, r.corner, element)
    end
end

-- Text --

function style:TextWidth(text)
    return self.font:getWidth(text)-1
end
function style:TextHeight()
    return self.font:getHeight()-self.fontheightgap
end
function style:TextForEachLine(option,element,args,func)
    local r = self:Init(option,element,args)
    local _, lines = self.font:getWrap(r.text,(r.W-(r.marginX*2))/r.scale)
    for idx, line in pairs(lines) do
        local tw, th = self:TextWidth(line)*r.scale, self:TextHeight()*r.scale
        local tx = self:AlignHor(r.X,r.W,tw,r.alignX,r.marginX)
        local ty = self:AlignVer(r.Y,r.H,th,r.alignY,r.marginY) - (((th+2)/2)*(#lines-1)) + ((th+2)*(idx-1))
        func(line, tx, ty, tw, th, idx)
    end
end
function style:DrawText(option,element,args)
    local r = self:Init(option,element,args)
    love.graphics.setFont(self.font)
    love.graphics.setColor(self.colors[r.fill][r.state])
    self:TextForEachLine(option,element,args,function(line,tx,ty)
        self:DefaultText(line,tx,ty,0,r.scale,r.scale, element)
    end)
end

-- Image --

function style:ImageWidth(image,quad)
    if quad then
        local x,y,w,h = quad:getViewport()
        return w
    else
        return image:getWidth()
    end
end
function style:ImageHeight(image,quad)
    if quad then
        local x,y,w,h = quad:getViewport()
        return h
    else
        return image:getHeight()
    end
end
function style:DrawImage(option,element,args)
    local r = self:Init(option,element,args)

    love.graphics.setColor(self.colors[r.fill][r.state])
    local x = self:AlignHor(r.X,r.W,self:ImageWidth(r.image,r.quad)*r.scale,r.alignX,r.marginX)
    local y = self:AlignVer(r.Y,r.H,self:ImageHeight(r.image,r.quad)*r.scale,r.alignY,r.marginY)
    if r.quad then
        self:DefaultImageQ(r.image,r.quad,x,y,0,r.scale,r.scale, element)
    else
        self:DefaultImage(r.image,x,y,0,r.scale,r.scale, element)
    end
end

return style