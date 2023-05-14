local M = {
        -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        event = 'InsertEnter',
        config = function()
            require('config/nvim-cmp').setup()
        end
    },{
        "hrsh7th/cmp-cmdline"  
    },{
        "hrsh7th/cmp-path"
    },{
        "hrsh7th/cmp-buffer"
    },{
        "hrsh7th/cmp-nvim-lsp"
    },
        -- vsnip
    {
        "hrsh7th/cmp-vsnip"
    },{
        "hrsh7th/vim-vsnip"
    },{
        "rafamadriz/friendly-snippets"
    }
}
return M
