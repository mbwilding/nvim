return {
    "robitx/gp.nvim",
    opts = {
        default_chat_agent = "ChatGPT4o",
        default_command_agent = "ChatGPT4o",
        chat_confirm_delete = false,
        agents = {
            {
                name = "ChatGPT4o",
                chat = true,
                model = { model = "gpt-4o", temperature = 1.0, top_p = 1 },
                system_prompt = "Only display the code if it is related to coding or simply answer the question directly, without unnecessary talking.",
            },
        },
        hooks = {
            UnitTests = function(gp, params)
                local template = "I have the following code from {{filename}}:\n\n"
                    .. "```{{filetype}}\n{{selection}}\n```\n\n"
                    .. "Please respond by writing table driven unit tests for the code above."
                local agent = gp.get_command_agent()
                gp.Prompt(params, gp.Target.vnew, agent, template)
            end,

            Explain = function(gp, params)
                local template = "I have the following code from {{filename}}:\n\n"
                    .. "```{{filetype}}\n{{selection}}\n```\n\n"
                    .. "Please respond by explaining the code above."
                local agent = gp.get_chat_agent()
                gp.Prompt(params, gp.Target.popup, agent, template)
            end,

            BufferChatNew = function(gp, _)
                -- call GpChatNew command in range mode on whole buffer
                vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
            end,

            Translator = function(gp, params)
                local chat_system_prompt = "You are a Translator, please translate to English."
                gp.cmd.ChatNew(params, chat_system_prompt)

                -- -- you can also create a chat with a specific fixed agent like this:
                -- local agent = gp.get_chat_agent("ChatGPT4o")
                -- gp.cmd.ChatNew(params, chat_system_prompt, agent)
            end,
        },
    },
    config = function(_, opts)
        require("gp").setup(opts)

        require("which-key").add({
            -- VISUAL mode mappings
            -- s, x, v modes are handled the same way by which_key
            {
                mode = { "v" },
                nowait = true,
                remap = false,
                { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<CR>", desc = "ChatNew tabnew" },
                { "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<CR>", desc = "ChatNew vsplit" },
                { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<CR>", desc = "ChatNew split" },
                { "<C-g>a", ":<C-u>'<,'>GpAppend<CR>", desc = "Visual Append (after)" },
                { "<C-g>b", ":<C-u>'<,'>GpPrepend<CR>", desc = "Visual Prepend (before)" },
                { "<C-g>c", ":<C-u>'<,'>GpChatNew<CR>", desc = "Visual Chat New" },
                { "<C-g>g", group = "generate into new .." },
                { "<C-g>ge", ":<C-u>'<,'>GpEnew<CR>", desc = "Visual GpEnew" },
                { "<C-g>gn", ":<C-u>'<,'>GpNew<CR>", desc = "Visual GpNew" },
                { "<C-g>gp", ":<C-u>'<,'>GpPopup<CR>", desc = "Visual Popup" },
                { "<C-g>gt", ":<C-u>'<,'>GpTabnew<CR>", desc = "Visual GpTabnew" },
                { "<C-g>gv", ":<C-u>'<,'>GpVnew<CR>", desc = "Visual GpVnew" },
                { "<C-g>i", ":<C-u>'<,'>GpImplement<CR>", desc = "Implement selection" },
                { "<C-g>n", "<CMD>GpNextAgent<CR>", desc = "Next Agent" },
                { "<C-g>p", ":<C-u>'<,'>GpChatPaste<CR>", desc = "Visual Chat Paste" },
                { "<C-g>r", ":<C-u>'<,'>GpRewrite<CR>", desc = "Visual Rewrite" },
                { "<C-g>s", "<CMD>GpStop<CR>", desc = "GpStop" },
                { "<C-g>t", ":<C-u>'<,'>GpChatToggle<CR>", desc = "Visual Toggle Chat" },
                { "<C-g>w", group = "Whisper" },
                { "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<CR>", desc = "Whisper Append" },
                { "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<CR>", desc = "Whisper Prepend" },
                { "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<CR>", desc = "Whisper Enew" },
                { "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<CR>", desc = "Whisper New" },
                { "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<CR>", desc = "Whisper Popup" },
                { "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<CR>", desc = "Whisper Rewrite" },
                { "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<CR>", desc = "Whisper Tabnew" },
                { "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<CR>", desc = "Whisper Vnew" },
                { "<C-g>ww", ":<C-u>'<,'>GpWhisper<CR>", desc = "Whisper" },
                { "<C-g>x", ":<C-u>'<,'>GpContext<CR>", desc = "Visual GpContext" },
            },

            -- NORMAL mode mappings
            {
                mode = { "n" },
                nowait = true,
                remap = false,
                { "<C-g><C-t>", "<CMD>GpChatNew tabnew<CR>", desc = "New Chat tabnew" },
                { "<C-g><C-v>", "<CMD>GpChatNew vsplit<CR>", desc = "New Chat vsplit" },
                { "<C-g><C-x>", "<CMD>GpChatNew split<CR>", desc = "New Chat split" },
                { "<C-g>a", "<CMD>GpAppend<CR>", desc = "Append (after)" },
                { "<C-g>b", "<CMD>GpPrepend<CR>", desc = "Prepend (before)" },
                { "<C-g>c", "<CMD>GpChatNew<CR>", desc = "New Chat" },
                { "<C-g>f", "<CMD>GpChatFinder<CR>", desc = "Chat Finder" },
                { "<C-g>g", group = "generate into new .." },
                { "<C-g>ge", "<CMD>GpEnew<CR>", desc = "GpEnew" },
                { "<C-g>gn", "<CMD>GpNew<CR>", desc = "GpNew" },
                { "<C-g>gp", "<CMD>GpPopup<CR>", desc = "Popup" },
                { "<C-g>gt", "<CMD>GpTabnew<CR>", desc = "GpTabnew" },
                { "<C-g>gv", "<CMD>GpVnew<CR>", desc = "GpVnew" },
                { "<C-g>n", "<CMD>GpNextAgent<CR>", desc = "Next Agent" },
                { "<C-g>r", "<CMD>GpRewrite<CR>", desc = "Inline Rewrite" },
                { "<C-g>s", "<CMD>GpStop<CR>", desc = "GpStop" },
                { "<C-g>t", "<CMD>GpChatToggle<CR>", desc = "Toggle Chat" },
                { "<C-g>w", group = "Whisper" },
                { "<C-g>wa", "<CMD>GpWhisperAppend<CR>", desc = "Whisper Append (after)" },
                { "<C-g>wb", "<CMD>GpWhisperPrepend<CR>", desc = "Whisper Prepend (before)" },
                { "<C-g>we", "<CMD>GpWhisperEnew<CR>", desc = "Whisper Enew" },
                { "<C-g>wn", "<CMD>GpWhisperNew<CR>", desc = "Whisper New" },
                { "<C-g>wp", "<CMD>GpWhisperPopup<CR>", desc = "Whisper Popup" },
                { "<C-g>wr", "<CMD>GpWhisperRewrite<CR>", desc = "Whisper Inline Rewrite" },
                { "<C-g>wt", "<CMD>GpWhisperTabnew<CR>", desc = "Whisper Tabnew" },
                { "<C-g>wv", "<CMD>GpWhisperVnew<CR>", desc = "Whisper Vnew" },
                { "<C-g>ww", "<CMD>GpWhisper<CR>", desc = "Whisper" },
                { "<C-g>x", "<CMD>GpContext<CR>", desc = "Toggle GpContext" },
            },

            -- INSERT mode mappings
            {
                mode = { "i" },
                nowait = true,
                remap = false,
                { "<C-g><C-t>", "<CMD>GpChatNew tabnew<CR>", desc = "New Chat tabnew" },
                { "<C-g><C-v>", "<CMD>GpChatNew vsplit<CR>", desc = "New Chat vsplit" },
                { "<C-g><C-x>", "<CMD>GpChatNew split<CR>", desc = "New Chat split" },
                { "<C-g>a", "<CMD>GpAppend<CR>", desc = "Append (after)" },
                { "<C-g>b", "<CMD>GpPrepend<CR>", desc = "Prepend (before)" },
                { "<C-g>c", "<CMD>GpChatNew<CR>", desc = "New Chat" },
                { "<C-g>f", "<CMD>GpChatFinder<CR>", desc = "Chat Finder" },
                { "<C-g>g", group = "generate into new .." },
                { "<C-g>ge", "<CMD>GpEnew<CR>", desc = "GpEnew" },
                { "<C-g>gn", "<CMD>GpNew<CR>", desc = "GpNew" },
                { "<C-g>gp", "<CMD>GpPopup<CR>", desc = "Popup" },
                { "<C-g>gt", "<CMD>GpTabnew<CR>", desc = "GpTabnew" },
                { "<C-g>gv", "<CMD>GpVnew<CR>", desc = "GpVnew" },
                { "<C-g>n", "<CMD>GpNextAgent<CR>", desc = "Next Agent" },
                { "<C-g>r", "<CMD>GpRewrite<CR>", desc = "Inline Rewrite" },
                { "<C-g>s", "<CMD>GpStop<CR>", desc = "GpStop" },
                { "<C-g>t", "<CMD>GpChatToggle<CR>", desc = "Toggle Chat" },
                { "<C-g>w", group = "Whisper" },
                { "<C-g>wa", "<CMD>GpWhisperAppend<CR>", desc = "Whisper Append (after)" },
                { "<C-g>wb", "<CMD>GpWhisperPrepend<CR>", desc = "Whisper Prepend (before)" },
                { "<C-g>we", "<CMD>GpWhisperEnew<CR>", desc = "Whisper Enew" },
                { "<C-g>wn", "<CMD>GpWhisperNew<CR>", desc = "Whisper New" },
                { "<C-g>wp", "<CMD>GpWhisperPopup<CR>", desc = "Whisper Popup" },
                { "<C-g>wr", "<CMD>GpWhisperRewrite<CR>", desc = "Whisper Inline Rewrite" },
                { "<C-g>wt", "<CMD>GpWhisperTabnew<CR>", desc = "Whisper Tabnew" },
                { "<C-g>wv", "<CMD>GpWhisperVnew<CR>", desc = "Whisper Vnew" },
                { "<C-g>ww", "<CMD>GpWhisper<CR>", desc = "Whisper" },
                { "<C-g>x", "<CMD>GpContext<CR>", desc = "Toggle GpContext" },
            },
        })
    end,
}
