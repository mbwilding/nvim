vim.g.projectionist_heuristics = {
    -- TypeScript
    ["tsconfig.json"] = {
        ["*.test.ts"] = {
            type = "test",
            alternate = {
                "{}.ts",
                "{}.tsx",
            },
        },
        ["*.test.tsx"] = {
            type = "test",
            alternate = {
                "{}.ts",
                "{}.tsx",
            },
        },
        ["*.ts"] = {
            type = "source",
            alternate = {
                "{}.test.ts",
                "{}.test.tsx",
                "{}.stories.tsx",
            },
        },
        ["*.tsx"] = {
            type = "source",
            alternate = {
                "{}.test.ts",
                "{}.test.tsx",
                "{}.stories.tsx",
            },
        },
        ["*.stories.tsx"] = {
            type = "source",
            alternate = {
                "{}.tsx",
            },
        },
    },
    -- Unreal Engine (CPP)
    ["compile_commands.json"] = {
        ["Source/{}.cpp"] = {
            type = "source",
            alternate = {
                "Source/{}.h",
            },
        },
        ["Source/{}.h"] = {
            type = "header",
            alternate = {
                "Source/{}.cpp",
            },
        },
    },
}

return {
    "tpope/vim-projectionist",
    dependencies = {
        "tpope/vim-dispatch",
    },
    keys = {
        {
            "<leader>af",
            mode = { "n" },
            "<CMD>A<CR>",
            desc = "Projectionist: Alternate File",
        },
        {
            "<leader>as",
            mode = { "n" },
            "<CMD>AS<CR>",
            desc = "Projectionist: Alternate File Horizontal Split",
        },
        {
            "<leader>av",
            mode = { "n" },
            "<CMD>AV<CR>",
            desc = "Projectionist: Alternate File Vertical Split",
        },
    },
}
