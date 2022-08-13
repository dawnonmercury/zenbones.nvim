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
		fg = hsluv "#484141",
		rose = hsluv "#dd4576",
		leaf = hsluv "#65ac57",
		wood = hsluv "#baba37",
		water = hsluv "#5566aa",
		blossom = hsluv "#9a46aa",
		sky = hsluv "#56abab",
		storm = hsluv "#d2c9c9",
	}, "light")
else
	palette = util.palette_extend({
		bg = hsluv "#181818",
		fg = hsluv "#c4bcb9",
		rose = hsluv "#bb4566",
		leaf = hsluv "#54ac8b",
		wood = hsluv "#a9a933",
		water = hsluv "#3366bb",
		blossom = hsluv "#9243aa",
		sky = hsluv "#578989",
		storm = hsluv "#2f2929",
	}, "dark")
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { base_specs.Statement, bg = palette.storm, gui = "italic" },
		Special { bg = palette.storm },
		Type { bg = palette.storm, gui = "underline" },
		Identifier { gui = "regular" },
	}
end)

-- Pass the specs to lush to apply
lush(specs)
