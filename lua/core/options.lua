local opt = vim.opt  -- Shorten the reference to `vim.opt`

-- Enable line numbers
opt.number = true
opt.relativenumber = true

-- Enable mouse support
opt.mouse = "a"

-- Set tab and indentation preferences
opt.expandtab = true       -- Use spaces instead of tabs
opt.shiftwidth = 4         -- Size of an indentation level
opt.tabstop = 4            -- Number of spaces per tab

-- Set search settings
opt.ignorecase = true      -- Ignore case in search patterns
opt.smartcase = true       -- Override ignorecase if the search pattern has upper case

-- Appearance
opt.termguicolors = true   -- Enable 24-bit RGB colors
opt.signcolumn = "yes"     -- Always show the sign column to avoid shifting text

-- Performance
opt.updatetime = 10       -- Faster completion and updates
opt.timeoutlen = 500       -- Shorter timeout for mapped key sequences
