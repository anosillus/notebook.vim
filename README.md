# Not developping
I rarely write python in jupyter notebook anymore and do very little development now.
I don't know much about recent development, but I'm sure there are good projects out there if you look for them, and I think lua is easier to write in now.

## This program's issue (For further development)
When you save or update a file that you have edited, there may be some strange behavior if another program is currently using the file. This can happen, for example, when you are editing a Jupyter notebook and it is open in Chrome. This is the only issue that I am aware of with this project.

# Vim-ipynb

- 　This is fork of [szymonmaszke/vimpyter](https://github.com/szymonmaszke/vimpyter).
- 　This fork enable us to open ipynb as Python file in vim.
- 　After you edit ipynb file as Python file, your edit would be save as ipynb file.

## Installation

　**Vim8 or Neovim is required (asynchronous features)**

　Install required external dependency:

- 　**[ipynb-py-convert](https://github.com/kiwi0fruit/ipynb-py-convert)**

## Configuration

- 　**g:vimpyter_view_directory**: directory where proxy files are created (default: `$TMP`)

## Integrations with other plugins

　Ipynb file would be opened as Python file. You can use python plugins.

## Known bugs
### 1. you cann't edit jupyter mounted file.
When you open one file in jupyter and vim at same time, the file is mounted by jupyter. 
So vim can't update with your edited history.
Please close the file in brower.

### 2. ~`:wq` bug.~(Solved)
I recommend you not to use `:wq`.   
If you take too much time to updating file, your data can be lost.(I think this situation is caused by #1 error.)  
When you use `:wq` command, preventing your file saving failed, vim sleeps 1 seconds. But it is not enough.  
It can be fixed later. [ALE](https://github.com/dense-analysis/ale) has solved this issue.

## ToDo
  ### 1. fix `:wq` support.
  ### 2. `$TMP` dir change.
  ### 3. change API name.
  If you install vimpyter at same time. Some trouble can be happen.       
  ### 4. Multi Kernel support.
  I will make my own python plugin which doesn't depend on ipynb-py-convert for dealing with [other kernels ](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)
  ### 5. Syntastics Support
   The target is sql and R in python. I will use [context_filetype.vim](https://github.com/Shougo/context_filetype.vim)
  ### 6. Exceclution Support
  If I add this, the excecution style is like [Nvim-R](https://github.com/jalvesaq/Nvim-R) or [jupyter-vim](https://github.com/wmvanvliet/jupyter-vim).  
  Now I am using browser for plot execution or use [quickrun](https://github.com/thinca/vim-quickrun) for easy test.
  But if some user need this function, I will try to add it.
  This function would be strongly relating with multi Kernel support.
##
## I am welcome pull requests and issue, questions.
