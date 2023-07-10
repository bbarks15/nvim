local status, null_ls = pcall(require, "null-ls")
if (not status) then return end

null_ls.setup {
  debug = false,
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.fourmolu,
    null_ls.builtins.formatting.stylish_haskell,
    null_ls.builtins.formatting.rustfmt.with({
      extra_args = function(params)
        local Path = require("plenary.path")
        local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

        if cargo_toml:exists() and cargo_toml:is_file() then
          for _, line in ipairs(cargo_toml:readlines()) do
            local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
            if edition then
              return { "--edition=" .. edition }
            end
          end
        end
        -- default edition when we don't find `Cargo.toml` or the `edition` in it.
        return { "--edition=2021" }
      end,
    }),
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})',
    }),
    null_ls.builtins.code_actions.eslint_d,
  },
}
