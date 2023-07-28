local M = { {
    "terryma/vim-expand-region",
    event = { "ModeChanged" },
    config = function()
        require('config/vim-expand-region').setup()
    end
} }

return M
