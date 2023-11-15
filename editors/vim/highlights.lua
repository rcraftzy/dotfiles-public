-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type HLTable
M.override = {
  --[[
  CursorLine = {
    bg = "black2",
  },
   Normal = {
    bg = "#2b2b2b",
  }
  ]]

  Comment = { italic = true },
  --[[ 
  Function = { italic = true },
  Type = { italic = true },
  SpecialComment = { italic = true },
  TSAttribute = { italic = true },
  TSParameter = { italic = true },
  TSLabel = { italic = true },
  TSVariableBuiltin = { italic = true },
  TSTagAttribute = { italic = true },
  TSStorageClass = { italic = true },
  TSProperty = { italic = true }
 ]]
}

---@type HLTable
M.add = {
  NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
--[[ 
"editor.tokenColorCustomizations": {
  "textMateRules": [
    {
    "scope": [
    "comment", 
    "entity.attribute-name", 
    "entity.other.attribute-name.class", 
    "entity.other.attribute-name.id", 
    "keyword", 
    "constant", 
    "storage.modifier", 
    "sotorage.type", 
    "storage.type.Function", 
    "storage.type.class", 
    "variable.parameter", 
    ],
    "settings": {"fontStyle": "italic"}
    }
  ]
}
 ]]
--
