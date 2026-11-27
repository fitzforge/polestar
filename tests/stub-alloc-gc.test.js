'use strict';
// tests/lua/stub_alloc.lua swaps wow_stub.lua's RunScript for a wrapper with debug.setupvalue. Lua 5.1's
// lua_setupvalue has no write barrier for the upvalue it stores into: a collector cycle that has already marked
// that upvalue never marks the new closure, frees it, and the next RunScript call runs freed memory (a SIGSEGV
// on the post-merge gates runner, 26 Nov 2026, in the route-speed :reload cases; which cases died depended on
// the length of the paths involved, because that moves where the cycle stands). The stub keeps the wrapper
// in a table as well, whose store does have its barrier.
//
// The test loads the stubs again and again with the collector one step behind a different amount of garbage
// each time (the cycle stands somewhere else when the swap happens) and asks, once the cycle is over, whether
// the closure the swap installed (held by a weak table meanwhile) is still there.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { runAddon, STUBS } = require('./helpers/lua');

test('stub_alloc.lua: the RunScript wrapper it installs survives a collector cycle begun at any point of the load', () => {
	const stub = (f) => JSON.stringify(path.join(STUBS, f));
	const [lost] = runAddon({
		script: `
local real, weak = debug.setupvalue, setmetatable({}, { __mode = "v" })
debug.setupvalue = function(fn, i, v) weak[1] = v; return real(fn, i, v) end
collectgarbage("setpause", 1)
collectgarbage("setstepmul", 100)
local lost = {}
for garbage = 0, 1500, 2 do
  weak[1] = nil
  local junk = {}
  for j = 1, garbage do junk[j] = {} end
  junk = nil
  dofile(${stub('wow_stub.lua')})
  dofile(${stub('stub_alloc.lua')})
  repeat until collectgarbage("step", 0)
  repeat until collectgarbage("step", 0)
  if weak[1] == nil then lost[#lost + 1] = garbage end
end
debug.setupvalue = real
emit(table.concat(lost, ","))`,
	}).emitted;
	assert.equal(lost, '', `the replacement closure was collected while its upvalue still held it, with ${lost} garbage tables`);
});
