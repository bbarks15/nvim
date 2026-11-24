-- Built-in statusline styled like lualine, using the colorscheme's lualine theme
local icons = require("core.icons")

local M = {}

-- stylua: ignore
local modes = {
  n = "NORMAL", no = "O-PENDING", nov = "O-PENDING", noV = "O-PENDING", ["no\22"] = "O-PENDING",
  niI = "NORMAL", niR = "NORMAL", niV = "NORMAL", nt = "NORMAL", ntT = "NORMAL",
  v = "VISUAL", vs = "VISUAL", V = "V-LINE", Vs = "V-LINE", ["\22"] = "V-BLOCK", ["\22s"] = "V-BLOCK",
  s = "SELECT", S = "S-LINE", ["\19"] = "S-BLOCK",
  i = "INSERT", ic = "INSERT", ix = "INSERT",
  R = "REPLACE", Rc = "REPLACE", Rx = "REPLACE", Rv = "V-REPLACE", Rvc = "V-REPLACE", Rvx = "V-REPLACE",
  c = "COMMAND", cv = "EX", ce = "EX", r = "REPLACE", rm = "MORE", ["r?"] = "CONFIRM", ["!"] = "SHELL",
  t = "TERMINAL",
}

-- stylua: ignore
local mode_colors = {
  VISUAL = "visual", ["V-LINE"] = "visual", ["V-BLOCK"] = "visual",
  SELECT = "visual", ["S-LINE"] = "visual", ["S-BLOCK"] = "visual",
  REPLACE = "replace", ["V-REPLACE"] = "replace",
  INSERT = "insert",
  COMMAND = "command", EX = "command", MORE = "command", CONFIRM = "command",
  TERMINAL = "terminal",
}

local diagnostics = {
  { severity = vim.diagnostic.severity.ERROR, icon = icons.diagnostics.Error, hl = "Error" },
  { severity = vim.diagnostic.severity.WARN, icon = icons.diagnostics.Warning, hl = "Warn" },
  { severity = vim.diagnostic.severity.INFO, icon = icons.diagnostics.Information, hl = "Info" },
  { severity = vim.diagnostic.severity.HINT, icon = icons.diagnostics.Hint, hl = "Hint" },
}

local function load_theme()
  local name = vim.g.colors_name
  if not name then return nil end
  local file = vim.api.nvim_get_runtime_file("lua/lualine/themes/" .. name .. ".lua", false)[1]
  if not file then return nil end
  local ok, theme = pcall(dofile, file)
  if ok and type(theme) == "table" and theme.normal then return theme end
end

-- Used when the colorscheme doesn't ship a lualine theme
local function fallback_theme()
  local function fg(group)
    return vim.api.nvim_get_hl(0, { name = group, link = false }).fg
  end
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  local dark = normal.bg or (vim.o.background == "light" and 0xffffff or 0x000000)
  local function section(color)
    return { a = { fg = dark, bg = color, gui = "bold" } }
  end
  local theme = {
    normal = section(fg("Function")),
    insert = section(fg("String")),
    visual = section(fg("Statement")),
    replace = section(fg("DiagnosticError")),
    command = section(fg("Constant")),
    terminal = section(fg("String")),
  }
  theme.normal.c = { fg = normal.fg }
  return theme
end

local function to_hl(spec)
  local hl = { fg = spec.fg, bg = spec.bg }
  for _, attr in ipairs(vim.split(spec.gui or "", ",", { trimempty = true })) do
    hl[attr] = true
  end
  if hl.bg == "NONE" then hl.bg = nil end
  return hl
end

function M.set_highlights()
  local theme = load_theme() or fallback_theme()
  local c = to_hl(theme.normal.c or {})
  c.bold = nil

  for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "terminal" }) do
    local a = (theme[mode] or theme.normal).a or theme.normal.a
    vim.api.nvim_set_hl(0, "StlMode_" .. mode, to_hl(a))
  end

  vim.api.nvim_set_hl(0, "StatusLine", c)
  vim.api.nvim_set_hl(0, "StlSection", c)
  for _, d in ipairs(diagnostics) do
    local diag_fg = vim.api.nvim_get_hl(0, { name = "Diagnostic" .. d.hl, link = false }).fg
    vim.api.nvim_set_hl(0, "StlDiag" .. d.hl, { fg = diag_fg, bg = c.bg })
  end
end

local function mode()
  local name = modes[vim.api.nvim_get_mode().mode] or vim.api.nvim_get_mode().mode
  return "%#StlMode_" .. (mode_colors[name] or "normal") .. "# " .. name .. " "
end

local function filename()
  local name = vim.fn.expand("%:~:.")
  if name == "" then name = "[No Name]" end
  name = name:gsub("%%", "%%%%")
  if vim.bo.modified then name = name .. " [+]" end
  if vim.bo.readonly or not vim.bo.modifiable then name = name .. " [-]" end
  return name
end

local function branch()
  local head = vim.b.gitsigns_head
  if head and head ~= "" then return "\238\130\160 " .. head end -- U+E0A0 (lualine's branch icon)
end

local function diagnostic_counts()
  local counts = vim.diagnostic.count(0)
  local parts = {}
  for _, d in ipairs(diagnostics) do
    local n = counts[d.severity]
    if n and n > 0 then
      table.insert(parts, "%#StlDiag" .. d.hl .. "#" .. d.icon .. " " .. n)
    end
  end
  if #parts > 0 then return table.concat(parts, " ") end
end

function M.render()
  if vim.bo.filetype == "snacks_dashboard" then return "%#StlSection#" end

  local right = {}
  for _, component in ipairs({ branch, diagnostic_counts }) do
    local part = component()
    if part then table.insert(right, " " .. part .. "%#StlSection# ") end
  end

  return table.concat({
    mode(),
    "%#StlSection# ",
    filename(),
    " %=",
    table.concat(right, "|"),
  })
end

function M.setup()
  local group = vim.api.nvim_create_augroup("core_statusline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = M.set_highlights })
  vim.api.nvim_create_autocmd({ "ModeChanged", "DiagnosticChanged" }, {
    group = group,
    callback = function() vim.cmd.redrawstatus() end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "GitSignsUpdate",
    callback = function() vim.cmd.redrawstatus() end,
  })

  M.set_highlights()
  vim.o.statusline = "%!v:lua.require'core.statusline'.render()"
end

return M
