return {
	"goolord/alpha-nvim",
	requires = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		local alpha = require 'alpha'
		local startify = require 'alpha.themes.startify'

		startify.section.header.val = {
			"                                                   ",
			"██╗    ██╗██╗██╗     ██████╗ ██╗███╗   ██╗ ██████╗ ",
			"██║    ██║██║██║     ██╔══██╗██║████╗  ██║██╔════╝ ",
			"██║ █╗ ██║██║██║     ██║  ██║██║██╔██╗ ██║██║  ███╗",
			"██║███╗██║██║██║     ██║  ██║██║██║╚██╗██║██║   ██║",
			"╚███╔███╔╝██║███████╗██████╔╝██║██║ ╚████║╚██████╔╝",
			" ╚══╝╚══╝ ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ ",
		}

		alpha.setup(startify.config)
	end
}
