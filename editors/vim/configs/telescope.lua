return {
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
}
