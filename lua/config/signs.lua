local function define_sign(name, opts)
    vim.fn.sign_define(name, opts)
    vim.diagnostic.config()
end

local signs = {
    {
        "DapBreakpointCondition",
        { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
    },
    {
        "DapBreakpointRejected",
        { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" },
    },
    { "DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" } },
    { "DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" } },
    { "DapBreakpoint", { text = "⦿", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" } },
}

for _, sign in ipairs(signs) do
    define_sign(sign[1], sign[2])
end

----------------------------------
vim.diagnostic.config{
    virtual_text = false,  -- floating text next to code is too noisy.
    underline = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
        },
        -- linehl = {
        --     [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        -- },
        -- numhl = {
        --     [vim.diagnostic.severity.WARN] = 'WarningMsg',
        -- },
    },
}
