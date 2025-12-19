local signs = {
    { "DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" } },
    { "DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" } },
    { "DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" } },
    { "DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" } },
    {
        "DapBreakpointCondition",
        { texthl = "DapBreakpoint", numhl = "DapBreakpoint" },
    },
    {
        "DapBreakpointRejected",
        { texthl = "DapBreakpoint", numhl = "DapBreakpoint" },
    },
    { "DapLogPoint", { texthl = "DapLogPoint", numhl = "DapLogPoint" } },
    { "DapStopped", { texthl = "DapStopped", numhl = "DapStopped" } },
    { "DapBreakpoint", { texthl = "DapBreakpoint", numhl = "DapBreakpoint" } },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign[1], sign[2])
end

vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        -- Highlights
        texthl = {
            [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
            [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
            [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
            [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
            ["DapLogPoint"] = "DapLogPoint",
            ["DapStopped"] = "DapStopped",
            ["DapBreakpoint"] = "DapBreakpoint",
        },
        linehl = {
            ["DapLogPoint"] = "DapLogPoint",
            ["DapStopped"] = "DapStopped",
            ["DapBreakpoint"] = "DapBreakpoint",
        },
        numhl = {
            ["DapLogPoint"] = "DapLogPoint",
            ["DapStopped"] = "DapStopped",
            ["DapBreakpoint"] = "DapBreakpoint",
        },
    },
})
