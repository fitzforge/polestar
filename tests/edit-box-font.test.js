'use strict';
// #1896: Polestar's Text size changed the text being typed in the chat box.
// The client is modelled as the report has it: an edit box made without a
// template draws with the chat box's font object (ChatFontNormal), and its
// font calls (face, size, colour, shadow, justification) write through to the
// font object it draws with. Polestar's edit boxes (the picker's search, the
// report's text, the copy box, the gear scales' fields, the import box, the
// settings window's profile fields) must each draw with a font object of
// their own: the chat box's font stays the game's whatever Polestar's text
// size, and every box still follows that size. Where the client gives a box
// a font of its own after all, the box's own font object changes nothing.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const P = require('../tools/commands/preview');

// The client as modelled: a bare edit box draws with ChatFontNormal, its font
// calls read and write the font object it draws with, and SetFontObject
// makes it draw with another. The game's chat font is noted before any addon
// loads.
const CLIENT = `
local M, createFrame = stub.Methods, CreateFrame
local THROUGH = { "SetFont", "GetFont", "SetTextColor", "GetTextColor", "SetShadowColor", "GetShadowColor", "SetJustifyH", "GetJustifyH", "SetJustifyV", "GetJustifyV" }
function CreateFrame(kind, name, parent, template, ...)
	local f = createFrame(kind, name, parent, template, ...)
	if kind == "EditBox" and template == nil then
		f.fontObject = ChatFontNormal
		for _, m in ipairs(THROUGH) do
			f[m] = function(self, ...) return M[m](rawget(self, "fontObject") or self, ...) end
		end
		f.SetFontObject = function(self, obj) self.fontObject = obj end
	end
	return f
end
function chatLook()
	local path, size, flags = ChatFontNormal:GetFont()
	local r, g, b, a = ChatFontNormal:GetTextColor()
	local sr, sg, sb, sa = ChatFontNormal:GetShadowColor()
	return { path, size, flags or "", r, g, b, a, sr, sg, sb, sa, ChatFontNormal:GetJustifyH() }
end
gameChat = chatLook()`;

const SCRIPT = `uistub.install()
stub.login()
local UI = Polestar.UI
UI.ShowPicker()
UI.ShowReport()
UI.ShowCopy("Copy", "Polestar")
UI.ShowScales()
UI.Import.Show()
UI.ShowOptions("profiles")
stub.runTimers()
local function boxes()
	local list = {}
	for _, f in ipairs(stub.frames) do
		if f.kind == "EditBox" and f.template == nil then list[#list + 1] = f end
	end
	return list
end
local function state()
	local list, own, shared, sizes = boxes(), {}, 0, {}
	for i, b in ipairs(list) do
		local font = rawget(b, "fontObject")
		if font == ChatFontNormal then shared = shared + 1 elseif font then own[font] = true end
		sizes[i] = select(2, b:GetFont())
	end
	local distinct = 0
	for _ in pairs(own) do distinct = distinct + 1 end
	return { boxes = #list, shared = shared, distinct = distinct, sizes = sizes, chat = chatLook() }
end
emit({ game = gameChat, built = state() })
Polestar.Set("ui.textSize", 1.3)
stub.runTimers()
emit(state())`;

test("Polestar's edit boxes draw with fonts of their own: the chat box's font keeps the game's through a text size change", () => {
	const [{ game, built }, sized] = runAddon({ stubs: ['stub_ui.lua'], before: CLIENT, addons: [{ name: 'Polestar', files: P.FILES }], script: SCRIPT }).emitted;
	assert.ok(built.boxes >= 7, `the windows built ${built.boxes} edit boxes`);
	assert.deepEqual(built.chat, game, 'building and painting the edit boxes left the chat font as the game has it');
	assert.equal(built.shared, 0, 'no edit box draws with the chat font');
	assert.equal(built.distinct, built.boxes, 'every edit box draws with a font object of its own');
	assert.deepEqual(sized.chat, game, "Polestar's text size left the chat font as the game has it");
	assert.equal(sized.boxes, built.boxes);
	built.sizes.forEach((size, i) => assert.ok(sized.sizes[i] > size, `edit box ${i + 1} follows the text size (${size} -> ${sized.sizes[i]})`));
});
