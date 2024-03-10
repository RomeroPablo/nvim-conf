local M = {
	"nvim-neorg/neorg",
    commit = "6aa9fd303c807ed1ca3fb15cdeab1e322d02fd31", -- we give it a commit hash ourself
	ft = "norg",
	cmd = "Neorg",
	build = ":Neorg sync-parsers",
	opts = {
		load = {
			["core.defaults"] = {}, -- Loads default behaviour
			["core.export"] = {},
			["core.concealer"] = {}, -- Adds pretty icons to your documents
			["core.dirman"] = { -- Manages Neorg workspaces
				config = {
					workspaces = {
						notes = "~/notes",
            comp = "~/notes/comp",
            mpd = "~/notes/modern-processor-design",
            bike = "~/notes/bike",
            freeRTOS = "~/notes/freeRTOS",
            emag = "~/notes/emag",
            LHR = "~/notes/LHR",
            
					},
				},
			},
		},
	},
	dependencies = { { "nvim-lua/plenary.nvim" } },
}

return M
