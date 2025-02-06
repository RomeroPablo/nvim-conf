-- Load core settings
require("core.options")
require("core.keymaps")

-- Plugin management
require("plugins.lazy")

-- LSP settings (will populate later)
require("lsp.setup")

vim.env.SHELL = "/bin/bash"

-- Default to no folds open
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
