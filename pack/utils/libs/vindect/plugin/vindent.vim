if !exists('s:configured_vindect')
  let s:configured_vindect = 0
  if has("python3")
python3 << EOI
import importlib.util as impu
from os.path import join as path_join
vindect_spec = impu.spec_from_file_location('vindect', path_join(vim.eval('expand("<sfile>:p:h")'), 'vindect.py'))
vindect = impu.module_from_spec(vindect_spec)
EOI
    try
      py3 vindect_spec.loader.exec_module(vindect)
    endtry

"    try
"      py3 vindect = load_source('vindect', path_join(vim.eval('expand("<sfile>:p:h")'), 'vindect.py'))
"      let s:configured_vindect = 1
"    catch
"      let s:configured_vindect = 0
"    endtry
  "else
    "let s:configured_vindect = 0
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
