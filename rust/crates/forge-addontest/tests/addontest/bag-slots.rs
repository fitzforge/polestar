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
	let before = [ELLESMERE, r#"
reportedErrors = 0
function recordBagError() reportedErrors = reportedErrors + 1 end
function geterrorhandler() return recordBagError end
function throwingPainter() error("bag painter test failure") end
"#].concat();
	let out = run(&before, &[VERDICTS, r#"
g.bag(0, 1, "item:9002")
g.openBag(0)
local look = markLook(g.bagButton(0, 1))
emit({ look.arrow.shown, look.quest.shown, reportedErrors > 0 })
"#].concat());
	assert_eq!(out[0], json!([true, true, true]));
}

#[test]
fn one_ellesmere_painter_draws_both_marks_on_the_same_overlay() {
	let out = run(ELLESMERE, &[VERDICTS, r#"
local keys = {}
for name in pairs(EUI_Bags.itemOverlayIcons) do keys[#keys + 1] = name end
table.sort(keys)
emit({ keys = keys, registrations = EUI_Bags.registrations })
local button = CreateFrame("Button", nil, UIParent)
button._textOverlay = CreateFrame("Frame", nil, button)
EUI_Bags.itemOverlayIcons.Polestar(button, { itemLink = "item:9002" })
emit(markLook(button._textOverlay))
"#].concat());
	assert_eq!(out[0], json!({ "keys": ["Polestar"], "registrations": 1 }));
	assert_eq!(out[1]["arrow"], json!({ "shown": true, "point": "BOTTOMLEFT", "onHost": true, "layer": "OVERLAY", "sublayer": 3, "size": [20, 20] }));
	assert_eq!(out[1]["quest"], json!({ "shown": true, "point": "TOPRIGHT", "onHost": true, "layer": "OVERLAY", "sublayer": 3, "size": [16, 16] }));
}
