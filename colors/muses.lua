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
		rose = hsluv "#883443",
		leaf = hsluv "#436845",
		wood = hsluv "#656544",
		water = hsluv "#445577",
		blossom = hsluv "#674377",
		sky = hsluv "#435656",
		storm = hsluv "#c0b5b3",
		depth = hsluv "#d0ccca",
		chaos = hsluv "#d0bcba",
	}, "light")
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
		Identifier { bg = palette.chaos, gui = "regular" },
	}
end)

-- Pass the specs to lush to apply
lush(specs)
