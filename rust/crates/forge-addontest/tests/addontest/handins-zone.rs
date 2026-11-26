//! The hub's local hand-in errand uses real Lookup, Codex and saved Engine tabs.

use super::{codex, run, run_scenario, run_with, ID};
use forge_addontest::lua_value;
use serde_json::json;

const LOCAL: &str = "lookup/carried/9001";

#[test]
fn browse_lookup_offers_a_zone_errand_before_any_lookup_guides_exist() {
	let out = run_scenario(
		&codex(),
		"",
		None,
		r#"
openOther('test/current')
local ui = Polestar.UI
ui.ShowPicker()
local F = PolestarPicker
for _, b in ipairs(F.tabButtons) do
	if rawget(b, 'psKey') == 'browse' then b:Click() end
end
assert(ui.Picker.View() == 'browse', 'the Browse tab is available')
local lookup
for _, b in ipairs(F.navButtons) do if b:IsShown() and b.psKey == 'Lookup' then lookup = b end end
assert(lookup, 'Lookup is available without any generated guides'):Click()
local action = F.ZoneHandins
assert(action:IsShown() and action.Title:GetText() == 'Hand in quests in this zone', 'the action is a Lookup list row')
local loaded = C_AddOns.IsAddOnLoaded('Polestar_FreeMode')
action:Click()
settle()
local g = E.GetGuide()
local empty = ui.GuideFrame.parts.empty
local opened = { id=g.id, title=g.title, category=g.category, notes=notes(g), shown=F:IsShown(), tabs=tabIds(),
	emptyText=empty:IsShown() and empty.Text:GetText() }
w.onQuest(7101, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
local refreshed = ids(E.GetGuide())
ui.ShowPicker()
local generated
for _, f in ipairs({F.Body:GetChildren()}) do
	local guide = rawget(f, 'psGuide')
	if f:IsShown() and guide and guide.id == g.id then
		assert(action:GetWidth() == f:GetWidth() and action:GetHeight() == f:GetHeight(), 'the action matches the guide rows')
		local _, parent, _, x, y = action:GetPoint()
		local _, guideParent, _, guideX, guideY = f:GetPoint()
		assert(parent == guideParent and x == guideX and y - action:GetHeight() == guideY,
			'the generated guide follows the action directly')
		generated = true
	end
end
ui.Picker.ToggleFolder('Lookup')
assert(not action:IsShown(), 'folding Lookup hides its action row')
ui.Picker.ToggleFolder('Lookup')
assert(action:IsShown(), 'the action stays available alongside the generated guide')
action:Click()
emit({ loaded=loaded, opened=opened, refreshed=refreshed, generated=generated, reopened=tabIds() })
"#,
		true,
	);
	assert_eq!(out["loaded"], false);
	assert_eq!(
		out["opened"],
		json!({"id":LOCAL,"title":"Hand in quests in Amber Vale","category":"Lookup",
		"notes":"No ready quests with a known hand-in location in this zone.","shown":false,"tabs":["test/current",LOCAL],
		"emptyText":"No ready quests with a known hand-in location in this zone."})
	);
	assert_eq!(out["refreshed"], json!([7101]));
	assert_eq!(out["generated"], true);
	assert_eq!(out["reopened"], json!(["test/current", LOCAL]));
}

#[test]
fn local_destinations_use_map_hierarchy_and_live_border_spawns() {
	let mut data = codex();
	data["npcs"]["5001"]["spawns"] = json!([
		{"map":9001,"x":99.5,"y":50,"f":"e"},
		{"map":9002,"x":0.5,"y":50,"f":"l"},
		{"map":9011,"x":50,"y":50,"f":"l"},
	]);
	data["objects"]["6010"]["spawns"] = json!([{"map":9012,"x":40,"y":60,"f":"l"}]);
	let out = run_with(
		&data,
		r#"
w.addMap(9011, { name='Amber Cave', parent=9001, mapType=5, c=0, left=900, right=700, top=900, bottom=700 })
w.addMap(9012, { name='Unknown Hollow', mapType=5 })
w.moveTo(9001, 99, 50)
for _, q in ipairs({7101,7103,7104,7105,7106,7109}) do w.onQuest(q, {}) end
w.onQuest(7108, {1})
"#,
		None,
		r#"
Polestar.RegisterMapFrames({era={[9001]={c=0,left=1000,right=-1000,top=1000,bottom=-1000}}})
local localId = H.StartZone(); settle()
local localGuide = Polestar.Guides.Get(localId)
w.moveTo(9002, 1, 50)
local across = H.StartZone(); settle()
local all = H.Start(); settle()
local function map(g) return g.steps[1].goals[1].map end
emit({ localMap=map(localGuide), localQuests=ids(localGuide), acrossMap=map(Polestar.Guides.Get(across)),
	acrossQuests=ids(Polestar.Guides.Get(across)), tabs=tabIds(), allQuests=ids(Polestar.Guides.Get(all)) })
"#,
	);
	assert_eq!(
		out,
		json!({"localMap":9011,"localQuests":[7101],"acrossMap":9002,"acrossQuests":[7101],
		"tabs":[LOCAL,"lookup/carried/9002",ID],"allQuests":[7101,7103,7104,7105,7106]})
	);
}

#[test]
fn a_zone_errand_keeps_its_scope_when_refreshed_or_restored_elsewhere() {
	let first = run(
		"w.onQuest(7101, {})",
		None,
		r#"
openOther('test/current')
assert(H.Start())
assert(H.StartZone()); settle()
E.SelectTab(1)
w.moveTo(9002, 50, 50)
w.onQuest(7102, {}); w.onQuest(7104, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({ localQuests=ids(Polestar.Guides.Get('lookup/carried/9001')), all=ids(Polestar.Guides.Get('lookup/carried/log')),
	active=E.GetGuide().id, saved=Polestar.CharState() })
"#,
	);
	assert_eq!(first["localQuests"], json!([7101, 7102]));
	assert_eq!(first["all"], json!([7101, 7102, 7104]));
	assert_eq!(first["active"], "test/current");
	let saved = format!("PolestarCharDB = {}", lua_value(&first["saved"]));
	let restored = run(
		"w.moveTo(9002, 50, 50)",
		Some(saved),
		r#"
local g = Polestar.Guides.Get('lookup/carried/9001')
local waiting = notes(g)
w.onQuest(7101, {}); w.onQuest(7104, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({ waiting=waiting, title=g.title, localQuests=ids(Polestar.Guides.Get(g.id)), all=ids(Polestar.Guides.Get('lookup/carried/log')) })
"#,
	);
	assert_eq!(restored, json!({"waiting":"Waiting for your quest log.","title":"Hand in quests in Amber Vale","localQuests":[7101],"all":[7101,7104]}));
}

#[test]
fn an_unknown_player_zone_keeps_the_current_tab_and_leaves_the_planner_unloaded() {
	let out = run(
		"w.moveTo(9999, 50, 50)",
		None,
		r#"
openOther('test/current')
local id, why = H.StartZone()
emit({ id=id or false, why=why, tabs=tabIds(), loaded=C_AddOns.IsAddOnLoaded('Polestar_FreeMode') })
"#,
	);
	assert_eq!(out, json!({"id":false,"why":"zone","tabs":["test/current"],"loaded":false}));
}
