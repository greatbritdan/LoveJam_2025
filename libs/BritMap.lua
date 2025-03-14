-- BritMap - A Tiled map loader for Love2d, made by Britdan

local _map = Class("britmap_map")
local _tileset = Class("britmap_tileset")
local _layer = Class("britmap_layer")

-- MAP --
function _map:initialize(path, args)
    self.path = path
    self.raw = love.filesystem.load(self.path)()

    self.LoadObject = function() print("Please provide a LoadObject argument!") end
    if args and args.LoadObject then self.LoadObject = args.LoadObject end

    self.tilesets = {}
    for _,tileset in ipairs(self.raw.tilesets) do
        table.insert(self.tilesets, _tileset:new(self,tileset))
    end

    self.layers = {}
    for _,layer in ipairs(self.raw.layers) do
        self:LoadLayer(layer)
    end
end

function _map:LoadLayer(layer)
    if layer.visible then
        if layer.type == "group" then
            for _,sublayer in ipairs(layer.layers) do
                self:LoadLayer(sublayer) -- Ahh recursion, my old friend
            end
        else
            table.insert(self.layers, _layer:new(self,layer))
        end
    end
end

function _map:GetTileData(idx)
    for _,tileset in ipairs(self.tilesets) do
        local localidx = tileset:Includes(idx)
        if localidx then
            return tileset.image, tileset.quads[localidx], localidx
        end
    end
    return nil, nil, 0
end

function _map:GetLayer(name)
    for _,lyr in ipairs(self.layers) do
        if lyr.name == name then
            return lyr
        end
    end
    return nil
end

-- TILESET --
function _tileset:initialize(map,data)
    self.map = map
    self.path = data.image
    self.raw = data
    self.name = data.name or "default"

    self.tileW, self.tileH = data.tilewidth, data.tileheight

    local result = LoadTileset{
        path = self.path, tilew=self.tileW, tileh=self.tileH,
        spacex=data.spacing, spacey=data.spacing
    }
    ---@diagnostic disable-next-line: deprecated
    self.image, self.quads, self.count = result.image, result.quads, result.count

    self.startidx, self.endidx = data.firstgid, data.firstgid + data.tilecount - 1
end

function _tileset:Includes(idx)
    if idx >= self.startidx and idx <= self.endidx then
        return idx - self.startidx
    end
    return nil
end

-- LAYER --
function _layer:initialize(map,data)
    self.map = map
    self.raw = data
    self.name = data.name or "default"

    self.W, self.H = data.width, data.height
    self.type = data.type

    if self.type == "tilelayer" then
        self:InitTileLayer(data)
    elseif self.type == "objectgroup" then
        self:InitObjectLayer(data)
    end
end

function _layer:LoopThrough(func)
    if self.type == "tilelayer" then
        for y=1,self.H do
            for x=1,self.W do
                local gidx = self.grid[y][x]
                if gidx == 0 then goto continue end
                local image, quad, lidx = self.map:GetTileData(gidx)
                if not image then goto continue end
                func{X=x,Y=y,idx=lidx,gidx=gidx,image=image,quad=quad}
                ::continue::
            end
        end
    elseif self.type == "objectgroup" then
        for _,obj in ipairs(self.objects) do
            func{obj=obj,all=self.objects}
        end
    end
end

-- Tiles
function _layer:InitTileLayer(data)
    self.grid = {}
    for y = 1, self.H do
        self.grid[y] = {}
        for x = 1, self.W do
            local idx = (y-1)*self.W + x
            self.grid[y][x] = data.data[idx]
        end
    end
end
function _layer:GetTile(x,y)
    if not self.grid then return nil end
    return self.grid[y][x]
end
function _layer:SetTile(x,y,idx)
    if not self.grid then return nil end
    self.grid[y][x] = idx
end

-- Objects
function _layer:InitObjectLayer(data)
    self.objects = {}
    for _,obj in ipairs(data.objects) do
        if obj.visible then
            if self.map.LoadObject then
                local typ,x,y,w,h = obj.type, obj.x, obj.y, obj.width, obj.height
                local newobj = self.map.LoadObject{class=typ,X=x,Y=y,W=w,H=h,obj=obj,layer=self,args=obj.properties}
                table.insert(self.objects, newobj)
            else
                table.insert(self.objects, obj)
            end
        end
    end
end
function _layer:SearchObjects(name,value,onlyone)
    if not self.objects then return nil end
    local results = {}
    for _,obj in ipairs(self.objects) do
        if obj[name] == value then
            if onlyone then
                return obj
            else
                table.insert(results, obj)
            end
        end
    end
    return results
end

return _map