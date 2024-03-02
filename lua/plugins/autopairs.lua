return {
    'windwp/nvim-autopairs',
    dependencies = { 'hrsh7th/nvim-cmp' },
    --event = "InsertEnter",
    config = function()
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp = require("cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        require("nvim-autopairs").setup({
            check_ts = true,                        -- Enable treesitter
            ts_config = {
                lua = { "string" },                 -- Don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- Don't add pairs in JavaScript template_string treesitter nodes
                -- java = false, -- Don't check treesitter on Java
            }
        })

        local npairs = require("nvim-autopairs")
        local Rule = require("nvim-autopairs.rule")
        local cond = require("nvim-autopairs.conds")

        -- https://github.com/windwp/nvim-autopairs/wiki/Rules-API/

        npairs.add_rules({
            -- Angle brackets
            npairs.add_rule(
                Rule("<", ">")
                :with_pair(cond.not_before_regex(" ", 1))
            ),
        })
    end,
}
