'use strict';
// Polestar's buttons in the game's Quick Keybind Mode (QoL/QuickBind.lua;
// #1620): a Tauren Hunter on the shipped Barrens guide opens the mode
// (Options > Keybindings > Quick Keybind Mode, or an action bar addon's /kb).
// The mode's window, its signals and the saved bindings are
// tests/lua/stub_quickbind.lua's (the 1.60.1 interface code's shapes); the
// window itself is drawn here as a plain stand-in with the game's own
// strings, and the mode's tooltip (QuickKeybindTooltip, kept as text lines
// by the stub) is drawn as the game's tooltip. Needs a checkout with
// tests/lua/stub_quickbind.lua (--checkout <quick-keybind worktree>).

const HL = 'UI-HUD-ActionBar-IconFrame-Mouseover';

// The game's Quick Keybind window (Blizzard_QuickKeybind), as a stand-in.
const WINDOW = `local f = CreateFrame("Frame", "StudioQuickKeybind", UIParent)
f:SetFrameStrata("DIALOG")
f:SetSize(500, 172)
f:SetPoint("TOP", UIParent, "TOP", 0, -130)
local bg = f:CreateTexture(nil, "BACKGROUND")
bg:SetAllPoints()
bg:SetColorTexture(0.05, 0.05, 0.06, 0.92)
for _, e in ipairs({ { "TOPLEFT", "TOPRIGHT", 0, 1 }, { "BOTTOMLEFT", "BOTTOMRIGHT", 0, 1 }, { "TOPLEFT", "BOTTOMLEFT", 1, 0 }, { "TOPRIGHT", "BOTTOMRIGHT", 1, 0 } }) do
	local t = f:CreateTexture(nil, "BORDER")
	t:SetPoint(e[1], f, e[1], 0, 0)
	t:SetPoint(e[2], f, e[2], 0, 0)
	if e[3] == 1 then t:SetWidth(1) else t:SetHeight(1) end
	t:SetColorTexture(0.6, 0.5, 0.3, 1)
end
local function text(size, r, g, b, y, s, w)
	local fs = f:CreateFontString(nil, "ARTWORK")
	fs:SetFont(STANDARD_TEXT_FONT, size, "")
	fs:SetTextColor(r, g, b, 1)
	fs:SetPoint("TOP", f, "TOP", 0, y)
	if w then fs:SetWidth(w); fs:SetWordWrap(true) end
	fs:SetJustifyH("CENTER")
	fs:SetText(s)
	return fs
end
text(16, 1, 0.82, 0, -14, "Quick Keybind Mode")
text(12, 1, 1, 1, -40, "You are in Quick Keybind Mode. Mouse over a button and press the desired key to set the binding for that button.", 440)
f.Output = text(12, 0.1, 1, 0.1, -80, stub.qkb.output or "")
text(12, 1, 0.82, 0, -104, "[  ]  Character Specific Keybindings")
local function button(label, x)
	local b = CreateFrame("Frame", nil, f)
	b:SetSize(110, 24)
	b:SetPoint("BOTTOM", f, "BOTTOM", x, 14)
	local t = b:CreateTexture(nil, "ARTWORK")
	t:SetAllPoints()
	t:SetColorTexture(0.45, 0.08, 0.06, 1)
	local fs = b:CreateFontString(nil, "OVERLAY")
	fs:SetFont(STANDARD_TEXT_FONT, 12, "")
	fs:SetTextColor(1, 0.82, 0, 1)
	fs:SetPoint("CENTER", b, "CENTER", 0, 0)
	fs:SetText(label)
end
button("Defaults", -122); button("Okay", 0); button("Cancel", 122)
studio.label("(the game's window: a stand-in)", 0, 0):SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -4)`;

const OPEN = `stub.keys = stub.keys or {}
local k = stub.qkb
k.bind("SHIFT-E", "CLICK PolestarQuestItemButton:LeftButton")
k.bind("F", "CLICK PolestarTargetButton:LeftButton")
k.open()
stub.advance(0.5)`;

module.exports = {
	title: 'Quick Keybind Mode on Polestar\'s buttons (/kb) (#1620)',
	character: { race: 'Tauren', cls: 'HUNTER', faction: 'Horde', level: 17, money: 4200 },
	place: { map: 1413, x: 51.6, y: 30.1, zone: 'The Barrens', subzone: 'The Crossroads' },
	guide: { id: 'forever/horde/02-the-barrens', play: 55, hours: 1.5 },
	stubs: ['stub_quickbind.lua'],
	art: [HL],
	settings: { 'behavior.offerClassQuests': false },
	window: [1440, 690],
	capture: ['PolestarTargetButton', 'PolestarQuestItemButton', 'PolestarHearthButton', 'PolestarRareButton', 'PolestarBagButton', 'PolestarTravelButton', 'PolestarStepButton', 'GameTooltip'],
	pad: 40,
	shots: {
		mode: {
			title: 'The mode open: every Polestar button with a binding shows, the ones the guide doesn\'t need now dimmed with their binding\'s name, in the mode\'s highlight',
			lua: `${OPEN}\n${WINDOW}`,
		},
		hover: {
			title: 'The Target button hovered: the mode\'s tooltip (the binding\'s name, its key, how to bind or unbind)',
			lua: `${OPEN}
stub.qkb.hover(PolestarTargetButton)
stub.advance(0.3)
studio.tooltipFrom(QuickKeybindTooltip, PolestarTargetButton)
${WINDOW}`,
		},
		bound: {
			title: 'Shift-T pressed over the hidden Hearthstone button: bound, the window says so',
			lua: `${OPEN}
stub.qkb.hover(PolestarHearthButton)
stub.keys.shift = true
stub.qkb.key("T")
stub.keys.shift = false
stub.advance(0.3)
studio.tooltipFrom(QuickKeybindTooltip, PolestarHearthButton)
${WINDOW}`,
		},
	},
};
