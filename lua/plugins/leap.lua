return {
    "ggandor/leap.nvim",
    dependencies = {
        "tpope/vim-repeat"
    },
    config = function()
        local leap = require("leap")
        leap.add_default_mappings()
        leap.opts.special_keys.prev_target = '<bs>'
        leap.opts.special_keys.prev_group = '<bs>'
        leap.opts.labels = "asonetuhidplyrfcgqzjvkwxmb"
        --leap.opts.safe_labels = {}
        require('leap.user').set_repeat_keys('<cr>', '<bs>')
    end
}
