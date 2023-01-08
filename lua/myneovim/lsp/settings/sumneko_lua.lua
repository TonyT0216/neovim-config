return {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins", "MiniTest" },
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.stdpath "config" .. "/lua"] = true,
          },
        },
        telemetry = {
          enable = false,
        },
      },
    },
  }