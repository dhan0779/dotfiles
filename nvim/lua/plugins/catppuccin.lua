return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        integrations = {
          neotree = true,
          diffview = true,
          bufferline = true,
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = { enabled = true },
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
