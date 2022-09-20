require('neogit').setup {
  disable_commit_confirmation = true,
  disable_insert_on_commit = false,
  kind = 'tab',
  integrations = {
    diffview = true
  },
  mappings = {
    status = {
      ['p'] = 'PushPopup',
      ['l'] = 'PullPopup'
    }
  }
}
