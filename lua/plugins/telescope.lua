return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    "stevearc/aerial.nvim",
    "ahmedkhalf/project.nvim",
    "debugloop/telescope-undo.nvim",
  },
  keys = {
    {
      "<leader>fp",
      "<cmd>Telescope projects<CR>",
      desc = "Find projects",
    },
    {
      "<leader>ff",
      "<cmd>Telescope find_files<CR>",
      desc = "Find Files",
    },
    {
      "<leader>fg",
      "<cmd> Telescope live_grep<CR>",
      desc = "Grep all files",
    },
    {
      "<leader>fr",
      "<cmd>Telescope oldfiles<cr>",
      desc = "Find recent files",
    },
    {
      "<leader>fd",
      "<cmd>Telescope git_files<cr>",
      desc = "Find project files",
    },
    {
      "<leader>fs",
      "<cmd>Telescope aerial<cr>",
      desc = "Find symbols",
    },
    {
      "<leader>fS",
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      desc = "Find workspace symbols",
    },
    {
      "<leader>fu",
      "<cmd>Telescope undo<cr>",
      desc = "Find symbols",
    },
  },
  opts = {},
  config = function()
    require("telescope").setup()

    require("telescope").load_extension("fzf")
    require("telescope").load_extension("projects")
    require("telescope").load_extension("aerial")
    require("telescope").load_extension("undo")
  end,
}
