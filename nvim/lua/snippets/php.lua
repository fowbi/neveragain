local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet -- Define a snippet
local t = ls.text_node -- Define text nodes
local i = ls.insert_node -- Define insert points
local fmt = require("luasnip.extras.fmt").fmt -- Enable format
local rep = require("luasnip.extras").rep -- Repeat

return {
  -- Plain constructor
  s(
    "construct",
    fmt(
      [[
    public function __construct(
        {}
    ) {{
    }}
  ]],
      { i(1, "") }
    )
  ),
  -- Virtual properties
  s(
    "vprop",
    fmt(
      [[
    private {} ${} {{
      get {{
        return $this->app[{}::class];
      }}
    }}
  ]],
      {
        i(1, ""),
        i(2, ""),
        rep(1),
      }
    )
  ),
  -- PHPUnit test case
  s(
    "pucase",
    fmt(
      [[
    #[Test]
    public function it{}(): void
    {{
      {}
    }}
  ]],
      { i(1, ""), i(2, "") }
    )
  ),
  -- Laravel's dd
  s("dd", fmt([[dd({});]], { i(1, "") })),
  -- Laravel's dump
  s("dump", fmt([[dump({});]], { i(1, "") })),
  -- Laravel's log
  s("log", fmt([[\Illuminate\Support\Facades\Log::info({});]], { i(1, "") })),
}
