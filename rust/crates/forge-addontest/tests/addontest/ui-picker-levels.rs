//! The guide menu's levels chip (addon/Polestar/UI/Picker.lua, UI/LevelTip.lua): what a leveling guide's
//! turn-ins are worth to this character (Levels.ForGuide), their XP from the Codex, and the panel its hover
//! opens, which follows the theme: a new accent, font or skin repaints the chip and lays the open panel out
//! again. The character: stub_ui.lua's level 4 Human Warrior, 1,200 of 2,100 XP into the level.

use forge_addontest::codex::{sample_codex, write_codex_pack, CodexOpts, CodexPack};
use forge_addontest::{emitted, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 5] = ["Core/Core.xml", "Theme/Theme.xml", "Gear/Gear.xml", "Lookup/Lookup.xml", "UI/UI.xml"];
const ELWYNN: &str = "forever/alliance/human/01-elwynn-forest";

// The sample Codex with the Elwynn guide's three turn-ins and its two kill goals' mobs (sample numbers).
fn codex_pack() -> CodexPack {
	let mut codex = sample_codex();
	let base = codex["quests"]["33"].clone();
	let quest = |id: i32, title: &str, level: i32, xp: i32| {
		let mut q = base.clone();
		for (k, v) in [("id", json!(id)), ("title", json!(title)), ("level", json!(level)), ("minLevel", json!(1)), ("objectives", json!([])), ("xp", json!(xp))] {
			q[k] = v;
		}
		q
	};
	codex["quests"]["783"] = quest(783, "A Threat Within", 1, 400);
	codex["quests"]["7"] = quest(7, "Kobold Camp Cleanup", 2, 450);
	let npc = |id: i32, name: &str, level: i32| json!({ "id": id, "name": name, "level": level, "levelMax": null, "faction": null, "rare": false, "elite": false, "boss": false, "instance": null, "roles": [], "loot": [], "spawns": [] });
	codex["npcs"]["6"] = npc(6, "Kobold Vermin", 2);
	codex["npcs"]["257"] = npc(257, "Kobold Worker", 4);
	write_codex_pack(&codex, &CodexOpts::default())
}

const PRELUDE: &str = r#"uistub.install()
stub.login()
uistub.player.xp, uistub.player.xpMax = 1200, 2100
local P, LT = Polestar.UI.Picker, Polestar.UI.LevelTip
local function rgb(r, g, b) return { math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5) } end
local function hover(c) c:GetScript("OnEnter")(c) end
"#;

fn run_with(script: &str, with_pack: bool) -> Vec<Value> {
	let pack = with_pack.then(codex_pack);
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: pack.as_ref().map(|p| p.stub_lua.clone()).unwrap_or_default(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("{PRELUDE}{}", script.replace("${ELWYNN}", ELWYNN)),
		..Default::default()
	})
}

fn run(script: &str) -> Vec<Value> {
	run_with(script, true)
}

#[test]
fn a_leveling_guide_the_chip_after_its_levels_says_what_its_turn_ins_are_worth_hovering_it_opens_the_panel() {
	let out = run(r#"
		Polestar.UI.ShowPicker()
		P.Select("${ELWYNN}")
		local d = P.details
		local chip = { d.XP:IsShown(), d.XP.Text:GetText() }
		local _, _, _, cx = d.XP:GetPoint(1)
		local _, _, _, lx = d.Chips[1]:GetPoint(1)
		hover(d.XP)
		local t = LT.Frame()
		local cells = 0
		for _, c in ipairs(t.Cells) do if c:IsShown() then cells = cells + 1 end end
		emit({ chip = chip, after = cx > lx, levels = d.Chips[1].Text:GetText(),
			tip = { t:IsShown(), t:GetParent() == PolestarPicker, t.Head:GetText(), t.Levels:GetText(), t.XP:GetText(), t.Now:GetText(), t.Then:GetText(), t.Notes:GetText(), cells } })"#);
	let out = &out[0];
	// In route order from 1,200 into 4: A Threat Within 400, a level 2 Vermin 39, Kobold Camp Cleanup 450,
	// Wolves Across the Border 250 (over 2,100: level 5, 239 in), a level 4 Worker at 5: 56. 1,195 XP, 295 into
	// 5 of 2,800.
	assert_eq!(out["chip"], json!([true, "+53% of a level"]));
	assert_eq!(out["after"], true, "the chip follows the Levels chip");
	assert!(is_match(text(&out["levels"]), r"^Levels "));
	assert_eq!(
		out["tip"],
		json!([
			true,
			true,
			"If you finish this guide",
			"+53% of a level",
			"1,195 XP",
			"Now: 57% into level 4",
			"After: 10% into level 5",
			"3 quests for you, not done yet.\n1,100 XP from quests, about 95 from 2 kills the guide asks for.",
			2
		])
	);
}

#[test]
fn below_the_guide_s_level_the_chip_says_the_recommended_level_the_panel_says_so_first_and_sums_from_there() {
	let out = run(r#"
		uistub.guides["${ELWYNN}"].minLevel = 6
		Polestar.UI.ShowPicker()
		P.Select("${ELWYNN}")
		local d = P.details
		hover(d.XP)
		local t = LT.Frame()
		emit({ chip = d.XP.Text:GetText(), chipColor = rgb(d.XP.Text:GetTextColor()), warning = rgb(Polestar.Theme.Color("warning")),
			need = t.Need:IsShown() and t.Need:GetText(), needColor = rgb(t.Need:GetTextColor()), now = t.Now:GetText(), first = t.Marks[1]:GetText() })"#);
	let out = &out[0];
	assert_eq!(out["chip"], "Recommended: level 6");
	assert_eq!(out["chipColor"], out["warning"], "in the warning colour");
	assert_eq!(out["need"], "You are level 4. Level 6 is recommended for this guide; from there:");
	assert_eq!(out["needColor"], out["warning"]);
	assert_eq!(out["now"], "Start: level 6");
	assert_eq!(out["first"], "6", "the bar starts at the guide's level");
}

#[test]
fn no_chip_without_the_codex_for_a_guide_that_is_not_leveling_or_with_nothing_selected() {
	let none = run_with(
		r#"
		Polestar.UI.ShowPicker()
		P.Select("${ELWYNN}")
		emit(P.details.XP:IsShown())"#,
		false,
	);
	assert_eq!(none[0], false, "no Codex: nothing to count");
	let other = run(r#"
		Polestar.UI.ShowPicker()
		P.Select("forever/professions/tailoring")
		emit(P.details.XP:IsShown())"#);
	assert_eq!(other[0], false, "a profession guide has no levels chip");
	let off = run(r#"
		Polestar.Set("lookup.enabled", false)
		local loads, load = 0, Polestar.Codex.Load
		Polestar.Codex.Load = function(...) loads = loads + 1; return load(...) end
		Polestar.UI.ShowPicker()
		P.Select("${ELWYNN}")
		emit({ shown = P.details.XP:IsShown(), loads = loads })"#);
	assert_eq!(off[0], json!({ "shown": false, "loads": 0 }), "Lookup turned off: the Codex is Lookup's, nothing loads it");
}

#[test]
fn the_theme_is_followed_a_new_accent_font_and_skin_repaint_the_chip_and_lay_the_open_panel_out_again() {
	let out = run(r#"
		Polestar.UI.ShowPicker()
		P.Select("${ELWYNN}")
		local d = P.details
		hover(d.XP)
		local t = LT.Frame()
		local function look()
			local font, size = t.Levels:GetFont()
			return { accent = rgb(Polestar.Theme.Accent()), chipText = rgb(d.XP.Text:GetTextColor()), levels = rgb(t.Levels:GetTextColor()),
				gain = rgb(t.Cells[1].Gain:GetVertexColor()), ground = rgb(t.Ground:GetVertexColor()), panel = rgb(Polestar.Theme.Color("panel")),
				font = font, size = size, width = t:GetWidth(), height = t:GetHeight(), shown = t:IsShown() }
		end
		emit(look())
		Polestar.Set("ui.accent", { 0.2, 0.8, 0.4 })
		Polestar.Set("ui.scheme", "graphite")
		Polestar.Set("ui.font", "inter")
		Polestar.Set("ui.skin", "halo")
		emit(look())"#);
	let (before, after) = (&out[0], &out[1]);
	for look in [before, after] {
		assert_eq!(look["chipText"], look["accent"], "the chip is in the accent");
		assert_eq!(look["levels"], look["accent"], "the levels line is in the accent");
		assert_eq!(look["gain"], look["accent"], "the bar's gain is in the accent");
		assert_eq!(look["ground"], look["panel"], "the ground is the scheme's panel");
	}
	assert_eq!(after["accent"], json!([51, 204, 102]), "your own accent");
	assert_ne!(after["ground"], before["ground"], "the scheme's ground");
	assert_ne!(after["font"], before["font"], "the chosen font");
	assert_eq!(after["shown"], true, "the open panel stays open, laid out again");
}
