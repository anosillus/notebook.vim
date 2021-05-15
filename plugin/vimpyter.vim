let s:save_cpo = &cpoptions
set cpoptions&vim

" Check if plugin already loaded, don't use this variable elsewhere
if exists('g:loaded_vimpyter_plugin_dont_use_this_flag_elsewhere')
    finish
endif

" Is notedown executable present?
if !executable('ipynb-py-convert')
  echom 'ipynb-py-convert executable is required in order for vimpyter.vim to work. '
        \ . 'Check whether you have needed dependencies installed in README.md'
  finish
endif

" Version checks
if !has('nvim') && !v:version >= 800
  echom '[VIMPYTER] You need neovim/vim8'
        \ . ' to run this plugin. Update your software.'
  finish
endif

" Vi compatibility has to be turned off
if &compatible
  echom '[VIMPYTER] compatible option is set. Disable it to use this plugin.'
endif

" Create temp directory if not present
if has('unix') && empty($TMPDIR)
    let $TMPDIR = '/tmp'
endif

" Set flag to prevent loading the plugin multiple times
let g:loaded_vimpyter_plugin_dont_use_this_flag_elsewhere = 1

" Parse user defined flags for notebook loaders
" let g:vimpyter_jupyter_notebook_flags = get(g:, 'vimpyter_jupyter_notebook_flags', '')
" let g:vimpyter_nteract_flags = get(g:, 'vimpyter_nteract_flags', '')
let g:vimpyter_view_directory = get(g:, 'vimpyter_view_directory', $TMPDIR)
let g:vimpyter_use_current_dir = get(g:, 'vimpyter_use_current_dir', 1)

" Parse configuration for colorful display of text in cmdline
let g:vimpyter_color = get(g:, 'vimpyter_color', 0)

" Neovim's jobstart returns id (integer) while vim's job_start returns string.
" vimpyter_internal_last_save_flag points to the job that was run last during saving.
" IT IS POSSIBLE THIS METHOD WILL FAIL, but I don't see any other way to check
" whether any save job is running during closing.
if has('nvim')
  let g:vimpyter_internal_last_save_flag = 0
else
  let g:vimpyter_internal_last_save_flag = ''
endif

let g:vimpyter_buffer_names = {}

" DEFINE COMMANDS
" command! -nargs=0 VimpyterStartJupyter call vimpyter#startJupyter()
" command! -nargs=0 VimpyterStartNteract call vimpyter#startNteract()
command! -nargs=0 VimpyterUpdate call vimpyter#updateNotebook()

" command! -nargs=0 VimpyterInsertPythonBlock call vimpyter#insertPythonBlock()

" DEFINE AUTOCOMMANDS
augroup VimpyterAutoCommands
  autocmd!
  " If new/existing file opened, create view for it at the beginning
  " autocmd BufRead,BufNewFile *.ipynb let g:ipynbvim_working = 1
  autocmd BufReadPost *.ipynb call vimpyter#createView()
  autocmd BufNewFile *.ipynb call vimpyter#createView()
  " If view was saved transfer the changes from proxy to original file
  autocmd BufWritePost *.py~ if get(b:, 'ipynb_on', 0) is 1 | call vimpyter#updateNotebook() | endif
  autocmd VimLeavePre  *.py~ if get(b:, 'ipynb_on', 0) is 1 | call vimpyter#notebookUpdatesFinished() | endif

augroup END

" }}}

let &cpoptions = s:save_cpo
