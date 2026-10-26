//! The Community guides page (addon/Polestar/UI/Packs.lua, registered by UI/Options.lua) against the real
//! Core + Theme + UI manifests. The UI's fake Engine comes from tests/lua/stub_ui.lua; the guide registry is the
//! real one (Core/Guides.lua), so the rows come from the core's own records and its scan of the AddOns list.

use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// The AddOns list of the installed-pack scan (ours, Joe's, an empty pack, one turned off, one out of date, one
// too new, one that crashed before registering) plus a pack with two problems and one with dungeon guides only.
const ADDONS: &str = r#"
ADDON_INTERFACE_VERSION = "Out of date"
stub.addons = {
	{ name = "Polestar", loaded = true },
	{ name = "Polestar_Guides", loaded = true },
	{ name = "JoeAddon", loaded = true },
	{ name = "EmptyAddon", loaded = true },
	{ name = "Off", reason = "DISABLED", enabled = false },
	{ name = "Old", reason = "INTERFACE_VERSION" },
	{ name = "Future", reason = "INTERFACE_VERSION" },
	{ name = "Crash", loaded = true },
	{ name = "Probs", loaded = true },
	{ name = "Dung", loaded = true },
}
local function toc(id, title, extra)
	local m = { ["X-Polestar-Pack"] = id, ["X-Polestar-Format"] = "1", Title = title, Author = title .. " Author", Version = "2.0", ["X-License"] = "CC0-1.0", ["X-Website"] = "https://example.org/" .. id }
	for k, v in pairs(extra or {}) do m[k] = v end
	return m
end
stub.addonMeta.Polestar_Guides = toc("guides", "Polestar Guides")
stub.addonMeta.JoeAddon = toc("joe", "Joe's Routes")
stub.addonMeta.EmptyAddon = toc("empty", "Empty")
stub.addonMeta.Off = toc("off", "Switched Off")
stub.addonMeta.Old = toc("old", "Old Pack")
stub.addonMeta.Future = toc("future", "Future Pack", { ["X-Polestar-Format"] = "9", ["X-Polestar-Needs"] = "0.4.0" })
stub.addonMeta.Crash = toc("crash", "Crashing Pack")
stub.addonMeta.Probs = toc("probs", "Problem Pack")
stub.addonMeta.Dung = toc("dung", "Dungeon Pack")
"#;

const PACKS: &str = r#"
uistub.install()
Polestar.Guides = uistub.realGuides
G = uistub.realGuides
local function meta(addon, id, title, extra)
	local m = { addon = addon, id = id, format = 1, title = title, author = title .. " Author", version = "1.2.0", license = "MIT" }
	for k, v in pairs(extra or {}) do m[k] = v end
	return m
end
local function guide(id, pack, extra)
	local g = { id = id, pack = pack, title = "T " .. id, minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }
	for k, v in pairs(extra or {}) do g[k] = v end
	return Polestar.RegisterGuide(g)
end
assert(Polestar.RegisterPack(meta("Polestar_Guides", "guides", "Polestar Guides", { author = "Polestar", license = "GPL-3.0" })))
guide("forever/a", "guides")
guide("forever/b", "guides")
assert(Polestar.RegisterPack(meta("JoeAddon", "joe", JOE_TITLE or "Joe's Routes", { author = "Joe", license = "CC-BY-4.0",
	website = "https://github.com/joe/routes", source = JOE_SOURCE or "Written from my own play" })))
guide("joe/a", "joe")
assert(Polestar.RegisterPack(meta("EmptyAddon", "empty", "Empty")))
assert(Polestar.RegisterPack(meta("Probs", "probs", "Problem Pack")))
guide("probs/ok", "probs")
guide("elsewhere/one", "probs")
guide("elsewhere/two", "probs")
assert(Polestar.RegisterPack(meta("Dung", "dung", "Dungeon Pack")))
guide("dung/deadmines", "dung", { category = "Dungeons" })
stub.login()
UI, O, P = Polestar.UI, Polestar.UI.Options, Polestar.UI.Packs
function openPage() UI.ShowOptions("guidepacks"); return P.view end
function rowOf(addon)
	for _, r in ipairs(P.view.rows) do if r:IsShown() and r.psRecord.addon == addon then return r end end
end
function shownText(fs) return fs:IsShown() and fs:GetText() or false end
function navDot()
	for _, b in ipairs(PolestarOptions.navButtons) do
		if b:IsShown() and b.psKey == "guidepacks" then return b.Dot:IsShown() end
	end
end
"#;

fn run_with(script: &str, before: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], before: format!("{ADDONS}{before}"), addons: vec![Addon::files("Polestar", &FILES)], script: format!("{PACKS}\n{script}"), ..Default::default() })
		.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, "")
}

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

#[test]
fn one_row_per_pack_ours_first_credits_count_website_source_and_each_status() {
	let out = run(r#"
		openPage()
		local rows = {}
		for _, r in ipairs(P.view.rows) do
			if r:IsShown() then
				rows[#rows + 1] = { addon = r.psRecord.addon, title = r.Title:GetText(), credits = r.Credits:GetText(),
					count = shownText(r.Count), switch = r.Switch:IsShown(), enable = r.Enable:IsShown(),
					status = shownText(r.Status), problems = r.Problems:IsShown() and r.Problems.Text:GetText() or false,
					website = r.Website:IsShown() and r.Website.Label:GetText() or false, source = shownText(r.Source) }
			end
		end
		emit({ rows = rows, title = PolestarOptions.Title:GetText() })"#);
	let rows = out["rows"].as_array().unwrap();
	let by = |a: &str| rows.iter().find(|r| r["addon"] == a).cloned().unwrap_or(Value::Null);
	assert_eq!(out["title"], "Community guides");
	let addons: Vec<&str> = rows.iter().map(|r| r["addon"].as_str().unwrap()).collect();
	assert_eq!(addons, vec!["Polestar_Guides", "Crash", "Dung", "EmptyAddon", "Future", "JoeAddon", "Old", "Probs", "Off"]);
	assert_eq!(
		by("Polestar_Guides"),
		json!({ "addon": "Polestar_Guides", "title": "Polestar Guides", "credits": "Polestar  ·  1.2.0  ·  GPL-3.0",
			"count": "2 guides", "switch": true, "enable": false, "status": false, "problems": false, "website": false, "source": false })
	);
	assert_eq!(
		by("JoeAddon"),
		json!({ "addon": "JoeAddon", "title": "Joe's Routes", "credits": "Joe  ·  1.2.0  ·  CC-BY-4.0",
			"count": "1 guide", "switch": true, "enable": false, "status": false, "problems": false,
			"website": "github.com/joe/routes", "source": "“Written from my own play”" })
	);
	assert_eq!(by("EmptyAddon")["status"], "broken: registered no guides");
	assert_eq!(by("EmptyAddon")["switch"], false);
	assert_eq!(by("Crash")["status"], "broken: registered no guides");
	assert_eq!(by("Crash")["website"], "example.org/crash", "a pack read from its TOC shows its website");
	assert_eq!(by("Off")["status"], "turned off in the AddOns list");
	assert_eq!(by("Off")["enable"], true);
	assert_eq!(by("Old")["status"], "not loaded: Out of date");
	assert_eq!(by("Future")["status"], "needs Polestar 0.4.0 or newer");
	assert_eq!(by("Probs")["problems"], "2 problems");
	assert_eq!(by("Probs")["switch"], true);
	assert_eq!(by("Probs")["count"], "1 guide");
}

#[test]
fn a_too_new_pack_without_x_polestar_needs_needs_a_newer_polestar() {
	let out = run_with(r#"openPage(); emit({ status = shownText(rowOf("Future").Status) })"#, r#"stub.addonMeta.Future["X-Polestar-Needs"] = nil"#);
	assert_eq!(out["status"], "needs a newer Polestar");
}

#[test]
fn the_switch_hides_and_shows_a_pack_through_guides_setpackshown() {
	let out = run(r#"
		openPage()
		local calls = {}
		local set = G.SetPackShown
		G.SetPackShown = function(id, shown) calls[#calls + 1] = { id, shown }; return set(id, shown) end
		local row = rowOf("JoeAddon")
		row.Switch:Click()
		local off = { status = G.Pack("joe").status, checked = rowOf("JoeAddon").Switch.checked, stored = PolestarDB.packs.joe.off }
		rowOf("JoeAddon").Switch:Click()
		emit({ calls = calls, off = off, on = G.Pack("joe").status })"#);
	assert_eq!(out["calls"], json!([["joe", false], ["joe", true]]));
	assert_eq!(out["off"], json!({ "status": "off", "checked": false, "stored": true }));
	assert_eq!(out["on"], "on");
}

#[test]
fn enable_and_reload_enables_the_addon_then_reloads() {
	let out = run(r#"
		openPage()
		rowOf("Off").Enable:Click()
		emit({ enabled = stub.enabledAddOns, reloaded = stub.reloaded or false })"#);
	assert_eq!(out["enabled"], json!(["Off"]));
	assert_eq!(out["reloaded"], true);
}

#[test]
fn show_lists_the_problems_copy_report_fills_a_selected_box_with_the_pack_versions_build_and_every_problem() {
	let out = run(r#"
		openPage()
		local row = rowOf("Probs")
		local before = { list = row.List:IsShown(), report = row.Report:IsShown() }
		row.ShowList:Click()
		row = rowOf("Probs")
		local list = shownText(row.List)
		local label = row.ShowList.Label:GetText()
		row.CopyReport:Click()
		row = rowOf("Probs")
		local messages = {}
		for i, p in ipairs(G.Pack("probs").problems) do messages[i] = p.message end
		emit({ before = before, list = list, label = label, report = row.Report:IsShown() and row.Report:GetText() or false,
			focused = stub.focus == row.Report, messages = messages })"#);
	assert_eq!(out["before"], json!({ "list": false, "report": false }));
	assert_eq!(out["label"], "Hide");
	let messages = out["messages"].as_array().unwrap();
	assert_eq!(messages.len(), 2);
	let list = text(&out["list"]);
	let report = text(&out["report"]);
	for m in messages {
		let m = text(m);
		assert!(list.contains(m), "the list shows \"{m}\"");
		assert!(report.contains(m), "the report has \"{m}\"");
	}
	assert!(is_match(report, r"(?m)^Community addon: probs \(Probs\)$"));
	assert!(is_match(report, r"Community addon version: 1\.2\.0"));
	assert!(is_match(report, r"Polestar version: 0\.1\.0-test"));
	assert!(is_match(report, r"1\.60\.1 \(70338\)"));
	assert_eq!(out["focused"], true, "the report box takes focus, its text selected");
}

#[test]
fn copy_report_keeps_the_report_open_and_selects_it_again_hide_or_escape_closes_it() {
	let out = run(r#"
		openPage()
		local row = rowOf("Probs")
		local selected = 0
		local highlight = row.Report.HighlightText
		row.Report.HighlightText = function(self, ...) selected = selected + 1; return highlight(self, ...) end
		row.CopyReport:Click()
		local first = selected
		rowOf("Probs").CopyReport:Click()
		local again = { open = rowOf("Probs").Report:IsShown(), selected = selected > first, label = rowOf("Probs").ShowList.Label:GetText() }
		rowOf("Probs").ShowList:Click()
		local hidden = rowOf("Probs").Report:IsShown()
		rowOf("Probs").CopyReport:Click()
		local report = rowOf("Probs").Report
		stub.RunScript(report, "OnEscapePressed")
		emit({ again = again, hidden = hidden, escaped = rowOf("Probs").Report:IsShown() })"#);
	assert_eq!(out["again"], json!({ "open": true, "selected": true, "label": "Hide" }));
	assert_eq!(out["hidden"], false, "Hide closes the report");
	assert_eq!(out["escaped"], false, "Escape closes the report");
}

#[test]
fn the_report_box_grows_to_fit_a_long_problem_message_as_it_wraps() {
	let out = run(r#"
		openPage()
		local probs = G.Pack("probs").problems
		probs[#probs + 1] = { message = string.rep("a step's target names a quest that no guide in the pack has ", 6) }
		rowOf("Probs").CopyReport:Click()
		local report = rowOf("Probs").Report
		local _, newlines = report:GetText():gsub("\n", "")
		emit({ h = report:GetHeight(), byLines = (newlines + 1) * 16 + 16 })"#);
	assert!(f(&out["h"]) > f(&out["byLines"]), "{} > {}", out["h"], out["byLines"]);
}

#[test]
fn a_refused_pack_says_why() {
	let out = run(r#"
		Polestar.RegisterPack({ addon = "JoeCopy", id = "joe", format = 1, title = "Joe Again", author = "X", version = "1", license = "MIT" })
		openPage()
		local row = rowOf("JoeCopy")
		emit({ status = shownText(row.Status), switch = row.Switch:IsShown() })"#);
	assert_eq!(out["switch"], false);
	assert!(is_match(text(&out["status"]), r"^refused: Pack id joe is already taken by JoeAddon; JoeCopy was refused\.$"));
}

#[test]
fn a_refused_pack_s_id_and_addon_kept_as_given_print_literally_in_the_row_title_and_the_report() {
	let out = run(r#"
		Polestar.RegisterPack({ addon = "Bad|Addon", id = "bad|cffid", format = 1 })
		openPage()
		local row = rowOf("Bad|Addon")
		local title = row.Title:GetText()
		row.CopyReport:Click()
		row = rowOf("Bad|Addon")
		emit({ title = title, report = row.Report:IsShown() and row.Report:GetText() or false, status = shownText(row.Status) })"#);
	assert_eq!(out["title"], "bad||cffid");
	assert!(truthy(&out["report"]), "the report opens");
	let report = text(&out["report"]);
	assert_eq!(report.split('\n').next().unwrap(), "Community addon: bad||cffid (Bad||Addon)");
	// Once: the refusal message escaped the id already, the report adds nothing to it.
	assert!(is_match(text(&out["status"]), r"Pack id bad\|\|cffid is not valid"));
	assert!(!is_match(report, r"\|\|\|\|"));
}

#[test]
fn the_source_wraps_on_its_own_line_under_the_website_box_at_the_row_s_full_width() {
	let long =
		"Written from my own play on a fresh character, every quest done in the order the route takes them, with the shortest walks between the givers and every flight path picked up on the way";
	let out = run_with(
		r#"
		openPage()
		local row = rowOf("JoeAddon")
		local _, _, _, bx, by = row.Website:GetPoint(1)
		local _, _, _, sx, sy = row.Source:GetPoint(1)
		local _, _, _, cx = row.Credits:GetPoint(1)
		emit({ text = row.Source:GetText(), box = { x = bx, y = by, h = row.Website:GetHeight(), w = row.Website:GetWidth() },
			source = { x = sx, y = sy, w = row.Source:GetWidth(), h = row.Source:GetStringHeight() }, credits = cx,
			row = row:GetWidth(), rowH = row:GetHeight() })"#,
		&format!(r#"JOE_SOURCE = "{long}""#),
	);
	assert_eq!(out["text"], format!("“{long}”").as_str());
	assert_eq!(out["source"]["x"], out["box"]["x"], "under the box, on the credits column");
	assert_eq!(out["source"]["x"], out["credits"]);
	assert!(f(&out["source"]["y"]) <= f(&out["box"]["y"]) - f(&out["box"]["h"]), "below the box ({} vs {}-{})", out["source"]["y"], out["box"]["y"], out["box"]["h"]);
	assert!(f(&out["source"]["w"]) > f(&out["box"]["w"]), "wider than the box");
	assert_eq!(f(&out["source"]["x"]) + f(&out["source"]["w"]), f(&out["row"]) - 12.0, "to the row's right inset");
	assert!(f(&out["source"]["h"]) > 12.0, "it wraps");
	assert!(f(&out["rowH"]) >= -f(&out["source"]["y"]) + f(&out["source"]["h"]), "the row grows to hold it");
}

#[test]
fn suggest_guides_from_lists_polestar_and_packs_with_leveling_guides_choosing_one_sets_behavior_suggestfrom() {
	let out = run(r#"
		local view = openPage()
		view.Source.Button:Click()
		local choices = {}
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() then choices[#choices + 1] = r.Text:GetText() end end
		for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == "Joe's Routes" then r:Click() end end
		emit({ choices = choices, setting = Polestar.Get("behavior.suggestFrom"), source = G.SuggestSource(),
			shown = view.Source.Button.Label:GetText(), sources = G.SuggestSources() })"#);
	assert_eq!(out["sources"], json!(["guides", "joe", "probs"]), "the page lists what the core allows");
	assert_eq!(out["choices"], json!(["Polestar", "Joe's Routes", "Problem Pack"]));
	assert_eq!(out["setting"], "joe");
	assert_eq!(out["source"], "joe");
	assert_eq!(out["shown"], "Joe's Routes");
}

#[test]
fn the_navigation_dot_shows_while_a_pack_has_problems_and_goes_with_them() {
	let out = run(r#"
		UI.ShowOptions("guide")
		local with = navDot()
		emit({ with = with })"#);
	assert_eq!(out["with"], true);
	let clean = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: r#"uistub.install()
			Polestar.Guides = uistub.realGuides
			assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "1", license = "GPL-3.0" }))
			assert(Polestar.RegisterGuide({ id = "forever/a", pack = "guides", title = "A", steps = { { goals = { { t = "level", level = 2 } } } } }))
			stub.login()
			Polestar.UI.ShowOptions("guide")
			local dot
			for _, b in ipairs(PolestarOptions.navButtons) do if b:IsShown() and b.psKey == "guidepacks" then dot = b.Dot:IsShown() end end
			emit({ dot = dot, problems = Polestar.Guides.ProblemCount() })"#
			.into(),
		..Default::default()
	});
	assert_eq!(clean[0], json!({ "dot": false, "problems": 0 }));
}

#[test]
fn polestar_packs_opens_the_page() {
	let out = run(r#"
		SlashCmdList.POLESTAR("packs")
		emit({ shown = PolestarOptions:IsShown(), title = PolestarOptions.Title:GetText() })"#);
	assert_eq!(out, json!({ "shown": true, "title": "Community guides" }));
}

#[test]
fn the_website_and_the_docs_line_are_links_that_open_the_copy_window_without_x_website_the_source_path() {
	let with_site = run_with(
		r#"
		local view = openPage()
		local seen = { label = view.DocsLabel:GetText(), link = view.Docs:IsShown() and view.Docs.Label:GetText() or false,
			kind = view.Docs:GetObjectType() }
		view.Docs:Click()
		seen.docsTitle, seen.docsCopy = PolestarCopy.Title:GetText(), PolestarCopy.Box:GetText()
		rowOf("JoeAddon").Website:Click()
		seen.siteTitle, seen.siteCopy = PolestarCopy.Title:GetText(), PolestarCopy.Box:GetText()
		emit(seen)"#,
		r#"stub.addonMeta.Polestar = { ["X-Website"] = "https://github.com/polestar/polestar/" }"#,
	);
	assert_eq!(
		with_site,
		json!({
			"label": "Read more:", "link": "github.com/polestar/polestar/blob/HEAD/docs/GUIDE_PACKS.md", "kind": "Button",
			"docsTitle": "Community guides, explained", "docsCopy": "https://github.com/polestar/polestar/blob/HEAD/docs/GUIDE_PACKS.md",
			"siteTitle": "Joe's Routes website", "siteCopy": "https://github.com/joe/routes",
		})
	);
	let without = run(r#"
		local view = openPage()
		emit({ label = view.DocsLabel:GetText(), link = view.Docs:IsShown() })"#);
	assert_eq!(without, json!({ "label": "Read more: docs/GUIDE_PACKS.md in Polestar's source", "link": false }));
}

#[test]
fn a_64_character_title_is_cut_before_the_guide_count_inside_the_row_the_credits_sit_under_it() {
	let long = "A".repeat(64);
	let out = run_with(
		r#"
		local view = openPage()
		local row = rowOf("JoeAddon")
		local _, _, _, x, y = row.Title:GetPoint(1)
		local _, _, _, cx, cy = row.Credits:GetPoint(1)
		emit({ text = row.Title:GetText(), width = row.Title:GetWidth(), x = x, y = y, row = row:GetWidth(),
			reserve = row.Switch:GetWidth() + 10 + row.Count:GetStringWidth(), cx = cx, cy = cy })"#,
		&format!(r#"JOE_TITLE = "{long}""#),
	);
	assert_eq!(text(&out["text"]).chars().count(), 64);
	assert!(
		f(&out["width"]) > 0.0 && f(&out["x"]) + f(&out["width"]) < f(&out["row"]) - 12.0 - f(&out["reserve"]),
		"title box {}+{} ends before the count and switch ({} from the right)",
		out["x"],
		out["width"],
		out["reserve"]
	);
	assert_eq!(out["cx"], out["x"], "the credits start under the title");
	assert!(f(&out["cy"]) < f(&out["y"]), "below it");
}
