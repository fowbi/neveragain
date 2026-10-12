local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet -- Define a snippet
local i = ls.insert_node -- Define insert points
local f = ls.function_node -- Computed text
local fmt = require("luasnip.extras.fmt").fmt -- Enable format
local rep = require("luasnip.extras").rep -- Repeat

-- Test snippets live in go/testing.lua

return {
  ---------------------------------------------------------------------------
  -- Declarations
  ---------------------------------------------------------------------------
  -- Package named after the current directory
  s("pkg", fmt("package {}", { f(function()
    return vim.fn.expand("%:p:h:t")
  end) })),
  -- Import block
  s(
    "im",
    fmt(
      [[
    import (
    	"{}"
    )
  ]],
      { i(1, "package") }
    )
  ),
  -- Short variable declaration
  s("v", fmt("{} := {}", { i(1, "name"), i(2, "value") })),
  -- Variable declaration
  s("var", fmt("var {} {}", { i(1, "name"), i(2, "type") })),
  -- Variable block
  s(
    "vars",
    fmt(
      [[
    var (
    	{} {}
    )
  ]],
      { i(1, "name"), i(2, "type") }
    )
  ),
  -- Constant declaration
  s("con", fmt("const {} = {}", { i(1, "name"), i(2, "value") })),
  -- Constant block
  s(
    "cons",
    fmt(
      [[
    const (
    	{} = {}
    )
  ]],
      { i(1, "name"), i(2, "value") }
    )
  ),
  -- Enum with iota
  s(
    "iota",
    fmt(
      [[
    type {} int

    const (
    	{} {} = iota
    	{}
    )
  ]],
      { i(1, "Kind"), i(2, "KindA"), rep(1), i(0) }
    )
  ),
  -- Struct type
  s(
    "struct",
    fmt(
      [[
    type {} struct {{
    	{}
    }}
  ]],
      { i(1, "Name"), i(0) }
    )
  ),
  -- Interface type
  s(
    "interface",
    fmt(
      [[
    type {} interface {{
    	{}
    }}
  ]],
      { i(1, "Name"), i(0) }
    )
  ),
  -- Grouped globals with anonymous struct
  s(
    "gg",
    fmt(
      [[
    var {} = struct {{
    	{} {}
    }}{{
    	{}: {},
    }}
  ]],
      { i(1, "config"), i(2, "name"), i(3, "type"), rep(2), i(4, "value") }
    )
  ),
  -- JSON struct tag
  s("json", fmt([[`json:"{}"`]], { i(1, "name") })),
  -- Marshalable JSON alias
  s(
    "ja",
    fmt(
      [[
    type {}Alias {}

    func (p *{}) MarshalJSON() ([]byte, error) {{
    	return json.Marshal(&struct{{ *{}Alias }}{{(*{}Alias)(p)}})
    }}
  ]],
      { i(1, "Type"), rep(1), rep(1), rep(1), rep(1) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Types and builtins
  ---------------------------------------------------------------------------
  s("map", fmt("map[{}]{}", { i(1, "string"), i(2, "int") })),
  s("ch", fmt("chan {}", { i(1, "int") })),
  s("mk", fmt("make({}, {})", { i(1, "[]string"), i(2, "0") })),
  s("ap", fmt("{} = append({}, {})", { i(1, "slice"), rep(1), i(2, "value") })),

  ---------------------------------------------------------------------------
  -- Control flow
  ---------------------------------------------------------------------------
  s(
    "if",
    fmt(
      [[
    if {} {{
    	{}
    }}
  ]],
      { i(1, "condition"), i(0) }
    )
  ),
  s(
    "ife",
    fmt(
      [[
    if {} {{
    	{}
    }} else {{
    	{}
    }}
  ]],
      { i(1, "condition"), i(2), i(0) }
    )
  ),
  s(
    "el",
    fmt(
      [[
    else {{
    	{}
    }}
  ]],
      { i(0) }
    )
  ),
  -- Key exists in map
  s(
    "om",
    fmt(
      [[
    if {}, ok := {}[{}]; ok {{
    	{}
    }}
  ]],
      { i(1, "value"), i(2, "m"), i(3, "key"), i(0) }
    )
  ),
  s(
    "for",
    fmt(
      [[
    for {} {{
    	{}
    }}
  ]],
      { i(1, "condition"), i(0) }
    )
  ),
  s(
    "fori",
    fmt(
      [[
    for {} := range {} {{
    	{}
    }}
  ]],
      { i(1, "i"), i(2, "n"), i(0) }
    )
  ),
  s(
    "forr",
    fmt(
      [[
    for {}, {} := range {} {{
    	{}
    }}
  ]],
      { i(1, "_"), i(2, "v"), i(3, "collection"), i(0) }
    )
  ),
  s(
    "switch",
    fmt(
      [[
    switch {} {{
    case {}:
    	{}
    default:
    	{}
    }}
  ]],
      { i(1, "value"), i(2, "a"), i(3), i(0) }
    )
  ),
  s(
    "cs",
    fmt(
      [[
    case {}:
    	{}
  ]],
      { i(1, "value"), i(0) }
    )
  ),
  s(
    "sl",
    fmt(
      [[
    select {{
    case {} := <-{}:
    	{}
    default:
    	{}
    }}
  ]],
      { i(1, "v"), i(2, "ch"), i(3), i(0) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Functions
  ---------------------------------------------------------------------------
  s(
    "main",
    fmt(
      [[
    func main() {{
    	{}
    }}
  ]],
      { i(0) }
    )
  ),
  s(
    "func",
    fmt(
      [[
    func {}({}) {} {{
    	{}
    }}
  ]],
      { i(1, "name"), i(2), i(3, "error"), i(0) }
    )
  ),
  -- Method
  s(
    "fum",
    fmt(
      [[
    func ({} {}) {}({}) {} {{
    	{}
    }}
  ]],
      { i(1, "r"), i(2, "*Type"), i(3, "Name"), i(4), i(5, "error"), i(0) }
    )
  ),
  -- HTTP handler
  s(
    "funch",
    fmt(
      [[
    func {}(w http.ResponseWriter, r *http.Request) {{
    	{}
    }}
  ]],
      { i(1, "handler"), i(0) }
    )
  ),
  -- HTTP handler method
  s(
    "fumh",
    fmt(
      [[
    func ({} {}) {}(w http.ResponseWriter, r *http.Request) {{
    	{}
    }}
  ]],
      { i(1, "h"), i(2, "*Handler"), i(3, "Name"), i(0) }
    )
  ),
  -- Goroutine
  s("g", fmt("go {}({})", { i(1, "fn"), i(2) })),
  -- Goroutine with anonymous function
  s(
    "ga",
    fmt(
      [[
    go func() {{
    	{}
    }}()
  ]],
      { i(0) }
    )
  ),
  s("df", fmt("defer {}", { i(1, "f.Close()") })),
  s(
    "dfr",
    fmt(
      [[
    defer func() {{
    	if r := recover(); r != nil {{
    		{}
    	}}
    }}()
  ]],
      { i(0) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Errors
  ---------------------------------------------------------------------------
  -- Return error
  s(
    "ir",
    fmt(
      [[
    if err != nil {{
    	return {}err
    }}
  ]],
      { i(1) }
    )
  ),
  -- Wrap error
  s(
    "errwr",
    fmt(
      [[
    if err != nil {{
    	return {}fmt.Errorf("{}: %w", err)
    }}
  ]],
      { i(1), i(2, "doing something") }
    )
  ),
  -- Log error
  s(
    "err",
    fmt(
      [[
    if err != nil {{
    	log.{}(err)
    }}
  ]],
      { i(1, "Fatal") }
    )
  ),
  s("pn", fmt([[panic("{}")]], { i(1, "msg") })),
  s("errn", fmt([[errors.New("{}")]], { i(1, "msg") })),
  -- Sentinel errors
  s(
    "errv",
    fmt(
      [[
    var (
    	Err{} = errors.New("{}")
    )
  ]],
      { i(1, "Name"), i(2, "msg") }
    )
  ),
  s(
    "erris",
    fmt(
      [[
    if errors.Is(err, {}) {{
    	{}
    }}
  ]],
      { i(1, "ErrName"), i(0) }
    )
  ),
  s(
    "erras",
    fmt(
      [[
    var {} {}
    if errors.As(err, &{}) {{
    	{}
    }}
  ]],
      { i(1, "target"), i(2, "*Error"), rep(1), i(0) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Context / env / concurrency
  ---------------------------------------------------------------------------
  s(
    "ctxt",
    fmt(
      [[
    {}, cancel := context.WithTimeout({}, {})
    defer cancel()
  ]],
      { i(1, "ctx"), i(2, "ctx"), i(3, "5*time.Second") }
    )
  ),
  -- Cancel on interrupt / SIGTERM
  s(
    "sig",
    fmt(
      [[
    ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
    defer stop()
  ]],
      {}
    )
  ),
  -- Required env var
  s(
    "env",
    fmt(
      [[
    {} := os.Getenv("{}")
    if {} == "" {{
    	{}
    }}
  ]],
      { i(1, "value"), i(2, "KEY"), rep(1), i(0) }
    )
  ),
  s(
    "mu",
    fmt(
      [[
    {}.Lock()
    defer {}.Unlock()
  ]],
      { i(1, "mu"), rep(1) }
    )
  ),

  ---------------------------------------------------------------------------
  -- HTTP / JSON
  ---------------------------------------------------------------------------
  -- Request with context
  s(
    "hreq",
    fmt(
      [[
    req, err := http.NewRequestWithContext(ctx, http.Method{}, {}, {})
    if err != nil {{
    	return {}err
    }}

    resp, err := {}.Do(req)
    if err != nil {{
    	return {}err
    }}
    defer resp.Body.Close()
  ]],
      { i(1, "Post"), i(2, "url"), i(3, "body"), i(4), i(5, "client"), rep(4) }
    )
  ),
  -- Decode JSON
  s(
    "jdec",
    fmt(
      [[
    var {} {}
    if err := json.NewDecoder({}).Decode(&{}); err != nil {{
    	{}
    }}
  ]],
      { i(1, "v"), i(2, "Type"), i(3, "r.Body"), rep(1), i(0) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Types
  ---------------------------------------------------------------------------
  -- Constructor
  s(
    "newt",
    fmt(
      [[
    func New{}({}) *{} {{
    	return &{}{{
    		{}
    	}}
    }}
  ]],
      { i(1, "Type"), i(2), rep(1), rep(1), i(0) }
    )
  ),
  -- Compile-time interface check
  s("impl", fmt("var _ {} = (*{})(nil)", { i(1, "Interface"), i(2, "Type") })),

  ---------------------------------------------------------------------------
  -- Printing / logging
  ---------------------------------------------------------------------------
  s("pf", fmt([[fmt.Printf("{}\n", {})]], { i(1, "%v"), i(2, "v") })),
  s("pl", fmt("fmt.Println({})", { i(1) })),
  s("ps", fmt([[fmt.Sprintf("{}", {})]], { i(1, "%v"), i(2, "v") })),
  s("lf", fmt([[log.Printf("{}", {})]], { i(1, "%v"), i(2, "v") })),
  s("lp", fmt("log.Println({})", { i(1) })),
  s("si", fmt([[slog.Info("{}"{})]], { i(1, "msg"), i(2) })),
  s("swn", fmt([[slog.Warn("{}", "error", err)]], { i(1, "msg") })),
  s("se", fmt([[slog.Error("{}", "error", err)]], { i(1, "msg") })),
}
