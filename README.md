![GitHub repo size](https://img.shields.io/github/repo-size/durev/.dotfiles)

# .dotfiles
My setup so I can feel at home in the terminal.
This is designed for personal use, but feel free to pick the parts you like and understand.
I don't know if dotfiles are meant to be forked, but they are definitely meant to be twisted and tinkered.

## Install
For initial symlinking, I use GNU Stow, because once you understand the path structure, it's very intuitive and exquisitely simple to use.

For the rest, a not-very-clever, idempotent, and slightly-ugly bash install script does the job.

### Usage
1. Git clone the repo in your home directory
2. Install GNU Stow
3. Symlink the parts you need:
`stow nvim zsh`
or
`stow */` to symlink everything
4. Run the install script:
`./install`

## Main Tools
- GNU Stow for symlink management
- Homebrew
- Minimal Zsh without Oh My Zsh
- Zed
- Neovim
- LF for navigation and file management
