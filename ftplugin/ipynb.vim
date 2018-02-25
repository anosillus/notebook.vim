" Fold python's input and output cells using marker
set foldmethod=marker
set foldmarker=```{.,```

" Substitution of fold name, effectively doing the following
" {.python .input n=i} -> In{i}
" {.json .output n=i} -> Out{i}
" {.python .input} -> Code Cell (unnumbered input cell)
set foldtext=substitute(substitute(substitute(getline(v:foldstart),'```{.python\ .input\ \ n=','In{','g'),'```{.json\ .output\ n=','Out{','g'),'```{.python\ .input}','In:','g')
setlocal completefunc=syntaxcomplete#Complete
