'use strict';
// One opt-in (addon/Polestar_Recorder/Recorder.lua, docs/RECORDING.md "Ack
// file"): Polestar Client writes PolestarRecorderShare into Ack.lua. true
// turns recording on at login (once, with a message) unless the player typed
// /psrec off; false turns it off; nil (no client) leaves the player's choice.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function run(share, saved) {
	const [out] = runAddon({
		stubs: ['stub_recorder.lua'],
		before: share === undefined ? '' : `PolestarRecorderShare = ${share}`,
		addons: ['Polestar_Recorder'],
		saved: saved ? { Polestar_Recorder: saved } : undefined,
		login: true,
		script: 'emit({ on = PolestarRecorderDB.enabled == true, optout = PolestarRecorderDB.optout == true, said = table.concat(stub.messages, "\\n") })',
	}).emitted;
	return out;
}

const OFF = 'PolestarRecorderDB = { schema = 2, enabled = false }';
const ON = 'PolestarRecorderDB = { schema = 2, enabled = true }';
// A first login: no SavedVariables at all.
const NONE = 'PolestarRecorderDB = nil';

test('the client sharing turns recording on, once, and says so', () => {
	const out = run('true', OFF);
	assert.equal(out.on, true);
	assert.match(out.said, /on, because sharing is on in Polestar Client\. \/psrec off to stop\./);
	// Already on: nothing to say.
	assert.doesNotMatch(run('true', ON).said, /because sharing is on/);
	assert.equal(run('true', NONE).on, true);
});

test('the client not sharing turns recording off without an opt-out', () => {
	const out = run('false', ON);
	assert.equal(out.on, false);
	assert.equal(out.optout, false);
});

test('/psrec off beats the client; /psrec on clears it', () => {
	const out = run('true', 'PolestarRecorderDB = { schema = 2, enabled = false, optout = true }');
	assert.equal(out.on, false);
	assert.equal(out.optout, true);
	const [after] = runAddon({
		stubs: ['stub_recorder.lua'],
		before: 'PolestarRecorderShare = true',
		addons: ['Polestar_Recorder'],
		saved: { Polestar_Recorder: ON },
		login: true,
		script: `
		local cmd = SlashCmdList.POLESTARREC
		cmd("off")
		local off = { on = PolestarRecorderDB.enabled, optout = PolestarRecorderDB.optout }
		cmd("on")
		emit({ off = off, on = PolestarRecorderDB.enabled, optout = PolestarRecorderDB.optout or false })`,
	}).emitted;
	assert.deepEqual(after, { off: { on: false, optout: true }, on: true, optout: false });
});

test('without the client (no flag) the old behaviour holds: off unless /psrec on', () => {
	assert.equal(run(undefined, OFF).on, false);
	assert.equal(run(undefined, ON).on, true);
	assert.equal(run(undefined, NONE).on, false);
});
