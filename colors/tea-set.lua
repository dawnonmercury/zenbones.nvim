vim.g.colors_name = "tea-set" -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.opt.background:get()

-- Define a palette. Use `palette_extend` to fill unspecified colors
local palette
if bg == "light" then
	palette = util.palette_extend({
		bg = hsluv "#ede6e3",
		fg = hsluv "#6c605a",
		rose = hsluv "#d65c5c",
		leaf = hsluv "#7ab87a",
		wood = hsluv "#d99d26",
		water = hsluv "#4d6eb3",
		blossom = hsluv "#b87ab8",
		sky = hsluv "#669999",
		c0 = hsluv "#e3d0cb",
		c1 = hsluv "#b6a8a2",
		c2 = hsluv "#e6dad6",
	}, "light")
else
	palette = util.palette_extend({
		bg = hsluv "#2a2a2a",
		fg = hsluv "#bebebe",
		rose = hsluv "#b34d4d",
		leaf = hsluv "#669966",
		wood = hsluv "#f7c96e",
		water = hsluv "#94a8d1",
		blossom = hsluv "#ad85ad",
		sky = hsluv "#85adad",
		c0 = hsluv "#4a4a4a",
		c1 = hsluv "#655e56",
		c2 = hsluv "#3a3a3a",
	}, "dark")
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config("tea-set", bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { base_specs.Statement, fg = palette.fg, gui = "bold" },
		Special { fg = palette.fg, gui = "italic" },
		Identifier { fg = palette.fg, bg = palette.c2 },
		Type { fg = palette.fg, gui = "bold" },
		Constant { fg = palette.fg, bg = palette.c0 },
		Comment { fg = palette.c1 },
		LineNr { fg = Comment.fg },
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
-- require("zenbones.term").apply_colors(palette)
