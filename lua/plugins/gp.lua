-- local model = "ollama-phi-4"
local model = "chatgpt-4o"
-- local model = "chatgpt-o1"
-- local model = "chatgpt-o1-mini"

local temperature = 0.5 -- Lower is less random
local top_p = 0.5 -- percentage of probability mass considered
local prompt =
    "Only display the code if it is related to coding or simply answer the question directly, without unnecessary talking."

return {
    "robitx/gp.nvim",
    lazy = true,
    keys = {
        -- VISUAL mode mappings
        { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<CR>", mode = "v", desc = "ChatNew tabnew" },
        { "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<CR>", mode = "v", desc = "ChatNew vsplit" },
        { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<CR>", mode = "v", desc = "ChatNew split" },
        { "<C-g>a", ":<C-u>'<,'>GpAppend<CR>", mode = "v", desc = "Visual Append (after)" },
        { "<C-g>b", ":<C-u>'<,'>GpPrepend<CR>", mode = "v", desc = "Visual Prepend (before)" },
        { "<C-g>c", ":<C-u>'<,'>GpChatNew<CR>", mode = "v", desc = "Visual Chat New" },
        { "<C-g>ge", ":<C-u>'<,'>GpEnew<CR>", mode = "v", desc = "Visual GpEnew" },
        { "<C-g>gn", ":<C-u>'<,'>GpNew<CR>", mode = "v", desc = "Visual GpNew" },
        { "<C-g>gp", ":<C-u>'<,'>GpPopup<CR>", mode = "v", desc = "Visual Popup" },
        { "<C-g>gt", ":<C-u>'<,'>GpTabnew<CR>", mode = "v", desc = "Visual GpTabnew" },
        { "<C-g>gv", ":<C-u>'<,'>GpVnew<CR>", mode = "v", desc = "Visual GpVnew" },
        { "<C-g>i", ":<C-u>'<,'>GpImplement<CR>", mode = "v", desc = "Implement selection" },
        { "<C-g>n", "<CMD>GpNextAgent<CR>", mode = "v", desc = "Next Agent" },
        { "<C-g>p", ":<C-u>'<,'>GpChatPaste<CR>", mode = "v", desc = "Visual Chat Paste" },
        { "<C-g>r", ":<C-u>'<,'>GpRewrite<CR>", mode = "v", desc = "Visual Rewrite" },
        { "<C-g>s", "<CMD>GpStop<CR>", mode = "v", desc = "GpStop" },
        { "<C-g>t", ":<C-u>'<,'>GpChatToggle<CR>", mode = "v", desc = "Visual Toggle Chat" },
        { "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<CR>", mode = "v", desc = "Whisper Append" },
        { "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<CR>", mode = "v", desc = "Whisper Prepend" },
        { "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<CR>", mode = "v", desc = "Whisper Enew" },
        { "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<CR>", mode = "v", desc = "Whisper New" },
        { "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<CR>", mode = "v", desc = "Whisper Popup" },
        { "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<CR>", mode = "v", desc = "Whisper Rewrite" },
        { "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<CR>", mode = "v", desc = "Whisper Tabnew" },
        { "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<CR>", mode = "v", desc = "Whisper Vnew" },
        { "<C-g>ww", ":<C-u>'<,'>GpWhisper<CR>", mode = "v", desc = "Whisper" },
        { "<C-g>x", ":<C-u>'<,'>GpContext<CR>", mode = "v", desc = "Visual GpContext" },

        -- NORMAL mode mappings
        { "<C-g><C-t>", "<CMD>GpChatNew tabnew<CR>", mode = "n", desc = "New Chat tabnew" },
        { "<C-g><C-v>", "<CMD>GpChatNew vsplit<CR>", mode = "n", desc = "New Chat vsplit" },
        { "<C-g><C-x>", "<CMD>GpChatNew split<CR>", mode = "n", desc = "New Chat split" },
        { "<C-g>a", "<CMD>GpAppend<CR>", mode = "n", desc = "Append (after)" },
        { "<C-g>b", "<CMD>GpPrepend<CR>", mode = "n", desc = "Prepend (before)" },
        { "<C-g>c", "<CMD>GpChatNew<CR>", mode = "n", desc = "New Chat" },
        { "<C-g>f", "<CMD>GpChatFinder<CR>", mode = "n", desc = "Chat Finder" },
        { "<C-g>ge", "<CMD>GpEnew<CR>", mode = "n", desc = "GpEnew" },
        { "<C-g>gn", "<CMD>GpNew<CR>", mode = "n", desc = "GpNew" },
        { "<C-g>gp", "<CMD>GpPopup<CR>", mode = "n", desc = "Popup" },
        { "<C-g>gt", "<CMD>GpTabnew<CR>", mode = "n", desc = "GpTabnew" },
        { "<C-g>gv", "<CMD>GpVnew<CR>", mode = "n", desc = "GpVnew" },
        { "<C-g>n", "<CMD>GpNextAgent<CR>", mode = "n", desc = "Next Agent" },
        { "<C-g>r", "<CMD>GpRewrite<CR>", mode = "n", desc = "Inline Rewrite" },
        { "<C-g>s", "<CMD>GpStop<CR>", mode = "n", desc = "GpStop" },
        { "<C-g>t", "<CMD>GpChatToggle<CR>", mode = "n", desc = "Toggle Chat" },
        { "<C-g>wa", "<CMD>GpWhisperAppend<CR>", mode = "n", desc = "Whisper Append (after)" },
        { "<C-g>wb", "<CMD>GpWhisperPrepend<CR>", mode = "n", desc = "Whisper Prepend (before)" },
        { "<C-g>we", "<CMD>GpWhisperEnew<CR>", mode = "n", desc = "Whisper Enew" },
        { "<C-g>wn", "<CMD>GpWhisperNew<CR>", mode = "n", desc = "Whisper New" },
        { "<C-g>wp", "<CMD>GpWhisperPopup<CR>", mode = "n", desc = "Whisper Popup" },
        { "<C-g>wr", "<CMD>GpWhisperRewrite<CR>", mode = "n", desc = "Whisper Inline Rewrite" },
        { "<C-g>wt", "<CMD>GpWhisperTabnew<CR>", mode = "n", desc = "Whisper Tabnew" },
        { "<C-g>wv", "<CMD>GpWhisperVnew<CR>", mode = "n", desc = "Whisper Vnew" },
        { "<C-g>ww", "<CMD>GpWhisper<CR>", mode = "n", desc = "Whisper" },
        { "<C-g>x", "<CMD>GpContext<CR>", mode = "n", desc = "Toggle GpContext" },

        -- INSERT mode mappings
        { "<C-g><C-t>", "<CMD>GpChatNew tabnew<CR>", mode = "i", desc = "New Chat tabnew" },
        { "<C-g><C-v>", "<CMD>GpChatNew vsplit<CR>", mode = "i", desc = "New Chat vsplit" },
        { "<C-g><C-x>", "<CMD>GpChatNew split<CR>", mode = "i", desc = "New Chat split" },
        { "<C-g>a", "<CMD>GpAppend<CR>", mode = "i", desc = "Append (after)" },
        { "<C-g>b", "<CMD>GpPrepend<CR>", mode = "i", desc = "Prepend (before)" },
        { "<C-g>c", "<CMD>GpChatNew<CR>", mode = "i", desc = "New Chat" },
        { "<C-g>f", "<CMD>GpChatFinder<CR>", mode = "i", desc = "Chat Finder" },
        { "<C-g>ge", "<CMD>GpEnew<CR>", mode = "i", desc = "GpEnew" },
        { "<C-g>gn", "<CMD>GpNew<CR>", mode = "i", desc = "GpNew" },
        { "<C-g>gp", "<CMD>GpPopup<CR>", mode = "i", desc = "Popup" },
        { "<C-g>gt", "<CMD>GpTabnew<CR>", mode = "i", desc = "GpTabnew" },
        { "<C-g>gv", "<CMD>GpVnew<CR>", mode = "i", desc = "GpVnew" },
        { "<C-g>n", "<CMD>GpNextAgent<CR>", mode = "i", desc = "Next Agent" },
        { "<C-g>r", "<CMD>GpRewrite<CR>", mode = "i", desc = "Inline Rewrite" },
        { "<C-g>s", "<CMD>GpStop<CR>", mode = "i", desc = "GpStop" },
        { "<C-g>t", "<CMD>GpChatToggle<CR>", mode = "i", desc = "Toggle Chat" },
        { "<C-g>wa", "<CMD>GpWhisperAppend<CR>", mode = "i", desc = "Whisper Append (after)" },
        { "<C-g>wb", "<CMD>GpWhisperPrepend<CR>", mode = "i", desc = "Whisper Prepend (before)" },
        { "<C-g>we", "<CMD>GpWhisperEnew<CR>", mode = "i", desc = "Whisper Enew" },
        { "<C-g>wn", "<CMD>GpWhisperNew<CR>", mode = "i", desc = "Whisper New" },
        { "<C-g>wp", "<CMD>GpWhisperPopup<CR>", mode = "i", desc = "Whisper Popup" },
        { "<C-g>wr", "<CMD>GpWhisperRewrite<CR>", mode = "i", desc = "Whisper Inline Rewrite" },
        { "<C-g>wt", "<CMD>GpWhisperTabnew<CR>", mode = "i", desc = "Whisper Tabnew" },
        { "<C-g>wv", "<CMD>GpWhisperVnew<CR>", mode = "i", desc = "Whisper Vnew" },
        { "<C-g>ww", "<CMD>GpWhisper<CR>", mode = "i", desc = "Whisper" },
        { "<C-g>x", "<CMD>GpContext<CR>", mode = "i", desc = "Toggle GpContext" },
    },
    opts = {
        default_chat_agent = model,
        default_command_agent = model,
        chat_confirm_delete = false,
        agents = {
            {
                name = "chatgpt-4o",
                provider = "openai",
                chat = true,
                command = true,
                model = {
                    model = "gpt-4o-2024-11-20",
                    temperature = temperature,
                    top_p = top_p,
                },
                system_prompt = prompt,
            },
            {
                name = "chatgpt-o1",
                provider = "openai",
                chat = true,
                command = true,
                model = {
                    model = "o1-preview",
                    temperature = temperature,
                    top_p = top_p,
                },
                system_prompt = prompt,
            },
            {
                name = "chatgpt-o1-mini",
                provider = "openai",
                chat = true,
                command = true,
                model = {
                    model = "o1-mini",
                    temperature = temperature,
                    top_p = top_p,
                },
                system_prompt = prompt,
            },
            {
                name = "ollama-phi-4",
                provider = "ollama",
                chat = true,
                command = true,
                model = {
                    model = "vanilj/Phi-4:latest",
                    temperature = temperature,
                    top_p = top_p,
                },
                system_prompt = prompt,
            },
        },
        providers = {
            openai = {
                endpoint = "https://api.openai.com/v1/chat/completions",
                secret = os.getenv("OPENAI_API_KEY"),
            },
            ollama = {
                endpoint = "https://ollama.mattwilding.com/v1/chat/completions",
                secret = os.getenv("OLLAMA_API_KEY"),
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
}
