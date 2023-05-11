local M = {{
    "kyazdani42/nvim-tree.lua",
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' },
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
        require('config/nvim-tree').setup()
    end
}}

return M
