local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {

	-- Override plugin definition options
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lsp.lspconfig")
		end,
	},
	-- overrde plugin configs
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	-- Install a plugin
	{
		"nvimtools/none-ls.nvim", -- configure formatters & linters
		lazy = true,
		-- event = { "BufReadPre", "BufNewFile" }, -- to enable uncomment this
		config = function()
			require("custom.configs.lsp.none-ls")
		end,
	},
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		config = function()
			require("custom.configs.incline")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("dapui").setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("custom.configs.dap")
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			require("custom.configs.formatting")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
		config = function()
			require("custom.configs.linting")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		lazy = true,
		event = "InsertEnter",
		config = true,
	},
	{
		"NTBBloodbath/rest.nvim",
		ft = "http",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("custom.configs.rest")
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"MunifTanjim/nui.nvim",
			},
			{
				"rcarriga/nvim-notify",
				config = function()
					require("notify").setup({
						render = "minimal",
					})
				end,
			},
		},
		config = function()
			require("noice").setup({
				lsp = {
					signature = {
						enabled = false,
					},
					hover = {
						enabled = false,
					},
					progress = {
						enabled = false,
					},
				},
			})
		end,
	},
	--[[ 
 ]]
	{
		"axelvc/template-string.nvim",
		lazy = true,
		event = { "BufReadPre" },
		config = true,
	},
	{
		"Exafunction/codeium.vim",
		event = "BufEnter",
	},
	{
		"mg979/vim-visual-multi",
		event = "BufRead",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
		enabled = true,
		opts = { mode = "cursor", max_lines = 3 },
		keys = {
			{
				"<leader>ut",
				function()
					local Util = require("lazyvim.util")
					local tsc = require("treesitter-context")
					tsc.toggle()
					if Util.inject.get_upvalue(tsc.toggle, "enabled") then
						Util.info("Enabled Treesitter Context", { title = "Option" })
					else
						Util.warn("Disabled Treesitter Context", { title = "Option" })
					end
				end,
				desc = "Toggle Treesitter Context",
			},
		},
	},
	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- Uncomment if you want to re-enable which-key
	-- {
	--   "folke/which-key.nvim",
	--   enabled = true,
	-- },
	{
		"nvim-telescope/telescope.nvim",
		opts = function()
			return require("plugins.configs.telescope")
		end,
		config = function(_, opts)
			dofile(vim.g.base46_cache .. "telescope")
			local telescope = require("telescope")
			telescope.setup(opts)
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			-- load extensions
			for _, ext in ipairs(opts.extensions_list) do
				telescope.load_extension(ext)
			end
			opts.extensions = {

				file_browser = {
					theme = "dropdown",
					-- disables netrw and use telescope-file-browser in its place
					-- hijack_netrw = true,
					mappings = {
						-- your custom insert mode mappings
						["n"] = {
							-- your custom normal mode mappings
							["N"] = fb_actions.create,
							["h"] = fb_actions.goto_parent_dir,
							["/"] = function()
								vim.cmd("startinsert")
							end,
							["<C-u>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_previous(prompt_bufnr)
								end
							end,
							["<C-d>"] = function(prompt_bufnr)
								for i = 1, 10 do
									actions.move_selection_next(prompt_bufnr)
								end
							end,
							["<PageUp>"] = actions.preview_scrolling_up,
							["<PageDown>"] = actions.preview_scrolling_down,
						},
					},
				},
			}
			telescope.setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
			require("plugins.configs.telescope")
			require("custom.configs.telescope")
		end,
		keys = {
			{
				"<leader>fP",
				function()
					require("telescope.builtin").find_files({
						cwd = "~/.config/nvim/lua/custom/",
					})
				end,
				desc = "Find Plugin File",
			},
			{
				"sf",
				function()
					local telescope = require("telescope")

					local function telescope_buffer_dir()
						return vim.fn.expand("%:p:h")
					end

					telescope.extensions.file_browser.file_browser({
						path = "%:p:h",
						cwd = telescope_buffer_dir(),
						respect_gitignore = false,
						hidden = true,
						grouped = true,
						previewer = false,
						initial_mode = "normal",
						layout_config = { height = 40 },
					})
				end,
				desc = "Open File Browser with the path of the current buffer",
			},
		},
		dependencies = {
			"nvim-telescope/telescope-file-browser.nvim",
		},
	},
}

return plugins
