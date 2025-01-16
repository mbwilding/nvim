return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
        -- "rcarriga/nvim-notify",
    },
    opts = {
        arg = "leetcode.nvim",
        lang = "rust",
        cn = {
            enabled = false,
            translator = true,
            translate_problems = true,
        },
        storage = {
            home = vim.fn.stdpath("data") .. "/leetcode",
            cache = vim.fn.stdpath("cache") .. "/leetcode",
        },
        plugins = {
            non_standalone = false,
        },
        logging = true,
        injector = {},
        cache = {
            update_interval = 60 * 60 * 24 * 7,
        },
        console = {
            open_on_runcode = true,
            dir = "row",
            size = {
                width = "90%",
                height = "75%",
            },
            result = {
                size = "60%",
            },
            testcase = {
                virt_text = true,
                size = "40%",
            },
        },
        description = {
            position = "left",
            width = "40%",
            show_stats = true,
        },
        hooks = {
            ["enter"] = {},
            ["question_enter"] = {
                function()
                    local file_extension = vim.fn.expand("%:e")
                    if file_extension == "rs" then
                        local target_dir = vim.fn.stdpath("data") .. "/leetcode"
                        local output_file = target_dir .. "/rust-project.json"

                        if vim.fn.isdirectory(target_dir) == 1 then
                            local crates = ""
                            local next = ""

                            local rs_files = vim.fn.globpath(target_dir, "*.rs", false, true)
                            for _, f in ipairs(rs_files) do
                                local file_path = f
                                crates = crates
                                    .. next
                                    .. "{\"root_module\": \""
                                    .. file_path
                                    .. "\",\"edition\": \"2021\",\"deps\": []}"
                                next = ","
                            end

                            if crates == "" then
                                print("No .rs files found in directory: " .. target_dir)
                                return
                            end

                            local sysroot_src = vim.fn.system("rustc --print sysroot"):gsub("\n", "")
                                .. "/lib/rustlib/src/rust/library"

                            local json_content = "{\"sysroot_src\": \""
                                .. sysroot_src
                                .. "\", \"crates\": ["
                                .. crates
                                .. "]}"

                            local file = io.open(output_file, "w")
                            if file then
                                file:write(json_content)
                                file:close()

                                local clients = vim.lsp.get_clients()
                                local rust_analyzer_attached = false
                                for _, client in ipairs(clients) do
                                    if client.name == "rust_analyzer" then
                                        rust_analyzer_attached = true
                                        break
                                    end
                                end

                                if rust_analyzer_attached then
                                    vim.cmd("LspRestart rust_analyzer")
                                end
                            else
                                print("Failed to open file: " .. output_file)
                            end
                        else
                            print("Directory " .. target_dir .. " does not exist.")
                        end
                    end
                end,
            },
            ["leave"] = {},
        },
        keys = {
            toggle = { "q" },
            confirm = { "<CR>" },
            reset_testcases = "r",
            use_testcase = "U",
            focus_testcases = "H",
            focus_result = "L",
        },
        theme = {},
        image_support = false,
    },
}
