local ls = require "luasnip"

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Add snippets
ls.add_snippets("typescriptreact", {
  s("rc", {
    -- Interface definition
    t("interface "),
    i(1, "COMPONENT"),
    t({ "Props {", "", "}", "", "const " }),
    -- Component definition
    f(function(args) return args[1][1] or "" end, { 1 }),
    t(": React.FC<"),
    f(function(args) return args[1][1] or "" end, { 1 }),
    t("Props> = ({  }) => {"),
    t({ "", "\treturn (", "\t\t<div>", "\t\t\t" }),
    i(0),
    t({ "", "\t\t</div>", "\t)", "}" }),
  }),
})
