local M = {{
    "voldikss/vim-floaterm",
    event = 'CmdLineEnter',
    config = function()
        require('config/vim-floaterm').setup()
    end
}}
return M
