if !exists('s:configured_vindect')
  if has("python")
    py from imp import load_source
    py from os.path import join as path_join
    try
      py vindect = load_source('vindect', path_join(vim.eval('expand("<sfile>:p:h")'), 'vindect.py'))
      let s:configured_vindect = 1
    catch
      let s:configured_vindect = 0
    endtry
  else
    let s:configured_vindect = 0
  endif
endif
if s:configured_vindect
  py vindect.setDefaults(indent='space', shiftwidth=4, verbose=0)
  au Syntax * py vindect.detect(preferred='space', preferredsw=4)
  au Syntax ruby py vindect.detect(preferred='space', preferredsw=2)
  au Syntax help py vindect.detect(preferred='mix', dosyntax=0, preferredsw=4)
  au Syntax gitconfig py vindect.detect(preferred='tab', preferredsw=4)
endif
