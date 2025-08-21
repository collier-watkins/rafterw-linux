local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    file_ignore_patterns = {}, -- don't ignore dotfiles
    mappings = {
      i = {
        ["<C-h>"] = function(prompt_bufnr)
          local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
          current_picker.finder.files = vim.tbl_map(function(f)
            return f:gsub("^%.", "") -- hack to include dotfiles
          end, current_picker.finder.files)
        end,
      },
    },
  },
  pickers = {
    find_files = {
      hidden = true, -- show hidden by default
    },
    live_grep = {
      additional_args = function() return { "--hidden" } end,
    },
  },
})

