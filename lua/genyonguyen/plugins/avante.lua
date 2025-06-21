return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    openai = {
        hide_in_model_selector = true,
    },
    claude = {
        hide_in_model_selector = true,
    },
    gemini = {
        hide_in_model_selector = true,
    },
    vertex = {
        hide_in_model_selector = true,
    },
    vertex_claude = {
        hide_in_model_selector = true,
    },
    cohere = {
        hide_in_model_selector = true,
    },
    bedrock = {
        hide_in_model_selector = true,
    },
    -- other providers
    ["claude-opus"] = {
      hide_in_model_selector = true,
    },
    ["claude-haiku"] = {
      hide_in_model_selector = true,
    },
    ["openai-gpt-4o-mini"] = {
      hide_in_model_selector = true,
    },
    vendors = {
      copilot_claude = {
        __inherited_from = 'copilot',
        model = "claude-3.5-sonnet",
        temperature = 1,
        max_tokens = 20000
      },
      copilot_claude_thinking = {
        __inherited_from = 'copilot',
        model = "claude-3.7-sonnet-thought",
        temperature = 1,
        max_tokens = 20000
      },
      copilot_openai = {
        __inherited_from = 'copilot',
        model = "gpt-4o"
      },
      copilot_gemini = {
        __inherited_from = 'copilot',
        model = "gemini-2.0-flash-001"
      }
    }
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
