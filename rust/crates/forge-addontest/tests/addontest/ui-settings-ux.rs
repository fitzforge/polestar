//! The settings window's ways around (addon/Polestar_Options/UI/Options.lua and its kit): a setting's Move into
//! Move frames, against the real addon's modules.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const ALL: [&str; 11] = [
	"Core/Core.xml",
	"Theme/Theme.xml",
	"Nav/Nav.xml",
	"Quests/Quests.xml",
	"Gear/Gear.xml",
	"Maps/Maps.xml",
	"QoL/QoL.xml",
	"Lookup/Lookup.xml",
	"Dungeons/Dungeons.xml",
	"UI/UI.xml",
	"Rares/Rares.xml",
];

const HELPERS: &str = r#"
local W, M = Polestar.Widgets, Polestar.Movers
-- A setting's widget wherever its page and tab are: its page opened there.
local function ctl(key)
	for _, c in ipairs(O.AllControls()) do
		if c.key == key then
			O.Select(c.page.key, c.tab or "")
			return O.view.cache[c] or O.view.extras[c], c
		end
	end
end
-- A shown section card by its title.
local function cardOf(name)
	for _, card in ipairs(O.view.cards) do if card:IsShown() and card.Title:GetText() == name then return card end end
end
-- A shown footer button by its label.
local function footerButton(text)
	for _, side in ipairs({ "left", "right" }) do
		for _, b in ipairs(PolestarOptions.footerButtons[side]) do if b:IsShown() and b.Label:GetText() == text then return b end end
	end
end
"#;

// The real addon's modules; the settings window's addon loads before the stub's fake Nav stands in, as in the game.
fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &ALL)],
		script: format!("Polestar.UI.LoadOptions()\nuistub.install()\nstub.login()\nlocal UI, O = Polestar.UI, Polestar.UI.Options\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// A setting that places a frame carries a Move: on its row (the floating button) or in its section's header (the
// flight timer's, Look > Trackers). A click hides the window, opens Move frames with that frame's box picked and
// pulsing a few times; Save and exit brings the window back on its page, the row lit. Move is off while the frame
// has no box (its feature off); an alert in the alerts' line picks the line; in a fight nothing opens.
#[test]
fn a_settings_move_opens_move_frames_with_its_frame_picked_and_pulsing_and_brings_the_window_back() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		UI.ShowOptions("guide")
		local w = ctl("ui.launcher")
		local move = rawget(w, "MoveButton")
		local row = { has = move ~= nil, shown = move and move:IsShown() or false, on = move and move:IsEnabled() or false,
			label = move and move.Label:GetText() or false, inCogColumn = rawget(w, "Cog") == move }
		local page = O.page.key
		move:Click()
		local box = M.Box("launcher")
		local during = { settings = PolestarOptions:IsShown(), unlocked = M.IsUnlocked(), selected = M.Selected() or false,
			pulse = box.PulseLayer:IsShown() }
		stub.advance(4)
		local pulsed = not box.PulseLayer:IsShown()
		M.Save()
		local after = { settings = PolestarOptions:IsShown(), page = O.page.key == page, lit = rawget(w, "psFlash") ~= nil and w.psFlash:IsShown() }
		Polestar.Set("ui.launcher", false)
		local off = move:IsEnabled()
		Polestar.Set("ui.launcher", true)
		-- A section's Move, in its header after its switch.
		Polestar.Set("maps.flightTimer", true)
		O.Select("trackers", "Travel")
		local card = cardOf("Flight timer")
		local header = { shown = card.Move:IsShown(), on = card.Move:IsEnabled(), right = select(2, card.Move:GetPoint(1)) == card.Header }
		card.Move:Click()
		local section = { settings = PolestarOptions:IsShown(), selected = M.Selected() or false }
		M.Save()
		-- The alerts lined up: the rare alert's Move picks their line.
		Polestar.Set("toasts.stack", true)
		O.MoveFrame("rareAlert")
		local line = M.Selected() or false
		M.Save()
		-- In a fight: nothing opens, the window stays.
		stub.inCombat = true
		local fought = { O.MoveFrame("launcher"), PolestarOptions:IsShown(), M.IsUnlocked() }
		stub.inCombat = false
		emit({ row = row, during = during, pulsed = pulsed, after = after, off = off, header = header, section = section, line = line, fought = fought })"#);
	assert_eq!(out["row"], json!({ "has": true, "shown": true, "on": true, "label": "Move", "inCogColumn": true }), "the row's Move, in the cog's column");
	assert_eq!(out["during"], json!({ "settings": false, "unlocked": true, "selected": "launcher", "pulse": true }));
	assert_eq!(out["pulsed"], true, "the pulse ends by itself");
	assert_eq!(out["after"], json!({ "settings": true, "page": true, "lit": true }), "the window back on its page, the row lit");
	assert_eq!(out["off"], false, "the floating button off: no box, Move off");
	assert_eq!(out["header"], json!({ "shown": true, "on": true, "right": true }), "the flight timer's section has its Move in the header");
	assert_eq!(out["section"], json!({ "settings": false, "selected": "flightTimer" }));
	assert_eq!(out["line"], "toastLine", "an alert in the line: the line's box");
	assert_eq!(out["fought"], json!([false, true, false]), "in a fight: refused, the window stays");
}

// A reset can be taken back once: after a row's right-click, a section's Reset or the page's, a chip in the footer
// says what was reset (in place of the thanks line) with an Undo that puts every setting back as it was; a new
// reset takes its place, it goes by itself after ten seconds, and a row already at its default offers nothing.
#[test]
fn a_reset_offers_one_undo_in_the_footer_for_a_while() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		UI.ShowOptions("guide")
		local w = ctl("ui.launcher")
		w:Click("RightButton")
		local chip = PolestarOptions.UndoChip
		local row = { value = Polestar.Get("ui.launcher"), shown = chip:IsShown(), text = chip.Text:GetText(),
			thanks = PolestarOptions.ThanksLink:IsShown() }
		chip.Undo:Click()
		local undone = { Polestar.Get("ui.launcher"), chip:IsShown() }
		-- Already at its default: nothing to undo.
		ctl("ui.combat"):Click("RightButton")
		local idle = chip:IsShown()
		-- A section's Reset (three settings or fewer: at once).
		Polestar.Set("ui.launcher", false)
		Polestar.Set("ui.combat", "hide")
		Polestar.Set("ui.instance", "show")
		ctl("ui.combat")
		cardOf("Show and hide").Reset:Click()
		local section = { Polestar.Get("ui.combat"), Polestar.Get("ui.instance"), chip.Text:GetText() }
		stub.advance(11)
		local gone = { chip:IsShown(), O.Undo(), Polestar.Get("ui.combat") }
		-- The page's Reset, through its question.
		Polestar.Set("ui.combat", "fade")
		footerButton("Reset page"):Click()
		PolestarModal.Box.Action:Click()
		local page = { Polestar.Get("ui.combat"), chip:IsShown() }
		O.Undo()
		emit({ row = row, undone = undone, idle = idle, section = section, gone = gone, page = page, back = Polestar.Get("ui.combat") })"#);
	assert_eq!(out["row"], json!({ "value": false, "shown": true, "text": "Floating button reset.", "thanks": false }));
	assert_eq!(out["undone"], json!([true, false]), "Undo puts it back and the chip goes");
	assert_eq!(out["idle"], false, "a row at its default: no Undo");
	assert_eq!(out["section"], json!(["show", "hide", "2 settings reset."]), "both back to their defaults");
	assert_eq!(out["gone"], json!([false, false, "show"]), "gone after ten seconds, nothing left to undo");
	assert_eq!(out["page"], json!(["show", true]));
	assert_eq!(out["back"], "fade", "the page's settings back");
}

// A sound list can be heard before a pick: each choice has a speaker that plays it without choosing it, and resting
// the pointer on a choice a moment plays it too (leaving first plays nothing). A list that is no sound has none.
#[test]
fn a_sound_lists_choices_play_from_their_speaker_without_being_picked() {
	let out = run(r#"
		Polestar.Set("rares.enabled", true)
		Polestar.Set("rares.alerts", true)
		Polestar.Set("rares.sound", true)
		Polestar.Set("rares.soundKit", "raid")
		UI.ShowOptions("alerts")
		local row = ctl("rares.soundKit")
		row.Button:Click()
		local rows = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then rows[#rows + 1] = r end end
		local speakers = 0
		for _, r in ipairs(rows) do if rawget(r, "Speaker") and r.Speaker:IsShown() then speakers = speakers + 1 end end
		stub.sounds = {}
		rows[3].Speaker:Click()
		local played = { #stub.sounds, Polestar.Get("rares.soundKit"), PolestarMenu:IsShown() }
		stub.sounds = {}
		stub.RunScript(rows[2], "OnEnter")
		stub.advance(0.7)
		local dwelt = #stub.sounds
		stub.sounds = {}
		stub.RunScript(rows[1], "OnEnter")
		stub.RunScript(rows[1], "OnLeave")
		stub.advance(0.7)
		local left = #stub.sounds
		Polestar.Widgets.HideMenu()
		-- A list of no sounds: no speakers.
		local other = ctl("toasts.headsup.place")
		other.Button:Click()
		local none = 0
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and rawget(r, "Speaker") and r.Speaker:IsShown() then none = none + 1 end end
		emit({ rows = #rows, speakers = speakers, played = played, dwelt = dwelt, left = left, none = none })"#);
	assert_eq!(out["rows"], 3);
	assert_eq!(out["speakers"], 3, "a speaker on each sound");
	assert_eq!(out["played"], json!([1, "raid", true]), "the speaker plays it; the choice stays and the list stays open");
	assert_eq!(out["dwelt"], 1, "resting on a choice plays it");
	assert_eq!(out["left"], 0, "leaving first plays nothing");
	assert_eq!(out["none"], 0, "no speaker on a list of no sounds");
}

// The window out of the way without closing it: Peek (its eye in the header, held down) fades the window and
// lets go back to whole; Fold leaves only the header, the page kept, and Unfold (or another page) brings the
// rest back as it was. Shift and the wheel anywhere on the window (the body, a slider) step the window's scale
// and light its control; the plain wheel still scrolls and steps.
#[test]
fn peek_fades_the_window_fold_leaves_its_header_and_shift_wheel_scales_it() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local F = PolestarOptions
		local peek, fold = F.PeekButton, F.FoldButton
		local order = { select(2, fold:GetPoint(1)) == F.HeaderTools, select(2, peek:GetPoint(1)) == fold,
			select(2, F.Search:GetPoint(1)) == peek }
		stub.RunScript(peek, "OnMouseDown", "LeftButton")
		stub.advance(0.3)
		local peeking = F:GetAlpha()
		stub.RunScript(peek, "OnMouseUp", "LeftButton")
		stub.advance(0.3)
		local whole = F:GetAlpha()
		local h = F:GetHeight()
		local page = O.page.key
		fold:Click()
		local folded = { h = F:GetHeight(), header = F.Header:IsVisible(), body = F.Content:IsVisible(), footer = F.Footer:IsVisible(),
			nav = F.NavScroll:IsVisible(), shown = F:IsShown(), tip = fold.psTip }
		fold:Click()
		local unfolded = { h = F:GetHeight() == h, body = F.Content:IsVisible(), footer = F.Footer:IsVisible(), nav = F.NavScroll:IsVisible(),
			page = O.page.key == page, tip = fold.psTip }
		fold:Click()
		O.Select("map")
		local another = { F.Content:IsVisible(), F.Footer:IsVisible(), F:GetHeight() == h }
		O.Select("guide")
		local scale = Polestar.Get("ui.menuScale")
		stub.keys.shift = true
		stub.RunScript(F.Scroll, "OnMouseWheel", 1)
		stub.keys.shift = false
		local shifted = Polestar.Get("ui.menuScale")
		local lit = rawget(F.HeaderTools, "psFlash") ~= nil and F.HeaderTools.psFlash:IsShown()
		local top = F.Scroll:GetVerticalScroll()
		stub.RunScript(F.Scroll, "OnMouseWheel", -1)
		stub.advance(0.5)
		local scrolled = F.Scroll:GetVerticalScroll() > top
		local slider = ctl("ui.scale")
		local guideScale = Polestar.Get("ui.scale")
		stub.keys.shift = true
		stub.RunScript(slider.Slider, "OnMouseWheel", 1)
		stub.keys.shift = false
		local overSlider = { Polestar.Get("ui.menuScale"), Polestar.Get("ui.scale") == guideScale }
		stub.RunScript(slider.Slider, "OnMouseWheel", 1)
		local stepped = Polestar.Get("ui.scale") > guideScale
		emit({ order = order, peeking = peeking, whole = whole, folded = folded, unfolded = unfolded, another = another,
			scale = scale, shifted = shifted, lit = lit, scrolled = scrolled, overSlider = overSlider, stepped = stepped })"#);
	assert_eq!(out["order"], json!([true, true, true]), "Fold and Peek between the search and the scale");
	assert!(out["peeking"].as_f64().unwrap() < 0.2, "held down, the window fades: {}", out["peeking"]);
	assert_eq!(out["whole"], 1.0, "let go, whole again");
	assert_eq!(out["folded"], json!({ "h": 114, "header": true, "body": false, "footer": false, "nav": false, "shown": true, "tip": "Unfold" }));
	assert_eq!(out["unfolded"], json!({ "h": true, "body": true, "footer": true, "nav": true, "page": true, "tip": "Fold" }));
	assert_eq!(out["another"], json!([true, true, true]), "another page unfolds it");
	assert_eq!(out["scale"], 1.0);
	assert_eq!(out["shifted"], 1.05, "Shift + the wheel over the body: one step bigger");
	assert_eq!(out["lit"], true, "the scale control lit");
	assert_eq!(out["scrolled"], true, "the plain wheel scrolls the body");
	assert_eq!(out["overSlider"], json!([1.1, true]), "over a slider, Shift + the wheel scales the window, not the slider");
	assert_eq!(out["stepped"], true, "the plain wheel steps the slider");
}

// A dragged slider is pulled onto its default, zero inside its range and the value it shows as 100% when the thumb
// passes within a few pixels of one; elsewhere it follows the drag. The wheel and a typed value never snap, and a
// slider whose steps are that far apart already lands on any value (no magnet).
#[test]
fn a_dragged_slider_lands_on_its_default_zero_or_100_percent_when_near_it() {
	let out = run(r#"
		UI.ShowOptions("buttons")
		local row = ctl("ui.launcherSize")
		local s = row.Slider
		stub.RunScript(s, "OnMouseDown", "LeftButton")
		stub.RunScript(s, "OnValueChanged", 30, true)
		local near = { Polestar.Get("ui.launcherSize"), s:GetValue() }
		stub.RunScript(s, "OnValueChanged", 41, true)
		local far = Polestar.Get("ui.launcherSize")
		stub.RunScript(s, "OnMouseUp", "LeftButton")
		Polestar.Set("ui.launcherSize", 32)
		stub.RunScript(s, "OnMouseWheel", -1)
		local wheel = Polestar.Get("ui.launcherSize")
		W.EditSliderValue(row)
		row.Entry:SetText("30")
		stub.RunScript(row.Entry, "OnEnterPressed")
		local typed = Polestar.Get("ui.launcherSize")
		-- The points themselves, on rows of their own: zero, 100%, and a coarse track.
		local pct = function(v) return math.floor(v * 100 + 0.5) .. "%" end
		local zero = W.SliderSnap({ psMin = -10, psMax = 10, psStep = 1, psTrackW = 120, psFormat = "%d" }, 1)
		local hundred = W.SliderSnap({ psMin = 0.5, psMax = 2, psStep = 0.01, psTrackW = 120, psFormat = pct }, 1.04)
		local coarse = W.SliderSnap({ psMin = -2, psMax = 2, psStep = 1, psTrackW = 120, psFormat = "%d" }, 1)
		emit({ near = near, far = far, wheel = wheel, typed = typed, zero = zero, hundred = hundred, coarse = coarse })"#);
	assert_eq!(out["near"], json!([32, 32]), "30 is 3 px from the default 32: it lands there, the thumb too");
	assert_eq!(out["far"], 41, "farther, the drag's own value");
	assert_eq!(out["wheel"], 31, "the wheel steps past it");
	assert_eq!(out["typed"], 30, "a typed value stays");
	assert_eq!(out["zero"], 0);
	assert_eq!(out["hundred"], 1.0);
	assert_eq!(out["coarse"], 1, "steps 30 px apart: no magnet");
}

// The settings body and sidebar glide where the wheel sends them, eased out and on whole pixels; notches in a row
// add up; nothing runs once it lands; Reduce motion jumps; a scroll from code ends a glide. The sidebar shows a
// chevron at its foot while more of it lies below, and a click on it glides to the bottom.
#[test]
fn the_settings_scroll_glides_on_whole_pixels_and_the_sidebar_nudges_to_its_bottom() {
	let out = run(r#"
		Polestar.RegisterDefaults("many", { on = true })
		for i = 1, 20 do
			Polestar.RegisterOptions({ page = "Module " .. i, order = 60 + i, controls = { { kind = "toggle", key = "many.on", label = "On" } } })
		end
		UI.ShowOptions("guide")
		stub.advance(1)
		local F = PolestarOptions
		local sf = F.Scroll
		stub.RunScript(sf, "OnMouseWheel", -1)
		local start = { sf:GetVerticalScroll(), sf.psGlideTo }
		stub.advance(0.05)
		local partway = sf:GetVerticalScroll()
		stub.RunScript(sf, "OnMouseWheel", -1)
		local target = sf.psGlideTo
		stub.advance(0.5)
		local landed = { sf:GetVerticalScroll(), sf.psGlideTo or false, Polestar.Anim.Active() }
		Polestar.Set("ui.reduceMotion", true)
		stub.RunScript(sf, "OnMouseWheel", -1)
		local jumped = sf:GetVerticalScroll() == math.min(180, sf.psContent - sf.psView)
		Polestar.Set("ui.reduceMotion", false)
		stub.RunScript(sf, "OnMouseWheel", 1)
		W.ScrollTo(sf, 0)
		stub.advance(0.5)
		local code = sf:GetVerticalScroll()
		local nav = F.NavScroll
		local nudge = { shown = F.NavMore:IsShown(), parent = F.NavMore:GetParent() == nav }
		F.NavMore:Click()
		stub.advance(0.5)
		local range = nav.psContent - nav.psView
		emit({ start = start, partway = partway, whole = partway == math.floor(partway), target = target, landed = landed,
			jumped = jumped, code = code, nudge = nudge, bottom = math.abs(nav:GetVerticalScroll() - range) < 1, gone = F.NavMore:IsShown() })"#);
	assert_eq!(out["start"], json!([0, 60]), "the wheel sets where it goes; the glide starts from here");
	let p = out["partway"].as_f64().unwrap();
	assert!(p > 0.0 && p < 60.0, "partway there after 50 ms: {p}");
	assert_eq!(out["whole"], true, "on a whole pixel");
	assert_eq!(out["target"], 120, "a second notch adds to where the first was going");
	assert_eq!(out["landed"], json!([120, false, 0]), "landed, nothing left running");
	assert_eq!(out["jumped"], true, "Reduce motion: at once (a notch on, or the end)");
	assert_eq!(out["code"], 0, "a scroll from code ends the glide");
	assert_eq!(out["nudge"], json!({ "shown": true, "parent": true }), "more of the sidebar below: the chevron");
	assert_eq!(out["bottom"], true, "its click glides to the bottom");
	assert_eq!(out["gone"], false, "at the bottom it goes");
}

// A list longer than twelve rows (a profile menu, a long dropdown) scrolls under a filter box that takes the keys:
// it opens with its current choice in view, typing narrows the rows (nothing left says so), Enter picks the first
// left, Escape empties the box and then closes the list. A short list stays as it was: no box, no scroll.
#[test]
fn a_long_list_scrolls_under_a_filter_that_narrows_it_and_enter_picks_the_first_left() {
	let out = run(r#"
		local anchor = CreateFrame("Frame", nil, UIParent)
		anchor:SetSize(100, 20)
		anchor:SetPoint("CENTER")
		local picked
		local items = {}
		for i = 1, 20 do items[i] = { text = "Choice " .. i, checked = i == 15, onClick = function() picked = i end } end
		W.ShowMenu(anchor, items)
		local m = PolestarMenu
		local function shown()
			local n = 0
			for _, r in ipairs(m.rows) do if r:IsShown() then n = n + 1 end end
			return n
		end
		local long = { scroll = m.Scroll:IsShown(), filter = m.Filter:IsShown(), focus = m.Filter:HasFocus(), rows = shown(),
			view = m.Scroll.psView, content = m.Scroll.psContent, choiceInView = m.Scroll:GetVerticalScroll() > 0 }
		local h = m:GetHeight()
		m.Filter:SetText("1")
		stub.RunScript(m.Filter, "OnTextChanged", true)
		local narrowed = { shown(), m:GetHeight() == h }
		m.Filter:SetText("zzz")
		stub.RunScript(m.Filter, "OnTextChanged", true)
		local none = { shown(), m.Empty:IsShown() }
		m.Filter:SetText("Choice 7")
		stub.RunScript(m.Filter, "OnTextChanged", true)
		stub.RunScript(m.Filter, "OnEnterPressed")
		local enter = { picked, m:IsShown() }
		W.ShowMenu(anchor, items)
		m.Filter:SetText("Choice")
		stub.RunScript(m.Filter, "OnTextChanged", true)
		stub.RunScript(m.Filter, "OnEscapePressed")
		local esc1 = { m.Filter:GetText(), m:IsShown() }
		stub.RunScript(m.Filter, "OnEscapePressed")
		local esc2 = m:IsShown()
		local few = {}
		for i = 1, 5 do few[i] = { text = "Few " .. i } end
		W.ShowMenu(anchor, few)
		local short = { filter = m.Filter:IsShown(), scroll = m.Scroll:IsShown(), rows = shown(), parent = m.rows[1]:GetParent() == m }
		W.HideMenu()
		emit({ long = long, narrowed = narrowed, none = none, enter = enter, esc1 = esc1, esc2 = esc2, short = short })"#);
	assert_eq!(out["long"], json!({ "scroll": true, "filter": true, "focus": true, "rows": 20, "view": 312, "content": 520, "choiceInView": true }));
	assert_eq!(out["narrowed"], json!([11, true]), "\"1\": Choice 1 and 10 to 19; the list keeps its size");
	assert_eq!(out["none"], json!([0, true]), "nothing left: it says so");
	assert_eq!(out["enter"], json!([7, false]), "Enter picks the first left");
	assert_eq!(out["esc1"], json!(["", true]), "Escape empties the box first");
	assert_eq!(out["esc2"], false, "then closes the list");
	assert_eq!(out["short"], json!({ "filter": false, "scroll": false, "rows": 5, "parent": true }), "a short list as it was");
}

// A colour row remembers more: a right-click on one of the recent colours keeps it as a favourite (first among the
// squares, in an accent edge, out of the recents' turnover; right-click again lets it go), and after a change the
// colour the row held before stands nearest the chip, a click going back to it.
#[test]
fn a_colour_row_keeps_favourites_and_offers_the_colour_it_held_before() {
	let out = run(r#"
		UI.ShowOptions("arrow")
		local row = ctl("nav.arrowNearColor")
		PolestarDB.recentColors = { { 1, 0, 0 }, { 0, 1, 0 }, { 0, 0, 1 } }
		PolestarDB.pinnedColors = nil
		row:Refresh()
		local function squares()
			local out = {}
			for _, sq in ipairs(row.Recent) do
				if sq:IsShown() then out[#out + 1] = (sq.psPinned and "*" or "") .. W.ColorHex(sq.psColor[1], sq.psColor[2], sq.psColor[3]) end
			end
			return out
		end
		local start = squares()
		stub.RunScript(row.Recent[2], "OnClick", "RightButton")
		local pinned = squares()
		for i = 1, 8 do W.PushRecentColor({ i / 10, 0.5, 0.5 }) end
		local turnover = squares()[1]
		stub.RunScript(row.Recent[1], "OnClick", "RightButton")
		local unpinned = { #PolestarDB.pinnedColors, squares()[1] }
		local noPrev = row.Prev:IsShown()
		stub.RunScript(row.Recent[1], "OnClick", "LeftButton")
		local picked = { Polestar.GetStored("nav.arrowNearColor") ~= nil, row.Prev:IsShown() }
		stub.RunScript(row.Prev, "OnClick", "LeftButton")
		local back = { Polestar.GetStored("nav.arrowNearColor") or false, row.Prev:IsShown() }
		emit({ start = start, pinned = pinned, turnover = turnover, unpinned = unpinned, noPrev = noPrev, picked = picked, back = back })"#);
	assert_eq!(out["start"], json!(["#FF0000", "#00FF00", "#0000FF"]));
	assert_eq!(out["pinned"], json!(["*#00FF00", "#FF0000", "#0000FF"]), "the favourite first, the others after");
	assert_eq!(out["turnover"], "*#00FF00", "eight new colours later it is still there");
	assert_eq!(out["unpinned"], json!([0, "#CC8080"]), "let go: the newest recent first again");
	assert_eq!(out["noPrev"], false, "no change yet: no previous colour");
	assert_eq!(out["picked"], json!([true, true]), "a change: the colour before it nearest the chip");
	assert_eq!(out["back"], json!([false, true]), "a click on it goes back (its default), and offers the other");
}

// The first change ever of a setting whose row has a cog pulses the cog's dot and says in a callout by it that more
// of that setting's settings are behind it; once on the account, and never after a cog has been opened.
#[test]
fn the_first_change_of_a_setting_with_a_cog_points_out_the_cog_once() {
	let out = run(r#"
		UI.ShowOptions("arrow")
		PolestarDB.optionsCogHint = nil
		local row = ctl("nav.arrowNearColor")
		local cog = row.Cog
		Polestar.Set("nav.arrowNearColor", { 1, 0, 0 })
		local cue = rawget(PolestarOptions, "psCallout")
		local first = { cue ~= nil and cue:IsShown(), cue and cue.Title:GetText() or false, cue and cue.Text:GetText() or false,
			PolestarDB.optionsCogHint or false, cue and select(2, cue:GetPoint(1)) == cog, cog.Dot:IsShown() }
		stub.advance(3)
		local settled = { cog.Dot:IsShown(), math.floor(cog.Dot:GetWidth() + 0.5) }
		cue.Close:Click()
		Polestar.Set("nav.arrowNearColor", { 0, 1, 0 })
		local again = cue:IsShown()
		-- An account that opened a cog first is never told.
		PolestarDB.optionsCogHint = nil
		cog:Click()
		local opened = PolestarDB.optionsCogHint or false
		Polestar.Widgets.HideMenu()
		O.HideMore()
		emit({ first = first, settled = settled, again = again, opened = opened })"#);
	assert_eq!(out["first"], json!([true, "More settings here", "Near colour has more settings behind its gear.", true, true, true]));
	assert_eq!(out["settled"], json!([false, 6]), "the pulse ends; the dot back to what it says");
	assert_eq!(out["again"], false, "once");
	assert_eq!(out["opened"], true, "a cog opened: no cue left to give");
}

// Enter takes the action of a dialog that destroys nothing (not of a danger one). Reset all settings says whose
// profile goes back; the account's (or a class's) asks for a word first: the action waits until the field holds it
// (any case), and Enter there takes it. A character's own profile needs no word.
#[test]
fn enter_takes_a_safe_dialog_and_a_wide_reset_asks_for_a_word_first() {
	let out = run(r#"
		local accepted
		W.Modal({ title = "Apply?", action = "Apply", onAccept = function() accepted = true end })
		stub.RunScript(PolestarModal.Box, "OnKeyDown", "ENTER")
		local enter = { accepted == true, W.ModalShown() }
		accepted = nil
		W.Modal({ title = "Reset?", action = "Reset", danger = true, onAccept = function() accepted = true end })
		stub.RunScript(PolestarModal.Box, "OnKeyDown", "ENTER")
		local danger = { accepted or false, W.ModalShown() }
		W.HideModal()
		Polestar.Set("ui.scale", 1.4)
		UI.ShowOptions("about")
		O.view.ResetAll:Click()
		local box = PolestarModal.Box
		local gated = { box.Word:IsShown(), box.Word:HasFocus(), box.Action:IsEnabled(), box.Word.Hint:GetText(),
			(box.Text:GetText():find("every character on the account", 1, true)) ~= nil }
		box.Action:Click()
		stub.RunScript(PolestarModal.Box, "OnKeyDown", "ENTER")
		local held = { Polestar.Get("ui.scale"), W.ModalShown() }
		box.Word:SetText("RES")
		stub.RunScript(box.Word, "OnTextChanged", true)
		local partial = box.Action:IsEnabled()
		box.Word:SetText(" reset ")
		stub.RunScript(box.Word, "OnTextChanged", true)
		local typed = box.Action:IsEnabled()
		stub.RunScript(box.Word, "OnEnterPressed")
		local done = { Polestar.Get("ui.scale"), W.ModalShown() }
		-- A character's own profile: no word.
		local P = Polestar.Profiles
		P.New("Mine")
		P.UseForCharacter(true)
		P.Switch("Mine")
		O.view.ResetAll:Click()
		local own = { box.Word:IsShown(), box.Action:IsEnabled(), (box.Text:GetText():find("this character's", 1, true)) ~= nil }
		W.HideModal()
		emit({ enter = enter, danger = danger, gated = gated, held = held, partial = partial, typed = typed, done = done, own = own })"#);
	assert_eq!(out["enter"], json!([true, false]), "Enter takes a dialog that destroys nothing");
	assert_eq!(out["danger"], json!([false, true]), "not a danger one");
	assert_eq!(out["gated"], json!([true, true, false, "Type RESET to go ahead.", true]), "the account's profile: a word to type, the dialog says whose");
	assert_eq!(out["held"], json!([1.4, true]), "neither the button nor Enter acts before it");
	assert_eq!(out["partial"], false);
	assert_eq!(out["typed"], true, "any case, spaces aside");
	assert_eq!(out["done"], json!([1, false]), "Enter in the field takes it");
	assert_eq!(out["own"], json!([false, true, true]), "a character's own profile: no word");
}

// A profile can have a key: on the Profiles page its Set a key takes the next key pressed (one the game binds is
// refused, the capture going on), set as an override binding of Polestar's own; pressing it switches to the
// profile (never in a fight); the key follows a rename, and a right-click (or deleting the profile) takes it away.
#[test]
fn a_profile_key_switches_to_its_profile_and_follows_it() {
	let out = run(r#"
		local overrides, saved = {}, { W = "MOVEFORWARD" }
		function SetOverrideBindingClick(owner, prio, key, button, mouse) overrides[key] = button .. ":" .. mouse end
		function ClearOverrideBindings() for k in pairs(overrides) do overrides[k] = nil end end
		function GetBindingAction(key, override)
			if override and overrides[key] then return "CLICK " .. overrides[key] end
			return saved[key] or ""
		end
		local P = Polestar.Profiles
		P.New("Raid")
		UI.ShowOptions("profiles")
		UI.Profiles.Select("Raid")
		local v = UI.Profiles.views["Profiles"]
		local unset = v.Key.Label:GetText()
		v.Key:Click()
		local waiting = { v.Key.Label:GetText(), PolestarPadCapture:IsShown() }
		stub.RunScript(PolestarPadCapture, "OnKeyDown", "W")
		local refused = { P.Key("Raid") or false, v.NameError:IsShown() and v.NameError:GetText() or false, PolestarPadCapture:IsShown() }
		stub.keys.ctrl = true
		stub.RunScript(PolestarPadCapture, "OnKeyDown", "F5")
		stub.keys.ctrl = false
		local set = { P.Key("Raid"), overrides["CTRL-F5"] or false, v.Key.Label:GetText(), PolestarPadCapture:IsShown() }
		stub.RunScript(PolestarProfileKey, "OnClick", "p1", true)
		local switched = { P.Active(), stub.messages[#stub.messages] }
		P.Switch("Default")
		stub.inCombat = true
		stub.RunScript(PolestarProfileKey, "OnClick", "p1", true)
		local fight = { P.Active(), stub.messages[#stub.messages] }
		stub.inCombat = false
		P.Rename("Raid", "Dungeons")
		local renamed = { P.Key("Dungeons") or false, P.Key("Raid") or false }
		stub.RunScript(PolestarProfileKey, "OnClick", "p1", true)
		local follows = P.Active()
		P.Switch("Default")
		UI.Profiles.Select("Dungeons")
		v.Key:Click("RightButton")
		local cleared = { P.Key("Dungeons") or false, next(overrides) == nil }
		P.SetKey("Dungeons", "CTRL-F6")
		P.Delete("Dungeons")
		emit({ unset = unset, waiting = waiting, refused = refused, set = set, switched = switched, fight = fight, renamed = renamed,
			follows = follows, cleared = cleared, deleted = { PolestarDB.profileKeys == nil, next(overrides) == nil } })"#);
	assert_eq!(out["unset"], "Set a key");
	assert_eq!(out["waiting"], json!(["Press a key...", true]));
	assert_eq!(out["refused"], json!([false, "W is taken (MOVEFORWARD): press another key, or Escape.", true]), "a key the game binds is refused, the capture goes on");
	assert_eq!(out["set"], json!(["CTRL-F5", "PolestarProfileKey:p1", "Key: Ctrl + F5", false]));
	assert_eq!(out["switched"], json!(["Raid", "|cff4fd1c5Polestar|r: Profile: Raid"]), "the key switches to it");
	assert_eq!(out["fight"], json!(["Default", "|cff4fd1c5Polestar|r: Profiles switch out of combat."]));
	assert_eq!(out["renamed"], json!(["CTRL-F5", false]), "the key follows a rename");
	assert_eq!(out["follows"], "Dungeons");
	assert_eq!(out["cleared"], json!([false, true]), "right-click takes it away");
	assert_eq!(out["deleted"], json!([true, true]), "deleting the profile takes its key");
}

// A page title too long for the header's room takes it from the search first (down to the search's least width,
// 130 px) before it is cut short; a shorter title gives the search its width back. Peek and Fold sit as a pair.
#[test]
fn a_long_title_takes_room_from_the_header_search_before_it_is_cut() {
	let out = run(r#"
		Polestar.Set("ui.optionsSize", { 1, 700 })
		UI.ShowOptions("guide")
		local F = PolestarOptions
		local function header()
			local edge
			for i = 1, F.Title:GetNumPoints() do
				local p, _, _, x = F.Title:GetPoint(i)
				if p == "TOPRIGHT" then edge = -x end
			end
			return { room = F.psMainW - W.SHELL.pad - edge, need = math.ceil(F.Title:GetStringWidth()), search = F.Search:GetWidth() }
		end
		local short = header()
		O.Select("qol")
		local long = header()
		O.Select("guide")
		local back = header()
		local _, rel, _, gap = F.PeekButton:GetPoint(1)
		emit({ short = short, long = long, back = back, pair = { rel == F.FoldButton, gap } })"#);
	assert_eq!(out["short"]["search"], 185, "a short title leaves the search its own width");
	assert!(out["short"]["room"].as_i64() >= out["short"]["need"].as_i64(), "{}", out["short"]);
	assert_eq!(out["long"]["search"], 130, "a long one takes room from the search, down to its least");
	assert_eq!(out["long"]["room"].as_i64().unwrap(), out["short"]["room"].as_i64().unwrap() + 55, "{}", out["long"]);
	assert_eq!(out["back"], out["short"], "the search's width back for a shorter title");
	assert_eq!(out["pair"], json!([true, -4]), "Peek sits close by Fold");
}
