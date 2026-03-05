require("tokyonight").setup({
  -- use the night style
  style = "night",
  transparent = true,
  -- disable italic for functions
  styles = {
    functions = {},
    sidebars = "transparent",
    floats = "transparent",
  },
  sidebars = { "qf", "vista_kind", "terminal", "packer" },
  -- Change the "hint" color to the "orange" color, and make the "error" color bright red
  on_colors = function(colors)
    colors.comment = "#909090"
  end
})

local status, _ = pcall(vim.cmd, "colorscheme tokyonight")
if not status then
    print("couldn't find colorscheme tokyonight")
    return
end
