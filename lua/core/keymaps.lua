local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = " " -- set leader key to space

-- Basic key mappings
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)  -- Example key for file explorer toggle
map("n", "<leader>q", ":q<CR>", opts)               -- Quick exit
map("n", "<leader>w", ":w<CR>", opts)               -- Quick save

-- Toggle file explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Buffer navigation
map("n", "<leader>bn", ":bnext<CR>", opts)    -- Go to the next buffer
map("n", "<leader>bp", ":bprevious<CR>", opts) -- Go to the previous buffer
map("n", "<leader>bd", ":bd<CR>", opts)       -- Close the current buffer

-- Window splitting
map("n", "<leader>sv", ":vsplit<CR>", opts)   -- Vertical split
map("n", "<leader>sh", ":split<CR>", opts)    -- Horizontal split

-- Window navigation
map("n", "<leader>h", "<C-w>h", opts)         -- Move to the left window
map("n", "<leader>j", "<C-w>j", opts)         -- Move to the window below
map("n", "<leader>k", "<C-w>k", opts)         -- Move to the window above
map("n", "<leader>l", "<C-w>l", opts)         -- Move to the right window

-- LSP commands (will be functional when LSP is set up)
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)         -- Go to definition
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)               -- Show hover information
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)     -- Go to implementation
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)     -- Rename symbol
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- Show code actions

-- Buffer navigation using bufferline
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)  -- Shift + H to go to the previous buffer
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)  -- Shift + L to go to the next buffer
map("n", "<S-q>", ":bdelete<CR>", opts)              -- Shift + W to close the current buffer

-- Trigger formatting with <leader>fm
map("n", "<leader>fm", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true })

-- Toggle terminal with Ctrl + \
map("n", "<C-\\>", ":ToggleTerm<CR>", { noremap = true, silent = true })
map("t", "<C-\\>", "<C-\\><C-n>:ToggleTerm<CR>", { noremap = true, silent = true })

-- open markdown preview in browser
map('n', '<Leader>g', ':MarkdownPreview<CR>', { noremap = true, silent = true })

-- Preview the current PlantUML file
vim.api.nvim_set_keymap("n", "<leader>zc", ":PlantumlOpen<CR>", { noremap = true, silent = true })
-- Stop the preview
vim.api.nvim_set_keymap("n", "<leader>zc", ":PlantumlClose<CR>", { noremap = true, silent = true })

-- Toggle fold under cursor
vim.api.nvim_set_keymap("n", "<leader>z", "za", { noremap = true, silent = true })

-- Open all folds
vim.api.nvim_set_keymap("n", "<leader>zo", "zR", { noremap = true, silent = true })

-- Close all folds
vim.api.nvim_set_keymap("n", "<leader>zc", "zM", { noremap = true, silent = true })
