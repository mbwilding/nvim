local picker = require("snacks.picker")

local M = {}

local scandir = require("plenary.scandir")

function M.find(pattern)
    return scandir.scan_dir(".", {
        hidden = false,
        search_pattern = pattern,
        -- respect_gitignore = true, -- Breaks searching
        -- ignore = {'node_modules', '.git'},
    })
end

function M.find_projects(args)
    local paths = M.find(args.pattern)
    local result = {}
    for _, path in ipairs(paths) do
        local name = args.get_name(path)
        result[#result + 1] = {
            name = name,
            path = path,
            language = args.language,
        }
    end
    return result
end

function M.merge()
    local merged_projects = {}
    local base_path = vim.fn.stdpath("config") .. "/lua/config/plugins/launch/languages"
    local files = vim.fn.globpath(base_path, "*.lua", false, true)
    for _, file in ipairs(files) do
        local module = dofile(file)
        if module.projects then
            for _, project in ipairs(module.projects) do
                table.insert(merged_projects, project)
            end
        end
    end
    return merged_projects
end

local function select_command(results)
    picker.select(vim.tbl_keys(results.language.commands), {
        prompt = "Command",
        format_item = function(item)
            return item
        end,
    }, function(cmd_key)
        if cmd_key then
            local cmd_value = results.language.commands[cmd_key]
            local path = vim.fs.joinpath(vim.fn.getcwd(), vim.fs.normalize(results.project.path))
            local command = vim.list_extend(vim.split(cmd_value, "%s+"), { path })
            vim.system(command)
        end
    end)
end

function M.select_project(results)
    picker.select(results, {
        prompt = "Project",
        format_item = function(item)
            return (item.language and (item.language .. ": ") or "") .. item.name
        end,
    }, function(project)
        if project then
            select_command({
                project = project,
                language = require("config/plugins/launch/languages/" .. project.language),
            })
        end
    end)
end

return M
