local M = {}


local HOME = os.getenv "HOME"
local DEBUGGER_LOCATION = HOME .. "/git/vscode-bash-debug"

function M.setup()
  local dap = require "dap"
  dap.adapters.sh = {
    type = "executable",
    command = "node",
    args = { DEBUGGER_LOCATION .. "/out/bashDebug.js" },
  }
  dap.configurations.sh = {
    {
      name = "Launch Bash debugger",
      type = "sh",
      request = "launch",
      program = "${file}",
      cwd = "${fileDirname}",
      pathBashdb = DEBUGGER_LOCATION .. "/bashdb_dir/bashdb",
      pathBashdbLib = DEBUGGER_LOCATION .. "/bashdb_dir",
      pathBash = "bash",
      pathCat = "cat",
      pathMkfifo = "mkfifo",
      pathPkill = "pkill",
      env = {},
      args = {},
      -- showDebugOutput = true,
      -- trace = true,
   }
  }
end

return M

