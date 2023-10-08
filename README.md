# qf-diagnostics

Turns errors and warnings from the quickfix list into diagnostics.

## Usage

vim-plug:

```vimscript
Plug 'dknaack/qf-diagnostics.nvim'
lua require("qf-diagnostics").setup()
```

lazy.nvim:

```lua
{
  'dknaack/qf-diagnostics.nvim',
  config = function()
    require("qf-diagnostics").setup()
  end
}
```
