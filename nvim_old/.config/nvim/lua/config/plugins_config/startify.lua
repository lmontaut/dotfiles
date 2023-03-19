vim.g.startify_session_dir = '~/.cache/nvim/sessions'
vim.g.startify_lists = {
  { type = 'sessions', header = {' Sessions'} },
  { type = 'bookmarks', header= {' Bookmarks'} },
  { type = 'files', header= {' Files'} }
}
vim.g.startify_bookmarks = {
  { c = '~/dotfiles/nvim/.config/nvim/init.lua' },
  { o = '~/orga/TODO.md' },
  { i = '~/dotfiles/i3/.config/i3/config' },
  { z = '~/dotfiles/zsh/.zshrc' },
}

-- Automatically restart a session
vim.g.startify_session_autoload = 1
-- Let startify handle buffers
vim.g.startify_session_delete_buffers = 1

vim.g.startify_change_to_vcs_root = 1

-- Automatically update sessions
vim.g.startify_session_persistence = 1

-- Get rid of buffer on quit
vim.g.startify_enable_special = 0

vim.g.startify_custom_header = {
            [[       ___          ___                                      ___          ___     ]],
            [[      /\  \        /\__\                                    /\  \        /\  \    ]],
            [[      \:\  \      /:/ _/_       ___                 ___    /::\  \       \:\  \   ]],
            [[       \:\  \    /:/ /\__\     /|  |               /|  |  /:/\:\  \       \:\  \  ]],
            [[   ___ /::\  \  /:/ /:/ _/_   |:|  |              |:|  | /:/  \:\  \  ___  \:\  \ ]],
            [[  /\  /:/\:\__\/:/_/:/ /\__\  |:|  |              |:|  |/:/__/ \:\__\/\  \  \:\__\]],
            [[  \:\/:/  \/__/\:\/:/ /:/  /__|:|__|            __|:|__|\:\  \ /:/  /\:\  \ /:/  /]],
            [[   \::/__/      \::/_/:/  //::::\  \           /::::\  \ \:\  /:/  /  \:\  /:/  / ]],
            [[    \:\  \       \:\/:/  / ~~~~\:\  \          ~~~~\:\  \ \:\/:/  /    \:\/:/  /  ]],
            [[     \:\__\       \::/  /       \:\__\              \:\__\ \::/  /      \::/  /   ]],
            [[      \/__/        \/__/         \/__/               \/__/  \/__/        \/__/    ]]
}

-- "  ____    ____                          ____     ___                ",
-- "  `MM'    `MM'                          `MM(     )M'                ",
-- "   MM      MM                            `MM.    d'                 ",
-- "   MM      MM   ____  ____    ___         `MM.  d' _____  ___   ___ ",
-- "   MM      MM  6MMMMb `MM(    )M'          `MM d' 6MMMMMb `MM    MM ",
-- "   MMMMMMMMMM 6M'  `Mb `Mb    d'            `MM' 6M'   `Mb MM    MM ",
-- "   MM      MM MM    MM  YM.  ,P              MM  MM     MM MM    MM ",
-- "   MM      MM MMMMMMMM   MM  M               MM  MM     MM MM    MM ",
-- "   MM      MM MM         `Mbd'               MM  MM     MM MM    MM ",
-- "   MM      MM YM    d9    YMP                MM  YM.   ,M9 YM.   MM ",
-- "  _MM_    _MM_ YMMMM9      M                _MM_  YMMMMM9   YMMM9MM_",
-- "                          d'                                        ",
-- "                      (8),P                                         ",
-- "                       YMM                                          "
