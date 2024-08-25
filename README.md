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
