-- DAP (Debug Adapter Protocol) is a protocol that allows editors to communicate with debuggers.

return {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
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

        require("nvim-dap-virtual-text").setup({
            enabled = true,                         -- enable this plugin (the default)
            enabled_commands = true,                -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
            highlight_changed_variables = true,     -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
            highlight_new_as_changed = false,       -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
            show_stop_reason = true,                -- show stop reason when stopped for exceptions
            commented = false,                      -- prefix virtual text with comment string
            only_first_definition = false,          -- only show virtual text at first definition (if there are multiple)
            all_references = true,                  -- show virtual text on all all references of the variable (not only definitions)
            clear_on_continue = false,              -- clear virtual text on "continue" (might cause flickering when stepping)
            --- A callback that determines how a variable is displayed or whether it should be omitted
            --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
            --- @param buf number
            --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
            --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
            --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
            --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
            display_callback = function(variable, buf, stackframe, node, options)
                -- by default, strip out new line characters
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.value:gsub("%s+", " ")
                else
                    return variable.name .. ' = ' .. variable.value:gsub("%s+", " ")
                end
            end,
            -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
            virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

            -- experimental features:
            all_frames = false,         -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
            virt_lines = false,         -- show virtual lines instead of virtual text (will flicker!)
            virt_text_win_col = 80      -- position the virtual text at a fixed window column (starting from the first text column)
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

        -- Configurations
        dap.configurations.cs = {
            {
                name = "Debug",
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
                        local current_dir = vim.fn.fnamemodify(vim.fn.expand('%:p'), ':h')

                        while current_dir ~= "" and current_dir ~= "/" do
                            local bin_dir, obj_dir = current_dir .. "/bin", current_dir .. "/obj"
                            if vim.fn.isdirectory(bin_dir) == 1 and vim.fn.isdirectory(obj_dir) == 1 then
                                local project_name = vim.fn.fnamemodify(current_dir, ":t")
                                local dll_pattern = bin_dir .. '/Debug/*/' .. project_name .. '.dll'
                                for _, dll in ipairs(vim.fn.glob(dll_pattern, false, true)) do
                                    return dll
                                end
                            end
                            current_dir = vim.fn.fnamemodify(current_dir, ':h')
                        end

                        return error("Debug binary not found")
                    end

                    return find_dll_path()
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }

        dap.configurations.rust = {
            {
                name = "Debug",
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

                    local function get_crate_target()
                        local current_file = vim.fn.expand('%:p')
                        local project_dir = string.match(current_file, "(.+)/src/.+")

                        if not project_dir then
                            return error("Project directory not found")
                        end

                        local result = vim.fn.systemlist("cargo read-manifest --manifest-path " .. project_dir .. "/Cargo.toml")
                        if vim.v.shell_error ~= 0 then
                            return error("Failed to read Cargo.toml")
                        end

                        local manifest = vim.fn.json_decode(table.concat(result, "\n"))
                        for _, target in ipairs(manifest.targets) do
                            if target.crate_types[1] == "bin" then
                                return target.name
                            else
                                -- Telescope floating ui to ask which binary in workspace
                            end
                        end

                        return error("No binary target found")
                    end

                    return build("cargo build -q --message-format=json --bin " .. get_crate_target())
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                showDisassembly = "never"
            }
        }
    end,
}
