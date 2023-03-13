# I18nvim

Adds neovim support for working with i18n.

## Installation

Using packer:

```vim
use { 'jbandura/i18nvim'}
```

## Requirements

- [Telescope](https://github.com/nvim-telescope/telescope.nvim)

### yq

```sh
brew install yq
```

### ack

```sh
brew install ack
```

## Running
Show translation for the key under cursor:
```vim
:call I18nvimShowTranslation()
```

Build cache of translation keys:
```vim
:call I18nvimBuildCache()
```

Open a file the translation keys lives in:
```vim
:call I18nvimGoToDefinition()
```

Show usages of the current key:
```vim
:call I18nvimShowUsages()
```
