local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "axelvc/template-string.nvim",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "c",
      "cpp",
      "lua",
      "tsx",
      "typescript",
      "javascript",
      "html",
      "css",
      "json",
      "graphql",
      "regex",
      "rust",
      "prisma",
      "markdown",
      "markdown_inline",
      "python",
      "bash",
      "fish",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },
    autotag = { enable = true },
    sync_install = false,
    auto_install = true,
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<enter>",
        node_incremental = "<enter>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = { query = "@function.outer", desc = "around a function" },
          ["if"] = { query = "@function.inner", desc = "inner part of a function" },
          ["ac"] = { query = "@class.outer", desc = "around a class" },
          ["ic"] = { query = "@class.inner", desc = "inner part of a class" },
          ["ai"] = { query = "@conditional.outer", desc = "around an if statement" },
          ["ii"] = { query = "@conditional.inner", desc = "inner part of an if statement" },
          ["al"] = { query = "@loop.outer", desc = "around a loop" },
          ["il"] = { query = "@loop.inner", desc = "inner part of a loop" },
          ["ap"] = { query = "@parameter.outer", desc = "around parameter" },
          ["ip"] = { query = "@parameter.inner", desc = "inside a parameter" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v",   -- charwise
          ["@parameter.inner"] = "v",   -- charwise
          ["@function.outer"] = "v",    -- charwise
          ["@conditional.outer"] = "V", -- linewise
          ["@loop.outer"] = "V",        -- linewise
          ["@class.outer"] = "<c-v>",   -- blockwise
        },
        include_surrounding_whitespace = false,
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_previous_start = {
          ["[f"] = { query = "@function.outer", desc = "Previous function" },
          ["[c"] = { query = "@class.outer", desc = "Previous class" },
          ["[p"] = { query = "@parameter.inner", desc = "Previous parameter" },
        },
        goto_next_start = {
          ["]f"] = { query = "@function.outer", desc = "Next function" },
          ["]c"] = { query = "@class.outer", desc = "Next class" },
          ["]p"] = { query = "@parameter.inner", desc = "Next parameter" },
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
    },
  })
  local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

  -- Repeat movement with ; and ,
  -- ensure ; goes forward and , goes backward regardless of the last direction
  -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

  -- vim way: ; goes to the direction you were moving.
  vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
  vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

  -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
  vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
  vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
  vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
  vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  require("template-string").setup({})
end

return M
