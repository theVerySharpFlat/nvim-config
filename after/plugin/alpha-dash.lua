local if_nil = vim.F.if_nil
local alpha = require("alpha")

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local default_header = {
    type = "text",
    val = {
        [[                                  __]],
        [[     ___     ___    ___   __  __ /\_\    ___ ___]],
        [[    / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\]],
        [[   /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
        [[   \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[    \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    },
    opts = {
        position = "center",
        hl = "Type",
        -- wrap = "overflow";
    },
}

local footer = {
    type = "text",
    val = "",
    opts = {
        position = "center",
        hl = "Number",
    },
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 3,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("e", "  New file", "<cmd>ene <CR>"),
        button("SPC f f", "󰈞  Find file"),
        button("SPC f h", "󰊄  Recently opened files"),
        button("SPC f r", "  Frecency/MRU"),
        button("SPC f g", "󰈬  Find word"),
        button("SPC f m", "  Jump to bookmarks"),
        button("SPC s l", "  Open last session"),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    terminal = default_terminal,
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 2 },
        section.header,
        { type = "padding", val = 2 },
        section.buttons,
        section.footer,
    },
    opts = {
        margin = 5,
    },
}

section.header.val = {
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ⠀⠀⠀⠙⢿⣿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣶⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⠚⠛⠻⣿⠛⣿⡿⠛⠒⠒⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⣿⡄⠀⠀⢀⣤⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣸⣿⡿⠶⠶⣤⡀⠀⢀⣿⠀⣿⡇⠀⠀⣸⣧⣤⣄⠀⠀⠀⠀⠀⠀⢀⣤⠀",
    "⣶⠟⣁⡀⠀⠀⠀⠀⢀⣀⣸⣿⣿⣏⣀⣴⣀⠸⣿⣶⣿⣧⣀⣿⣇⣀⣸⣿⣿⣿⣿⡇⠀⠀⠀⠀⢀⠻⣿⣶",
    "⣿⡄⠉⣿⣀⡀⠀⢀⣸⣿⣿⣿⣿⣿⠟⠛⠛⠶⣿⣿⣉⣿⣿⣿⡿⠛⠛⠛⠛⢿⣿⣷⣄⣀⣀⣀⠛⣀⠛⣁",
    "⠛⣠⣶⣄⡈⠛⠛⢻⣿⣿⣿⣿⣿⣿⠄⠀⠀⠀⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⢸⣿⣿⣿⣅⠀⠈⣶⣤⣶⠛",
    "⠀⠈⠋⣤⣷⣴⣿⣿⣿⠇⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⢸⣿⣿⣤⣼⣿⣤⠛⠀",
    "⠀⠀⠀⠀⠀⠀⣿⡟⢡⡜⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣿⠃⠀⠙⣄⠀⠀⠀⠀⠀⠀⠈⢻⡏⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⢹⡇⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⠉⠀⠀⠀⠙⣷⡄⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⢠⡆⠈⣷⣾⣷⣶⣶⡄⠀⠀⠀⢰⣶⣶⣿⠁⠀⠀⠀⠀⠀⠙⣷⡆⠰⠆⠀⠀⠈⠀⣴⠀⠀⠀⠀",
    "⠀⠀⠀⣀⣠⡇⠀⠛⢻⣿⡟⢿⣷⣶⣄⣴⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⢠⡿⢃⣰⣶⡶⢀⣴⣄⠘⠀⠀⠀⠀",
    "⠀⠀⠀⡿⠻⣇⠀⢀⣼⣿⣧⡀⢹⣿⠟⠛⢿⣿⣿⣿⣤⣄⠀⠀⣤⣤⣼⣧⣼⣿⣿⣦⣼⣿⣿⠀⣠⠀⠀⠀",
    "⠀⠀⠀⣷⠀⠋⢀⣼⣿⣿⣿⣧⠀⢹⣦⣤⠘⢻⣿⠛⠛⣿⣤⡄⠛⣿⡟⠛⠛⢻⡟⠛⠛⢻⣿⠛⠛⠀⠀⠀",
    "⠀⠀⠀⣿⡄⠀⣴⡟⢹⣿⡿⠿⠦⠾⠋⢻⣤⣾⠋⠀⣤⣿⡟⠁⣤⠉⢡⡄⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⣿⡇⠀⡟⠁⠀⢹⣧⣤⣤⣤⣴⣾⠋⠉⣦⠀⣿⠉⣷⠀⠹⡆⠈⠁⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠿⡇⠀⣧⡀⠀⠈⠉⠉⠉⠉⠉⢹⣶⠀⠻⣶⠉⠀⠉⠀⠘⠗⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠃⠀⠛⢣⡀⠀⠀⢀⡀⠀⠀⠘⠛⠀⠀⠀⣀⠀⣶⠀⡀⠰⡆⠀⠀⠀⠀⠀⠀⠀⢀⠲⢤⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣼⡇⠀⢠⣤⣤⠀⣠⠀⣿⣤⣷⣤⣧⣤⣧⣤⣤⡄⠀⠀⠀⢠⣼⣦⠀⠀⠀⠀",
}

local configPath = vim.fn.stdpath("config")
--------------------------

section.buttons.val = {
    button("f", "  > Find file",
        ":lua require('telescope').extensions.file_browser.file_browser({hidden = true, path=vim.fn.expand('$HOME')})<CR>"),
    button("r", "  > Recent", ":Telescope oldfiles<CR>"),
    button("s", "  > Settings", ":cd " .. configPath .. "| Telescope file_browser path=" .. configPath .. "<CR>",
        { noremap = true, silent = false, nowait = true }),
    button("q", "  > Quit NVIM", ":qa<CR>"),
}

-- Set footer
--   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
--   To see test this yourself, add the function as a dependecy in packer and uncomment the footer lines
--   ```init.lua
--   return require('packer').startup(function()
--       use 'wbthomason/packer.nvim'
--       use {
--           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
--           requires = {'BlakeJC94/alpha-nvim-fortune'},
--           config = function() require("config.alpha") end
--       }
--   end)
--   ```
-- local fortune = require("alpha.fortune")
-- dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(config)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
        if vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.cmd("Alpha")
        end
    end
})
