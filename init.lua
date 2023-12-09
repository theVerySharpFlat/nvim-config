-- make sure we cd to given directory if available
if vim.fn.argc() > 0 and vim.fn.isdirectory(vim.fn.argv(0)) == 1
then
    vim.fn.chdir(vim.fn.argv(0))
end

require("theVerySharpFlat")
