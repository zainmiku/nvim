local M = {{
    dir = "~/.fzf",
    event = 'CmdLineEnter',
},{
    "junegunn/fzf.vim",
    after = "fzf",
    un = 'cd ~/.fzf && ./install --all',
    event = 'CmdLineEnter',
    config = function()
        require('config/fzf').setup()
    end
}}

return M
