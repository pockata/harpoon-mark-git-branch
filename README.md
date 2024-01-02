# harpoon-mark-git-branch
A small plugin to add a separate list for each git branch with [Harpoon v2](https://github.com/ThePrimeagen/harpoon).  
Emulates `mark_branch` from Harpoon v1.

Uses tpope's `vim-fugitive` for faster branch name resolution if available, otherwise falls back to `git rev-parse`.

## Installation
### Using [Lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{
    "pockata/harpoon-mark-git-branch",
    dependencies = { "ThePrimeagen/harpoon" },
    config = function() 
        require("harpoon-mark-git-branch").setup()
    end,
},
```

## Configuration
None

## License
MIT
