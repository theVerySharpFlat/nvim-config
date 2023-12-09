-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function open_nvim_tree(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    if not directory then
        return
    end

    -- change to the directory
    vim.cmd.cd(data.file)

    vim.cmd.enew()
end

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

-- OR setup with some options
-- require("nvim-tree").setup({
--     sort_by = "case_sensitive",
--     view = {
--         float = {
--             enable = true,
--             open_win_config = function()
--                 local screen_w = vim.opt.columns:get()
--                 local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
--                 local window_w = screen_w * WIDTH_RATIO
--                 local window_h = screen_h * HEIGHT_RATIO
--                 local window_w_int = math.floor(window_w)
--                 local window_h_int = math.floor(window_h)
--                 local center_x = (screen_w - window_w) / 2
--                 local center_y = ((vim.opt.lines:get() - window_h) / 2)
--                     - vim.opt.cmdheight:get()
--                 return {
--                     border = 'single',
--                     relative = 'editor',
--                     row = center_y,
--                     col = center_x,
--                     width = window_w_int,
--                     height = window_h_int,
--                 }
--             end,
--         },
--         width = function()
--             return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
--         end,
--     },
--     renderer = {
--         group_empty = true,
--     },
--     filters = {
--         dotfiles = false,
--     }
-- })
--
-- vim.keymap.set("n", "<leader>ptt", function() vim.cmd("NvimTreeToggle") end)
-- vim.keymap.set("n", "<leader>ptf", function() vim.cmd("NvimTreeFocus") end)

-- vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
