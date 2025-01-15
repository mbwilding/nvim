local config_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/config/*.lua", false, true)
for _, file in ipairs(config_files) do
  if not file:match("init%.lua$") then
    require("config." .. file:match("([^/]+)%.lua$"))
  end
end
