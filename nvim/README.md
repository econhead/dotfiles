# Neovim learning configuration

This is an isolated configuration built from Neovim's native Lua API upward.

## Activate it

Link this directory to the configuration path associated with `NVIM_APPNAME`:

```sh
ln -s /Users/econhead/Documents/Codex/2026-06-22/how/outputs/nvim-learning ~/.config/nvim-learning
```

Then launch it without affecting the normal `~/.config/nvim` configuration:

```sh
NVIM_APPNAME=nvim-learning nvim
```

Inside Neovim, confirm the active configuration with:

```vim
:echo stdpath('config')
```
