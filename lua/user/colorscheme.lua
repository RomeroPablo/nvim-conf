local M = {
 -- "folke/tokyonight.nvim",
  "morhetz/gruvbox",
  -- commit = "e52c41314e83232840d6970e6b072f9fba242eb9",
  commit = "bf2885a95efdad7bd5e4794dd0213917770d79b7",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

-- M.name = "tokyonight-night"
M.name = "gruvbox"
function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
