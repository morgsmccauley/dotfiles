local whichkey = require('whichkey_setup')

local keymap = {
    w = {':w!<CR>', 'save file'} -- set a single command and text
}

whichkey.register_keymap('leader', keymap)
