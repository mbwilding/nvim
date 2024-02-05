local dap = require("dap")
local log = require("structlog")

local function getHighestVersionDirectory(dir)
    local command = IsWindows and ("dir /B " .. dir) or ("dir " .. dir)
    local max_version, max_dir = -1, ""
    local p = io.popen(command)
    local lines = p:lines()
    for dirname in lines do
        local version = tonumber(dirname:match("net(%d+%.%d+)"))
        if version and version > max_version then
            max_version = version
            max_dir = dirname
        end
    end
    if p ~= nil then
        p:close()
    end

    return max_dir
end

local function getDotnetCoreDebugger()
    local directory_name = "netcoredbg"
    local file_name = "/netcoredbg"

    -- Determine the operating system
    local path_separator = package.config:sub(1, 1) -- Get the path separator used by the OS

    -- Set different paths based on the OS
    if IsWindows then -- Windows paths
        paths = {
            "C:\\Program Files\\" .. directory_name
        }
    else -- Assume Linux/Unix paths
        paths = {
            "/usr/local/share/" .. directory_name,
            "/usr/share/" .. directory_name,
            "/opt/" .. directory_name,
        }
        file_name = "/" .. directory_name
    end

    -- Iterate through each path and check if the directory exists
    for _, path in ipairs(paths) do
        local found_path = vim.fn.finddir(path, "")
        if found_path ~= "" then
            -- print("netcore: " .. path .. file_name)
            return path .. file_name
        end
    end

    return nil
end

dap.adapters.coreclr = {
    type = "executable",
    command = getDotnetCoreDebugger(),
    args = { "--interpreter=vscode" }
    -- args = { "--interpreter=vscode", "--log=file" }
}

Wilding_config = {
    debug_dllPath = nil
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            local path = vim.fn.getcwd()
            local logger = log.get_logger("wilding_vim")
            logger:info("Path is: " .. path)
            local sep = path:match("[/\\]")          -- Get the path separator used (either / or \)
            local last_dir = path:match("([^" .. sep .. "]+" .. sep .. "?)$")
            local project_name = last_dir:sub(1, -1) -- Remove the trailing separator if it exists
            local version_directory = path .. "\\bin\\Debug"
            local latest_version = getHighestVersionDirectory(version_directory);
            -- logger:info("Hieghest version: " .. latest_version)
            local executable_path = version_directory .. "\\" .. latest_version .. "\\" .. project_name .. ".dll"
            -- local tokens = string.gmatch(path, "\\")
            -- local project_name = tokens[#(tokens) - 1] .. "\\"
            if (Wilding_config.debug_dllPath ~= nill) then
                executable_path = Wilding_config.debug_dllPath
            end

            local result = vim.fn.input("Path to dll: ", executable_path, "file")
            Wilding_config.debug_dllPath = result
            -- logger:info("Result: " .. result)
            return result
        end,
        -- env = {},
        -- cwd = ""
    },
}

require("nvim-dap-virtual-text").setup()

local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dapui.setup()
