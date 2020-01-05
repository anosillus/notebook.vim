# Vim-ipynb

- 　This is fork of [szymonmaszke/vimpyter](https://github.com/szymonmaszke/vimpyter).
- 　This fork enable us to open ipynb as Python file in vim.
- 　After you edit ipynb file as Python file, your edit would be save as ipynb file.

## Installation

　**Vim8 or Neovim is required (asynchronous features)**

　Install required external dependency:

- 　**[ipynb-py-convert](https://github.com/kiwi0fruit/ipynb-py-convert)**

　Install plugin using plugin manager like **[vim-plug](https://github.com/junegunn/vim-plug)** or **[Vundle](https://github.com/VundleVim/Vundle.vim)**:

　If you want to use different plugin manager/direct installation please do refer to their respective repositories/documentation.

## Configuration

- 　**g:vimpyter_view_directory**: directory where proxy files are created (default: `$TMP`)

## Integrations with other plugins

　Ipynb file would be opened as Python file. You can use python plugins.

## Known bugs

　When you use `:wq` command, preventing your file saving failed, vim sleeps 1 seconds. (It can be fixed later.)
