return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "2021.02.15",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 16,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 6,
  nextobjectid = 32,
  properties = {
    ["bluekey"] = 99,
    ["crate"] = 99,
    ["dialog_name"] = "none",
    ["greenkey"] = 99,
    ["level_name"] = "test level",
    ["orb"] = 99,
    ["platform"] = 99,
    ["redkey"] = 99,
    ["springboard"] = 99,
    ["yellowkey"] = 99
  },
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 16,
      image = "../graphics/tiles.png",
      imagewidth = 256,
      imageheight = 256,
      objectalignment = "unspecified",
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
      terrains = {},
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
        0, 0, 66, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0,
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82,
        0, 0, 65, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82,
        68, 69, 69, 69, 68, 69, 69, 52, 52, 69, 69, 69, 68, 68, 69, 69, 69, 69, 69, 82,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 1, 2, 2, 2, 3, 18,
        2, 2, 2, 2, 3, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 18, 18, 18, 19, 18
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "Allow",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 10,
          name = "",
          type = "place_allow",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 320,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Objects",
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
          y = 112,
          width = 4,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 160,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "yellow",
            ["dir"] = "ver"
          }
        },
        {
          id = 23,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 176,
          y = 176,
          width = 16,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "red",
            ["dir"] = "ver"
          }
        },
        {
          id = 24,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 192,
          y = 176,
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
          id = 25,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 208,
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
          id = 28,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 176,
          y = 48,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "yellow",
            ["dir"] = "hor"
          }
        },
        {
          id = 29,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 176,
          y = 64,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "red",
            ["dir"] = "hor"
          }
        },
        {
          id = 30,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 176,
          y = 80,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "green",
            ["dir"] = "hor"
          }
        },
        {
          id = 31,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 176,
          y = 96,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "blue",
            ["dir"] = "hor"
          }
        }
      }
    }
  }
}
