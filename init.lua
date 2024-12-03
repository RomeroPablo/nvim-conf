-- Load core settings
require("core.options")
require("core.keymaps")

-- Plugin management setup (empty for now; we’ll configure this soon)
require("plugins.lazy")

-- LSP settings (will populate later)
require("lsp.setup")

-- Default to no folds open
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
