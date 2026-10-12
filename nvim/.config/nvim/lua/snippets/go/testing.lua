local ls = require("luasnip") -- Load LuaSnip
local s = ls.snippet -- Define a snippet
local i = ls.insert_node -- Define insert points
local fmt = require("luasnip.extras.fmt").fmt -- Enable format
local rep = require("luasnip.extras").rep -- Repeat

-- Only expand inside *_test.go files
local in_test_file = {
  condition = function()
    return vim.fn.expand("%:t"):match("_test%.go$") ~= nil
  end,
  show_condition = function()
    return vim.fn.expand("%:t"):match("_test%.go$") ~= nil
  end,
}

-- Snippet that only exists in test files
local ts = function(trig, desc, body, nodes)
  return s({ trig = trig, desc = desc }, fmt(body, nodes), in_test_file)
end

return {
  ---------------------------------------------------------------------------
  -- Standard library: testing
  ---------------------------------------------------------------------------
  -- Test function
  ts(
    "test",
    "test function",
    [[
    func Test{}(t *testing.T) {{
    	{}
    }}
  ]],
    { i(1, "Name"), i(0) }
  ),
  -- Table test
  ts(
    "testt",
    "table test function",
    [[
    func Test{}(t *testing.T) {{
    	tests := []struct {{
    		name string
    		{}
    	}}{{
    		{{name: "{}"}},
    	}}

    	for _, tc := range tests {{
    		t.Run(tc.name, func(t *testing.T) {{
    			{}
    		}})
    	}}
    }}
  ]],
    { i(1, "Name"), i(2), i(3, "case"), i(0) }
  ),
  -- Subtest
  ts(
    "trun",
    "t.Run subtest",
    [[
    t.Run("{}", func(t *testing.T) {{
    	{}
    }})
  ]],
    { i(1, "name"), i(0) }
  ),
  -- Parallel subtest
  ts(
    "trunp",
    "t.Run parallel subtest",
    [[
    t.Run("{}", func(t *testing.T) {{
    	t.Parallel()

    	{}
    }})
  ]],
    { i(1, "name"), i(0) }
  ),
  -- Map based table test (random order, name as key)
  ts(
    "ttm",
    "map based table test",
    [[
    func Test{}(t *testing.T) {{
    	tests := map[string]struct {{
    		{}
    	}}{{
    		"{}": {{
    			{}
    		}},
    	}}

    	for name, tc := range tests {{
    		t.Run(name, func(t *testing.T) {{
    			{}
    		}})
    	}}
    }}
  ]],
    { i(1, "Name"), i(2, "input string"), i(3, "case"), i(4), i(0) }
  ),
  -- Table test with got/want and error
  ts(
    "ttw",
    "table test with want/wantErr",
    [[
    func Test{}(t *testing.T) {{
    	tests := []struct {{
    		name    string
    		input   {}
    		want    {}
    		wantErr bool
    	}}{{
    		{{name: "{}"}},
    	}}

    	for _, tc := range tests {{
    		t.Run(tc.name, func(t *testing.T) {{
    			got, err := {}(tc.input)
    			if (err != nil) != tc.wantErr {{
    				t.Fatalf("{}() error = %v, wantErr %v", err, tc.wantErr)
    			}}
    			if got != tc.want {{
    				t.Errorf("{}() = %v, want %v", got, tc.want)
    			}}
    		}})
    	}}
    }}
  ]],
    { i(1, "Name"), i(2, "string"), i(3, "string"), i(4, "case"), i(5, "fn"), rep(5), rep(5) }
  ),
  -- Test helper
  ts(
    "thelp",
    "test helper function",
    [[
    func {}(t *testing.T{}) {{
    	t.Helper()
    	{}
    }}
  ]],
    { i(1, "helper"), i(2), i(0) }
  ),
  -- Parallel
  ts("tpar", "t.Parallel()", "t.Parallel()", {}),
  -- Cleanup
  ts(
    "tcl",
    "t.Cleanup",
    [[
    t.Cleanup(func() {{
    	{}
    }})
  ]],
    { i(0) }
  ),
  -- Temp dir
  ts("ttmp", "t.TempDir()", "{} := t.TempDir()", { i(1, "dir") }),
  -- Env var for the duration of the test
  ts("tenv", "t.Setenv", [[t.Setenv("{}", "{}")]], { i(1, "KEY"), i(2, "value") }),
  -- Context bound to the test (Go 1.24+)
  ts("tctx", "t.Context()", "ctx := t.Context()", {}),
  -- Skip in short mode
  ts(
    "tshort",
    "skip in -short mode",
    [[
    if testing.Short() {{
    	t.Skip("{}")
    }}
  ]],
    { i(1, "skipping in short mode") }
  ),
  -- Fatal on error
  ts(
    "tfe",
    "t.Fatal on error",
    [[
    if err != nil {{
    	t.Fatal(err)
    }}
  ]],
    {}
  ),
  -- Expect an error
  ts(
    "twe",
    "t.Fatal when error expected",
    [[
    if err == nil {{
    	t.Fatal("{}")
    }}
  ]],
    { i(1, "expected an error, got nil") }
  ),
  -- got != want
  ts(
    "tgw",
    "compare got/want",
    [[
    if {} != {} {{
    	t.Errorf("got %v, want %v", {}, {})
    }}
  ]],
    { i(1, "got"), i(2, "want"), rep(1), rep(2) }
  ),
  -- reflect.DeepEqual
  ts(
    "tdeq",
    "compare with reflect.DeepEqual",
    [[
    if !reflect.DeepEqual({}, {}) {{
    	t.Errorf("got %+v, want %+v", {}, {})
    }}
  ]],
    { i(1, "got"), i(2, "want"), rep(1), rep(2) }
  ),
  -- go-cmp diff
  ts(
    "tdiff",
    "compare with cmp.Diff",
    [[
    if diff := cmp.Diff({}, {}); diff != "" {{
    	t.Errorf("{} mismatch (-want +got):\n%s", diff)
    }}
  ]],
    { i(1, "want"), i(2, "got"), i(3, "result") }
  ),
  -- Fuzz test
  ts(
    "tfuzz",
    "fuzz test",
    [[
    func Fuzz{}(f *testing.F) {{
    	f.Add({})

    	f.Fuzz(func(t *testing.T, {}) {{
    		{}
    	}})
    }}
  ]],
    { i(1, "Name"), i(2, '"seed"'), i(3, "in string"), i(0) }
  ),
  -- Benchmark with b.Loop (Go 1.24+)
  ts(
    "bench",
    "benchmark with b.Loop",
    [[
    func Benchmark{}(b *testing.B) {{
    	{}
    	for b.Loop() {{
    		{}
    	}}
    }}
  ]],
    { i(1, "Name"), i(2), i(0) }
  ),
  -- Example function
  ts(
    "tex",
    "example function",
    [[
    func Example{}() {{
    	{}
    	// Output:
    	// {}
    }}
  ]],
    { i(1, "Name"), i(2), i(0) }
  ),

  ---------------------------------------------------------------------------
  -- net/http/httptest
  ---------------------------------------------------------------------------
  -- Handler test with recorder
  ts(
    "threc",
    "httptest request + recorder",
    [[
    req := httptest.NewRequest(http.Method{}, "{}", {})
    rec := httptest.NewRecorder()

    {}(rec, req)

    if rec.Code != http.Status{} {{
    	t.Errorf("status = %d, want %d", rec.Code, http.Status{})
    }}
  ]],
    { i(1, "Get"), i(2, "/"), i(3, "nil"), i(4, "handler.ServeHTTP"), i(5, "OK"), rep(5) }
  ),
  -- Test server
  ts(
    "thsrv",
    "httptest server",
    [[
    srv := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {{
    	{}
    }}))
    t.Cleanup(srv.Close)
  ]],
    { i(0) }
  ),

  ---------------------------------------------------------------------------
  -- testify (assert / require / suite)
  ---------------------------------------------------------------------------
  ts("aeq", "assert.Equal", "assert.Equal(t, {}, {})", { i(1, "want"), i(2, "got") }),
  ts("ane", "assert.NoError", "assert.NoError(t, {})", { i(1, "err") }),
  ts("aer", "assert.Error", "assert.Error(t, {})", { i(1, "err") }),
  ts("aei", "assert.ErrorIs", "assert.ErrorIs(t, {}, {})", { i(1, "err"), i(2, "target") }),
  ts("atr", "assert.True", "assert.True(t, {})", { i(1) }),
  ts("afa", "assert.False", "assert.False(t, {})", { i(1) }),
  ts("anil", "assert.Nil", "assert.Nil(t, {})", { i(1) }),
  ts("annil", "assert.NotNil", "assert.NotNil(t, {})", { i(1) }),
  ts("alen", "assert.Len", "assert.Len(t, {}, {})", { i(1, "list"), i(2, "n") }),
  ts("acon", "assert.Contains", "assert.Contains(t, {}, {})", { i(1, "s"), i(2, "contains") }),
  ts("aelm", "assert.ElementsMatch", "assert.ElementsMatch(t, {}, {})", { i(1, "want"), i(2, "got") }),
  ts("req", "require.Equal", "require.Equal(t, {}, {})", { i(1, "want"), i(2, "got") }),
  ts("rne", "require.NoError", "require.NoError(t, {})", { i(1, "err") }),
  ts("rer", "require.Error", "require.Error(t, {})", { i(1, "err") }),
  ts("rei", "require.ErrorIs", "require.ErrorIs(t, {}, {})", { i(1, "err"), i(2, "target") }),
  ts("rnn", "require.NotNil", "require.NotNil(t, {})", { i(1) }),
  -- testify suite
  ts(
    "tsuite",
    "testify suite",
    [[
    type {}Suite struct {{
    	suite.Suite
    	{}
    }}

    func Test{}Suite(t *testing.T) {{
    	suite.Run(t, new({}Suite))
    }}

    func (s *{}Suite) SetupTest() {{
    	{}
    }}

    func (s *{}Suite) Test{}() {{
    	{}
    }}
  ]],
    { i(1, "Name"), i(2), rep(1), rep(1), rep(1), i(3), rep(1), i(4, "Something"), i(0) }
  ),
  -- testify suite method
  ts(
    "tsm",
    "testify suite test method",
    [[
    func (s *{}) Test{}() {{
    	{}
    }}
  ]],
    { i(1, "Suite"), i(2, "Name"), i(0) }
  ),
}
