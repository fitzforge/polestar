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

// No Polestar widget in the stack count's corner (bottom-right in Baganator and BagSmith, #4207). The step glow
// shares bottom-left with the keep lock: a glowing step item never gets the lock. The leftover's full-slot border
// shares top-left with the upgrade arrow: quest-class items never get the arrow.
#[test]
fn baganator_leaves_the_stack_count_s_corner_to_the_count() {
	let out = run(
		BAGANATOR_CORNERS,
		r#"
local ids = { "polestar_upgrade", "polestar_quest_needed", "polestar_step_glow", "polestar_keep_lock" }
local corners = {}
for _, id in ipairs(ids) do corners[#corners + 1] = bagCorners[id] or false end
emit(corners)
"#,
	);
	assert_eq!(out[0], json!(["top_left", "top_right", "bottom_left", "bottom_left"]));
}

// Baganator's corners as it draws them (its Core/Config.lua defaults, API/Main.lua's AutoInsert, once per widget id,
// and ItemViewCommon/ItemButton.lua's update): in each corner only the first widget whose onUpdate says true shows.
// The stack count is its `quantity` widget, bottom-right, shown for a stack of 2 or more.
const BAGANATOR_SLOTS: &str = r#"
corners = savedCorners or { top_left = { "junk", "item_level" }, top_right = {}, bottom_left = { "equipment_set" }, bottom_right = { "quantity" } }
applied = savedApplied or {}
plugins = {
 quantity = { onUpdate = function(_, d) return d.itemCount > 1 end, onInit = function(b) return b.Count end },
}
for _, id in ipairs({ "junk", "item_level", "equipment_set" }) do
 plugins[id] = { onUpdate = function() return false end, onInit = function(b) return CreateFrame("Frame", nil, b) end }
end
refreshes = 0
Baganator = { API = {}, Constants = { RefreshReason = { ItemWidgets = 4 } } }
function Baganator.API.RegisterCornerWidget(label, id, onUpdate, onInit, position)
 assert(id and label and onUpdate and onInit and not plugins[id])
 plugins[id] = { label = label, onUpdate = onUpdate, onInit = onInit }
 if applied[id] then return end
 applied[id] = true
 local list = corners[position.corner]
 if position.priority > #list then table.insert(list, id) else table.insert(list, position.priority, id) end
end
function Baganator.API.IsCornerWidgetActive(id)
 for _, list in pairs(corners) do
  for _, x in ipairs(list) do if x == id then return true end end
 end
 return false
end
function Baganator.API.RequestItemButtonsRefresh() refreshes = refreshes + 1 end
-- One slot drawn: corner -> the id it shows.
function baganatorSlot(details)
 local button = CreateFrame("Button", nil, UIParent)
 button:SetSize(37, 37)
 button.Count = button:CreateFontString(nil, "ARTWORK")
 local shown = {}
 for corner, list in pairs(corners) do
  for _, id in ipairs(list) do
   local p = plugins[id]
   local widget = p and p.onInit(button)
   if widget and p.onUpdate(widget, details) then shown[corner] = id; break end
  end
 end
 return shown, button
end
function stepWidget()
 for id, p in pairs(plugins) do
  if p.label == "Polestar: step item" then return id end
 end
end
"#;

const STACK_OF_THREE: &str = r#"
local QoL = Polestar.QoL
QoL.CurrentStep = function() return { goals = { { t = "collect", item = 9003, quest = 882, count = 5, status = "active" } } }, {} end
QoL.BagGlow.Refresh()
local stack = { itemID = 9003, itemLink = "item:9003", itemCount = 3 }
local function look()
 local shown = baganatorSlot(stack)
 local glow = false
 for corner, id in pairs(shown) do
  if id == stepWidget() then glow = corner end
 end
 return { count = shown.bottom_right or false, glow = glow }
end
emit(look())
"#;

// #4207: a stack of 3 of the quest item the step collects. The step's highlight sat first in the count's corner,
// so Baganator drew it (a small empty square) instead of the count until the last one was collected.
#[test]
fn baganator_shows_the_stack_count_of_the_step_s_quest_item_with_its_glow() {
	let out = run(BAGANATOR_SLOTS, STACK_OF_THREE);
	assert_eq!(out[0], json!({ "count": "quantity", "glow": "bottom_left" }));
}

// Players of 0.4.3 have the old step widget saved first in the count's corner: the count shows for them too.
#[test]
fn baganator_shows_the_stack_count_for_a_layout_saved_with_the_old_step_widget() {
	let saved = [
		r#"
savedCorners = { top_left = { "polestar_upgrade", "junk", "item_level" }, top_right = { "polestar_quest_needed" },
 bottom_left = { "polestar_keep_lock", "equipment_set" }, bottom_right = { "polestar_step_item", "quantity" } }
savedApplied = { polestar_upgrade = true, polestar_quest_needed = true, polestar_quest_leftover = true,
 polestar_step_item = true, polestar_keep_lock = true }
"#,
		BAGANATOR_SLOTS,
	]
	.concat();
	let out = run(&saved, STACK_OF_THREE);
	assert_eq!(out[0], json!({ "count": "quantity", "glow": "bottom_left" }));
}

// The highlight is the full-slot ring of the game's bags, centred on the slot, in the theme's accent; switched off
// (qol.bagGlow), Baganator is asked to redraw and no Polestar widget shows, the count still does.
#[test]
fn baganator_step_glow_rings_the_slot_and_goes_with_its_setting() {
	let out = run(
		BAGANATOR_SLOTS,
		&[
			STACK_OF_THREE,
			r#"
local _, button = baganatorSlot(stack)
local frame = plugins[stepWidget()].onInit(button)
local ring = frame:GetRegions()
local point, relative = ring:GetPoint(1)
local r, g, b = Polestar.Theme.Accent()
local vr, vg, vb = ring:GetVertexColor()
emit({ texture = ring.texture, point = point, onButton = relative == button, blend = ring.blend,
 width = math.floor(ring:GetWidth() * 10 + 0.5) / 10, accent = r == vr and g == vg and b == vb })
refreshes = 0
Polestar.Set("qol.bagGlow", false); stub.advance(0.1)
emit({ refreshed = refreshes > 0, look = look() })
"#,
		]
		.concat(),
	);
	assert_eq!(out[1], json!({ "texture": "Interface\\Buttons\\UI-ActionButton-Border", "point": "CENTER", "onButton": true, "blend": "ADD", "width": 70.3, "accent": true }));
	assert_eq!(out[2], json!({ "refreshed": true, "look": { "count": "quantity", "glow": false } }));
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
