return {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
        enabled = true, -- if you want to enable the plugin
        message_template = " <summary> • <date> • <author> • <<sha>>",
        date_format = "%m-%d-%Y %H:%M:%S",
        virtual_text_column = 1,
        delay = 3000;
    },
}
