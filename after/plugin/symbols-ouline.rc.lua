local status, symbols = pcall(require, "symbols-outline")
if (not status) then return end

symbols.setup({
  symbols = {
    File = { icon = "", hl = "URI" },
    Module = { icon = "", hl = "Namespace" },
    Namespace = { icon = "", hl = "Namespace" },
    Package = { icon = "", hl = "Namespace" },
    Class = { icon = "", hl = "Type" },
    Method = { icon = "ƒ", hl = "Method" },
    Property = { icon = "", hl = "Method" },
    Field = { icon = "", hl = "Field" },
    Constructor = { icon = "", hl = "Constructor" },
    Enum = { icon = "", hl = "Type" },
    Interface = { icon = "", hl = "Type" },
    Function = { icon = "ﬦ", hl = "Function" },
    Variable = { icon = "", hl = "Constant" },
    Constant = { icon = "", hl = "Constant" },
    String = { icon = "", hl = "String" },
    Number = { icon = "#", hl = "Number" },
    Boolean = { icon = " ", hl = "Boolean" },
    Array = { icon = "", hl = "Constant" },
    Object = { icon = "", hl = "Type" },
    Key = { icon = "", hl = "Type" },
    Null = { icon = "ﳠ", hl = "Type" },
    EnumMember = { icon = "", hl = "Field" },
    Struct = { icon = "", hl = "Type" },
    Event = { icon = "", hl = "Type" },
    Operator = { icon = "", hl = "Operator" },
    TypeParameter = { icon = " ", hl = "Parameter" }
  }
})
