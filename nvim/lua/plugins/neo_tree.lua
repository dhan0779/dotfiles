return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        default_component_configs = {
          git_status = {
            symbols = {
              modified  = "●",
              untracked = "●",
              added     = "●",
              deleted   = "",
              renamed   = "",
              staged    = "",
              unstaged  = "",
              conflict  = "",
              ignored   = "",
            },
          },
        },
      })

      local function git_colors()
        vim.api.nvim_set_hl(0, "NeoTreeGitModified",  { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "NeoTreeGitAdded",     { fg = "#a6e3a1" })
        vim.api.nvim_set_hl(0, "NeoTreeGitStaged",    { fg = "#a6e3a1" })
      end
      git_colors()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = git_colors })
    end,
  },
}
