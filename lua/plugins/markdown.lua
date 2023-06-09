local M = { {
    "mzlogin/vim-markdown-toc",
    ft = 'markdown',
}, {
    "iamcco/markdown-preview.nvim",
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = 'markdown',
    config = function()
        require('config/markdown').setup()
    end
} }

return M
