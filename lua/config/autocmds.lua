-- Helper func
local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})


-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+://") then
			return
		end
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Relative numbers group
augroup("NumberToggle")

-- Enabling relative numbers
vim.api.nvim_create_autocmd(
	{ "BufEnter", "FocusGained", "InsertLeave", "WinEnter", "BufWinEnter" },
	{
		group = "NumberToggle",
		pattern = "*",
		callback = function()
			if vim.wo.number then
				vim.wo.relativenumber = true
			end
		end
	}
)

-- Disabling relative numbers only when the buffer is not focused
vim.api.nvim_create_autocmd(
	{ "FocusLost", "BufLeave" },
	{
		group = "NumberToggle",
		pattern = "*",
		callback = function()
			if vim.wo.number then
				vim.wo.relativenumber = false
			end
		end,
	}
)

-- Set current line color to match mode color
local function adjustLineNrHighlight()
	local colors = require("config/colors")
	local mode_colors = require("config/colors-mode")

	-- Get the current mode
	local mode = vim.api.nvim_get_mode().mode

	-- Find the color for the current mode; default to white if not defined
	local color = mode_colors[mode] or colors.blue_light

	-- Adjust LineNr highlight group to the color for the current mode
	vim.cmd(string.format("highlight LineNr guifg=%s", color))
end

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = adjustLineNrHighlight,
})
