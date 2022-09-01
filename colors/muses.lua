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
		rose = hsluv "#df2566",
		leaf = hsluv "#45ac57",
		wood = hsluv "#e0ad37",
		water = hsluv "#5566bf",
		blossom = hsluv "#9a46ba",
		sky = hsluv "#569aac",
		storm = hsluv "#e3dada",
	}, "light")
else
	palette = util.palette_extend({
		bg = hsluv "#181818",
		fg = hsluv "#c4aca9",
		rose = hsluv "#df2566",
		leaf = hsluv "#45ac57",
		wood = hsluv "#e0bd47",
		water = hsluv "#5576cf",
		blossom = hsluv "#9a46ba",
		sky = hsluv "#569aac",
		storm = hsluv "#2f2929",
	}, "dark")
end

-- Generate the lush specs using the generator util
local generator = require "zenbones.specs"
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
	return {
		Statement { bg = palette.storm, gui = "regular" },
		Special { base_specs.Special, gui = "italic" },
		Type { base_specs.Type, gui = "underline" },
		Identifier { base_specs.Identifier, bg = palette.storm },
	}
end)

-- Pass the specs to lush to apply
lush(specs)
