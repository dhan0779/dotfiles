return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggle", "DiffviewRefresh" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
  },
  opts = {
    enhanced_diff_hl = true,  -- See better diff highlights
    use_icons = true,         -- Requires nvim-web-devicons
    show_help_hints = false,  -- Hide the "Help: g?" hint in the panels
  },
}
