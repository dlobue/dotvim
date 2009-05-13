if !exists('s:configured_vindect')
  if has("python")
    py import sys,os; sys.path.append(os.path.expanduser("~/.vim/"))
    try
      py import vindect
      let s:configured_vindect = 1
    catch
      let s:configured_vindect = 0
    endtry
    "if you want different defaults: py vindect.setDefaults(...)
  else
    let s:configured_vindect = 0
  endif
endif
if s:configured_vindect
  py vindect.detect(preferred='space')
endif
