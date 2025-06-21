return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "windwp/nvim-autopairs",
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "L3MON4D3/LuaSnip", -- snippet engine
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    cmp.setup({
      window = {
        completion = {
          col_offset = -3 -- align the abbr and word on cursor (due to fields order below)
        }
      },
      --completion = {
      --  completeopt = "menu,menuone,preview,noselect",
      --},
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions ["<C-e>"] = cmp.mapping.abort(), -- close completion window ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<CR>"] = cmp.mapping.confirm({select = true}),
      }),
      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" }, -- snippets
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
      -- configure lspkind for vs-code like pictograms in completion menu
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = lspkind.cmp_format({
          mode = 'symbol_text', -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
          maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          menu = ({ -- showing type in menu
            nvim_lsp = "[LSP]",
            path = "[Path]",
            buffer = "[Buffer]",
            luasnip = "[LuaSnip]",
          }),
          before = function(entry, vim_item) -- for tailwind css autocomplete
            if vim_item.kind == 'Color' and entry.completion_item.documentation then
              local documentation = entry.completion_item.documentation
              if type(documentation) == "table" then
                documentation = vim.inspect(documentation.value)
              end
              if string.match(documentation, "^#%x%x%x%x%x%x$") then
                local color = string.sub(documentation, 2)
                local group = 'Tw_' .. color
                if vim.fn.hlID(group) < 1 then
                  vim.api.nvim_set_hl(0, group, {fg = '#' .. color})
                end
                vim_item.kind = "■" -- or "⬤" or anything
                vim_item.kind_hl_group = group
                return vim_item
              end
            end
            -- vim_item.kind = icons[vim_item.kind] and (icons[vim_item.kind] .. vim_item.kind) or vim_item.kind
            -- or just show the icon
            vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
            return vim_item
          end
        })
      }
    })

    -- Setup vim-dadbod
    cmp.setup.filetype({ "sql" }, {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
      },
    })
  end,
}
