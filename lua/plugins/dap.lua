-- DAP (Debug Adapter Protocol) is a protocol that allows editors to communicate with debuggers.

return {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,
            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},
            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
                -- Update this to ensure that you have the debuggers for the langs you want

                -- "delve", -- go
                "coreclr", -- netcoredbg
                "codelldb", -- cpp, rust
            },
        })

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set("n", "<leader>dap", dapui.toggle, { desc = "Debug: See last session result." })
        vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug: Start/Continue" })
        vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
        vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debug: Step Back" })
        vim.keymap.set("n", "<F6>", dap.run_to_cursor, { desc = "Debug: Run To Cursor" })

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Breakpoint" })
        vim.keymap.set("n", "<leader>?", function()
            dap.eval(nil, { enter = true })
        end, { desc = "Debug: Cursor Value" })

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup({
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
            controls = {
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "",
                    terminate = "",
                    disconnect = "",
                },
            },
        })

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        dap.listeners.after.event_initialized.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Install golang specific config
        -- require('dap-go').setup()

        ---- CSHARP
        dap.adapters.coreclr = {
            type = "executable",
            command = "/usr/bin/netcoredbg",
            args = { "--interpreter=vscode" },
        }

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
                end,
            },
        }

        ---- RUST
        local function find_codelldb_path()
            local possible_paths = {
                vim.env.HOME .. "/.local/share/nvim/mason/bin/codelldb",
                vim.env.HOME .. "/AppData/Local/nvim-data/mason/packages/codelldb/extension/adapter/codelldb.exe",
            }

            for _, path in ipairs(possible_paths) do
                if vim.fn.filereadable(path) == 1 then
                    return path
                end
            end

            print("codelldb not found")

            return nil
        end

        local function find_rust_target()
            local metadata = vim.fn.json_decode(vim.fn.system("cargo metadata --no-deps --format-version 1"))
            if metadata and metadata["packages"] then
                local package = metadata["packages"][1]
                if package and package["targets"] then
                    for _, target in ipairs(package["targets"]) do
                        if target["kind"] and vim.tbl_contains(target["kind"], "bin") then
                            return target["name"]
                        end
                    end
                end
            end

            print("Rust target not found")
            return nil
        end

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = find_codelldb_path(),
                args = { "--port", "${port}" },
            },
        }

        dap.configurations.rust = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    vim.cmd("!cargo build")
                    return vim.fn.getcwd() .. "/target/debug/" .. find_rust_target()
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
    end,
}
