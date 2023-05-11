local M = {
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
    },{
        "neovim/nvim-lspconfig"
    },{
        "saadparwaiz1/cmp_luasnip"
    }
}
return M