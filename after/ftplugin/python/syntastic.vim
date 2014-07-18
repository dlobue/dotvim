
if executable('flake8-python2')
    let g:syntastic_python_flake8_exe = 'flake8-python2'
endif

if executable('pep8-python2')
    let g:syntastic_python_pep8_exe = 'pep8-python2'
endif

if executable('python2')
    let g:syntastic_python_python_exe = 'python2'
endif

