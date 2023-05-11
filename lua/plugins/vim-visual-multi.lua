local M = {{
    "mg979/vim-visual-multi",
    event = 'CursorHold',
    config = function()
        require('config/vim-visual-multi').setup()
    end
}}

return M
