" Display terminal messages in color if g:vimpyter_color = 1

" Update jupyter notebook when saving buffer
function! vimpyter#updateNotebook()
	if !exists('b:proxy_file')
		return
	endif
  " Updating notebook for neovim (another function for vim, line 53)
  function! s:updateNotebookNeovim()
    function! s:updateSuccessNeovim(job_id, data, event)
      if a:data == 0
        echo 'Updated source notebook'
      else
        echoerr 'Failed to update original notebook'
      endif
    endfunction

  "Set the last updated file flag (job_id in case of neovim)
  "(see function below: vimpyter#notebookUpdatesFinished())
  let g:vimpyter_internal_last_save_flag = jobstart(
        \ 'ipynb-py-convert '  . b:proxy_file .
        \ ' ' . b:original_file,
        \ {
        \  'on_exit': function('s:updateSuccessNeovim')
        \ })
  endfunction

  "Updating notebook for vim
  function! s:updateNotebookVim()
    function! s:updateSuccessVim(channel, message)
      if a:message== 0
        echo 'Updated source notebook'
      else
        echoerr 'Failed to update original notebook'
      endif
    endfunction

    "Set the last updated file flag (string in case of vim, see documentation)
    "(see function below: vimpyter#notebookUpdatesFinished())
    let l:command = [&shell, &shellcmdflag,
          \ 'ipynb-py-convert ' .
          \ b:proxy_file . ' ' . b:original_file]
    let g:vimpyter_internal_last_save_flag = job_start(
          \ l:command, {'exit_cb': function('s:updateSuccessVim')})
  endfunction

  if has('nvim')
    call s:updateNotebookNeovim()
  else
    call s:updateNotebookVim()
  endif
endfunction

"Create view by notedown in /tmp directory with specified filename
function! vimpyter#createView()
  "Checks if buffer of this name already exists.
  "If it does, returns the name of buffer with appropriate number appended
  "Otherwise returns buffer name
  function! s:checkNameExistence(name)
    " Buffer name like this already exists, append number
    if has_key(g:vimpyter_buffer_names, a:name)
      let l:buffer_name = g:vimpyter_buffer_names[a:name]
      let g:vimpyter_buffer_names[a:name] = l:buffer_name + 1
      return a:name . string(l:buffer_name) . '.py'
    else
      let g:vimpyter_buffer_names[a:name] = 0
      return a:name . '.py'
    endif
    return ''
  endfunction

  " Save original file path and create path to proxy
  let l:original_file = substitute(expand('%:p'), '\ ', '\\ ', 'g')
  let l:original_dir = substitute(expand('%:p:h'), '\ ', '\\ ', 'g')
  " Proxies are named accordingly to %:t:r (with appended number for
  " replicating names) (see documentation for more informations)
  let l:proxy_file_name = '.ipynb_tmp.' . expand('%:t:r')
  let l:proxy_buffer_name = s:checkNameExistence(l:proxy_file_name)
  if g:vimpyter_use_current_dir
    let l:proxy_file = l:original_dir . '/' . l:proxy_buffer_name
  else
    let l:proxy_file = g:vimpyter_view_directory . '/' . l:proxy_buffer_name
  endif

  " Transform json to markdown and save the result in proxy
	call system('ipynb-py-convert ' . l:original_file .
				\ ' ' . l:proxy_file)

  " Open proxy file
  silent execute 'edit' l:proxy_file
	let b:ipynb_mode = 1
  " Save references to proxy file and the original
  let b:original_file = l:original_file
  call add(g:vimpyter_proxy_files, l:proxy_file)
  let b:ipynb_on = 1


  " Close original file (it won't be edited directly)
  silent execute ':bw' l:original_file

  " SET FILETYPE TO ipynb
  set filetype=python
endfunction

" Close vim/nvim only if all updates finished
function! vimpyter#notebookUpdatesFinished()
  if has('nvim')
    " infinite loop waiting for last update to finish
    while jobwait([g:vimpyter_internal_last_save_flag]) != [-3]
      echo 'Waiting vim-ipynb...'
    endwhile
  else
    " Vim asynchronous API returns string instead of job_id (WHY?!)
    " It's internal flag regarding last saved file has to be empty string
    if g:vimpyter_internal_last_save_flag !=? ''
      " infinite loop waiting for last update to finish
      while job_status(g:vimpyter_internal_last_save_flag) !~? 'dead'
				echo 'Updating as ipynb...'
      endwhile
    endif
  endif
  call system('rm ' . join(g:vimpyter_proxy_files, ' '))

endfunction
