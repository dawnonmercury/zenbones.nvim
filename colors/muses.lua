local colors_name = "muses"
vim.g.colors_name = "muses" -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.opt.background:get()

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
	palette = util.palette_extend({
		bg = hsluv "#f3efed",
		fg = hsluv "#282828",
		rose = hsluv "#bb2354",
		leaf = hsluv "#549b46",
		wood = hsluv "#989825",
		water = hsluv "#334488",
		blossom = hsluv "#782488",
		sky = hsluv "#126767",
		storm = hsluv "#d2c2c2",
		depths = hsluv "#d5c5c5",
		chaos = hsluv "#d9c9c9",
	}, "light")
else
	palette = util.palette_extend({
		bg = hsluv "#181818",
		fg = hsluv "#f3efed",
		rose = hsluv "#bb4566",
		leaf = hsluv "#54ac8b",
		wood = hsluv "#a9a933",
		water = hsluv "#3366bb",
		blossom = hsluv "#9243aa",
		sky = hsluv "#578989",
		storm = hsluv "#545454",
		depths = hsluv "#494949",
		chaos = hsluv "#3b3b3b",
	}, "dark")
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { base_specs.Statement, bg = palette.storm },
		Special { bg = palette.depths },
		Type { bg = palette.chaos, gui = "italic" },
		Identifier { gui = "regular" },
	}
end)

-- Pass the specs to lush to apply
lush(specs)
