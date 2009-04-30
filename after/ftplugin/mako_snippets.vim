if !exists('loaded_snippet') || &cp
    finish
endif

runtime! ftplugin/html_snippets.vim

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet <%def <%def name=\"".st.et."\" ".st.et."><CR>".st.et."<CR></%def>".st.et
exec "Snippet <%call <%call expr=\"".st.et."\"".st.et."><CR><Tab>".st.et."<CR></%expr>\<CR>".st.et
exec "Snippet <%doc <%doc><CR><Tab>".st.et."<CR></%doc><CR>".st.et
exec "Snippet <%text <%text ".st.et."><CR>".st.et."<CR></%text><CR>".st.et

exec "Snippet %for % for ".st.et." in ".st.et.":<CR><Tab>".st.et."<CR>% endfor<CR>".st.et
exec "Snippet %if % if ".st.et.":<CR><Tab>".st.et."<CR>% endif<CR>".st.et
exec "Snippet %try % try:<CR><Tab>".st.et."<CR>% except ".st.et.":<CR><Tab>".st.et."<CR>% endtry<CR>".st.et
exec "Snippet %else % else:<CR><Tab>".st.et
exec "Snippet %while % while ".st.et.":<CR><Tab>".st.et."<CR>% endwhile<CR>".st.et
exec "Snippet %elif % elif ".st.et.":<CR><Tab>".st.et

exec "Snippet ${ ${ ".st.et." }"
exec "Snippet <% <%<CR><Tab>".st.et."<CR>%><CR>".st.et
exec "Snippet <%! <%!<CR><Tab>".st.et."<CR>%><CR>".st.et

for ctag in ['page', 'namespace', 'include', 'inherit']
    exec "Snippet <%".ctag." <%".ctag." ".st.et."/>"
endfor
