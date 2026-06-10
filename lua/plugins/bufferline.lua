return {
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = false,
	  modified_icon = '●',
	  
	  separator_style = "slant",
	  style_preset = "no_italic",

	  offsets = {
	    {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center", -- "left" | "center" | "right"
              separator = true
	    },
          },
	},
      })
    end
  }
}
