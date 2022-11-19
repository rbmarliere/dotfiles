-- https://alpha2phi.medium.com/neovim-for-beginners-debugging-using-dap-44626a767f57

local M = {}

local function configure()
  -- local dap_install = require "dap-install"
  -- dap_install.setup {
  --   installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  -- }

  local dap_breakpoint = {
    error = {
      text = ">",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "-",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "*",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  require("nvim-dap-virtual-text").setup {
    commented = true,
  }
end

local function configure_debuggers()
  require("config.dap.typescript").setup()
  require("config.dap.python").setup()
  require("config.dap.bash").setup()
end

function M.setup()
  configure() -- Configuration
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  require("config.dap.keymaps").setup() -- Keymaps
  require("config.dap.ui") -- UI
end

configure_debuggers()

return M
