let g:lightline = {
  \  'active' : {
  \    'left' : [
  \      ['mode', 'paste'],
  \      ['readonly', 'absolutepath', 'modified', 'ale']
  \    ],
  \    'right' : [
  \      ['lineinfo'],
  \      ['percent'],
  \      ['fileformat', 'fileencoding', 'filetype', 'gitbranch']
  \    ]
  \  },
  \  'component_function' : {
  \    'ale' : 'ALEGetStatusLine',
  \    'gitbranch' : 'fugitive#head'
  \  }
  \}

