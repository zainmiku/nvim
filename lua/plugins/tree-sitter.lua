local M = {{
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate', 
    event = 'BufRead',
    config = function()
        require('config/tree-sitter').setup()
    end
},{
    "nvim-treesitter/playground",
    after = 'nvim-treesitter', 

}}

return M
