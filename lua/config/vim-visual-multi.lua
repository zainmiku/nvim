local G = require('G')
local M = {}

function M.config()
    G.g.VM_theme = 'ocean'
    G.g.VM_highlight_matches = 'underline'
    G.g.VM_maps = {
        ['Find Under'] = '<C-n>',
        ['Find Subword Under'] = '<C-n>',
        ['Select All'] = '<C-s>',
        ['Select h'] = '<C-Left>',
        ['Select l'] = '<C-Right>',
        ['Add Cursor Up'] = '<C-Up>',
        ['Add Cursor Down'] = '<C-Down>',
        ['Add Cursor At Pos'] = '<C-x>',
        ['Add Cursor At Word'] = '<C-w>',
        ['Move Left'] = '<C-S-Left>',
        ['Move Right'] = '<C-S-Right>',
        ['Remove Region'] = 'q',
        ['Increase'] = '+',
        ['Decrease'] = '_',
        ["Undo"] = 'u',
        ["Redo"] = '<C-r>',
    }
end

function M.setup()
    -- do nothing
end

return M
