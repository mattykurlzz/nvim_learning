return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("mason-nvim-dap").setup({
            ensure_installed = { "python", "codelldb" },
            automatic_installation = true,
            handlers = {
                function(config)
                    require('mason-nvim-dap').default_setup(config)
                end,
            },
        })

        dapui.setup()
        require("nvim-dap-virtual-text").setup({ commented = true })

        local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(debugpy_path)

        dap.listeners.before.attach.dapui_config = function() dapui.open() end
        dap.listeners.before.launch.dapui_config = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })

        local opts = { noremap = true, silent = true }
        vim.keymap.set("n", "<F5>", dap.continue, opts)
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
    end,
}
