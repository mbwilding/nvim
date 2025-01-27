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
