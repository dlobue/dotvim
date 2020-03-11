if !exists('s:configured_vindect')
  if has("python3")
    py3 from imp import load_source
    py3 from os.path import join as path_join
    try
      py3 vindect = load_source('vindect', path_join(vim.eval('expand("<sfile>:p:h")'), 'vindect.py'))
      let s:configured_vindect = 1
    catch
      let s:configured_vindect = 0
    endtry
  else
    let s:configured_vindect = 0
  endif
endif
if s:configured_vindect
  py3 vindect.setDefaults(indent='space', shiftwidth=4, verbose=0)
  au Syntax * py3 vindect.detect(preferred='space', preferredsw=4)
  au Syntax ruby py3 vindect.detect(preferred='space', preferredsw=2)
  au Syntax help py3 vindect.detect(preferred='mix', dosyntax=0, preferredsw=4)
  au Syntax gitconfig py3 vindect.detect(preferred='tab', preferredsw=4)
  au Syntax c,cpp py3 vindect.detect(preferred='tab', preferredsw=4)
  au Syntax go,golang py3 vindect.detect(preferred='tab', preferredsw=4, force='tab')
endif
