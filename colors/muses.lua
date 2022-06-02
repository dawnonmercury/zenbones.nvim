local colors_name = "muses"
vim.g.colors_name = muses -- Required when defining a colorscheme

local lush = require "lush"
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require "zenbones.util"

local bg = vim.opt.background:get()

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
	palette = util.palette_extend({
		bg = hsluv "#fbf1c7",
		fg = hsluv "#3c3836",
		rose = hsluv "#9d0006",
		leaf = hsluv "#79740e",
		wood = hsluv "#b57614",
		water = hsluv "#076678",
		blossom = hsluv "#8f3f71",
		sky = hsluv "#427b58",
	}, bg)
else
	palette = util.palette_extend({
		bg = hsluv "#181818",
		fg = hsluv "#f3efed",
		rose = hsluv "#ff7eb6",
		leaf = hsluv "#76df9a",
		wood = hsluv "#dada99",
		water = hsluv "#88aaff",
		blossom = hsluv "#be95cc",
		sky = hsluv "#85adad",
		storm = hsluv "#883443",
		depths = hsluv "#445577",
		chaos = hsluv "#435656",
	}, bg)
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
		Constant { bg = palette.chaos, gui = "bold" },
	}
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
