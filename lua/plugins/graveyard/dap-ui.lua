---@type zpack.Spec
return {
    "rcarriga/nvim-dap-ui",
    dependencies = {
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {
                enabled = true,                     -- enable this plugin (the default)
                enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                show_stop_reason = true,            -- show stop reason when stopped for exceptions
                commented = false,                  -- prefix virtual text with comment string
                only_first_definition = false,      -- only show virtual text at first definition (if there are multiple)
                all_references = true,              -- show virtual text on all all references of the variable (not only definitions)
                clear_on_continue = false,          -- clear virtual text on "continue" (might cause flickering when stepping)
                --- A callback that determines how a variable is displayed or whether it should be omitted
                display_callback = function(variable, _, _, _, options)
                    -- by default, strip out new line characters
                    if options.virt_text_pos == "inline" then
                        return " = " .. variable.value:gsub("%s+", " ")
                    else
                        return variable.name .. " = " .. variable.value:gsub("%s+", " ")
                    end
                end,
                -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

                -- experimental features:
                all_frames = false,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                virt_lines = false,     -- show virtual lines instead of virtual text (will flicker!)
                virt_text_win_col = 80, -- position the virtual text at a fixed window column (starting from the first text column)
            },
        },
    },
    opts = {
        icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
        controls = {
            icons = {
                pause = "",
                play = "",
                step_into = "",
                step_over = "",
                step_out = "",
                step_back = "",
                run_last = "",
                terminate = "",
                disconnect = "",
            },
        },
        layouts = {
            {
                -- You can change the order of elements in the sidebar
                elements = {
                    -- Provide IDs as strings or tables with "id" and "size" keys
                    {
                        id = "scopes",
                        size = 0.25, -- Can be float or integer > 1
                    },
                    { id = "breakpoints", size = 0.25 },
                    { id = "stacks",      size = 0.25 },
                    { id = "watches",     size = 0.25 },
                },
                size = 0.3,
                position = "right", -- Can be "left" or "right"
            },
            {
                elements = {
                    "repl",
                    "console",
                },
                size = 10,
                position = "bottom", -- Can be "bottom" or "top"
            },
        },
    },
    config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup(opts)

        vim.keymap.set("n", "<leader>dap", dapui.toggle, { desc = "Debug: Toggle UI" })

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end

        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end

        dap.listeners.after.event_initialized.dapui_config = function()
            dapui.open()
            require("dap-powershell").correct_repl_colors()
        end

        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end

        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end
    end,
}
