local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim",  lazy = true },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
  },
  keys = {
    { "<leader>ff", "<CMD>Telescope find_files<CR>",                                      desc = "Find files" },
    { "<leader>fp", "<CMD>Telescope find_files cwd=~/AppData/Local/nvim/lua/plugins<CR>", desc = "Plugins config" },
    { "<leader>fg", "<CMD>Telescope live_grep<CR>",                                       desc = "Find Text" },
    { "<leader>fe", "<CMD>Telescope file_browser<CR>",                                    desc = "File Browser" },
    { "<leader>b",  "<CMD>Telescope buffers<CR>",                                         desc = "List open buffer" },
    { "<leader>fd", "<CMD>Telescope diagnostics<CR>",                                     desc = "List Dianostics" },
    { "<leader>ft", "<CMD>Telescope treesitter<CR>",                                      desc = "List Function names, variables, from Treesitter" },
    { "<leader>fk", "<CMD>Telescope keymaps<CR>",                                         desc = "List keymaps" },
    { "<leader>fn", "<CMD>Telescope noice<CR>",                                           desc = "Help tags" },
    { "<leader>fn", "<CMD>Telescope noice<CR>",                                           desc = "Help tags" },
    { "<leader>fh", "<CMD>Telescope highlights<CR>",                                      desc = "Help tags" },
    { "<leader>f?", "<CMD>Telescope help_tags<CR>",                                       desc = "Help tags" },
  },
}

function M.config()
  local icons = {
    ChevronRight = "",
    -- Forward = " ",
    Forward = "  ",
  }
  local actions = require("telescope.actions")
  local fb_actions = require("telescope").extensions.file_browser.actions

  require("telescope").setup({
    defaults = {
      prompt_prefix = icons.ChevronRight .. " ",
      selection_caret = icons.Forward .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      path_display = { "smart" },
      color_devicons = true,
      dynamic_preview_title = true,
      layout_config = {
        horizontal = {
          preview_cutoff = 100,
          preview_width = 0.5,
        },
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["q"] = actions.close,
        },
      },
    },
    pickers = {
      live_grep = {
        -- theme = "dropdown",
      },

      grep_string = {
        theme = "dropdown",
      },

      find_files = {
        theme = "dropdown",
        wrap_results = true,
        initial_mode = "insert",
        hidden = true,
        no_ignore = false,
        previewer = false,
        layout_config = {
          prompt_position = "top",
          width = { 0.8, max = 70 },
        },
      },

      buffers = {
        theme = "dropdown",
        previewer = false,
        initial_mode = "normal",
        layout_config = {
          prompt_position = "top",
          width = { 0.5, max = 50 },
        },
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },

      planets = {
        show_pluto = true,
        show_moon = true,
      },

      colorscheme = {
        enable_preview = true,
      },

      lsp_references = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_definitions = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_declarations = {
        theme = "dropdown",
        initial_mode = "normal",
      },

      lsp_implementations = {
        theme = "dropdown",
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      },
      file_browser = {
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        path = "%:p:h",
        cwd = vim.fn.expand("%:p:h"),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        -- previewer = false,
        initial_mode = "normal",
        layout_config = {
          prompt_position = "top",
          width = 0.8,
          -- width = { 0.8, max = 70 },
        },
        wrap_results = true,
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          -- your custom insert mode mappings
          ["n"] = {
            -- your custom normal mode mappings
            ["N"] = fb_actions.create,
            ["h"] = fb_actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
            ["<C-u>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_previous(prompt_bufnr)
              end
            end,
            ["<C-d>"] = function(prompt_bufnr)
              for i = 1, 10 do
                actions.move_selection_next(prompt_bufnr)
              end
            end,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
          },
        },
      },
    },
  })
  -- require("telescope").load_extension("fzf")
  require("telescope").load_extension("file_browser")
end

return M
