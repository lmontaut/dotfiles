-- See https://github.com/vim-test/vim-test to configure

vim.cmd[[
  let test#strategy = "neovim"
  " let g:test#neovim#start_normal = 1 " so that the terminal does not close when pressing a key
  let test#neovim#term_position = "vert"
  " Important: vim-test, by default, operates in the "build" folder
  "-> must generate a build folder with CMake beforehand
  let g:test#cpp#catch2#bin_dir = "./test" "vim-test is already in build
]]
