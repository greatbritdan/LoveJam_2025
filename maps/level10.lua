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
  nextobjectid = 92,
  properties = {
    ["DEBUG"] = false,
    ["crate"] = 0,
    ["dialog_name"] = "none",
    ["level_name"] = "graceful descent",
    ["orb"] = 1,
    ["platform"] = 1,
    ["springboard"] = 1,
    ["yellowkey"] = 0
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
        23, 24, 0, 66, 0, 22, 23, 23, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 24, 0, 66, 0, 22, 23, 23, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 24, 0, 66, 0, 38, 39, 39, 39, 0, 0, 0, 18, 0, 18, 0, 23, 23, 23, 23,
        23, 24, 52, 66, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 23, 23, 23, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 22, 23, 23, 23, 23,
        0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 22, 23, 23, 23, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0,
        0, 18, 0, 0, 28, 28, 27, 27, 28, 28, 28, 28, 28, 28, 27, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 0, 18, 0, 18, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 17, 18, 19, 18, 18, 18, 18, 18,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 17, 18, 19, 20, 34, 34, 34, 34,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 33, 34, 35, 19, 0, 0, 0, 0,
        68, 69, 69, 85, 0, 0, 0, 0, 0, 33, 34, 34, 34, 34, 34, 35, 0, 0, 0, 0,
        2, 2, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        2, 3, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 101, 102, 103, 68, 69, 69, 68,
        18, 19, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 51, 1, 2, 2, 2, 2,
        18, 19, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 1, 2,
        18, 19, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 33, 34,
        34, 35, 18, 19, 52, 0, 0, 0, 0, 0, 0, 52, 52, 0, 0, 17, 18, 18, 18, 18,
        18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18,
        18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18,
        18, 18, 18, 19, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 81, 17, 1, 2, 3, 18,
        18, 18, 18, 36, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 37, 17, 18, 19, 18,
        2, 2, 2, 2, 3, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 18, 19, 18,
        18, 18, 18, 18, 19, 18, 18, 18, 18, 18, 18, 18, 18, 18, 1, 2, 17, 18, 19, 18
      }
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
          x = 24,
          y = 48,
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
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
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
          id = 81,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 0,
          y = 64,
          width = 64,
          height = 144,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 144,
          y = 0,
          width = 112,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 240,
          y = 96,
          width = 80,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 85,
          name = "",
          type = "spike",
          shape = "rectangle",
          x = 64,
          y = 204,
          width = 144,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 88,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 240,
          y = 64,
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
          id = 89,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 208,
          y = 96,
          width = 32,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {
            ["oneway"] = "up"
          }
        },
        {
          id = 90,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 256,
          y = 0,
          width = 64,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "",
          type = "key",
          shape = "rectangle",
          x = 176,
          y = 80,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "yellow"
          }
        }
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
      objects = {
        {
          id = 69,
          name = "",
          type = "place_allow",
          shape = "rectangle",
          x = 80,
          y = 64,
          width = 48,
          height = 48,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          type = "place_allow",
          shape = "rectangle",
          x = 160,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
