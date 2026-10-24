use forge_addontest::{emitted, fake_locale, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const BEFORE: &str = r#"
local menus = {}
Menu = { ModifyMenu = function(tag, fn) menus[tag] = fn end }
function questMenu(tag, owner)
	local root = { buttons = { { text = "Native action" } } }
	function root:QueueDivider() end
	function root:CreateButton(text, fn)
		self.buttons[#self.buttons + 1] = { text = text, click = fn }
	end
	if menus[tag] then menus[tag](owner, root) end
	return root.buttons
end
"#;

const PRELUDE: &str = r#"
uistub.install()
Polestar.Guides.Matches = uistub.realGuides.Matches
Polestar.Compat.GetQuestTitle = function(id) return id == 7 and "Kobold Camp Cleanup" or nil end
stub.login()
local P = Polestar.UI.Picker
"#;

fn run_with(script: &str, before: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: format!("{before}{BEFORE}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"])],
		script: format!("{PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, "")
}

#[test]
fn quest_log_action_opens_guide_search_and_matching_steps_without_codex_or_changing_the_active_guide() {
	let r = run(r#"
uistub.setGuide(uistub.tailoring, 2)
local before = Polestar.Engine.GetGuide().id
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
buttons[2].click()
emit({ label = buttons[2].text, native = buttons[1].text, shown = PolestarPicker:IsShown(),
	section = P.Section(), query = P.Query(), search = P.search:GetText(), selected = P.Selected(),
	preview = P.details.Pitch:GetText(), active = Polestar.Engine.GetGuide().id,
	before = before, step = Polestar.Engine.GetStepIndex() })
"#);
	assert_eq!(r["label"], "Polestar: Show in Guides");
	assert_eq!(r["native"], "Native action");
	assert_eq!(r["shown"], true);
	assert_eq!(r["section"], "Guides");
	assert_eq!(r["query"], "Kobold Camp Cleanup");
	assert_eq!(r["search"], r["query"]);
	assert_eq!(r["selected"], "forever/alliance/human/01-elwynn-forest");
	assert!(is_match(text(&r["preview"]), r"Step 2 of \d+: Marshal McBride"));
	assert!(is_match(text(&r["preview"]), r"Kobold Camp"));
	assert_eq!(r["active"], r["before"]);
	assert_eq!(r["step"], 2);
}

#[test]
fn a_quest_menu_leaves_the_account_wide_faction_filter_following_each_character() {
	let r = run(r#"
local function after(setting)
	Polestar.Set("ui.pickerFaction", setting)
	P.ShowQuest(7)
	return Polestar.Get("ui.pickerFaction")
end
emit({ auto = after("auto"), all = after("All"), other = after("Horde"), selected = P.Selected() })
"#);
	assert_eq!(json!([r["auto"], r["all"], r["other"]]), json!(["auto", "All", "auto"]));
	assert_eq!(r["selected"], "forever/alliance/human/01-elwynn-forest");
}

#[test]
fn tracker_resolves_the_quest_from_the_clicked_block_and_freezes_it_when_its_row_is_reused() {
	let r = run(r#"
local opened = {}
P.ShowQuest = function(id) opened[#opened + 1] = id end
QuestObjectiveTracker, CampaignQuestObjectiveTracker = {}, {}
local block = CreateFrame("Frame")
block.parentModule, block.id = QuestObjectiveTracker, 7
local header = CreateFrame("Button", nil, block)
local child = CreateFrame("Frame", nil, header)
QuestObjectiveTracker.GetExistingBlock = function(_, id) if id == block.id then return block end end
GetMouseFoci = function() return { child } end
local buttons = questMenu("MENU_QUEST_OBJECTIVE_TRACKER", { questID = 783 })
block.id = 783
buttons[2].click()
block.parentModule = CampaignQuestObjectiveTracker
CampaignQuestObjectiveTracker.GetExistingBlock = QuestObjectiveTracker.GetExistingBlock
local campaign = questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
campaign[2].click()
emit({ opened = opened, native = buttons[1].text })
"#);
	assert_eq!(r["opened"], json!([7, 783]));
	assert_eq!(r["native"], "Native action");
}

#[test]
fn quest_log_action_keeps_its_original_quest_id_after_a_pooled_row_changes() {
	let r = run(r#"
local owner, opened = { questID = 7 }, nil
P.ShowQuest = function(id) opened = id end
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", owner)
owner.questID = 783
buttons[2].click()
emit({ opened = opened })
"#);
	assert_eq!(r["opened"], 7);
}

#[test]
fn unrelated_tracker_blocks_and_invalid_or_secret_quest_ids_do_not_add_an_action() {
	let r = run(r#"
local counts = {}
for _, id in ipairs({ 0, -1, 7.5, math.huge, "7", {} }) do
	counts[#counts + 1] = #questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = id })
end
issecretvalue = function(value) return value == 7 end
counts[#counts + 1] = #questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
issecretvalue = nil
counts[#counts + 1] = #questMenu("MENU_QUEST_MAP_LOG_TITLE", {})
local other = CreateFrame("Frame")
other.id, other.parentModule = 7, {}
GetMouseFoci = function() return { other } end
counts[#counts + 1] = #questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
QuestObjectiveTracker = { GetExistingBlock = function() return nil end }
other.parentModule = QuestObjectiveTracker
counts[#counts + 1] = #questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
GetMouseFoci = nil
counts[#counts + 1] = #questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})
emit({ counts = counts })
"#);
	assert!(r["counts"].as_array().unwrap().iter().all(|n| *n == 1), "{}", r["counts"]);
}

#[test]
fn a_quest_absent_from_installed_guides_shows_an_empty_search_with_no_unrelated_selection() {
	let r = run(r#"
Polestar.UI.ShowPicker()
local active = Polestar.Engine.GetGuide()
P.ShowQuest(999999)
emit({ query = P.Query(), count = P.shown.guides, selected = P.Selected(),
	empty = PolestarPicker.Empty:GetText(), active = Polestar.Engine.GetGuide() == active })
"#);
	assert_eq!(r["query"], "999999");
	assert_eq!(r["count"], 0);
	assert!(r["selected"].is_null());
	assert!(is_match(text(&r["empty"]), r"No guides match"));
	assert_eq!(r["active"], true);
}

#[test]
fn quest_context_uses_the_client_title_filters_inapplicable_steps_and_clears_on_a_new_search() {
	let r = run(r#"
local westfall = uistub.guides["forever/alliance/02-westfall"]
westfall.steps[1].only = { classes = { "Mage" } }
westfall.steps[1].goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup" } }
Polestar.Compat.GetQuestTitle = function() return "Client quest title" end
P.ShowQuest(7)
local found, query = P.shown.guides, P.Query()
P.SetQuery("westfall")
emit({ found = found, query = query, selected = P.Selected(), count = P.shown.guides, preview = P.details.Pitch:IsShown() and P.details.Pitch:GetText() or "" })
"#);
	assert_eq!(r["found"], 1);
	assert_eq!(r["query"], "Client quest title");
	assert_eq!(r["selected"], "forever/alliance/02-westfall");
	assert_eq!(r["count"], 1);
	assert!(!is_match(text(&r["preview"]), r"Step 2 of"));
}

#[test]
fn menu_wording_and_quest_preview_follow_the_client_language() {
	let r = run_with(
		r#"
Polestar.Compat.GetQuestTitle = function() return "Titolo della missione" end
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
buttons[2].click()
emit({ label = buttons[2].text, query = P.Query(), preview = P.details.Pitch:GetText() })
"#,
		&fake_locale("itIT", &[("Show in Guides", "Mostra nelle guide"), ("Step %d of %d: %s", "Passaggio %d di %d: %s")]),
	);
	assert_eq!(r["label"], "Polestar: Mostra nelle guide");
	assert_eq!(r["query"], "Titolo della missione");
	assert!(is_match(text(&r["preview"]), r"Passaggio 2 di"));
}

#[test]
fn the_shipped_undead_guide_opens_at_the_mindless_ones_from_the_tracker_menu() {
	let r = emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		before: BEFORE.to_string()
			+ r#"
stub.world.race, stub.world.raceName, stub.world.raceID = "Scourge", "Undead", 5
stub.world.faction = "Horde"
stub.world.titles[364] = "The Mindless Ones"
"#,
		// The pack and the Horde part (Polestar loads it on demand in game).
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Lookup/Lookup.xml", "UI/UI.xml"]), Addon::name("Polestar_Guides"), Addon::name("Polestar_Guides_Horde")],
		saved: vec![(
			"Polestar".into(),
			"PolestarDB = { schema = 1, welcomeSeen = 1, settings = { behavior = { autoSelectGuide = false } } }; PolestarCharDB = { schema = 1, welcomeSeen = 1 }".into(),
		)],
		login: true,
		script: r#"
QuestObjectiveTracker = {}
local block = CreateFrame("Frame")
block.id, block.parentModule = 364, QuestObjectiveTracker
QuestObjectiveTracker.GetExistingBlock = function(_, id) if id == 364 then return block end end
local header = CreateFrame("Button", nil, block)
GetMouseFoci = function() return { header } end
local before = Polestar.Engine.GetGuide()
questMenu("MENU_QUEST_OBJECTIVE_TRACKER", {})[2].click()
local P = Polestar.UI.Picker
emit({ query = P.Query(), selected = P.Selected(), preview = P.details.Pitch:GetText(),
	active = Polestar.Engine.GetGuide() == before })
"#
		.into(),
	})
	.remove(0);
	assert_eq!(r["query"], "The Mindless Ones");
	assert_eq!(r["selected"], "forever/horde/undead/01-tirisfal-glades");
	assert!(is_match(text(&r["preview"]), r"Shadow Priest Sarvis"));
	assert!(is_match(text(&r["preview"]), r"Mindless Zombies"));
	assert!(is_match(text(&r["preview"]), r"graveyard"));
	assert_eq!(r["active"], true);
}

fn shipped_wording(locale: &str, label: &str) {
	let r = run_with(
		r#"
local buttons = questMenu("MENU_QUEST_MAP_LOG_TITLE", { questID = 7 })
emit({ label = buttons[2].text })
"#,
		&format!("function GetLocale() return \"{locale}\" end\n"),
	);
	assert_eq!(r["label"], format!("Polestar: {label}").as_str());
}

#[test]
fn quest_menu_uses_shipped_dede_wording() {
	shipped_wording("deDE", "In den Guides zeigen");
}

#[test]
fn quest_menu_uses_shipped_eses_wording() {
	shipped_wording("esES", "Ver en Guías");
}

#[test]
fn quest_menu_uses_shipped_esmx_wording() {
	shipped_wording("esMX", "Ver en Guías");
}

#[test]
fn quest_menu_uses_shipped_frfr_wording() {
	shipped_wording("frFR", "Voir dans les guides");
}

#[test]
fn quest_menu_uses_shipped_ptbr_wording() {
	shipped_wording("ptBR", "Mostrar em Guias");
}

#[test]
fn quest_menu_uses_shipped_ruru_wording() {
	shipped_wording("ruRU", "Показать в гайдах");
}

#[test]
fn quest_menu_uses_shipped_kokr_wording() {
	shipped_wording("koKR", "가이드에서 보기");
}

#[test]
fn quest_menu_uses_shipped_zhcn_wording() {
	shipped_wording("zhCN", "在指南中显示");
}

#[test]
fn quest_menu_uses_shipped_zhtw_wording() {
	shipped_wording("zhTW", "在指南中顯示");
}
