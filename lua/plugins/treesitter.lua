local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    print("couldn't load treesitter")
    return
end

treesitter.setup {
    ensure_installed = {
        "go",
        "typescript",
        "html",
        "css",
        "c",
        "python",
        "lua",
        "dockerfile",
        "make",
        "bash",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
        enable = true,

        disable = { "latex" },

        additional_vim_regex_highlighting = false,
    },
}
