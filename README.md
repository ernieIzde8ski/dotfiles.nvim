# dotfiles.nvim

my neovim configs;
[the rest of my dotfiles exist here](https://github.com/ernieIzde8ski/dotfiles)

## usage

- linux: `git clone 'https://github.com/ernieIzde8ski/dotfiles.nvim.git' ~/.config/nvim`
- windows (untested): `git clone "https://github.com/ernieIzde8ski/dotfiles.nvim.git" "<user directory>/AppData/Local/nvim"`

## development

`pre-commit` requires `python3`. Because of
[an open issue in pre-commit](https://github.com/pre-commit/pre-commit/issues/3230),
it is currently necessary to manually install stylua:
`cargo install stylua --features lua52`

### vscode support

From vscode-neovim/vscode-neovim:

> Make sure to disable unneeded plugins, as many of them don't make sense with
> VSCode. Specifically, you don't need any code highlighting, completion, LSP
> plugins, or plugins that spawn windows/buffers (nerdtree , fuzzy-finders, etc).
> Most navigation/textobject/editing plugins should be fine.
>
> ...
>
> VSCode's jumplist is used instead of Neovim's. This is to make VSCode native
> navigation (mouse click, jump to definition, etc) navigable through the
> jumplist.

Use VSCode plugins (LSPs, syntax highlighters, )
