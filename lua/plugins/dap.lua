-- DAP (Debug Adapter Protocol) is a protocol that allows editors to communicate with debuggers.

local is_nixos = vim.uv.fs_stat("/etc/nixos") ~= nil

---@type zpack.Spec
return {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
        "nvim-neotest/nvim-nio",
        "banjo/package-pilot.nvim",
        {
            "Willem-J-an/nvim-dap-powershell",
            -- dependencies = {
            --     "nvim-lua/plenary.nvim",
            --     {
            --         "m00qek/baleia.nvim",
            --         lazy = true,
            --         tag = "v1.4.0",
            --     },
            -- },
            lazy = true,
            ft = "ps1",
            opts = {
                pses_bundle_path = (function()
                    return (is_nixos and "/etc/profiles/per-user/mbwilding/bin/powershell-editor-services")
                        or (jit.os == "OSX" and os.getenv("HOME") .. "/.lsp/powershell_es")
                        or (jit.os == "Linux" and "/opt/powershell-editor-services")
                end)(),
            },
        },

    },
    config = function()
        local dap = require("dap")

        -- Basic debugging keymaps, feel free to change to your liking!
        vim.keymap.set("n", "<F1>", dap.continue, { desc = "Debug: Start/Continue" })
        vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Debug: Step Into" })
        vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Debug: Step Over" })
        vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Debug: Step Out" })
        vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Debug: Step Back" })
        vim.keymap.set("n", "<leader>dat", function()
            dap.disconnect({ terminateDebuggee = true })
        end, { desc = "Debug: Terminate" })
        vim.keymap.set("n", "<leader>cr", dap.run_to_cursor, { desc = "Debug: Run To Cursor" })

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        vim.keymap.set("n", "<leader>B", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Debug: Set Breakpoint" })
        vim.keymap.set("n", "<leader>cv", function()
            dap.eval(nil, { enter = true })
        end, { desc = "Debug: Cursor Value" })

        -- Bash
        dap.adapters.sh = {
            type = "executable",
            command = vim.fn.exepath("vscode-bash-debug"),
        }

        dap.configurations.sh = {
            {
                name = "Debug",
                type = "sh",
                request = "launch",
                program = "${file}",
                cwd = "${fileDirname}",
                env = {},
                args = {},

                pathBashdb = vim.fn.exepath("bashdb"),
                pathBashdbLib = is_nixos
                    and vim.fn.fnamemodify(vim.fn.exepath("bashdb"), ":h:h") .. "/share/bashdb"
                    or "/usr/share/bashdb",
                pathBash = vim.fn.exepath("bash"),
                pathCat = vim.fn.exepath("cat"),
                pathMkfifo = vim.fn.exepath("mkfifo"),
                pathPkill = vim.fn.exepath("pkill"),

                -- showDebugOutput = true,
                -- trace = true,
            },
        }

        -- CSharp
        dap.adapters.coreclr = {
            -- CSharp
            type = "executable",
            command = vim.fn.exepath("netcoredbg"),
            args = { "--interpreter=vscode" },
        }

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
                        local function find_project_name()
                            local current_file_dir = vim.fn.expand("%:p:h")
                            while current_file_dir do
                                for _, file in ipairs(vim.fn.glob(current_file_dir .. "/*.csproj", false, true)) do
                                    if vim.fn.filereadable(file) == 1 then
                                        return vim.fn.fnamemodify(file, ":t:r")
                                    end
                                end
                                local parent_dir = vim.fn.fnamemodify(current_file_dir, ":h")
                                if parent_dir == current_file_dir then
                                    break
                                end
                                current_file_dir = parent_dir
                            end

                            return error("csproj file not found in directory tree")
                        end

                        local project_name = find_project_name()
                        local current_dir = vim.fn.getcwd()
                        local dll_pattern = current_dir .. "/**/" .. project_name .. ".dll"

                        for _, dll in ipairs(vim.fn.glob(dll_pattern, false, true)) do
                            if vim.fn.filereadable(dll) == 1 then
                                return dll
                            end
                        end

                        return error("Debug binary not found in current directory or its subdirectories")
                    end

                    return find_dll_path()
                end,
                -- cwd = "${workspaceFolder}",
                cwd = function()
                    local function find_project_name_and_dir()
                        local current_file_dir = vim.fn.expand("%:p:h")
                        while current_file_dir do
                            for _, file in ipairs(vim.fn.glob(current_file_dir .. "/*.csproj", false, true)) do
                                if vim.fn.filereadable(file) == 1 then
                                    return current_file_dir
                                end
                            end
                            local parent_dir = vim.fn.fnamemodify(current_file_dir, ":h")
                            if parent_dir == current_file_dir then
                                break
                            end
                            current_file_dir = parent_dir
                        end
                        return error("csproj file not found in directory tree")
                    end

                    local function find_framework(build_dir)
                        local frameworks = vim.fn.glob(build_dir .. "/*", 1, 1)
                        if #frameworks > 0 then
                            return vim.fn.fnamemodify(frameworks[1], ":t")
                        end
                        return error("Could not find target framework directory")
                    end

                    local project_dir = find_project_name_and_dir()
                    local build_dir = project_dir .. "/bin/Debug"
                    local framework = find_framework(build_dir)
                    return build_dir .. "/" .. framework
                end,
                stopOnEntry = false,
            },
        }

        -- LLVM
        dap.adapters.codelldb = {
            -- LLVM
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.exepath("codelldb"),
                args = { "--port", "${port}" },
                detached = vim.fn.has("win32") == 0,
            },
        }

        dap.configurations.c = {
            {
                name = "Debug",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                showDisassembly = "never",
            },
        }
        dap.configurations.cpp = dap.configurations.c

        dap.configurations.rust = {
            {
                name = "Debug",
                type = "codelldb",
                request = "launch",
                program = function()
                    local current_file = vim.fn.expand("%:p")
                    local project_dir = string.match(current_file, "(.+)/src/.+")

                    local function build(command)
                        local output = vim.fn.systemlist(command)
                        local errors = {}
                        local json_status
                        local error_message
                        for _, line in ipairs(output) do
                            local ok, decoded = pcall(vim.json.decode, line)
                            if ok and type(decoded) == "table" then
                                if decoded.success ~= nil then
                                    json_status = decoded
                                end
                                if decoded and decoded.message and decoded.message.rendered then
                                    table.insert(errors, decoded.message.rendered)
                                end
                            end
                        end
                        if json_status and not json_status.success then
                            return error(table.concat(errors, ""))
                        end
                    end

                    local function get_crate_target()
                        if not project_dir then
                            return error("Project directory not found")
                        end

                        local result =
                            vim.fn.systemlist("cargo read-manifest --manifest-path " .. project_dir .. "/Cargo.toml")
                        if vim.v.shell_error ~= 0 then
                            return error("Failed to read Cargo.toml")
                        end

                        local manifest = vim.fn.json_decode(table.concat(result, "\n"))
                        for _, target in ipairs(manifest.targets) do
                            if target.crate_types[1] == "bin" then
                                return target.name
                            end
                        end

                        return error("No binary target found")
                    end

                    local crate_target = get_crate_target()

                    build("cargo build -q --message-format=json --bin " .. crate_target)

                    local dir = project_dir
                    while dir and dir ~= "/" do
                        if vim.fn.isdirectory(dir .. "/target/debug") == 1 then
                            break
                        end
                        local parent_dir = vim.fn.fnamemodify(dir, ":h")
                        if parent_dir == dir then
                            break
                        end
                        dir = parent_dir
                    end

                    return dir .. "/target/debug/" .. crate_target
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                showDisassembly = "never",
            },
        }

        dap.configurations.zig = {
            {
                name = "Zig Run",
                type = "codelldb",
                request = "launch",
                program = function()
                    os.execute("zig build")
                    local command = "find ! -type d -path './zig-out/bin/*' | grep -v 'Test' | sed 's#.*/##'"
                    local bin_location = io.popen(command, "r")
                    if bin_location ~= nil then
                        return "zig-out/bin/" .. bin_location:read("*a"):gsub("[\n\r]", "")
                    else
                        return ""
                    end
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                -- args = function()
                --     local argv = {}
                --     arg = vim.fn.input(string.format("Arguments: "))
                --     for a in string.gmatch(arg, "%S+") do
                --         table.insert(argv, a)
                --     end
                --     return argv
                -- end,
            },
        }

        -- GO
        dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.exepath("dlv"),
                args = { "dap", "-l", "127.0.0.1:${port}" },
            },
        }

        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug Test",
                request = "launch",
                mode = "test",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug Test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}",
            },
        }

        -- Python
        dap.adapters.python = {
            type = "executable",
            command = vim.fn.exepath("debugpy-adapter"),
        }

        dap.configurations.python = {
            {
                type = "python",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    local os_name = vim.loop.os_uname().sysname
                    if os_name == "Darwin" then
                        return "/usr/bin/python3"
                    else
                        return "/usr/bin/python"
                    end
                end,
            },
        }

        -- JavaScript
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = {
                    "/usr/lib/js-debug/dapDebugServer.js",
                    "${port}",
                },
            },
        }

        dap.configurations.javascript = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
        }
        dap.configurations.javascriptreact = dap.configurations.javascript
    end,
}
