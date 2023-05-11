local M = {{
    "github/copilot.vim",
    event = 'InsertEnter',
    config = function()
        require('config/copilot').setup()
    end
}}

return M
