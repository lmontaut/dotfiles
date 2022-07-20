-- Default value is clap
-- vim.g.dashboard_default_executive ='telescope'
-- vim.cmd("let g:dashboard_custom_shortcut={ 'last_session'       : 'SPC v l', 'find_history'       : 'SPC f r', 'find_file'          : 'SPC f f', 'new_file'           : 'SPC c n', 'change_colorscheme' : 'SPC v p', 'find_word'          : 'SPC f g', 'book_marks'         : 'SPC f R', }")

-- vim.g.dashboard_custom_header = {
-- [[██╗  ██╗███████╗██╗   ██╗    ██╗   ██╗ ██████╗ ██╗   ██╗]],
-- [[██║  ██║██╔════╝╚██╗ ██╔╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║]],
-- [[███████║█████╗   ╚████╔╝      ╚████╔╝ ██║   ██║██║   ██║]],
-- [[██╔══██║██╔══╝    ╚██╔╝        ╚██╔╝  ██║   ██║██║   ██║]],
-- [[██║  ██║███████╗   ██║          ██║   ╚██████╔╝╚██████╔╝]],
-- [[╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝    ╚═════╝  ╚═════╝ ]]
-- }


local dashboard = require('dashboard')
dashboard.custom_header = {
  [[                                                        ]],
  [[                                                        ]],
  [[                                                        ]],
  [[██╗  ██╗███████╗██╗   ██╗    ██╗   ██╗ ██████╗ ██╗   ██╗]],
  [[██║  ██║██╔════╝╚██╗ ██╔╝    ╚██╗ ██╔╝██╔═══██╗██║   ██║]],
  [[███████║█████╗   ╚████╔╝      ╚████╔╝ ██║   ██║██║   ██║]],
  [[██╔══██║██╔══╝    ╚██╔╝        ╚██╔╝  ██║   ██║██║   ██║]],
  [[██║  ██║███████╗   ██║          ██║   ╚██████╔╝╚██████╔╝]],
  [[╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝    ╚═════╝  ╚═════╝ ]],
  [[                                                        ]],
  [[                                                        ]],
  [[                                                        ]],
}
-- dashboard.custom_center = {
--   {icon = '  ',
--   desc ='New File                            ',
--   action =  'DashboardNewFile'},
--   {icon = '  ',
--   desc = 'Recent Files                        ',
--   action =  ':browse oldfiles'},
--   {icon = '  ',
--   desc = 'Configuration                       ',
--   action = ':edit ~/.config/nvim/init.lua'},
-- }
dashboard.preview_file_height = 12
dashboard.preview_file_width = 80
local home = os.getenv('HOME')
dashboard.custom_center = {
    -- {icon = '  ',
    -- desc = 'Recently latest session                  ',
    -- shortcut = 'SPC v l',
    -- action ='SessionLoad'},
    {icon = '  ',
    desc = 'Recently opened files                   ',
    action =  'DashboardFindHistory',
    shortcut = 'SPC f r'},
    {icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'SPC SPC'},
    -- {icon = '  ',
    -- desc ='File Browser                            ',
    -- action =  'Telescope file_browser',
    -- shortcut = 'SPC e'},
    {icon = '  ',
    desc = 'Find  word                              ',
    action = 'Telescope live_grep',
    shortcut = 'SPC f g'},
    {icon = '  ',
    desc = 'Open Personal dotfiles                  ',
    action = 'Telescope dotfiles path=' .. home ..'/dotfiles',
    shortcut = 'SPC v p'},
}
