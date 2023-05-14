local M = {{
    "junegunn/fzf",
    event = 'CmdLineEnter',
    -- cmd = { 'RG', 'Files', 'BLines', 'GFiles', 'CHistory' },
},{
    "junegunn/fzf.vim",
    after = "fzf",
    un = 'cd ~/.fzf && ./install --all',
    event = 'CmdLineEnter',
    -- cmd = { 'RG', 'Files', 'BLines', 'GFiles', 'CHistory' },
    config = function()
        require('config/fzf').setup()
    end
}}

return M
