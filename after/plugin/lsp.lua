local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'lua_ls'
})

-- Fix Undefined global 'vim'
lsp.configure('lua_ls', {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        }
    }
})

lsp.skip_server_setup({ 'rust_analyzer' })


local cmp = require('cmp')

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    window = {
        completion = {
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
            col_offset = -3,
            side_padding = 0,
        },
    },
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
            local strings = vim.split(kind.kind, "%s", { trimempty = true })
            --print("strings " .. vim.inspect(strings));
            --print("kind " .. vim.inspect(kind));
            --print("entry " .. vim.inspect(entry))
            print("vim_item" .. vim.inspect(vim_item))
            kind.kind = " " .. (strings[1] or "") .. " "
            kind.menu = "    (" .. (strings[2] or "") .. ")"

            print("kind" .. vim.inspect(kind))

            return kind
        end,
    },
})

-- require("lsp_signature").setup({
--     debug = false,                                            -- set to true to enable debug logging
--     log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
--     -- default is  ~/.cache/nvim/lsp_signature.log
--     verbose = false,                                          -- show debug line number
--
--     bind = true,                                              -- This is mandatory, otherwise border config won't get registered.
--     -- If you want to hook lspsaga or other signature handler, pls set to false
--     doc_lines = 10,                                           -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
--     -- set to 0 if you DO NOT want any API comments be shown
--     -- This setting only take effect in insert mode, it does not affect signature help in normal
--     -- mode, 10 by default
--
--     max_height = 12,                     -- max height of signature floating_window
--     max_width = 80,                      -- max_width of signature floating_window, line will be wrapped if exceed max_width
--     -- the value need >= 40
--     wrap = true,                         -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
--     floating_window = true,              -- show hint in a floating window, set to false for virtual text only mode
--
--     floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
--     -- will set to true when fully tested, set to false will use whichever side has more space
--     -- this setting will be helpful if you do not want the PUM and floating win overlap
--
--     floating_window_off_x = 1, -- adjust float windows x position.
--     -- can be either a number or function
--     floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
--     -- can be either number or function, see examples
--
--     close_timeout = 4000, -- close floating window after ms when laster parameter is entered
--     fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
--     hint_enable = true, -- virtual hint enable
--     hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
--     hint_scheme = "String",
--     hint_inline = function() return false end, -- should the hint be inline(nvim 0.10 only)?  default false
--     -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
--     -- return 'right_align' to display hint right aligned in the current line
--     hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
--     handler_opts = {
--         border = "rounded"                      -- double, rounded, single, shadow, none, or a table of borders
--     },
--
--     always_trigger = false,                 -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
--
--     auto_close_after = nil,                 -- autoclose signature float win after x sec, disabled if nil.
--     extra_trigger_chars = {},               -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
--     zindex = 200,                           -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
--
--     padding = '',                           -- character to pad on left and right of signature can be ' ', or '|'  etc
--
--     transparency = nil,                     -- disabled by default, allow floating win transparent value 1~100
--     shadow_blend = 36,                      -- if you using shadow as border use this set the opacity
--     shadow_guibg = 'Black',                 -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
--     timer_interval = 200,                   -- default timer check interval set to lower value if you want to reduce latency
--     toggle_key = nil,                       -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
--     toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
--     -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
--     -- may not popup when typing depends on floating_window setting
--
--     select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
--     move_cursor_key = nil,    -- imap, use nvim_set_current_win to move cursor between current win and floating
-- }
-- )
require("dressing").setup({
    input = {
        -- Set to false to disable the vim.ui.input implementation
        enabled = true,

        -- Default prompt string
        default_prompt = "Input:",

        -- Can be 'left', 'right', or 'center'
        title_pos = "left",

        -- When true, <Esc> will close the modal
        insert_only = true,

        -- When true, input will start in insert mode.
        start_in_insert = true,

        -- These are passed to nvim_open_win
        border = "rounded",
        -- 'editor' and 'win' will default to being centered
        relative = "cursor",

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        prefer_width = 40,
        width = nil,
        -- min_width and max_width can be a list of mixed types.
        -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },

        buf_options = {},
        win_options = {
            -- Disable line wrapping
            wrap = false,
            -- Indicator for when text exceeds window
            list = true,
            listchars = "precedes:…,extends:…",
            -- Increase this for more context when text scrolls off the window
            sidescrolloff = 0,

            winhighlight = 'FloatBorder:Number',
        },

        -- Set to `false` to disable
        mappings = {
            n = {
                ["<Esc>"] = "Close",
                ["<CR>"] = "Confirm",
            },
            i = {
                ["<C-c>"] = "Close",
                ["<CR>"] = "Confirm",
                ["<Up>"] = "HistoryPrev",
                ["<Down>"] = "HistoryNext",
            },
        },

        override = function(conf)
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            return conf
        end,

        -- see :help dressing_get_config
        get_config = nil,
    },
    select = {
        -- Set to false to disable the vim.ui.select implementation
        enabled = true,

        -- Priority list of preferred vim.select implementations
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

        -- Trim trailing `:` from prompt
        trim_prompt = true,

        -- Options for telescope selector
        -- These are passed into the telescope picker directly. Can be used like:
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = require('telescope.themes').get_cursor({}),

        -- Options for fzf selector
        fzf = {
            window = {
                width = 0.5,
                height = 0.4,
            },
        },

        -- Options for fzf-lua
        fzf_lua = {
            -- winopts = {
            --   height = 0.5,
            --   width = 0.5,
            -- },
        },

        -- Options for nui Menu
        nui = {
            position = "50%",
            size = nil,
            relative = "editor",
            border = {
                style = "rounded",
            },
            buf_options = {
                swapfile = false,
                filetype = "DressingSelect",
            },
            win_options = {
                winblend = 0,
            },
            max_width = 80,
            max_height = 40,
            min_width = 40,
            min_height = 10,
        },

        -- Options for built-in selector
        builtin = {
            -- Display numbers for options and set up keymaps
            show_numbers = true,
            -- These are passed to nvim_open_win
            border = "rounded",
            -- 'editor' and 'win' will default to being centered
            relative = "editor",

            buf_options = {},
            win_options = {
                cursorline = true,
                cursorlineopt = "both",
            },

            -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- the min_ and max_ options can be a list of mixed types.
            -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
            width = nil,
            max_width = { 140, 0.8 },
            min_width = { 40, 0.2 },
            height = nil,
            max_height = 0.9,
            min_height = { 10, 0.2 },

            -- Set to `false` to disable
            mappings = {
                ["<Esc>"] = "Close",
                ["<C-c>"] = "Close",
                ["<CR>"] = "Confirm",
            },

            override = function(conf)
                -- This is the config that will be passed to nvim_open_win.
                -- Change values here to customize the layout
                return conf
            end,
        },

        -- Used to override format_item. See :help dressing-format
        format_item_override = {},

        -- see :help dressing_get_config
        get_config = nil,
    },
})


lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local lsp_attach_fn = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>fo", function() vim.cmd("ClangdSwitchSourceHeader") end, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vff", function() vim.lsp.buf.format() end, opts)

    vim.lsp.inlay_hint.enable()
    vim.api.nvim_set_hl(0, "LspInlayHint", { link = "Comment" })
end

lsp.on_attach(lsp_attach_fn)

lsp.setup()
lsp.nvim_workspace()

vim.diagnostic.config({
    virtual_text = true
})

local rust_tools = require('rust-tools')

rust_tools.setup({
    server = {
        on_attach = function(client, bufnr)
            lsp_attach_fn(client, bufnr)
            vim.keymap.set('n', '<leader>vh', rust_tools.hover_actions.hover_actions, { buffer = bufnr, remap = true })
            vim.keymap.set('n', '<Leader>vca', rust_tools.code_action_group.code_action_group,
                { buffer = bufnr, remap = true })
        end,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                }
            }
        }
    }
})
