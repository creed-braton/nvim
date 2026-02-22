-- Reserve a space in the gutter
vim.opt.signcolumn = 'yes'

vim.diagnostic.config({
  virtual_text = true,
})

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    if #event.file >= 3 and string.sub(event.file, -2) == "py" then
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
    else
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

-- list of language servers: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      buildFlags = {"-tags=test integration dev"}
    }
  }
})

vim.lsp.enable({
  'gopls',
  'rust_analyzer',
  'ts_ls',
  'html',
  'cssls',
  'dockerls',
  'terraformls',
  'clangd',
  'pylsp',
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(), --show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
  }),
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
    local file = vim.fn.expand("%")
    vim.fn.system({"go", "fmt", file})
    vim.cmd("silent! checktime")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.py",
  callback = function()
    local file = vim.fn.expand("%")
    vim.fn.system({"black", "--fast", file, "--line-length", "79"})
    vim.cmd("silent! checktime")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    "*.js", 
    "*.ts", 
    "*.jsx", 
    "*.tsx", 
    "*.md", 
    "*.yml", 
    "*.yaml", 
    "*.json", 
    "*.css", 
    "*.htm", 
    "*.html",
  },
  callback = function()
    local file = vim.fn.expand("%")
    vim.fn.system({"prettier", "--write", file})
    vim.cmd("silent! checktime")
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = {"*.tf", "*.tfvars", "*.hcl"},
  callback = function()
    local file = vim.fn.expand("%")
    vim.fn.system({"terraform", "fmt", file})
    vim.cmd("silent! checktime")
  end,
})
