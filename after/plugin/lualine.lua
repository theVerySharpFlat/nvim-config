-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignored
local colorutil = require("oxocarbon.colorutils")
local blend_hex = colorutil["blend-hex"]

local base00 = "#161616"
local base06 = "#ffffff"
local base09 = "#78a9ff"
local oxocarbon = (((vim.o.background == "dark") and {base00 = base00, base01 = blend_hex(base00, base06, 0.085), base02 = blend_hex(base00, base06, 0.18), base03 = blend_hex(base00, base06, 0.3), base04 = blend_hex(base00, base06, 0.82), base05 = blend_hex(base00, base06, 0.95), base06 = base06, base07 = "#08bdba", base08 = "#3ddbd9", base09 = base09, base10 = "#ee5396", base11 = "#33b1ff", base12 = "#ff7eb6", base13 = "#42be65", base14 = "#be95ff", base15 = "#82cfff", blend = "#131313", none = "NONE"}) or {base00 = base06, base01 = blend_hex(base00, base06, 0.95), base02 = blend_hex(base00, base06, 0.82), base03 = base00, base04 = "#37474F", base05 = "#90A4AE", base06 = "#525252", base07 = "#08bdba", base08 = "#ff7eb6", base09 = "#ee5396", base10 = "#FF6F00", base11 = "#0f62fe", base12 = "#673AB7", base13 = "#42be65", base14 = "#be95ff", base15 = "#FFAB91", blend = "#FAFAFA", none = "NONE"})

local colors = {
  blue   = oxocarbon.base09,
  cyan   = oxocarbon.base07,
  black  = oxocarbon.base00,
  white  = oxocarbon.base04,
  red    = oxocarbon.base09,
  violet = oxocarbon.base12,
  grey   = '#303030',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black},
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '|',
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = { 'filename', 'branch', 'fileformat' },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {'nvim-tree', 'aerial', 'toggleterm', 'mason'},
}
