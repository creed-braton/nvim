require("plugins.options")
require("plugins.remaps")
require("plugins-setup")
require("plugins.treesitter")
require("plugins.telescope")
require("plugins.harpoon")
require("plugins.colorscheme")
require("plugins.lualine")
require("plugins.gitsigns")
require("plugins.lsp")
require("plugins.autopairs")
require("plugins.vimtex")
-- require("plugins.transparent")

vim.api.nvim_create_autocmd('FileType', {
  callback = function() pcall(vim.treesitter.start) end,
})
