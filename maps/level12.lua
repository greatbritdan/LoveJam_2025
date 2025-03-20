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
  nextobjectid = 105,
  properties = {
    ["DEBUG"] = false,
    ["crate"] = 0,
    ["dialog_name"] = "none",
    ["level_name"] = "drag and drop",
    ["orb"] = 0,
    ["platform"] = 0,
    ["springboard"] = 0,
    ["teleporterin"] = 1,
    ["teleporterout"] = 1
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
        0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 22, 23, 23, 23,
        18, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 22, 23, 23, 23,
        0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 22, 23, 23, 23,
        0, 0, 23, 24, 0, 0, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 22, 23, 23, 23,
        0, 0, 23, 24, 0, 0, 52, 0, 0, 0, 0, 66, 0, 0, 52, 52, 22, 23, 23, 23,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18,
        23, 23, 23, 24, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 0, 0,
        23, 23, 23, 24, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 0, 0,
        23, 23, 23, 24, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 0, 0, 22, 23, 0, 18,
        23, 23, 23, 24, 52, 0, 0, 66, 0, 0, 0, 0, 0, 52, 0, 0, 22, 23, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 18, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 18, 0, 0, 0, 0,
        0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
        19, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        35, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        18, 19, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        18, 19, 69, 68, 69, 69, 69, 69, 68, 68, 69, 69, 69, 69, 69, 69, 69, 69, 69, 68,
        18, 36, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 34, 21, 1,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 17,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 33,
        69, 69, 68, 69, 69, 69, 69, 69, 69, 68, 69, 68, 69, 69, 69, 69, 69, 68, 17, 18,
        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 37, 18,
        18, 18, 18, 18, 18, 18, 18, 1, 2, 3, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
        18, 18, 18, 18, 18, 18, 18, 17, 18, 19, 18, 18, 18, 18, 18, 1, 2, 2, 2, 2,
        2, 3, 18, 18, 18, 18, 18, 17, 18, 19, 18, 18, 18, 18, 18, 17, 18, 18, 18, 18,
        18, 19, 18, 18, 18, 18, 18, 17, 18, 19, 18, 18, 18, 18, 18, 17, 18, 18, 18, 18
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
          y = 64,
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
          id = 101,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 0,
          y = 80,
          width = 320,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 103,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 288,
          y = 112,
          width = 32,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 104,
          name = "",
          type = "ground",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 32,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
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
          id = 99,
          name = "",
          type = "place_allow",
          shape = "rectangle",
          x = 48,
          y = 48,
          width = 32,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 102,
          name = "",
          type = "place_allow",
          shape = "rectangle",
          x = 240,
          y = 144,
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
