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
  nextobjectid = 27,
  properties = {
    ["crate"] = 2,
    ["dialog_name"] = "level4",
    ["dialog_spike_hit"] = "level4_dumb",
    ["level_name"] = "fork in the path",
    ["platform"] = 1,
    ["springboard"] = 0
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 18, 0, 0, 18, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 43, 27,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 6, 7,
        23, 23, 23, 23, 23, 23, 23, 0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 22, 23,
        39, 39, 39, 39, 39, 39, 39, 0, 0, 39, 40, 0, 0, 0, 0, 0, 0, 0, 22, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 22, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 18, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 43, 0, 0, 0, 18, 0,
        28, 27, 28, 44, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 6, 0, 0, 0, 0, 0,
        7, 7, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 66, 22, 0, 0, 0, 0, 0,
        23, 23, 23, 24, 0, 0, 0, 52, 66, 0, 0, 0, 0, 66, 22, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 18, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 18, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
        18, 18, 18, 17, 18, 18, 19, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        18, 18, 18, 33, 34, 34, 35, 18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52,
        34, 34, 34, 34, 34, 34, 34, 21, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 17, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 82, 17, 19, 83, 0, 0, 0, 101, 102, 103, 69, 68, 69, 68,
        0, 0, 0, 0, 0, 0, 82, 17, 19, 83, 0, 0, 0, 65, 51, 1, 2, 2, 2, 2,
        0, 0, 0, 0, 0, 0, 82, 17, 19, 83, 0, 0, 0, 0, 0, 17, 18, 18, 1, 2,
        0, 0, 0, 0, 0, 0, 82, 33, 35, 83, 0, 0, 0, 0, 0, 17, 18, 18, 33, 34,
        52, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18,
        0, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 17, 18, 18, 18, 18,
        68, 69, 69, 69, 69, 69, 68, 69, 69, 69, 69, 69, 68, 68, 69, 17, 18, 18, 18, 18,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 37, 1, 2, 3, 18,
        18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 18, 19, 18,
        18, 18, 1, 2, 3, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 17, 18, 19, 18,
        18, 18, 17, 18, 19, 18, 18, 18, 18, 18, 18, 18, 1, 2, 2, 2, 17, 18, 19, 2,
        18, 18, 17, 18, 19, 18, 18, 18, 18, 18, 18, 18, 17, 18, 18, 18, 17, 18, 19, 18
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
          x = 280,
          y = 64,
          width = 16,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["startleft"] = true
          }
        },
        {
          id = 6,
          name = "",
          type = "exit",
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
          id = 8,
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
          id = 22,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 240,
          y = 80,
          width = 80,
          height = 96,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 144,
          height = 128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          type = "spike",
          shape = "rectangle",
          x = 144,
          y = 64,
          width = 4,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 208,
          y = 80,
          width = 32,
          height = 4,
          rotation = 0,
          visible = true,
          properties = {
            ["oneway"] = "up"
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
          id = 18,
          name = "",
          type = "place_allow",
          shape = "rectangle",
          x = 160,
          y = 64,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
