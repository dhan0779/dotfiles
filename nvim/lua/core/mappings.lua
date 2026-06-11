vim.keymap.set("n", "-", vim.cmd.Ex)
vim.opt.number = true


-- Telescope keymaps
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, { desc = 'Telescope help tags' })

vim.keymap.set('n', '<leader>e', '<cmd>Neotree toggle<cr>', { desc = 'Toggle file explorer' })
vim.keymap.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Lazy plugin manager' })

vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview Open' })
vim.keymap.set('n', '<leader>gc', '<cmd>DiffviewClose<cr>', { desc = 'Diffview Close' })
