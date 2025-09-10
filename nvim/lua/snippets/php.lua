local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet -- Define a snippet
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
        get => $this->app[{}::class];
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
  -- PHPUnit DataProvider attribute
  s(
    "pudp",
    fmt(
      [[
    #[DataProvider('{}')]
      ]],
      { i(1, "") }
    )
  ),
  -- PHPUnit DataProvider attribute
  s(
    "puedp",
    fmt(
      [[
    #[ExternalDataProvider({}::class, '{}')]
      ]],
      { i(1, ""), i(2, "") }
    )
  ),
  -- PHPUnit TestWith attribute
  s(
    "putw",
    fmt(
      [[
    #[TestWith([{})]
      ]],
      { i(1, "") }
    )
  ),
  -- Factory
  s(
    "factory",
    fmt(
      [[
      ${} = {}::new(){}->{}();
      ]],
      { i(1, ""), i(2, "Factory"), i(3, ""), i(4, "create") }
    )
  ),
  -- PHPUnit mark test incomplete
  s(
    "puinc",
    fmt(
      [[
      $this->markTestIncomplete('{}');
      ]],
      { i(1, "") }
    )
  ),
  -- PHPUnit provider
  s(
    "puprov",
    fmt(
      [[
    public static function {}(): iterable
    {{
        {}
    }}
  ]],
      { i(1, ""), i(2, "") }
    )
  ),
}
