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
  nextobjectid = 81,
  properties = {
    ["DEBUG"] = false,
    ["crate"] = 2,
    ["dialog_name"] = "none",
    ["level_name"] = "double blockade",
    ["orb"] = 1,
    ["platform"] = 2,
    ["springboard"] = 1
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
        0, 0, 0, 0, 0, 0, 23, 23, 23, 23, 23, 23, 23, 23, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 39, 39, 39, 39, 39, 39, 39, 39, 0, 0, 0, 18, 18, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 18, 0,
        0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        23, 23, 23, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 23, 23, 23,
        23, 23, 23, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 23, 23, 23,
        23, 23, 23, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 23, 23, 23,
        23, 23, 23, 23, 24, 66, 0, 0, 0, 52, 52, 52, 0, 0, 66, 22, 23, 23, 23, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 18, 0,
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
        18, 19, 18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18, 18,
        18, 19, 18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 1, 3, 18,
        18, 19, 18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 33, 35, 18,
        34, 35, 18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18, 18,
        18, 18, 18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18, 18,
        18, 18, 18, 18, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18, 18,
        34, 34, 34, 34, 21, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 20, 34, 34, 34, 34,
        0, 0, 0, 0, 17, 19, 0, 0, 0, 0, 0, 0, 0, 0, 17, 19, 0, 0, 0, 0,
        0, 0, 0, 0, 33, 35, 0, 0, 0, 0, 0, 0, 0, 0, 33, 35, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0,
        69, 68, 69, 69, 69, 69, 68, 69, 69, 69, 69, 69, 68, 68, 69, 69, 69, 69, 69, 68,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 1, 2, 3, 18,
        18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 18, 19, 18,
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
          y = 160,
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
          y = 160,
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
          y = 176,
          width = 320,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 73,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 224,
          y = 112,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 64,
          y = 112,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 224,
          y = 0,
          width = 96,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 96,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 236,
          y = 144,
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
          id = 78,
          name = "",
          type = "key",
          shape = "rectangle",
          x = 192,
          y = 32,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "yellow"
          }
        },
        {
          id = 79,
          name = "",
          type = "door",
          shape = "rectangle",
          x = 228,
          y = 144,
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
          id = 80,
          name = "",
          type = "key",
          shape = "rectangle",
          x = 144,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["color"] = "red"
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
          x = 128,
          y = 48,
          width = 32,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
