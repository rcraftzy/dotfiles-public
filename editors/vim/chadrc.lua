---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("custom.highlights")

M.ui = {
	theme_toggle = { "tokyodark", "one_light" },
	theme = "tokyodark",
	hl_override = highlights.override,
	hl_add = highlights.add,

	tabufline = {
		enabled = false,
	},
	transparency = false,
	cmp = {
		border_color = "red",
	},
	statusline = {
		theme = "vscode_colored", -- default/vscode/vscode_colored/minimal

		-- default/round/block/arrow (separators work only for "default" statusline theme;
		-- round and block will work for the minimal theme only)
		separator_style = "default",
	},
}
M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require("custom.mappings")

M.lazy_nvim = {}

return M
