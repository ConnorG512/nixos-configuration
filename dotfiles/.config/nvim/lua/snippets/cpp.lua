local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node

ls.add_snippets("cpp", {
    s("struct", {
        c(1, { t("constexpr "), t("") }),
        t("struct "), i(2, "Name"), t({" {", "\t"}),
        i(3, "/* fields */"), t({"", "};"})
    })
})

