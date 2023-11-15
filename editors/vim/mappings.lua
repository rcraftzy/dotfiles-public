---@type MappingsTable
local M = {}

M.general = {
	n = {
		[";"] = { ":", "enter command mode", opts = { nowait = true } },
		-- ["<leader>w"] = { "<cmd> w <CR>", "save file" },
		-- ["<leader>q"] = { "<cmd> q <CR>", "save file" },
		["<C-q>"] = { "<cmd> q! <CR>", "save file" },
		["<C-s>"] = { "<cmd> w! <CR>", "save file" },
		--
		["<leader>nt"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
	},
}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add breakpoint at line",
		},
		["<leader>dr"] = {
			"<cmd> DapContinue <CR>",
			"Run or continue the debugger",
		},
	},
}
return M
