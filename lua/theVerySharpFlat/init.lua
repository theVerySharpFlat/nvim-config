require("theVerySharpFlat.bind")
require("theVerySharpFlat.packer")
require("theVerySharpFlat.set")
vim.cmd("colorscheme oxocarbon")

vim.keymap.set("n", "<C-l>", function()
    vim.cmd.noh()
    vim.cmd.redraw()
end, { silent = true })
