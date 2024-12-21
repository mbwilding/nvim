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

                "coreclr",  -- netcoredbg
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
        vim.keymap.set("n", "<leader>cv", function()
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

        -- Adapters
        dap.adapters.codelldb = {
            name = "codelldb",
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.exepath("codelldb"),
                args = { "--port", "${port}" },
                detached = vim.fn.has("win32") == 0
            }
        }

        dap.adapters.coreclr = {
            type = "executable",
            command = vim.fn.exepath("netcoredbg"),
            args = { "--interpreter=vscode" },
        }

        dap.configurations.cs = {
            {
                name = "app",
                type = "coreclr",
                request = "launch",
                program = function()
                    local function build()
                        local lines = vim.fn.systemlist("dotnet build")
                        local output = table.concat(lines, "\n")

                        if not output:find("Build succeeded") then
                            return error("Failed to build")
                        end
                    end

                    build()

                    local function find_dll_path()
                        local current_file = vim.fn.expand('%:p')
                        local current_dir = vim.fn.fnamemodify(current_file, ':h')

                        while current_dir ~= "" and current_dir ~= "/" do
                            local bin_dir = current_dir .. "/bin"
                            local obj_dir = current_dir .. "/obj"
                            if vim.fn.isdirectory(bin_dir) == 1 and vim.fn.isdirectory(obj_dir) == 1 then
                                local project_name = vim.fn.fnamemodify(current_dir, ":t")
                                local dll_files = vim.fn.glob(bin_dir .. '/Debug/*/' .. project_name .. '.dll', false, true)
                                if #dll_files > 0 then
                                    return dll_files[1]
                                else
                                    error("Project DLL file found")
                                end
                            end
                            current_dir = vim.fn.fnamemodify(current_dir, ':h')
                        end

                        error("DLL not found and reached top directory")
                        return nil
                    end

                    return find_dll_path()
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.configurations.rust = {
            {
                name = "bin",
                type = "codelldb",
                request = "launch",
                program = function()
                    local function build(command)
                        local lines = vim.fn.systemlist(command)
                        local output = table.concat(lines, "\n")
                        local filename = output:match('^.*"executable":"(.*)",.*\n.*,"success":true}$')

                        if filename == nil then
                            return error("Failed to build cargo project")
                        end

                        return filename
                    end

                    local function get_project_name()
                        local current_file = vim.fn.expand('%:p')
                        local project_dir = string.match(current_file, "(.+)/src/.+")
                        if project_dir then
                            return vim.fn.fnamemodify(project_dir, ":t")
                        end
                        print("Project name not found")
                        return nil
                    end

                    return build("cargo build -q --message-format=json --bin " .. get_project_name())
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                showDisassembly = "never"
            }
        }
    end,
}
