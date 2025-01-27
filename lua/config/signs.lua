local function define_sign(name, opts)
    vim.fn.sign_define(name, opts)
    vim.diagnostic.config()
end

local signs = {
    { "DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" } },
    { "DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" } },
    { "DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" } },
    { "DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" } },
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
