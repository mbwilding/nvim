-- LuaSnip is a Lua based snippet system

return {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v2.*",
    opts = {},
    config = function(_, opts)
        local luasnip = require("luasnip")
        luasnip.config.setup(opts)

        local s = luasnip.snippet
        local sn = luasnip.snippet_node
        local t = luasnip.text_node
        local i = luasnip.insert_node
        local f = luasnip.function_node
        local c = luasnip.choice_node
        local d = luasnip.dynamic_node
        local r = luasnip.restore_node
        luasnip.add_snippets("rust", {
            -- s("struct", {
            --     t({ "#[derive(Debug)]", "struct " }), i(1, "Name"), t({ " {", "\t" }), i(2, "field"), t({ ": "}), i(3, "Type"), t({ "", "}" }),
            -- }),
            s("impl-struct", {
                t({ "impl " }),
                i(1, "Name"),
                t({ " {", "\tpub fn new() -> Self {", "\t\tSelf {", "\t\t\t" }),
                i(2, "// init_fields"),
                t({ "", "\t\t}", "\t}", "}" }),
            }),
        })
    end
}
