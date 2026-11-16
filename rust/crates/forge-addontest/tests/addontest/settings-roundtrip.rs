//! Every control of the settings window keeps what it was given, whatever the player does next: it reads back at
//! once and after a reload; Reset page puts every setting of the page back, its row on screen or not, as each
//! row's own reset does, and the footer's Undo brings every one back; Reset all leaves every control at its
//! default; a profile string carries every setting a control writes, the place of every frame Move frames moves
//! and the skin's variant, so an import gives each back exactly (ui.shown aside: a string never hides the guide
//! window); a child row is off while the switch it follows is, and so is a row's detail setting (its inline
//! extra, its cog's) that does nothing while its row's switch is off. Each check walks the controls the settings
//! window has (UI/Options.lua's O.AllControls: the homes; a reference's setting is its home's), on the whole
//! addon with every addon Polestar works with installed, a skin with variants, Shortest Path Forever, and a guide
//! with a group quest and a dungeon, so every row is there.

use forge_addontest::{emitted, text, Addon, RunAddon};
use serde_json::Value;

// Every row of the settings window there: a guide with a group quest and a dungeon, open on a level 1 Human in
// Elwynn Forest (none with NOGUIDE set: the guides' own rows wait for one); Shortest Path Forever; every addon
// Polestar works with (EllesmereUI itself as BEFORE brings it, before Polestar loads); a skin with variants in use
// (unless a reload brings a saved one: KEEP set). The guides are two: the audit's, open, and a second to change to.
pub(crate) const ENV: &str = r#"
stub.advance(1)
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
if not NOGUIDE then
	Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
	assert(Polestar.RegisterGuide({ id = "test/audit", pack = "test", title = "Audit", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Marshal McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds", goals = { { t = "kill", quest = 7, obj = 1, target = "Kobold Vermin", npc = 6, map = 1429, x = 47, y = 35 } } },
		{ title = "Hogger", when = { { k = "group", q = 176 } }, goals = { { t = "task", text = "Kill Hogger with a group" } } },
		{ title = "The Deadmines", when = { { k = "dungeon", name = "The Deadmines", map = 36 } }, goals = { { t = "task", text = "Run The Deadmines" } } },
		{ title = "Level up", goals = { { t = "level", level = 60 } } },
	} }))
	assert(Polestar.RegisterGuide({ id = "test/second", pack = "test", title = "Second", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Marshal McBride", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Goldshire", goals = { { t = "goto", map = 1429, x = 42, y = 65, text = "Goldshire" } } },
	} }))
	Polestar.Engine.SetGuide("test/audit")
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(0.6)
end
_G.ShortestPathForever = { API = { version = 1, Cancel = function() end, Navigate = function() end, NavigateRoute = function() end } }
assert(Polestar.UI.LoadOptions())
local T = Polestar.Theme
C_AddOns.IsAddOnLoaded = function() return true end
assert(T.RegisterSkin("audit", { name = "Audit", addon = "Test_Audit", variants = { { id = "a", name = "A" }, { id = "b", name = "B" } } }))
if not KEEP then Polestar.Set("ui.skin", "audit") end
stub.advance(0.2)
"#;

// What runs before Polestar loads: EllesmereUI's skinning contract (wow_stub.lua's stub.withEllesmere).
pub(crate) const BEFORE: &str = "stub.withEllesmere()\n";

// The controls and what each writes: current(c) as its row reads it, other(c) another value it could write (the
// other state of a switch, the far end of a slider, another choice, a colour; settings-effects.rs's runner picks
// the same), write(c, v) as its row writes; same(a, b) and show(v) as the effect checks compare and say them.
pub(crate) const HELPERS: &str = r#"
O = Polestar.UI.Options
P = Polestar.Profiles
W = Polestar.Widgets
UI = Polestar.UI
function labelOf(c) if type(c.label) == "function" then return c.label() end return c.label end
function idOf(c)
	if c.key then return c.key end
	if c.kind == "binding" then return "action:" .. tostring(c.action) end
	return (c.page and c.page.name or "?") .. ":" .. tostring(labelOf(c))
end
function current(c)
	if c.get then return c.get() end
	if c.key then return Polestar.Get(c.key) end
end
function choices(c)
	local list = c.choices
	if type(list) == "function" then list = list() end
	return list or {}
end
function other(c, cur)
	if cur == nil then cur = current(c) end
	if c.kind == "toggle" then return not cur end
	if c.kind == "slider" then
		local lo, hi = c.min or 0, c.max or 1
		if type(cur) ~= "number" or math.abs(cur - hi) > 1e-9 then return hi end
		return lo
	end
	if c.kind == "dropdown" or c.kind == "cards" or c.kind == "font" then
		for _, ch in ipairs(choices(c)) do
			local off = ch.disabled
			if type(off) == "function" then off = off() end
			if ch.value ~= cur and not off then return ch.value end
		end
		return nil
	end
	if c.kind == "color" then
		if type(cur) == "table" and cur[1] == 1 and (cur[2] or 0) == 0 then return { 0, 1, 0, 1 } end
		return { 1, 0, 0, 1 }
	end
end
function write(c, v)
	if c.set then c.set(v) elseif c.key then Polestar.Set(c.key, v) end
end
function same(a, b, depth)
	if type(a) == "number" and type(b) == "number" then return math.abs(a - b) < 1e-6 end
	if type(a) ~= type(b) then return false end
	if type(a) ~= "table" then return a == b end
	if (depth or 0) > 8 then return false end
	for k, v in pairs(a) do if not same(v, b[k], (depth or 0) + 1) then return false end end
	for k in pairs(b) do if a[k] == nil then return false end end
	return true
end
function show(v, depth)
	if type(v) ~= "table" then return tostring(v) end
	if (depth or 0) > 3 then return "{...}" end
	local parts = {}
	for k, x in pairs(v) do parts[#parts + 1] = tostring(k) .. "=" .. show(x, (depth or 0) + 1) end
	table.sort(parts)
	return "{" .. table.concat(parts, ",") .. "}"
end
function ser(v)
	local t = type(v)
	if t == "string" then return string.format("%q", v) end
	if t == "number" then return string.format("%.17g", v) end
	if t ~= "table" then return tostring(v) end
	local out = {}
	for k, x in pairs(v) do
		local key = type(k) == "number" and ("[" .. string.format("%.17g", k) .. "]") or ("[" .. string.format("%q", k) .. "]")
		out[#out + 1] = key .. " = " .. ser(x)
	end
	return "{ " .. table.concat(out, ", ") .. " }"
end
-- Every home control holding a setting or a state (no button, binding or reference).
function settingControls()
	local out = {}
	for _, c in ipairs(O.AllControls()) do
		if c.kind ~= "button" and c.kind ~= "binding" and (c.key or (c.get and c.set)) then out[#out + 1] = c end
	end
	return out
end
-- Every value a control can take: both states of a switch, a slider's ends and middle, every choice, colours
-- (opaque, half seen, without alpha).
function values(c)
	if c.kind == "toggle" then return { true, false } end
	if c.kind == "slider" then
		local lo, hi, st = c.min or 0, c.max or 1, c.step or 0.1
		return { lo, hi, lo + math.floor((hi - lo) / 2 / st + 0.5) * st }
	end
	if c.kind == "dropdown" or c.kind == "cards" or c.kind == "font" then
		local out = {}
		for _, ch in ipairs(choices(c)) do out[#out + 1] = ch.value end
		return out
	end
	if c.kind == "color" then return { { 1, 0, 0, 1 }, { 0, 1, 0, 0.5 }, { 0.2, 0.4, 0.6 } } end
	return {}
end
-- The game's image sharpening is the game's own CVar, which no reset writes and the game keeps (settings-game.rs).
GAME = { ["Quality of Life:Increase game image quality"] = true }
"#;

fn run_saved(saved: Option<String>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		before: BEFORE.into(),
		addons: vec![Addon::name("Polestar")],
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		login: true,
		script: format!("{ENV}\n{HELPERS}\n{script}"),
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_saved(None, script)
}

// A Lua list as emitted: an empty one comes as {}.
fn list(v: &Value) -> Vec<String> {
	if v.as_object().is_some_and(|o| o.is_empty()) {
		return vec![];
	}
	v.as_array().unwrap_or_else(|| panic!("not a list: {v}")).iter().map(|x| x.as_str().unwrap_or_default().to_string()).collect()
}

#[test]
fn every_control_reads_back_what_it_writes_and_keeps_it_through_a_reload() {
	let first = run(r#"
		local bad, list = {}, settingControls()
		-- The skin last: the variant row writes the variant of the skin in use.
		table.sort(list, function(a, b) return (a.key == "ui.skin" and 1 or 0) < (b.key == "ui.skin" and 1 or 0) end)
		for _, c in ipairs(list) do
			local v = other(c)
			if v == nil then bad[#bad + 1] = idOf(c) .. ": no other value to write" else
				write(c, v)
				local back = current(c)
				if not same(back, v) then bad[#bad + 1] = idOf(c) .. ": wrote " .. show(v) .. ", reads " .. show(back) end
			end
		end
		stub.advance(0.5)
		local keep = {}
		for _, c in ipairs(list) do keep[idOf(c)] = { v = current(c) } end
		emit({ n = #list, bad = bad, keep = "KEEP = " .. ser(keep), db = "PolestarDB = " .. ser(PolestarDB), char = "PolestarCharDB = " .. ser(PolestarCharDB) })"#);
	assert!(first["n"].as_f64().unwrap() >= 600.0, "every setting and state of the window: {}", first["n"]);
	let bad = list(&first["bad"]);
	assert!(bad.is_empty(), "{} controls do not read back what they write:\n{}", bad.len(), bad.join("\n"));
	let saved = format!("{}\n{}\n{}", text(&first["db"]), text(&first["char"]), text(&first["keep"]));
	let again = run_saved(
		Some(saved),
		r#"
		local bad, n = {}, 0
		for _, c in ipairs(settingControls()) do
			local k = KEEP[idOf(c)]
			if k and not GAME[idOf(c)] then
				n = n + 1
				if not same(current(c), k.v) then bad[#bad + 1] = idOf(c) .. ": " .. show(k.v) .. " before the reload, " .. show(current(c)) .. " after" end
			end
		end
		table.sort(bad)
		emit({ n = n, bad = bad })"#,
	);
	assert!(again["n"].as_f64().unwrap() >= 600.0, "every control read after the reload: {}", again["n"]);
	let bad = list(&again["bad"]);
	assert!(bad.is_empty(), "{} controls lose their value in a reload:\n{}", bad.len(), bad.join("\n"));
}

#[test]
fn a_profile_string_carries_every_setting_every_frame_s_place_and_the_skin_variant() {
	let out = run(r#"
		local M = Polestar.Movers
		M.Unlock()
		M.Lock()
		local variant
		for _, c in ipairs(settingControls()) do
			if c.key and c.key ~= "ui.skin" then write(c, other(c)) end
			if idOf(c) == "Theme:Variant" then variant = c end
		end
		-- The skin's variant (Theme > Colour > Variant: per skin, ui.skinVariants.<id>).
		write(variant, other(variant))
		-- Every frame Move frames places, somewhere of its own: the alerts each on their own, then their line; the
		-- heads-up card on a spot of its own.
		Polestar.Set("toasts.headsup.place", "free")
		local function moveAll()
			for i, key in ipairs(M.Keys()) do
				if M.Movable(key) then M.MoveTo(key, 100 + i * 37, 120 + i * 23) end
			end
		end
		Polestar.Set("toasts.stack", false)
		moveAll()
		Polestar.Set("toasts.stack", true)
		moveAll()
		stub.advance(0.1)
		-- Every setting the profile holds, leaf by leaf (a colour or a place is one value).
		local stored = {}
		local function walk(prefix, t)
			for k, v in pairs(t) do
				local path = prefix .. "." .. k
				local d = Polestar.GetDefault(path)
				if type(v) == "table" and type(v[1]) ~= "number" and (d == nil or type(d) == "table") and not path:find("Pos$") and not path:find("[pP]oint$") and not path:find("%.pos$") then
					walk(path, v)
				else
					stored[path] = v
				end
			end
		end
		for section, t in pairs(Polestar.DB().settings) do if type(t) == "table" then walk(section, t) end end
		local s = P.Export()
		Polestar.ResetSettings()
		stub.advance(0.1)
		local pv, why = P.Import(s)
		assert(pv, why)
		P.Apply(pv)
		stub.advance(0.1)
		local lost, n = {}, 0
		for path, v in pairs(stored) do
			n = n + 1
			if not same(Polestar.Get(path), v) then lost[#lost + 1] = path .. ": " .. show(v) .. ", after the import " .. show(Polestar.Get(path)) end
		end
		table.sort(lost)
		emit({ n = n, lost = lost, dropped = pv.dropped, variant = Polestar.Get("ui.skinVariants.audit"), movers = #M.Keys() })"#);
	assert!(out["n"].as_f64().unwrap() >= 450.0, "every setting stored: {}", out["n"]);
	assert!(out["movers"].as_f64().unwrap() >= 12.0, "every frame Move frames places: {}", out["movers"]);
	assert_eq!(list(&out["dropped"]), Vec::<String>::new(), "nothing of our own string is dropped");
	let lost: Vec<String> = list(&out["lost"]).into_iter().filter(|l| !l.starts_with("ui.shown:")).collect();
	assert!(lost.is_empty(), "{} settings a profile string does not carry:\n{}", lost.len(), lost.join("\n"));
	assert_eq!(out["variant"], "b", "the skin's variant came back");
}

#[test]
fn reset_page_puts_every_setting_back_shown_or_not_as_its_row_s_own_reset_does_and_undo_brings_each_back() {
	let out = run(r#"
		local function ownReset(c)
			if c.key then W.ResetSetting(c.key, c.get, c.set) else W.ResetSetting(nil, c.get, c.set) end
		end
		local bad, changed = {}, {}
		local byPage, order = {}, {}
		for _, c in ipairs(settingControls()) do
			local p = c.page
			if p and not GAME[idOf(c)] then
				if not byPage[p] then byPage[p] = {}; order[#order + 1] = p end
				table.insert(byPage[p], c)
			end
		end
		for _, p in ipairs(order) do
			local list = byPage[p]
			-- Every row of the page (on screen at the moment or not) to another value.
			for _, c in ipairs(list) do
				local v = other(c)
				if v ~= nil then write(c, v) end
			end
			stub.advance(0.1)
			local held = {}
			for _, c in ipairs(list) do
				held[c] = current(c)
				-- A setting off its default marks its row changed (its reset button) and its section's Reset.
				if c.key and not W.Modified(c.key) and not same(held[c], Polestar.GetDefault(c.key)) then changed[#changed + 1] = idOf(c) end
			end
			-- The footer's Undo is offered while the window is up.
			UI.ShowOptions("about")
			O.ResetPage(p)
			stub.advance(0.1)
			local afterPage = {}
			for _, c in ipairs(list) do afterPage[c] = current(c) end
			if not O.Undo() then bad[#bad + 1] = p.key .. ": Reset page offers no Undo" end
			PolestarOptions:Hide()
			stub.advance(0.1)
			for _, c in ipairs(list) do
				if not same(current(c), held[c]) then
					bad[#bad + 1] = p.key .. ": after Undo " .. idOf(c) .. " reads " .. show(current(c)) .. " (it held " .. show(held[c]) .. ")"
				end
			end
			-- Each row's own reset, one after another, from what it held: the page as Reset page left it.
			for _, c in ipairs(list) do ownReset(c) end
			stub.advance(0.1)
			for _, c in ipairs(list) do
				if not same(afterPage[c], current(c)) then
					bad[#bad + 1] = p.key .. ": after Reset page " .. idOf(c) .. " reads " .. show(afterPage[c]) .. ", its own reset " .. show(current(c))
				end
			end
		end
		-- No reset answers for the character: a group quest or a dungeon reset is asked about again.
		local answers = {}
		for q, a in pairs(Polestar.CharState().groupQuests) do answers[#answers + 1] = "group quest " .. q .. ": " .. tostring(a) end
		for m, a in pairs(Polestar.CharState().dungeons) do answers[#answers + 1] = "dungeon " .. m .. ": " .. tostring(a) end
		table.sort(bad)
		emit({ pages = #order, bad = bad, answers = answers, changed = changed })"#);
	assert!(out["pages"].as_f64().unwrap() >= 14.0, "every page with settings: {}", out["pages"]);
	let bad = list(&out["bad"]);
	assert!(bad.is_empty(), "{} settings Reset page or its Undo leave otherwise:\n{}", bad.len(), bad.join("\n"));
	assert_eq!(list(&out["answers"]), Vec::<String>::new(), "a reset leaves no answer of its own behind");
	assert_eq!(list(&out["changed"]), Vec::<String>::new(), "settings off their default whose row does not say so");
}

// A group quest's row (Discovery > Group quests) shows the guide's answer for it, its own or, while it has none,
// Guide > Automation > Group quests'. Reset page forgets its own, and Undo puts back the one it had, or none: no
// answer the player never gave (a skip the guide would then keep to without asking), whatever Group quests says.
#[test]
fn reset_page_and_undo_give_a_group_quest_back_its_own_answer_or_none() {
	let out = run(r#"
		local E = Polestar.Engine
		local row
		for _, c in ipairs(O.AllControls()) do
			if c.page and c.page.name == "Discovery" and labelOf(c) == "Hogger" then row = c end
		end
		local bad, n = {}, 0
		for _, all in ipairs({ "ask", "do", "skip" }) do
			for _, answer in ipairs({ "none", "do", "skip" }) do
				Polestar.Set("behavior.groupQuests", all)
				E.AnswerGroup(176, answer ~= "none" and answer or nil)
				local was, guide = Polestar.CharState().groupQuests[176], E.GroupAnswer(176)
				UI.ShowOptions("about")
				O.ResetPage(row.page)
				stub.advance(0.1)
				local cleared = Polestar.CharState().groupQuests[176]
				O.Undo()
				PolestarOptions:Hide()
				stub.advance(0.1)
				n = n + 1
				local now, case = Polestar.CharState().groupQuests[176], "Group quests " .. all .. ", Hogger " .. answer
				if cleared ~= nil then bad[#bad + 1] = case .. ": Reset page leaves " .. tostring(cleared) end
				-- An answer of its own that is Group quests' too reads the same on the row: Undo may leave it to that.
				if now ~= was and not (now == nil and was == all) then bad[#bad + 1] = case .. ": after Undo it holds " .. tostring(now) end
				if E.GroupAnswer(176) ~= guide then bad[#bad + 1] = case .. ": the guide answers " .. tostring(E.GroupAnswer(176)) .. ", it answered " .. tostring(guide) end
			end
		end
		emit({ n = n, bad = bad, found = row ~= nil })"#);
	assert_eq!(out["found"], true, "Hogger's row on Discovery > Group quests");
	assert_eq!(out["n"], 9.0);
	let bad = list(&out["bad"]);
	assert!(bad.is_empty(), "{} answers Reset page and Undo leave otherwise:\n{}", bad.len(), bad.join("\n"));
}

#[test]
fn reset_all_leaves_every_control_at_its_default_and_the_window_s_state_alone() {
	let out = run(r#"
		local list = settingControls()
		local state = {}
		for _, c in ipairs(list) do
			local v = other(c)
			if v ~= nil then write(c, v) end
		end
		stub.advance(0.1)
		-- State that is no setting (per character: the pause, the arrow kept while hidden, answers, restock amounts)
		-- is not Reset all's.
		for _, c in ipairs(list) do if not c.key then state[c] = current(c) end end
		Polestar.ResetSettings()
		stub.advance(0.1)
		local bad = {}
		for _, c in ipairs(list) do
			if c.key and not c.get then
				if not same(Polestar.Get(c.key), Polestar.GetDefault(c.key)) then bad[#bad + 1] = idOf(c) .. " reads " .. show(Polestar.Get(c.key)) end
			elseif not c.key and not GAME[idOf(c)] and c.page and O.GroupOf(c.page.key) ~= "look" then
				if not same(current(c), state[c]) then bad[#bad + 1] = idOf(c) .. " (state) reads " .. show(current(c)) .. ", it held " .. show(state[c]) end
			end
		end
		table.sort(bad)
		emit({ bad = bad, n = #list })"#);
	let bad = list(&out["bad"]);
	assert!(bad.is_empty(), "{} controls Reset all leaves otherwise:\n{}", bad.len(), bad.join("\n"));
}

#[test]
fn a_child_and_a_row_s_detail_setting_are_off_while_the_switch_they_follow_is_off() {
	let out = run(r#"
		-- Details that work while their row's switch is off, and why.
		local FREE = {
			["guideWindow.rules"] = "the dividers inside the window, with or without its border",
			["guideWindow.animSpeed"] = "the done goals' fold moves at it too",
			["guideWindow.guideTitle"] = "the guide's name stands in for the step number while that is off",
			["buttons.borderSize"] = "the hover's border is drawn at it too",
		}
		local function isOff(c)
			local s = rawget(c, "psSection")
			if s and s.toggle and s.toggle ~= c and s.toggle.key and not Polestar.Get(s.toggle.key) then return true end
			if c.disabled then local ok, v = pcall(c.disabled); return ok and v and true or false end
			return false
		end
		local bad, children = {}, 0
		for _, c in ipairs(O.AllControls()) do
			local parent, owner = rawget(c, "psParent"), rawget(c, "psOwner")
			-- A child follows the row before it; a toggle with no setting (Pause) has children that are its options.
			if c.child and parent and parent.kind == "toggle" and parent.key then
				children = children + 1
				local was = Polestar.Get(parent.key)
				Polestar.Set(parent.key, false)
				if not isOff(c) then bad[#bad + 1] = idOf(c) .. " is on while " .. idOf(parent) .. " is off" end
				Polestar.Set(parent.key, was)
			end
			if owner and owner.kind == "toggle" and owner.key and c.key and not FREE[c.key] then
				local was = Polestar.Get(owner.key)
				Polestar.Set(owner.key, false)
				if not isOff(c) then bad[#bad + 1] = idOf(c) .. " (a detail of its row) is on while " .. idOf(owner) .. " is off" end
				Polestar.Set(owner.key, was)
			end
		end
		table.sort(bad)
		emit({ bad = bad, children = children })"#);
	assert!(out["children"].as_f64().unwrap() >= 10.0, "the children: {}", out["children"]);
	let bad = list(&out["bad"]);
	assert!(bad.is_empty(), "{} rows stay on while what they depend on is off:\n{}", bad.len(), bad.join("\n"));
}

// The slash commands that set a setting or a character's state set the one the settings window shows: /polestar
// arrow hide, show and reset (Guide > Arrow & routes), /polestar hide arrow (Keep the arrow when hidden), /polestar
// pause on and off and /polestar resume (Pause), /polestar profile <name> (the footer's profile), each read back
// through its row.
#[test]
fn the_slash_commands_that_set_a_setting_set_what_its_row_shows() {
	let out = run(r#"
		local function row(id) for _, c in ipairs(settingControls()) do if idOf(c) == id then return c end end end
		local cmd = SlashCmdList.POLESTAR
		local r = {}
		cmd("arrow hide"); r.arrowHidden = current(row("nav.arrow"))
		cmd("arrow show"); r.arrowShown = current(row("nav.arrow"))
		Polestar.Set("nav.arrowPos", { point = "TOP", relPoint = "TOP", x = 10, y = -50 })
		cmd("arrow reset"); r.arrowPlaced = Polestar.Get("nav.arrowPos") ~= nil
		cmd("hide arrow"); r.keep = current(row("Guide:Keep the arrow when hidden"))
		cmd("hide arrow"); r.keepAgain = current(row("Guide:Keep the arrow when hidden"))
		cmd("pause on"); r.paused = current(row("Guide:Pause"))
		cmd("pause off"); r.unpaused = current(row("Guide:Pause"))
		cmd("pause"); r.toggled = current(row("Guide:Pause"))
		cmd("resume"); r.resumed = current(row("Guide:Pause"))
		P.New("Raid")
		Polestar.Set("ui.compact", true)
		cmd("profile raid"); r.profile, r.compact = P.Active(), current(row("ui.compact"))
		emit(r)"#);
	assert_eq!(out["arrowHidden"], false, "/polestar arrow hide: Show arrow off");
	assert_eq!(out["arrowShown"], true, "/polestar arrow show: on again");
	assert_eq!(out["arrowPlaced"], false, "/polestar arrow reset: the arrow back in its place");
	assert_eq!(out["keep"], true, "/polestar hide arrow: Keep the arrow when hidden on");
	assert_eq!(out["keepAgain"], false, "and off again");
	assert_eq!(out["paused"], true, "/polestar pause on: Pause on");
	assert_eq!(out["unpaused"], false, "/polestar pause off");
	assert_eq!(out["toggled"], true, "/polestar pause turns it over");
	assert_eq!(out["resumed"], false, "/polestar resume");
	assert_eq!(out["profile"], "Raid", "/polestar profile raid: the profile, whatever the case typed");
	assert_eq!(out["compact"], false, "and its own settings in the rows");
}
