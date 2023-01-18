local status, ih = pcall(require, "inlay-hints")
if (not status) then return end

ih.setup({
  renderer = "inlay-hints/render/eol",
  only_current_line = false,
  hints = {
    parameter = { show = false, },
    type = {
      show = true,
      highlight = "Comment",
    },
  },
  eol = {
    parameter = {
      separator = ", ",
      format = function(hints)
        return string.format(" <- (%s)", hints)
      end,
    },

    type = {
      separator = ", ",
      format = function(hints)
        return string.format(" => %s", hints)
      end,
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my-inlay-hints", {}),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft ~= "rust" then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require("inlay-hints").on_attach(client, args.buf)
  end,
})
