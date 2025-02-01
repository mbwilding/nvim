-- Helper func
local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    command = "checktime",
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "help",
        "lspinfo",
        "man",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
        "neotest-output",
        "checkhealth",
        "neotest-summary",
        "neotest-output-panel",
        "oil",
        -- "notify",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup("auto_create_dir"),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Set fileformat to unix for shell scripts
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = augroup("lf"),
    pattern = "*.sh",
    command = "set fileformat=unix",
})

-- Restore cursor to file position in previous editing session
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, "\"")
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.cmd("normal! g`\"zz")
        end
    end,
})

-- Auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
    group = augroup("splits-resize"),
    command = "wincmd =",
})

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup("lsp-attach"),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        -- Set up signature help overloads
        if client.server_capabilities.signatureHelpProvider then
            ---@diagnostic disable-next-line: missing-fields
            require("lsp-overloads").setup(client, {})
        end

        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Format the buffer
        map("<leader>f", function()
            vim.notify("Formatting")
            vim.lsp.buf.format({ async = true })
        end, "Format")

        map("<leader>ih", function()
            local enabled = not vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(enabled)
            vim.notify("Inlay Hints: " .. tostring(enabled))
        end, "Toggle [I]nlay [H]ints")

        map("<leader>h", function()
            vim.lsp.buf.document_highlight()
        end, "Highlight")

        map("<leader>H", function()
            vim.lsp.buf.clear_references()
        end, "Unhighlight")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        --
        -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        --     local highlight_augroup = augroup("lsp-highlight")
        --     vim.api.nvim_create_autocmd({ "CursorHold" }, { -- "CursorHoldI"
        --         buffer = event.buf,
        --         group = highlight_augroup,
        --         callback = vim.lsp.buf.document_highlight,
        --     })
        --
        --     vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter" }, {
        --         buffer = event.buf,
        --         group = highlight_augroup,
        --         callback = vim.lsp.buf.clear_references,
        --     })
        --
        --     vim.api.nvim_create_autocmd("LspDetach", {
        --         group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        --         callback = function(event2)
        --             vim.lsp.buf.clear_references()
        --             vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
        --         end,
        --     })
        -- end
    end,
})

-- Keep the cursor position when yanking or pasting
local cursorPreAction

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and cursorPreAction then
            vim.api.nvim_win_set_cursor(0, cursorPreAction)
        end
    end,
})

vim.keymap.set({ "n", "x" }, "y", function()
    cursorPreAction = vim.api.nvim_win_get_cursor(0)
    return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
    cursorPreAction = vim.api.nvim_win_get_cursor(0)
    return "yg_"
end, { expr = true })

vim.keymap.set({ "n", "x" }, "<leader>y", function()
    cursorPreAction = vim.api.nvim_win_get_cursor(0)
    return "\"+y"
end, { expr = true })

vim.keymap.set("n", "<leader>yy", function()
    cursorPreAction = vim.api.nvim_win_get_cursor(0)
    return "\"+yy"
end, { expr = true })

-- Virtual text only on current line
-- vim.diagnostic.config({
--     virtual_text = false,
-- })
-- local ns = vim.api.nvim_create_namespace("CurlineDiag")
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         vim.api.nvim_create_autocmd("CursorHold", {
--             buffer = args.buf,
--             callback = function()
--                 pcall(vim.api.nvim_buf_clear_namespace, args.buf, ns, 0, -1)
--                 local hi = { "Error", "Warn", "Info", "Hint" }
--                 local curline = vim.api.nvim_win_get_cursor(0)[1]
--                 local diagnostics = vim.diagnostic.get(args.buf, { lnum = curline - 1 })
--                 local virt_texts = {{ (' '):rep(4) } }
--                 -- local virt_texts = {}
--                 for _, diag in ipairs(diagnostics) do
--                     virt_texts[#virt_texts + 1] = { diag.message:gsub("\n", " ") .. " ", "Diagnostic" .. hi[diag.severity] }
--                 end
--                 vim.api.nvim_buf_set_extmark(args.buf, ns, curline - 1, 0, {
--                     virt_text = virt_texts,
--                     hl_mode = "combine",
--                 })
--             end,
--         })
--     end,
-- })
