return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            local dap_python = require("dap-python")

            local function install_debugpy(python_path)
                local check_cmd = python_path .. ' -c "import debugpy" 2>&1'
                local handle = io.popen(check_cmd)
                local result = handle:read("*a")
                handle:close()

                -- If debugpy is not found, install it
                if result:match("ModuleNotFoundError") or result:match("ImportError") then
                    vim.notify("Installing debugpy for " .. python_path)

                    local install_cmd = python_path .. " -m pip install debugpy"
                    local success = os.execute(install_cmd)

                    if success then
                        vim.notify("debugpy installed successfully!")
                        return true
                    else
                        vim.notify("Failed to install debugpy", vim.log.levels.ERROR)
                        return false
                    end
                end

                return true
            end

            local function find_venv_python()
                local cwd = vim.fn.getcwd()

                -- Check common venv locations
                local venv_candidates = {
                    cwd .. "/venv/bin/python",
                    cwd .. "/venv/bin/python3",
                    cwd .. "/.venv/bin/python",
                    cwd .. "/.venv/bin/python3",
                    cwd .. "/env/bin/python",
                    cwd .. "/env/bin/python3",
                }

                -- Check if any venv exists
                for _, candidate in ipairs(venv_candidates) do
                    vim.notify(candidate)
                    if vim.fn.filereadable(candidate) == 1 then
                        return candidate
                    end
                end

                -- Check for virtual environment via python module
                local handle = io.popen('python3 -c "import sys; print(sys.executable)" 2>/dev/null')
                local python_exec = handle:read("*a"):gsub("\n", "")
                handle:close()

                return python_exec or "python3"
            end

            require("dapui").setup({})
            require("nvim-dap-virtual-text").setup({
                commented = true, -- Show virtual text alongside comment
            })

            local python_path = find_venv_python()

            if install_debugpy(python_path) then
                dap_python.setup(python_path)
                vim.notify("DAP ready with: " .. python_path)
            else
                vim.notify("Could not setup Python DAP. Install debugpy manually: pip install debugpy",
                    vim.log.levels.ERROR)
            end

            dap_python.setup(python_path)

            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapBreakpointRejected", {
                text = "", -- or "❌"
                texthl = "DiagnosticSignError",
                linehl = "",
                numhl = "",
            })

            vim.fn.sign_define("DapStopped", {
                text = "", -- or "→"
                texthl = "DiagnosticSignWarn",
                linehl = "Visual",
                numhl = "DiagnosticSignWarn",
            })

            -- Automatically open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end

            local opts = { noremap = true, silent = true }

            -- Toggle breakpoint
            vim.keymap.set("n", "<leader>db", function()
                dap.toggle_breakpoint()
            end, opts)

            -- Continue / Start
            vim.keymap.set("n", "<F5>", function()
                dap.continue()
            end, opts)

            -- Step Over
            vim.keymap.set("n", "<F6>", function()
                dap.step_over()
            end, opts)

            -- Step Into
            vim.keymap.set("n", "<F7>", function()
                dap.step_into()
            end, opts)

            -- Step Out
            vim.keymap.set("n", "<F19>", function()
                dap.step_out()
            end, opts)

            -- Keymap to terminate debugging
            vim.keymap.set("n", "<F8>", function()
                require("dap").terminate()
            end, opts)

            -- Toggle DAP UI
            vim.keymap.set("n", "<F20>", function()
                dapui.toggle()
            end, opts)
        end,
    },
}
