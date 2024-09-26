-- Autopairs automatically closes brackets, quotes, etc and puts you in the middle of them.

return {
	"windwp/nvim-autopairs",
	dependencies = { "hrsh7th/nvim-cmp" },
	event = "InsertEnter",
	config = function()
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		require("nvim-autopairs").setup({
			check_ts = true, -- Enable treesitter
			ts_config = {
				lua = { "string" },
				javascript = { "template_string" },
				-- java = false, -- Don't check treesitter on Java
			},
		})

		local pairs = require("nvim-autopairs")
		local rule = require("nvim-autopairs.rule")
		local cond = require("nvim-autopairs.conds")

		-- https://github.com/windwp/nvim-autopairs/wiki/Rules-API/
		pairs.add_rules({
			pairs.add_rule(rule("<", ">"):with_pair(cond.not_before_regex(" ", 1))),
		})
	end,
}
