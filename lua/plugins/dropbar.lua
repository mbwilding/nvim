return {
	"Bekaboo/dropbar.nvim",
	dev = true,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- Build command adjusted to use 'make' if available, otherwise 'cmake'
			build = function()
				if vim.fn.executable("make") == 1 then
					return "make"
				elseif vim.fn.executable("cmake") == 1 then
					return
					"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
				else
					error("Neither 'make' nor 'cmake' are available for building telescope-fzf-native.nvim")
				end
			end,
			-- This plugin is conditionally loaded if either 'make' or 'cmake' is available
			cond = function()
				return vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1
			end,
		},
	},
	opts = {
		sources = {
			path = {
				max_depth = 16,
			},
			treesitter = {
				max_depth = 0,
			},
			lsp = {
				max_depth = 0,
			},
			markdown = {
				max_depth = 0,
			},
			terminal = {
				show_current = false,
			},
		},
		bar = {
			enable = function(buf, win, _)
				if
					not vim.api.nvim_buf_is_valid(buf)
					or not vim.api.nvim_win_is_valid(win)
					or vim.fn.win_gettype(win) ~= ''
					or vim.wo[win].winbar ~= ''
					or vim.bo[buf].ft == 'help'
				then
					return false
				end

				local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
				if stat and stat.size > 1024 * 1024 then
					return false
				end

				local ft = vim.bo[buf].ft
				return ft == "markdown"
					or ft == "oil"
					or pcall(vim.treesitter.get_parser, buf)
					or not vim.tbl_isempty(vim.lsp.get_clients({
						bufnr = buf,
						method = "textDocument/documentSymbol",
					}))
			end,
		},
	},
}
