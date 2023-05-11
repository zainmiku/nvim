local M = {{
    "junegunn/fzf",
    event = 'CmdLineEnter',
},{
    "junegunn/fzf.vim",
    after = "fzf",
    un = 'cd ~/.fzf && ./install --all',
    config = function()
        require('config/fzf').setup()
    end
}}

return M
