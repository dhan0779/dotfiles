return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        highlights = {
          buffer_selected = { sp = "#ffffff", underline = true },
          modified_selected = { sp = "#ffffff", underline = true },
          numbers_selected = { sp = "#ffffff", underline = true },
          diagnostic_selected = { sp = "#ffffff", underline = true },
          info_selected = { sp = "#ffffff", underline = true },
          warning_selected = { sp = "#ffffff", underline = true },
          error_selected = { sp = "#ffffff", underline = true },
        },
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
	  modified_icon = '●',

	  indicator = { style = "underline" },
	  separator_style = "slant",
	  style_preset = "no_italic",

	  offsets = {
	    {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center", -- "left" | "center" | "right"
              separator = true
	    },
	    {
              filetype = "DiffviewFiles",
              text = "Source Control",
              text_align = "center",
              separator = true
	    },
	    {
              filetype = "DiffviewFileHistoryPanel",
              text = "Source Control",
              text_align = "center",
              separator = true
	    },
          },
	},
      })
    end
  }
}
