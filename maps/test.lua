return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 16,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 6,
  nextobjectid = 44,
  properties = {
    ["DEBUG"] = true,
    ["dialog_name"] = "none",
    ["level_name"] = "test level"
  },
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      class = "",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../graphics/tiles.png",
      imagewidth = 256,
      imageheight = 256,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      wangsets = {},
      tilecount = 256,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 16,
      id = 5,
      name = "BackTiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 255, 255, 255 },
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 66, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 66, 0, 0, 0, 0, 82,
        0, 0, 66, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0,
        52, 0, 66, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 66, 0, 0, 0, 52, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 18, 0,
        0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 16,
      id = 1,
      name = "Tiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        33, 34, 35, 36, 37, 38, 39, 40, 41, 0, 43, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 106, 107, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 119, 120, 121, 122, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 132, 133, 134, 135, 136, 137, 138, 139, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 65, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82,
        68, 69, 69, 69, 68, 69, 0, 0, 52, 0, 69, 69, 68, 68, 69, 69, 69, 69, 69, 82,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        18, 0, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 2, 2, 2, 3, 18,
        2, 2, 2, 2, 3, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 18, 18, 18, 19, 18
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "Allow",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 4,
          name = "",
          type = "player",
          shape = "rectangle",
          x = 16,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "exit",
          shape = "rectangle",
          x = 280,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 0,
          y = 208,
          width = 320,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 32,
          y = 160,
          width = 288,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {
            ["oneway"] = "up"
          }
        },
        {
          id = 17,
          name = "",
          type = "spike",
          shape = "rectangle",
          x = 316,
          y = 160,
          width = 4,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "conveyorbelt",
          shape = "rectangle",
          x = 160,
          y = 144,
          width = 160,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["speed"] = -64
          }
        },
        {
          id = 38,
          name = "",
          type = "teleporter",
          shape = "rectangle",
          x = 66,
          y = 146,
          width = 12,
          height = 14,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = "boner",
            ["other"] = true
          }
        },
        {
          id = 39,
          name = "",
          type = "teleporter",
          shape = "rectangle",
          x = 66,
          y = 194,
          width = 12,
          height = 14,
          rotation = 0,
          visible = true,
          properties = {
            ["id"] = "boner",
            ["other"] = false
          }
        },
        {
          id = 40,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 240,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "blue",
            ["dir"] = "ver"
          }
        },
        {
          id = 41,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 240,
          y = 112,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "green",
            ["dir"] = "ver"
          }
        },
        {
          id = 42,
          name = "",
          type = "key",
          shape = "rectangle",
          x = 176,
          y = 112,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "green"
          }
        },
        {
          id = 43,
          name = "",
          type = "key",
          shape = "rectangle",
          x = 176,
          y = 176,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "blue"
          }
        }
      }
    }
  }
}
