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

　When you use `:wq` command, preventing your file saving failed, vim sleeps 1 seconds. (It can be fixed later. https://github.com/dense-analysis/ale can work well.)

## ToDo
  ### 1. Multilanguage support.
  (https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)
  ### 2. Syntastics Support
   The target is sql and R in python. I will use https://github.com/Shougo/context_filetype.vim.
  ### 3. Exceclution Support
  If I add this, The excecution style like https://github.com/jalvesaq/Nvim-R or https://github.com/wmvanvliet/jupyter-vim.
  Now I am using browser for plot execution or use quickrun for easy test.(https://github.com/thinca/vim-quickrun)
  But if some user need this function, I will try to add it.
  This function would be strongly relating with multilanguage support.
