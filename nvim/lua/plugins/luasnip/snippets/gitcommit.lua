return {
  s({ trig = 'r', dscr = 'refactor' }, t('refactor: ')),
  s({ trig = 'fi', dscr = 'fix' }, t('fix: ')),
  s({ trig = 'c', dscr = 'chore' }, t('chore: ')),
  s({ trig = 'b', dscr = 'build' }, t('build: ')),
  s({ trig = 'f', dscr = 'feat' }, t('feat: ')),
  s({ trig = 't', dscr = 'test' }, t('test: ')),
}
