require("bufferline").setup{
    options = {
        separator_style = "padded_slant",
        highlight = {underline = true},
        indicator = {
            style = 'icon'

        },
        offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    --text_align = "left",
                    separator = true
                }
        }
    }
}

vim.keymap.set("n", "<leader>bn", function() vim.cmd("BufferLineCycleNext") end)
vim.keymap.set("n", "<leader>bN", function() vim.cmd("BufferLineCyclePrev") end)
vim.keymap.set("n", "<leader>bd", function() vim.cmd("bd|bp") end)
