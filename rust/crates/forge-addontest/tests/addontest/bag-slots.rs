//! Shared bag hooks paint every module without changing the marks' placement.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const HOOKS: &str = r#"
g = stub.gear
bagHooks = {}
local originalHook = hooksecurefunc
function hooksecurefunc(frame, method, fn)
 if type(frame) == "table" and method == "UpdateItems" then bagHooks[frame] = (bagHooks[frame] or 0) + 1 end
 return originalHook(frame, method, fn)
end
function hookCounts()
 local counts = {}
 for _, frame in ipairs(ContainerFrameContainer.ContainerFrames) do counts[#counts + 1] = bagHooks[frame] or 0 end
 counts[#counts + 1] = bagHooks[ContainerFrameCombinedBags] or 0
 return counts
end
"#;

const ELLESMERE: &str = r#"
g = stub.gear
EUI_Bags = { itemOverlayIcons = {}, registrations = 0 }
function EUI_Bags.RegisterItemOverlayIcon(name, fn)
 EUI_Bags.registrations = EUI_Bags.registrations + 1
 EUI_Bags.itemOverlayIcons[name] = fn
 -- Register before the modules so a failure must not stop any of their marks.
 if throwingPainter then Polestar.BagSlots.Painter("test-throw", throwingPainter) end
end
"#;

const VERDICTS: &str = r#"
local G, Q = Polestar.Gear, Polestar.QuestDB
G.IsUpgrade = function(link) return link == "item:9002" end
G.FillsEmptySlot = function() return false end
Q.IsRunning = function() return true end
Q.IsItemNeeded = function(id) return id == 9002 end
Q.IsObsoleteQuestItem = function() return false end
local function markLook(host)
 local result = {}
 for _, region in ipairs(host.regions) do
  local key = region.texture == "Interface/GossipFrame/ActiveQuestIcon" and "quest"
  if type(region.texture) == "string" and region.texture:find("qol%-upgrade$") then key = "arrow" end
  if key then
   local point, relative = region:GetPoint(1)
   result[key] = { shown = region:IsShown(), point = point, onHost = relative == host,
    layer = region.layer, sublayer = region.sublayer, size = { region:GetSize() } }
  end
 end
 return result
end
"#;

const STEP_ITEMS: &str = r#"
local QoL = Polestar.QoL
QoL.CurrentStep = function() return { goals = { { t = "use", item = 9003, status = "active" } } }, {} end
Polestar.Engine.KeptItems = function() return { [9002] = 2, [9003] = 3 } end
QoL.Client.SellPrice = function() return 10 end
QoL.BagGlow.Refresh()
local function textureOn(host, path)
 for _, region in ipairs(host.regions) do
  if region.texture == path then return region end
 end
end
local function overlaySlot(id)
 local button = CreateFrame("Button", nil, UIParent)
 button:SetSize(37, 37)
 button._textOverlay = CreateFrame("Frame", nil, button)
 EUI_Bags.itemOverlayIcons.Polestar(button, { itemLink = "item:" .. id })
 return button
end
local glowPath = "Interface\\Buttons\\UI-ActionButton-Border"
local lockPath = "Interface\\PetBattles\\PetBattle-LockIcon"
"#;

fn run(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "QoL/QoL.xml", "Quests/Quests.xml"])],
		script: script.into(),
		..Default::default()
	})
}

#[test]
fn one_update_hook_per_frame_after_every_modules_redraw_and_login() {
	let out = run(
		HOOKS,
		r#"
emit(hookCounts())
Polestar.Gear.Bags.Redraw()
Polestar.QuestDB.RedrawBagMarks()
Polestar.QoL.BagGlow.Redraw()
emit(hookCounts())
stub.login()
emit(hookCounts())
"#,
	);
	assert_eq!(out, vec![json!([1, 1, 1, 1, 1, 1]); 3]);
}

#[test]
fn a_failing_painter_does_not_cost_the_other_modules_their_marks() {
	let before = [
		ELLESMERE,
		r#"
reportedErrors = 0
function recordBagError() reportedErrors = reportedErrors + 1 end
function geterrorhandler() return recordBagError end
function throwingPainter() error("bag painter test failure") end
"#,
	]
	.concat();
	let out = run(
		&before,
		&[
			VERDICTS,
			r#"
g.bag(0, 1, "item:9002")
g.openBag(0)
local look = markLook(g.bagButton(0, 1))
emit({ look.arrow.shown, look.quest.shown, reportedErrors > 0 })
"#,
		]
		.concat(),
	);
	assert_eq!(out[0], json!([true, true, true]));
}

#[test]
fn one_ellesmere_painter_draws_both_marks_on_the_same_overlay() {
	let out = run(
		ELLESMERE,
		&[
			VERDICTS,
			r#"
local keys = {}
for name in pairs(EUI_Bags.itemOverlayIcons) do keys[#keys + 1] = name end
table.sort(keys)
emit({ keys = keys, registrations = EUI_Bags.registrations })
local button = CreateFrame("Button", nil, UIParent)
button._textOverlay = CreateFrame("Frame", nil, button)
EUI_Bags.itemOverlayIcons.Polestar(button, { itemLink = "item:9002" })
emit(markLook(button._textOverlay))
"#,
		]
		.concat(),
	);
	assert_eq!(out[0], json!({ "keys": ["Polestar"], "registrations": 1 }));
	assert_eq!(out[1]["arrow"], json!({ "shown": true, "point": "BOTTOMLEFT", "onHost": true, "layer": "OVERLAY", "sublayer": 3, "size": [20, 20] }));
	assert_eq!(out[1]["quest"], json!({ "shown": true, "point": "TOPRIGHT", "onHost": true, "layer": "OVERLAY", "sublayer": 3, "size": [16, 16] }));
}

#[test]
fn client_arrow_quest_icon_and_keep_lock_have_distinct_corners() {
	let out = run(
		HOOKS,
		&[
			VERDICTS,
			STEP_ITEMS,
			r#"
g.bag(0, 1, "item:9002")
g.openBag(0)
local button = g.bagButton(0, 1)
local look = markLook(button)
local lock = textureOn(button, lockPath)
local point, host, relative, x, y = lock:GetPoint(1)
emit({ arrow = look.arrow.point, quest = look.quest.point, lock = point,
 shown = lock:IsShown(), onButton = host == button, relative = relative, x = x, y = y })
"#,
		]
		.concat(),
	);
	assert_eq!(out[0], json!({ "arrow": "TOPLEFT", "quest": "TOPRIGHT", "lock": "BOTTOMLEFT", "shown": true, "onButton": true, "relative": "BOTTOMLEFT", "x": 1, "y": 1 }));
}

const BAGANATOR_CORNERS: &str = r#"
bagCorners = {}
Baganator = { API = {} }
function Baganator.API.RegisterCornerWidget(label, id, show, make, position)
 bagCorners[id] = position.corner
end
"#;

#[test]
fn baganator_assigns_four_distinct_widget_corners() {
	let out = run(
		BAGANATOR_CORNERS,
		r#"
-- The leftover's full-slot border is excluded: quest-class items never get the upgrade arrow.
local ids = { "polestar_upgrade", "polestar_quest_needed", "polestar_step_item", "polestar_keep_lock" }
local corners, seen = {}, {}
for _, id in ipairs(ids) do
 local corner = bagCorners[id]
 assert(corner and not seen[corner], id .. " needs a distinct corner")
 seen[corner] = true; corners[#corners + 1] = corner
end
emit(corners)
"#,
	);
	assert_eq!(out[0], json!(["top_left", "top_right", "bottom_right", "bottom_left"]));
}

const ELLESMERE_GLOW_LOOK: &str = r#"
local step, kept = overlaySlot(9003), overlaySlot(9002)
local glow = textureOn(step._textOverlay, glowPath)
local lock = textureOn(kept._textOverlay, lockPath)
local point, host, relative, x, y = lock:GetPoint(1)
emit({ glow = glow:IsShown(), lock = lock:IsShown(), point = point,
 onOverlay = host == kept._textOverlay, relative = relative, x = x, y = y, size = { lock:GetSize() } })
assert(not textureOn(step._textOverlay, lockPath))
local centre, glowHost = glow:GetPoint(1)
assert(centre == "CENTER" and glowHost == step._textOverlay and glow.sublayer == 2)
assert(math.abs(glow:GetWidth() - 37 * 1.9) < 0.001)
Polestar.Set("ui.skin", "halo")
local r, g, b = Polestar.Theme.Accent()
local gr, gg, gb = glow:GetVertexColor()
emit(r == gr and g == gg and b == gb)
Polestar.Set("qol.bagGlow", false)
emit({ glow:IsShown(), lock:IsShown() })
"#;

#[test]
fn ellesmere_step_glow_and_keep_lock_follow_the_setting_and_theme() {
	let out = run(ELLESMERE, &[VERDICTS, STEP_ITEMS, ELLESMERE_GLOW_LOOK].concat());
	assert_eq!(out[0], json!({ "glow": true, "lock": true, "point": "TOPRIGHT", "onOverlay": true, "relative": "TOPRIGHT", "x": -17, "y": -1, "size": [14, 14] }));
	assert_eq!(out[1], true);
	assert_eq!(out[2], json!([false, false]));
}

const MOTION_STATES: &str = r#"
g.bag(0, 1, "item:9003"); g.openBag(0)
local button = overlaySlot(9003)
local client = textureOn(g.bagButton(0, 1), glowPath)
local overlay = textureOn(button._textOverlay, glowPath)
-- The stub finishes Play immediately; a looping bounce must stay playing until Stop.
local FakeLoopingPulse = {}
function FakeLoopingPulse.Play(self) self.playing = true end
client.pulse.Play, overlay.pulse.Play = FakeLoopingPulse.Play, FakeLoopingPulse.Play
local states = {}
local function motionState(reduce)
 client:SetAlpha(0.35); overlay:SetAlpha(0.35)
 Polestar.Set("ui.reduceMotion", reduce)
 assert(client.pulse:IsPlaying() == (not reduce) and overlay.pulse:IsPlaying() == (not reduce))
 assert(client:IsShown() and overlay:IsShown())
 if reduce then assert(client:GetAlpha() == 1 and overlay:GetAlpha() == 1) end
 QoL.BagGlow.Redraw()
 states[#states + 1] = { client.pulse:IsPlaying(), overlay.pulse:IsPlaying() }
end
motionState(true); motionState(false); motionState(true)
motionState(false); motionState(true)
emit(states)
"#;

#[test]
fn reduce_motion_stops_and_restarts_client_and_ellesmere_pulses_twice() {
	let out = run(ELLESMERE, &[VERDICTS, STEP_ITEMS, MOTION_STATES].concat());
	assert_eq!(out[0], json!([[false, false], [true, true], [false, false], [true, true], [false, false]]));
}

// The vial a later step keeps has no quest icon: its lock sits in the corner, not 17 px in. A quest needing it
// (or the quest marks' setting) moves the lock aside for the icon and back, on the quest marks' redraw alone.
const ELLESMERE_LOCK_ASIDE: &str = r#"
Polestar.Engine.KeptItems = function() return { [9002] = 2, [9005] = 4 } end
QoL.BagGlow.Refresh()
local vial = overlaySlot(9005)
local lock = textureOn(vial._textOverlay, lockPath)
local Q, needed = Polestar.QuestDB, false
Q.IsItemNeeded = function(id) return id == 9002 or (id == 9005 and needed) end
local function lockX()
 local point, _, _, x = lock:GetPoint(1)
 assert(point == "TOPRIGHT" and lock:IsShown() and #lock.points == 1)
 return x
end
local xs = { lockX() }
for _ = 1, 2 do
 needed = true; Q.RedrawBagMarks(); xs[#xs + 1] = lockX()
 Polestar.Set("qol.questBagMarks", false); xs[#xs + 1] = lockX()
 Polestar.Set("qol.questBagMarks", true); xs[#xs + 1] = lockX()
 needed = false; Q.RedrawBagMarks(); xs[#xs + 1] = lockX()
end
emit(xs)
"#;

#[test]
fn ellesmere_keep_lock_sits_in_the_corner_and_moves_aside_only_for_a_quest_icon() {
	let out = run(ELLESMERE, &[VERDICTS, STEP_ITEMS, ELLESMERE_LOCK_ASIDE].concat());
	assert_eq!(out[0], json!([-1, -17, -1, -17, -1, -17, -1, -17, -1]));
}
