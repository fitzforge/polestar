'use strict';
// Phase 3, Task 3.1: the predicate atom { "done", label } — true when the
// guide step carrying that label is done. Predicate.lua does not know guides;
// the Engine installs a resolver with Predicate.SetDoneResolver(fn).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Predicate.lua'] };

function run(script) {
	return runAddon({ stubs: ['stub_world.lua'], addons: [CORE], script }).emitted;
}

test('Validate accepts { "done", label } with a non-empty string label only', () => {
	const out = run(`
		local P = Polestar.Predicate
		emit(P.Validate({ "done", "camp" }) == true)
		emit(P.Validate({ "all", { "done", "camp" }, { "not", { "done", "x-1_b" } } }) == true)
		for _, n in ipairs({ { "done" }, { "done", "" }, { "done", 5 }, { "done", "a", "b" } }) do
			local ok, msg = P.Validate(n)
			emit({ ok == true, type(msg) == "string" })
		end
	`);
	assert.deepEqual(out, [true, true, [false, true], [false, true], [false, true], [false, true]]);
});

test('without a resolver "done" is false; with one it asks the resolver, once per label per env', () => {
	const out = run(`
		local P = Polestar.Predicate
		emit(P.Eval({ "done", "camp" }))
		local asked = {}
		P.SetDoneResolver(function(label) asked[#asked + 1] = label; return label == "camp" end)
		local env = P.NewEnv()
		emit(P.Eval({ "done", "camp" }, env))
		emit(P.Eval({ "done", "town" }, env))
		emit(P.Eval({ "all", { "done", "camp" }, { "not", { "done", "town" } } }, env))
		emit(asked)
		P.SetDoneResolver(nil)
		emit(P.Eval({ "done", "camp" }))
	`);
	assert.deepEqual(out, [false, true, false, true, ['camp', 'town'], false]);
});

test('a resolver that errors or returns a non-boolean answers false / its truthiness', () => {
	const out = run(`
		local P = Polestar.Predicate
		P.SetDoneResolver(function(label) if label == "boom" then error("x") end return label == "yes" and 1 or nil end)
		emit(P.Eval({ "done", "boom" }))
		emit(P.Eval({ "done", "yes" }))
		emit(P.Eval({ "done", "no" }))
	`);
	assert.deepEqual(out, [false, true, false]);
});
