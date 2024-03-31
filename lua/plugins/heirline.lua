return {
	"rebelot/heirline.nvim",
	event = "BufReadPre",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"cbochs/grapple.nvim",
	},
	config = function()
		local conditions = require("heirline.conditions")
		local utils = require("heirline.utils")
		local colors = require("config/colors")
		require("heirline").load_colors(colors)

		local icons = true

		-- HELPERS
		local spacer = { provider = " " }

		local align = { provider = "%=" }

		local cut = { provider = "%<" }

		local o = { provider = "[" }

		local c = { provider = "]" }

		-- MODE
		local mode_name = {
			n = "NORMAL",
			no = "OPERATOR-PENDING",
			nov = "OPERATOR-PENDING VISUAL",
			noV = "OPERATOR-PENDING VISUAL LINE",
			["no\22"] = "OPERATOR-PENDING VISUAL BLOCK",
			niI = "NORMAL INSERT",
			niR = "NORMAL REPLACE",
			niV = "NORMAL VIRTUAL",
			nt = "TERMINAL",
			v = "VISUAL",
			vs = "VISUAL SELECT",
			V = "VISUAL LINE",
			Vs = "VISUAL LINE SELECT",
			["\22"] = "VISUAL BLOCK",
			["\22s"] = "VISUAL BLOCK SELECT",
			s = "SELECT",
			S = "SELECT LINE",
			["\19"] = "SELECT BLOCK",
			i = "INSERT",
			ic = "INSERT COMPLETION",
			ix = "INSERT XTERM",
			R = "REPLACE",
			Rc = "REPLACE COMPLETION",
			Rx = "REPLACE XTERM",
			Rv = "VIRTUAL REPLACE",
			Rvc = "VIRTUAL REPLACE COMPLETION",
			Rvx = "VIRTUAL REPLACE XTERM",
			c = "COMMAND-LINE",
			cv = "EX MODE",
			r = "HIT-ENTER PROMPT",
			rm = "MORE PROMPT",
			["r?"] = "CONFIRM",
			["!"] = "SHELL or EXTERNAL COMMAND",
			t = "TERMINAL",
		}

		local mode_info = function()
			local mode = vim.fn.mode(1)
			local letter = mode:sub(1, 1)
			local name = mode_name[mode]
			local color = colors.mode[mode]

			return {
				mode = mode,
				letter = letter,
				name = name,
				color = color,
			}
		end

		local vim_mode = {
			init = function(self)
				self.mode_info = mode_info()
			end,
			provider = function(self)
				return "%2(" .. self.mode_info.name .. "%)"
			end,
			hl = function(self)
				return { fg = self.mode_info.color, bg = colors.base.none, bold = true }
			end,
			update = {
				"ModeChanged",
				pattern = "*:*",
				callback = vim.schedule_wrap(function()
					vim.cmd("redrawstatus")
				end),
			},
		}

		-- FILE
		local file_name_block = {
			init = function(self)
				self.filename = vim.api.nvim_buf_get_name(0)
			end,
			hl = function()
				return { fg = colors.fg, bg = colors.base.none }
			end,
		}

		local file_icon = {
			init = function(self)
				local filename = self.filename
				local extension = vim.fn.fnamemodify(filename, ":e")
				self.icon, self.icon_color =
					require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
			end,
			provider = function(self)
				return self.icon and (self.icon .. " ")
			end,
			hl = function(self)
				return { fg = self.icon_color, bg = colors.base.none }
			end,
		}

		local file_name = {
			provider = function(self)
				local filename = vim.fn.fnamemodify(self.filename, ":.")
				if filename == "" then
					return "[No Name]"
				end
				-- See Flexible Components section for dynamic truncation
				if not conditions.width_percent_below(#filename, 0.25) then
					filename = vim.fn.pathshorten(filename)
				end
				return "[" .. filename .. "]"
			end,
			hl = function()
				return { fg = colors.base.brown, bg = colors.base.none, bold = true, force = true }
			end,
		}

		local file_name_modifier = {
			hl = function()
				if vim.bo.modified then
					return { fg = colors.base.pink_dark, bg = colors.base.none, bold = true, force = true }
				elseif vim.bo.readonly or not vim.bo.modifiable then
					return { fg = colors.base.red, bg = colors.base.none, bold = true, force = true }
				end
			end,
		}

		file_name_block = utils.insert(
			file_name_block,
			file_icon,
			utils.insert(file_name_modifier, file_name),
			{ provider = "%<" } -- this means that the statusline is cut here when there's not enough space
		)

		-- FILE TYPE
		local file_type = {
			provider = function()
				return string.upper(vim.bo.filetype)
			end,
			hl = function()
				return { fg = mode_info().color, bg = colors.base.none }
			end,
		}

		-- FILE ENCODING
		local file_encoding = {
			provider = function()
				local x = vim.bo.fenc
				if x ~= "" then
					return " " .. x:upper()
				end
			end,
			hl = function()
				return { fg = colors.base.blue_dark, bg = colors.base.none }
			end,
		}

		-- FILE FORMAT
		local file_format = {
			provider = function()
				local x = vim.bo.fileformat
				-- Override, this is ambiguous
				local icons = false
				if x ~= "" then
					if icons then
						if x == "unix" then
							return " "
						else
							return " "
						end
					end

					return " " .. x:upper()
				end
			end,
			hl = function()
				return { fg = colors.base.green, bg = colors.base.none, bold = true }
			end,
		}

		-- FILE SIZE
		local file_size = {
			provider = function()
				local suffix = { "B", "KB", "MB", "GB", "TB", "PB", "EB" }
				local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))

				fsize = (fsize < 0 and 0) or fsize

				if fsize == 0 or fsize == nil then
					return nil
				end

				if fsize < 1024 then
					return fsize .. suffix[1]
				end
				local i = math.floor((math.log(fsize) / math.log(1024)))
				return string.format(" %.2g%s", fsize / math.pow(1024, i), suffix[i + 1])
			end,
			hl = function()
				return { fg = colors.base.orange_light, bg = colors.base.none, bold = true }
			end,
		}

		-- FILE LAST MODIFIED
		local file_last_modified = {
			-- did you know? Vim is full of functions!
			provider = function()
				local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
				return (ftime > 0) and os.date("%c", ftime)
			end,
			hl = { bg = colors.base.none, bold = true },
		}

		-- RULER
		local ruler = {
			-- %l = current line number
			-- %L = number of lines in the buffer
			-- %c = column number
			-- %P = percentage through file of displayed window

			static = {
				--sbar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" },
				sbar = {
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
					"",
				},
			},
			provider = function(self)
				local curr_line = vim.api.nvim_win_get_cursor(0)[1]
				local lines = vim.api.nvim_buf_line_count(0)
				local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
				return "(%c) [%l/%L] " .. string.rep(self.sbar[i], 1) .. " "
			end,
			hl = function()
				return { fg = colors.base.orange_light, bg = colors.base.none, bold = true }
			end,
		}

		-- GIT
		local git = {
			condition = conditions.is_git_repo,
			init = function(self)
				self.status_dict = vim.b.gitsigns_status_dict
				self.has_changes = self.status_dict.added ~= nil
					or self.status_dict.removed ~= nil
					or self.status_dict.changed ~= nil
			end,

			hl = { fg = colors.base.blue_light, bg = colors.base.none, bold = true },

			{ -- git branch name
				provider = function(self)
					return " " .. "[" .. self.status_dict.head .. "]"
				end,
				hl = { bold = true },
			},
			{
				provider = function(self)
					local count = self.status_dict.added or 0
					if count > 0 then
						if icons then
							return "  " .. count
						else
							return " + " .. count
						end
					end
				end,
				hl = { fg = utils.get_highlight("DiffAdd").fg },
			},
			{
				provider = function(self)
					local count = self.status_dict.removed or 0
					if count > 0 then
						if icons then
							return "  " .. count
						else
							return " - " .. count
						end
					end
				end,
				hl = { fg = utils.get_highlight("DiffDelete").fg },
			},
			{
				provider = function(self)
					local count = self.status_dict.changed or 0
					if count > 0 then
						if icons then
							return "  " .. count
						else
							return " ~ " .. count
						end
					end
				end,
				hl = { fg = utils.get_highlight("DiffChange").fg },
			},
		}

		-- LSP
		local lsp = {
			condition = conditions.lsp_attached,
			update = { "LspAttach", "LspDetach" },

			-- You can keep it simple,
			-- provider = " [LSP]",

			-- Or complicate things a bit and get the servers names
			provider = function()
				local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return nil
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return " " .. "[" .. client.name .. "]"
					end
				end
			end,
			hl = { fg = colors.base.pink_dark, bg = colors.base.none, bold = true },
		}

		-- DIAGNOSTICS
		local diagnostics = {
			condition = conditions.has_diagnostics,

			static = {
				error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
				warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
				info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
				hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
			},

			init = function(self)
				self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
				self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
				self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
				self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			end,

			update = { "DiagnosticChanged", "BufEnter" },

			{
				provider = function(self)
					return self.info > 0 and (" " .. self.info_icon .. self.info .. " ")
				end,
				hl = { fg = colors.base.green, bg = colors.base.none, bold = true },
			},
			{
				provider = function(self)
					return self.hints > 0 and (" " .. self.hint_icon .. self.hints)
				end,
				hl = { fg = colors.base.blue_light, bg = colors.base.none, bold = true },
			},
			{
				provider = function(self)
					-- 0 is just another output, we can decide to print it or not!
					return self.errors > 0 and (" " .. self.error_icon .. self.errors .. " ")
				end,
				hl = { fg = colors.base.red, bg = colors.base.none, bold = true },
			},
			{
				provider = function(self)
					return self.warnings > 0 and (" " .. self.warn_icon .. self.warnings .. " ")
				end,
				hl = { fg = colors.base.orange_dark, bg = colors.base.none, bold = true },
			},
		}

		-- DEBUG
		local debug = {
			condition = function()
				local session = require("dap").session()
				return session ~= nil
			end,
			provider = function()
				return " " .. "[" .. require("dap").status() .. "]"
			end,
			hl = { fg = colors.base.blue_dark, bg = colors.base.none, bold = true },
		}

		-- WORKING DIRECTORY
		local work_dir = {
			provider = function()
				local icon = " "
				local cwd = vim.fn.getcwd(0)
				cwd = vim.fn.fnamemodify(cwd, ":~")
				if not conditions.width_percent_below(#cwd, 0.25) then
					cwd = vim.fn.pathshorten(cwd)
				end
				local trail = cwd:sub(-1) == "/" and "" or "/"
				return icon .. "[" .. cwd .. trail .. "]"
			end,
			hl = { fg = colors.base.purple_light, bg = colors.base.none, bold = true },
		}

		-- DATE TIME
		local date_time = {
			provider = function()
				return os.date("%Y-%m-%d %I:%M:%S %p")
			end,
			hl = { fg = colors.base.purple_light, bg = colors.base.none, bold = true },
		}
		local function startTimerOnSecondDivisibleBy(updateRateInSeconds)
			local currentTime = os.date("*t")
			local currentSecond = currentTime.sec
			local millisecondsTillNextDivisibleSecond = (
				(updateRateInSeconds - (currentSecond % updateRateInSeconds)) % updateRateInSeconds
			) * 1000
			if millisecondsTillNextDivisibleSecond == 0 then
				millisecondsTillNextDivisibleSecond = updateRateInSeconds * 1000
			end
			vim.fn.timer_start(millisecondsTillNextDivisibleSecond, function()
				vim.cmd("redrawstatus")
			end, { ["repeat"] = -1 })
		end
		startTimerOnSecondDivisibleBy(1)

		-- GRAPPLE
		local grapple = {
			provider = function()
				local value = require("grapple").name_or_index()
				if value == "" then
					return nil
				end
				return " " .. "[" .. value .. "]"
			end,
			condition = function()
				return require("grapple").exists()
			end,
			hl = { fg = colors.base.purple_light, bg = colors.base.none, bold = true },
		}

		-- MEMES
		local meme = {
			provider = "Feet Pics: 57.6TB",
			hl = { fg = colors.base.brown, bold = true },
		}

		-- INIT
		require("heirline").setup({
			statusline = {
				spacer,
				vim_mode,
				spacer,
				file_name_block,
				spacer,
				work_dir,
				spacer,
				file_size,
				spacer,
				file_encoding,
				spacer,
				file_format,

				align,
				git,
				spacer,
				lsp,
				spacer,
				debug,
				diagnostics,

				align,
				grapple,
				spacer,
				ruler,
				spacer,
				date_time,
				spacer,
			},
			winbar = nil,
			--tabline = { ... },
			--statuscolumn = { ... },
		})
	end,
}
