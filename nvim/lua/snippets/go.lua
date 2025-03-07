local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet -- Define a snippet
local t = ls.text_node -- Define text nodes
local i = ls.insert_node -- Define insert points
local fmt = require("luasnip.extras.fmt").fmt -- Enable format

return {
  -- Print statement snippet
  s("pr", fmt('fmt.Println("{}")', { i(1, "Hello, world!") })),

  -- Main function snippet
  s(
    "main",
    fmt(
      [[
    package main

    import "fmt"

    func main() {{
        {}
    }}
  ]],
      { i(1, 'fmt.Println("Hello, Go!")') }
    )
  ),

  -- Function snippet
  s(
    "fn",
    fmt(
      [[
    func {}({}) {} {{
        {}
    }}
  ]],
      {
        i(1, "FunctionName"), -- Function name
        i(2, "param string"), -- Parameters
        i(3, "error"), -- Return type
        i(4, "return nil"), -- Function body
      }
    )
  ),

  -- Go routine snippet
  s(
    "go",
    fmt(
      [[
    go func() {{
        {}
    }}()
  ]],
      { i(1, "// Do something") }
    )
  ),
}
