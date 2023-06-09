local M = { {
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require('config/tree-sitter').setup()
    end
}, {
    "nvim-treesitter/playground",
    after = 'nvim-treesitter',

} }

return M
