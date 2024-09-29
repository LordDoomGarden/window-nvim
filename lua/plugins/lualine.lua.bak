local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  -- local conditions = {
  --   hide_in_width = function()
  --     return vim.fn.winwidth(0) > 80
  --   end,
  -- }

  local color = {
    bg = "#00212B",
    bg_i = "#48AEF5",
    bg_n = "#0d3440",
    -- fg = "#74c5fc",
    -- fg = "#92d1fc",
    -- fg = "#a2c9de",
    fg = "#92c4de",
    -- fg = "#C8D7D8",
    fg_i = "#0d3440",
    fg_n = "#48AEF5",
    -- bg_v = "#fd5e3a",
    fg_v = "#fa7a61",
    bg_v = "#D94E4C",
    -- fg_v = "#E48679",
  }

  local my_status = {
    normal = {
      b = { bg = color.bg_n, fg = color.fg_n },
      c = { bg = color.bg, fg = color.fg },
    },
    insert = {
      b = { bg = color.bg_i, fg = color.fg_i },
      c = { bg = color.bg, fg = color.fg },
    },
    visual = {
      b = { bg = color.bg_v, fg = color.bg },
      c = { bg = color.bg, fg = color.fg_v },
    },
  }

  require("lualine").setup({
    options = {
      theme = my_status,
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = {},
      lualine_b = {
        {
          "mode",
          fmt = function(str)
            local mode = str:sub(1, 1)
            if "N" == mode then
              -- return " "
              return "󰀘 "
            elseif "I" == mode then
              return " "
              -- return "󰜍 "
              -- return " "
              -- return " "
              -- return " "
              -- return "󰀘 "
              -- return " "
              -- return " "
            elseif "V" == mode then
              -- return " "
              return " "
            elseif "C" == mode then
              return " "
            end
          end,
        },
      },
      lualine_c = {
        {
          "branch",
          icon = "",
          color = { fg = "#48AEF5" },
          -- color = { fg = "#00FFFF" },
          -- cond = conditions.hide_in_width,
        },
      },
      lualine_x = {
        -- {
        --   "searchcount"
        -- },
        {
          "diagnostics",
        },

        -- {
        --   "branch",
        --   icon = "",
        --   color = { fg = "#48AEF5" },
        --   -- color = { fg = "#00FFFF" },
        --   -- cond = conditions.hide_in_width,
        -- },
        {
          function()
            local msg = "[No Active]"
            -- local msg = " No Active"
            local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
            local clients = vim.lsp.get_active_clients()
            if next(clients) == nil then
              return msg
            end
            for _, client in ipairs(clients) do
              local filetypes = client.config.filetypes
              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return "[" .. client.name .. "]"
              end
            end
            return msg
          end,
        },
        {
          function()
            return " " .. vim.bo.shiftwidth
          end

        },
        "filetype",
        '%l:%c'
      },
      lualine_y = { '%p%%/%L' },
      -- lualine_y = { "progress" },
      lualine_z = {},
    },
    -- extensions = {}
  })
end

return M
