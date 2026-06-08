# mini-in-one.nvim

Configure all your [mini.nvim](https://github.com/echasnovski/mini.nvim) plugins in a single table.

> mini-in-one.nvim is just a thin wrapper. All credit for the actual functionality goes to [@echasnovski](https://github.com/echasnovski) and the [mini.nvim](https://github.com/echasnovski/mini.nvim) project — one of the most thoughtfully designed plugin ecosystems in Neovim.

## Requirements

- Neovim 0.10+
- [mini.nvim](https://github.com/echasnovski/mini.nvim)

## Installation

**[vim.pack](https://neovim.io/doc/user/helptag.html?tag=vim.pack)** (Neovim 0.12+)
```lua
vim.pack.add({
  "https://github.com/echasnovski/mini.nvim",
  -- or stable: { src = "https://github.com/echasnovski/mini.nvim", version = "stable" },
  "https://github.com/braam-76/mini-in-one.nvim",
})
```

**[lazy.nvim](https://github.com/folke/lazy.nvim)**
```lua
{
  "braam-76/mini-in-one.nvim",
  dependencies = {
    { "echasnovski/mini.nvim", version = false },
    -- or stable: { "echasnovski/mini.nvim", version = "*" },
  },
}
```

## Usage

Pass any mini.nvim module name as a key with its config as the value. Modules that fail to load are skipped with a warning. After setup, each loaded module is accessible directly on the returned table.

Example configuration (I use this myself):

```lua
local mini = require("mini-in-one").setup({
  icons      = {},
  pairs      = {},
  surround   = {},
  ai = {
    mappings = { around_next = "aa", inside_next = "ii" },
    n_lines  = 500,
  },
  statusline = {
    use_icons = vim.g.have_nerd_font,
  },
  pick = {
    window = { config = { border = "rounded" } },
  },

  -- Of cource you can also add other plugin definitions as you wish
})

-- Modules are accessible on the returned table
local pick = mini.pick.builtin
vim.keymap.set("n", "<leader> ",  pick.files,     { desc = "Pick files" })
vim.keymap.set("n", "<leader>mg", pick.grep_live, { desc = "Pick grep" })
vim.keymap.set("n", "<leader>mb", pick.buffers,   { desc = "Pick buffers" })
vim.keymap.set("n", "<leader>mh", pick.help,      { desc = "Pick help" })
```

Any module listed in mini.nvim can be used as a key. Passing an empty table `{}` uses that module's default config.

## License

MIT — see [LICENSE](LICENSE). This project is not affiliated with or endorsed by [@echasnovski](https://github.com/echasnovski).
