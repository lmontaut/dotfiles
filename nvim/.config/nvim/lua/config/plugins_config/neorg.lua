require('nvim-treesitter.configs').setup {
    ensure_installed = { "norg", --[[ other parsers you would wish to have ]] },
    highlight = { -- Be sure to enable highlights if you haven't!
        enable = true,
    }
}
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/dev/org", -- Format: <name_of_workspace> = <path_to_workspace_root>
                },
                autochdir = false, -- Automatically change the directory to the current workspace's root every time
                index = "index.norg", -- The name of the main (root) .norg file
            }
        },
        ["core.gtd.base"] = {
           config = { -- Note that this table is optional and doesn't need to be provided
               workspace = "work",
           }
        },
    }
}
