local M ={}

function M.setup()
  local dap = require('dap')
  -- LINUX
  dap.adapters.cppdbg = {
    id = "cppdbg",
    type = 'executable',
    -- command = os.getenv("CONDA_PREFIX") .. "/bin/lldb-vscode", -- adjust as needed
    command = "/home/lou/libs/cpptoold_linux/extension/debugAdapters/bin/OpenDebugAD7",
  }
  -- MACOS - does not have gdb on M1
  -- dap.adapters.cppdbg = {
  --   id = "cppdbg",
  --   type = 'executable',
  --   -- command = os.getenv("CONDA_PREFIX") .. "/bin/lldb-vscode", -- adjust as needed
  --   command = "/Users/louis/code/misc/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
  -- }
  dap.adapters.lldb = {
    type = 'executable',
    id = "lldb",
    command = "/opt/homebrew/Cellar/llvm/15.0.5/bin/lldb-vscode"
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
    },
  }
  -- If you want to use this for rust and c, add something like this:
  -- dap.configurations.c = dap.configurations.cpp
  -- dap.configurations.rust = dap.configurations.cpp
end

return M
