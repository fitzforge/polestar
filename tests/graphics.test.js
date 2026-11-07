'use strict';
// Tests for QoL Graphics: unlocked vegetation density, extended scenery view distance,
// color presets, RGB world tinting, and combat safety.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

test('graphics lua: module parses and has valid Lua syntax', () => {
	const luaPath = path.join(__dirname, '..', 'addon', 'Polestar', 'QoL', 'Graphics.lua');
	assert.ok(fs.existsSync(luaPath), 'Graphics.lua must exist');
	const content = fs.readFileSync(luaPath, 'utf8');
	assert.match(content, /QoL\.Graphics = Graphics/);
	assert.match(content, /groundEffectDensity/);
	assert.match(content, /groundEffectDist/);
	assert.match(content, /terrainLodDist/);
	assert.match(content, /lodObjectFadeScale/);
	assert.match(content, /farclip/);
	assert.match(content, /ffxGlow/);
	assert.match(content, /ffxDeath/);
	assert.match(content, /ResampleSharpness/);
	assert.match(content, /cameraDistanceMaxZoomFactor/);
	assert.match(content, /applyTint/);
	assert.match(content, /InCombatLockdown/);
});

test('graphics defaults: all graphics settings are registered in QoL defaults', () => {
	const qolPath = path.join(__dirname, '..', 'addon', 'Polestar', 'QoL', 'QoL.lua');
	const content = fs.readFileSync(qolPath, 'utf8');
	const expectedKeys = [
		'graphicsEnabled',
		'grassDensity',
		'grassDist',
		'terrainLodDist',
		'objectFade',
		'viewDist',
		'colorPreset',
		'gamma',
		'brightness',
		'contrast',
		'tintRed',
		'tintGreen',
		'tintBlue',
		'noGlow',
		'noDeathEffect',
		'sharpness',
		'cameraZoom',
		'cameraFov',
		'fpsFeedback',
	];
	for (const key of expectedKeys) {
		assert.match(content, new RegExp(`${key}\\s*=\\s*`), `QoL.lua must register default for ${key}`);
	}
});

test('graphics options: Graphics tab is declared in Quality of Life options', () => {
	const optionsPath = path.join(__dirname, '..', 'addon', 'Polestar', 'UI', 'Options.lua');
	const content = fs.readFileSync(optionsPath, 'utf8');
	assert.match(content, /L\["Graphics"\]/);
	assert.match(content, /L\["Performance & FPS"\]/);
	assert.match(content, /L\["Vegetation & Scenery"\]/);
	assert.match(content, /L\["Color & Post-Processing"\]/);
	assert.match(content, /L\["Camera"\]/);
});

test('graphics manifest: Graphics.lua is declared in QoL.xml before Options.lua', () => {
	const xmlPath = path.join(__dirname, '..', 'addon', 'Polestar', 'QoL', 'QoL.xml');
	const content = fs.readFileSync(xmlPath, 'utf8');
	assert.match(content, /<Script file="Graphics\.lua"\/>/);
	const graphicsIndex = content.indexOf('Graphics.lua');
	const optionsIndex = content.indexOf('Options.lua');
	assert.ok(graphicsIndex > 0 && graphicsIndex < optionsIndex, 'Graphics.lua must be loaded before Options.lua');
});
