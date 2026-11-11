//! Unlock mode (addon/Polestar_Options/UI/Movers.lua, loaded on its first use through core's door,
//! addon/Polestar/UI/Movers.lua): a box over every movable Polestar frame, dragged with a grid and
//! snapping, each frame's spot kept in its own saved key and format, against the whole addon.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
stub.login()
local M = Polestar.Movers
local function r(v) return math.floor(v + 0.5) end
local function rect(key) local l, b, w, h = M.Rect(key); return { r(l), r(b), r(w), r(h) } end
local function shownKeys()
	local out = {}
	for _, k in ipairs(M.Keys()) do local b = M.Box(k); if b and b:IsShown() then out[#out + 1] = k end end
	return out
end
-- Where a frame stands, in UIParent's units: its recorded anchor (Anim.Anchor) or its first point.
local function frameRect(f)
	local a = f.psAnchor
	local p, rp, x, y
	if a then p, rp, x, y = a[1], a[3], a[4], a[5] else local _; p, _, rp, x, y = f:GetPoint(1) end
	local s = M.Ratio(f)
	local l, b = M.RectOf(p, rp, x * s, y * s, f:GetWidth() * s, f:GetHeight() * s)
	return { r(l), r(b) }
end
local root = function() return PolestarMovers end
local function key(k) stub.RunScript(root(), "OnKeyDown", k) end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], addons: vec![Addon::name("Polestar")], script: format!("{PRELUDE}{script}"), ..Default::default() }).remove(0)
}

const ALL: [&str; 10] = ["guide", "arrow", "launcher", "buttons", "flightTimer", "instances", "party", "rareAlert", "transportAlert", "whileHere"];

// Nothing is built until the first unlock; then a box for every registered frame whose feature is on, hidden
// frames too, each where its frame's saved spot (or default) puts it; a feature turned off takes its box away.
#[test]
fn unlock_lays_a_box_over_every_movable_frame_hidden_ones_too_and_builds_nothing_before() {
	let out = run(r#"
		local before = root() ~= nil
		Polestar.Set("ui.launcher", true)
		local ok = M.Unlock()
		local placed = true
		for _, k in ipairs(shownKeys()) do
			local b, l, bt, w, h = M.Box(k), M.Rect(k)
			if b.psLeft ~= l or b.psBottom ~= bt or b:GetWidth() ~= w or b:GetHeight() ~= h then placed = false end
		end
		local all = shownKeys()
		Polestar.Set("ui.launcher", false)
		emit({ before = before, ok = ok, unlocked = M.IsUnlocked(), shown = root():IsShown(), keys = M.Keys(), all = all,
			placed = placed, withoutLauncher = shownKeys(), idle = root():GetScript("OnUpdate") == nil,
			grid = #M.GridLines() > 0, bar = PolestarMoversBar:IsShown() })"#);
	assert_eq!(out["before"], false, "no frame before the first unlock");
	assert_eq!(out["ok"], true);
	assert_eq!(out["unlocked"], true);
	assert_eq!(out["shown"], true);
	assert_eq!(json!(out["keys"].as_array().unwrap()[..ALL.len()]), json!(ALL), "every movable frame is registered (Alerts & toasts adds its line)");
	assert_eq!(out["all"], json!(ALL), "a box for each, shown or not");
	assert_eq!(out["placed"], true, "each box stands where its frame's spot puts it");
	let without: Vec<&str> = ALL.iter().copied().filter(|k| *k != "launcher").collect();
	assert_eq!(out["withoutLauncher"], json!(without), "the floating button turned off: no box for it");
	assert_eq!(out["idle"], true, "nothing runs per frame while nothing is dragged");
	assert_eq!(out["grid"], true);
	assert_eq!(out["bar"], true);
}

// With nothing saved, each box is where its module puts the frame by default (the defaults written in
// Movers.lua must follow the modules').
#[test]
fn with_nothing_saved_each_box_stands_where_its_module_puts_the_frame() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		local out = {}
		local function check(k, f)
			local box = rect(k)
			out[k] = { box[1], box[2] }
			out[k .. "Frame"] = f and frameRect(f) or false
		end
		check("guide", PolestarGuideFrame)
		check("arrow", PolestarNavArrow)
		check("launcher", PolestarLauncher)
		Polestar.Rares.Toast.Show({ kind = "rare", name = "Hogger" })
		check("rareAlert", PolestarRareToast)
		Polestar.Rares.Toast.Hide()
		Polestar.Nav.alerts.ShowNotice("Notice", "A line", 5)
		check("transportAlert", PolestarAlert)
		PolestarAlert:Hide()
		Polestar.UI.WhileHereToast.Show({ t = "kill", text = "Kill a boar", here = "goal" })
		check("whileHere", PolestarWhileHereToast)
		-- The quest buttons: the box is the column, centred on the holder (the quest item button's slot).
		local B = Polestar.QoL.Buttons
		local p = B.SavedPos()
		local l, b, w, h = M.Rect("buttons")
		local hs = B.Size("item")
		local hl, hb = M.RectOf(p[1], p[2], p[3], p[4], hs, hs)
		out.buttons = { r(l + w / 2), r(b + h / 2) }
		out.buttonsFrame = { r(hl + hs / 2), r(hb + hs / 2) }
		emit(out)"#);
	for k in ["guide", "arrow", "launcher", "rareAlert", "transportAlert", "whileHere", "buttons"] {
		assert_ne!(out[format!("{k}Frame")], json!(false), "{k}: its frame was built");
		assert_eq!(out[k], out[format!("{k}Frame")], "{k}: the box stands where the frame does");
	}
	// The compact frames are built only in flight, in an instance or a group: their defaults are the
	// arguments of their Maps.CompactFrame calls. Unlock mode is the settings' addon's (core keeps its door).
	let root = env!("CARGO_MANIFEST_DIR").to_string() + "/../../../addon/Polestar/";
	let read = |p: &str| std::fs::read_to_string(root.clone() + p).unwrap();
	let movers = read("../Polestar_Options/UI/Movers.lua");
	for (file, call, default) in [
		("Maps/FlightTimer.lua", r#"CompactFrame("PolestarFlightTimer", "maps.timerPos", "TOP", 0, -140)"#, r#""maps.timerPos", { "TOP", 0, -140 })"#),
		("Maps/Instances.lua", r#"CompactFrame("PolestarInstanceTracker", "maps.trackerPos", "TOPRIGHT", -220, -220)"#, r#""maps.trackerPos", { "TOPRIGHT", -220, -220 })"#),
		("UI/PartyPanel.lua", r#"CompactFrame("PolestarPartyPanel", "party.panelPos", "TOPLEFT", 280, -220)"#, r#""party.panelPos", { "TOPLEFT", 280, -220 })"#),
	] {
		assert!(read(file).contains(call), "{file} places its frame as {call}");
		assert!(movers.contains(default), "Movers.lua's default for {file}: {default}");
	}
}

// A drag of a box moves the frame along, snaps, and on the drop saves the spot through the frame's own key
// in its own format; the frame stands there.
#[test]
fn a_drag_saves_the_spot_in_the_frames_own_key_and_format_and_places_the_frame() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		Polestar.Set("movers.grid", false)
		Polestar.Set("movers.snap", false)
		M.Unlock()
		local b = M.Box("launcher")
		local l, bt, w, h = M.Rect("launcher")
		stub.cursor = { l + w / 2, bt + h / 2 }
		stub.RunScript(b, "OnMouseDown", "LeftButton")
		local ticking = root():GetScript("OnUpdate") ~= nil
		stub.cursor = { l + w / 2 - 300.4, bt + h / 2 - 200 }
		root():GetScript("OnUpdate")(root(), 0.02)
		local _, _, _, fx = PolestarLauncher:GetPoint(1)
		local followed = fx
		stub.RunScript(b, "OnMouseUp", "LeftButton")
		local p, rel, rp, x, y = PolestarLauncher:GetPoint(1)
		emit({ ticking = ticking, followed = followed, saved = Polestar.Get("ui.launcherPos"), placed = { p, rel == UIParent, rp, x, y },
			idle = root():GetScript("OnUpdate") == nil, selected = M.Selected(), start = { r(l + w / 2), r(bt + h / 2) } })"#);
	assert_eq!(out["ticking"], true, "a drag runs per frame");
	let start = out["start"].as_array().unwrap();
	let (sx, sy) = (start[0].as_i64().unwrap(), start[1].as_i64().unwrap());
	let want = json!([sx - 300, sy - 200]);
	assert_eq!(out["saved"], want, "ui.launcherPos: the button's centre from the bottom-left");
	assert_eq!(out["placed"], json!(["CENTER", true, "BOTTOMLEFT", sx - 300, sy - 200]), "the launcher re-placed from its key");
	assert_ne!(out["followed"], json!(-440), "the live button followed the drag");
	assert_eq!(out["idle"], true, "the drop stops the per-frame work");
	assert_eq!(out["selected"], "launcher");
}

// Each frame's spot goes to its own key in its own format, and the box lands where it was put.
#[test]
fn a_move_writes_every_frames_own_key_in_its_own_format() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		M.Unlock()
		local out, back = {}, {}
		local to = { guide = { 200, 500 }, arrow = { 900, 300 }, launcher = { 40, 60 }, buttons = { 1500, 300 }, flightTimer = { 700, 900 },
			instances = { 1200, 800 }, party = { 50, 700 }, rareAlert = { 600, 600 }, transportAlert = { 800, 950 }, whileHere = { 300, 100 } }
		for k, at in pairs(to) do
			M.MoveTo(k, at[1], at[2])
			local box = rect(k)
			back[k] = { box[1], box[2] }
		end
		local A = PolestarNavArrow
		local p, _, rp, x, y = A:GetPoint(1)
		emit({ back = back, to = to, guide = Polestar.Get("ui.pos"), arrow = Polestar.Get("nav.arrowPos"), arrowAt = { p, rp, x, y },
			launcher = Polestar.Get("ui.launcherPos"), buttons = Polestar.CharState().qol.buttonPos, timer = Polestar.Get("maps.timerPos"),
			tracker = Polestar.Get("maps.trackerPos"), party = Polestar.Get("party.panelPos"), rare = Polestar.Get("rares.toastPoint"),
			transport = Polestar.Get("toasts.transport.point"), here = Polestar.Get("toasts.whilehere.point"),
			guideH = rect("guide")[4], arrowW = rect("arrow")[3], arrowH = rect("arrow")[4] })"#);
	assert_eq!(out["back"], out["to"], "every box lands where it was put");
	let gh = out["guideH"].as_i64().unwrap();
	assert_eq!(out["guide"], json!([200, 500 + gh]), "ui.pos: the window's top-left corner");
	let (aw, ah) = (out["arrowW"].as_i64().unwrap(), out["arrowH"].as_i64().unwrap());
	let (ax, ay) = (900 + aw / 2 - 960, 300 + ah - 1080);
	assert_eq!(out["arrow"], json!({ "point": "TOP", "relPoint": "TOP", "x": ax, "y": ay }), "nav.arrowPos keeps its table");
	assert_eq!(out["arrowAt"], json!(["TOP", "TOP", ax, ay]), "the arrow stands there");
	assert_eq!(out["launcher"], json!([56, 76]), "ui.launcherPos: the 32px button's centre");
	assert_eq!(out["buttons"][0], "CENTER");
	assert_eq!(out["buttons"][1], "CENTER", "qol.buttonPos keeps its point, relPoint, x, y");
	assert_eq!(out["timer"][0], "TOP", "maps.timerPos keeps its point, x, y");
	assert_eq!(out["tracker"][0], "TOPRIGHT");
	assert_eq!(out["party"][0], "TOPLEFT");
	assert_eq!(out["rare"][0], "TOP");
	assert_eq!(out["transport"][0], "TOP");
	assert_eq!(out["here"][0], "TOP");
	assert_eq!(out["timer"].as_array().unwrap().len(), 3);
}

// The snapping: to the screen's centre lines and the other boxes' edges and centres within 6 px (with the
// line to draw), else to the grid out from the screen's centre; a snap beats the grid on its axis; the box
// stays on screen.
#[test]
fn snapping_takes_the_screen_centre_and_other_edges_within_six_pixels_else_the_grid() {
	let out = run(r#"
		local function s(...) local l, b, gx, gy = M.Snap(...); return { l, b, gx or false, gy or false } end
		emit({
			grid16 = s(101, 203, 50, 20, {}, { snap = false, grid = 16 }),
			grid32 = s(101, 203, 50, 20, {}, { snap = false, grid = 32 }),
			centre = s(905, 300, 100, 40, {}, { snap = true }),
			far = s(900, 300, 100, 40, {}, { snap = true }),
			edges = s(403, 452, 80, 40, { { 300, 400, 100, 50 } }, { snap = true }),
			centres = s(322, 202, 50, 20, { { 300, 400, 100, 50 } }, { snap = true }),
			beatsGrid = s(403, 203, 80, 40, { { 300, 400, 100, 50 } }, { snap = true, grid = 32 }),
			clamped = s(-50, 2000, 80, 40, {}, { snap = false }),
		})"#);
	// 1920 x 1080: grid lines at 960 + gk and 540 + gk.
	assert_eq!(out["grid16"], json!([96, 204, false, false]));
	assert_eq!(out["grid32"], json!([96, 188, false, false]));
	assert_eq!(out["centre"], json!([910, 300, 960, false]), "its centre onto the screen's");
	assert_eq!(out["far"], json!([900, 300, false, false]), "10 px off: no snap");
	assert_eq!(out["edges"], json!([400, 450, 400, 450]), "its left onto the other's right, its bottom onto the other's top");
	assert_eq!(out["centres"], json!([325, 202, 350, false]), "centre onto centre");
	assert_eq!(out["beatsGrid"], json!([400, 188, 400, false]), "x snapped to the edge, y to the grid");
	assert_eq!(out["clamped"], json!([0, 1040, false, false]));
}

// The arrow keys nudge the selected box 1 px (Shift: 10) through the frame's key; a right-click puts that
// frame back; Reset all positions puts every one back.
#[test]
fn arrow_keys_nudge_right_click_resets_one_and_reset_all_resets_every_frame() {
	let out = run(r#"
		Polestar.Set("ui.launcher", true)
		Polestar.Set("ui.launcherPos", { 500, 500 })
		Polestar.Set("maps.timerPos", { "CENTER", 10, 10 })
		Polestar.Set("ui.pos", { 100, 900 })
		M.Unlock("launcher")
		local sel = M.Selected()
		key("UP"); key("RIGHT")
		local one = Polestar.Get("ui.launcherPos")
		stub.keys.shift = true
		key("LEFT")
		stub.keys.shift = false
		local ten = Polestar.Get("ui.launcherPos")
		stub.RunScript(M.Box("launcher"), "OnMouseUp", "RightButton")
		local reset = Polestar.Get("ui.launcherPos")
		Polestar.QoL.Buttons.SetPosition({ "CENTER", "CENTER", 0, 0 })
		M.ResetAll()
		emit({ sel = sel, one = one, ten = ten, reset = reset or false, timer = Polestar.Get("maps.timerPos") or false,
			guide = Polestar.Get("ui.pos") or false, buttons = Polestar.CharState().qol.buttonPos or false })"#);
	assert_eq!(out["sel"], "launcher", "Unlock(key) selects that box");
	assert_eq!(out["one"], json!([501, 501]));
	assert_eq!(out["ten"], json!([491, 501]));
	assert_eq!(out["reset"], false, "right-click: back to its default place");
	assert_eq!(out["timer"], false);
	assert_eq!(out["guide"], false);
	assert_eq!(out["buttons"], false);
}

// A fight locks (it starts before the lockdown) and no unlocking in one; Escape and /polestar unlock lock too.
#[test]
fn a_fight_escape_and_the_command_lock_and_no_unlocking_in_combat() {
	let out = run(r#"
		M.Unlock()
		stub.inCombat = true
		stub.fire("PLAYER_REGEN_DISABLED")
		local fight = { M.IsUnlocked(), root():IsShown(), stub.messages[#stub.messages] }
		local refused = { M.Unlock(), M.IsUnlocked(), stub.messages[#stub.messages] }
		stub.inCombat = false
		SlashCmdList.POLESTAR("unlock")
		local cmd = M.IsUnlocked()
		key("ESCAPE")
		local esc = { M.IsUnlocked(), root():IsShown(), root():GetScript("OnUpdate") == nil }
		SlashCmdList.POLESTAR("unlock")
		SlashCmdList.POLESTAR("unlock")
		emit({ fight = fight, refused = refused, cmd = cmd, esc = esc, toggled = M.IsUnlocked() })"#);
	assert_eq!(out["fight"], json!([false, false, "|cff4fd1c5Polestar|r: Frames locked for the fight."]));
	assert_eq!(out["refused"], json!([false, false, "|cff4fd1c5Polestar|r: You can't move frames in combat."]));
	assert_eq!(out["cmd"], true, "/polestar unlock");
	assert_eq!(out["esc"], json!([false, false, true]), "Escape locks; nothing left running");
	assert_eq!(out["toggled"], false, "/polestar unlock again locks");
}
