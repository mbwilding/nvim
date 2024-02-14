return {
    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- LSP Configuration & Plugins
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
            { 'j-hui/fidget.nvim', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            'folke/neodev.nvim',
        },
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                'L3MON4D3/LuaSnip',
                build = (function()
                    -- Build Step is needed for regex support in snippets
                    -- This step is not supported in many windows environments
                    -- Remove the below condition to re-enable on windows
                    if vim.fn.has 'win32' == 1 then
                        return
                    end
                    return 'make install_jsregexp'
                end)(),
            },
            'saadparwaiz1/cmp_luasnip',

            -- Adds LSP completion capabilities
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',

            -- Adds a number of user-friendly snippets
            'rafamadriz/friendly-snippets',
        },
    },

    -- Useful plugin to show you pending keybinds.
    {
        'folke/which-key.nvim',
        opts = {}
    },

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map({ 'n', 'v' }, ']c', function()
                    if vim.wo.diff then
                        return ']c'
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Jump to next hunk' })

                map({ 'n', 'v' }, '[c', function()
                    if vim.wo.diff then
                        return '[c'
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return '<Ignore>'
                end, { expr = true, desc = 'Jump to previous hunk' })

                -- Actions
                -- visual mode
                map('v', '<leader>hs', function()
                    gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'stage git hunk' })
                map('v', '<leader>hr', function()
                    gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                end, { desc = 'reset git hunk' })
                -- normal mode
                map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
                map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
                map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
                map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
                map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
                map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
                map('n', '<leader>hb', function()
                    gs.blame_line { full = false }
                end, { desc = 'git blame line' })
                map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
                map('n', '<leader>hD', function()
                    gs.diffthis '~'
                end, { desc = 'git diff against last commit' })

                -- Toggles
                map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
                map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

                -- Text object
                map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
            end,
        },
    },

    -- TS Rainbow
    {
        "HiPhish/nvim-ts-rainbow2",
        lazy = true
    },

    -- Set lualine as statusline
    {
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = false,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    -- Add indentation guides even on blank lines
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
    },

    -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        opts = {}
    },

    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- Fuzzy Finder Algorithm which requires local dependencies to be built.
            -- Only load if `make` is available. Make sure you have the system
            -- requirements installed.
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },

    -- Highlight, edit, and navigate code
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    -- Theme inspired by Atom
    {
        'navarasu/onedark.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require('onedark').setup {
                -- Main options --
                style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
                transparent = true,  -- Show/hide background
                term_colors = true, -- Change terminal color as per the selected theme style
                ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
                cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

                -- toggle theme style ---
                toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
                toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

                -- Change code style ---
                -- Options are italic, bold, underline, none
                -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
                code_style = {
                    comments = 'italic',
                    keywords = 'none',
                    functions = 'none',
                    strings = 'none',
                    variables = 'none'
                },

                -- Lualine options --
                lualine = {
                    transparent = false, -- lualine center bar transparency
                },

                -- Custom Highlights --
                colors = {
                    -- Base
                    fg = "#bdbdbd",
                    -- gray = "#6e6e6e";
                    string = "#c9a26d",
                    number = "#ed94c0",
                    comment = "#85c46c",
                    comment_alt = "#487d34",
                    keyword = "#6c95eb",
                    class = "#c191ff",
                    enum = "#e1bfff",
                    interface = "#9591ff",
                    method = "#39cc8f",
                    constant = "#66c3cc",
                    field = "#66c3cc",
                    todo = "#66c3cc",
                    macro = "#4eade5",
                    error = "#ff0000",
                    redundant = "#787878",
                    format = "#B189F5",

                    -- Rust
                    crate = "#ffb083",
                    module = "#ffd3b3",
                    lifetime = "#ff9e64",
                },
                highlights = {
                    -- Base
                    ["@variable"] = { fg = '$fg' },
                    ["@punctuation.delimiter"] = { fg = '$fg' },
                    ["@punctuation.bracket"] = { fg = '$fg' },
                    ["@punctuation.special"] = { fg = '$macro' },
                    ["@constant"] = { fg = '$constant' },
                    ["@comment"] = { fg = '$comment' },
                    ["@string"] = { fg = '$string' },
                    ["@boolean"] = { fg = '$keyword' },
                    ["@operator"] = { fg = '$fg' },
                    ["@type"] = { fg = '$class' },
                    ["@function"] = { fg = '$method' },
                    ["Function"] = { fg = '$method' },
                    ["@lsp.typemod.method.defaultLibrary"] = { fg = '$method' },
                    ["@keyword.repeat"] = { fg = '$keyword' },
                    ["@type.builtin"] = { fg = '$keyword' },
                    ["@variable.member"] = { fg = '$field' },
                    ["@number"] = { fg = '$number' },
                    ["@number.float"] = { fg = '$number' },
                    ["@keyword"] = { fg = '$keyword' },
                    ["@keyword.function"] = { fg = '$keyword' },
                    ["@keyword.import"] = { fg = '$keyword' },
                    ["@keyword.operator"] = { fg = '$keyword' },
                    ["@function.macro"] = { fg = '$macro' },
                    ["@lsp.type.macro"] = { fg = '$macro' },
                    ["@lsp.type.interface"] = { fg = '$interface' },
                    ["@lsp.type.keyword"] = { fg = '$keyword' },
                    ["@lsp.typemod.variable.static"] = { fg = '$constant' },
                    ["@lsp.type.parameter"] = { fg = '$fg' },
                    ["@variable.builtin"] = { fg = '$keyword' },
                    ["@variable.parameter"] = { fg = '$fg' },
                    ["@lsp.type.builtinType"] = { fg = '$keyword' },
                    ["@lsp.type.comment"] = { fg = '$comment' },
                    ["@lsp.type.enum"] = { fg = '$enum' },
                    ["Structure"] = { fg = '$class' },
                    ["@lsp.type.method"] = { fg = '$method' },
                    ["@constant.builtin"] = { fg = '$constant' },
                    ["@lsp.type.enumMember"] = { fg = '$constant' },
                    ["@lsp.type.typeParameter"] = { fg = '$class' },
                    ["@lsp.type.generic"] = { fg = '$class' },

                    -- Rust
                    ["@module.rust"] = { fg = '$module' },
                    ["@lsp.mod.crateRoot.rust"] = { fg = '$crate' },
                    ["@string.rust"] = { fg = '$string' },
                    ["@type.qualifier.rust"] = { fg = '$keyword' },
                    ["@lsp.typemod.variable.constant.rust"] = { fg = '$constant' },
                    ["@lsp.type.formatSpecifier.rust"] = { fg = '$format' },
                    ["@lsp.type.decorator.rust"] = { fg = '$macro' },
                    ["@lsp.type.derive.rust"] = { fg = '$interface' },
                    ["@lsp.type.lifetime.rust"] = { fg = '$lifetime' },
                },

                -- Plugins Config --
                diagnostics = {
                    darker = true, -- darker colors for diagnostic
                    undercurl = true,   -- use undercurl instead of underline for diagnostics
                    background = true,    -- use background color for virtual text
                },
            }
            require('onedark').load()
        end,
    },
    
    -- Cellular Automaton
    {
        "eandrju/cellular-automaton.nvim",
        lazy = false
    },
    
    -- Load plugins in the lua/custom/plugins directory
    {
        import = 'custom.plugins'
    },
}