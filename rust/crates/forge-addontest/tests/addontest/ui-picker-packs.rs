//! Community guides in the guide menu (addon/Polestar/UI/Picker.lua) and the credits line on every guide, over
//! the real guide registry (uistub.realGuides) and the UI's fake Engine (tests/lua/stub_ui.lua). Our categories
//! list only our guides; All lists every shown guide; a "Guide packs" heading lists one entry per shown pack
//! with guides.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const SETUP: &str = r##"
uistub.install()
Polestar.Guides = uistub.realGuides
G = uistub.realGuides
local function guide(id, pack, extra)
	local g = { id = id, pack = pack, title = extra.title, minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }
	for k, v in pairs(extra) do g[k] = v end
	assert(Polestar.RegisterGuide(g))
end
assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = OURS_AUTHOR or "Polestar", version = "0.1.0", license = "GPL-3.0" }))
guide("forever/westfall", "guides", { title = "Westfall", category = "Leveling" })
guide("forever/cooking", "guides", { title = "Cooking", category = "Professions" })
assert(Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 1, title = JOE_TITLE or "Joe's Routes", author = "Joe", version = "1.2.0",
	license = "CC-BY-4.0", source = JOE_SOURCE or "Written from my own play" }))
guide("joe/barrens", "joe", { title = "Joe's Barrens" })
guide("joe/redridge", "joe", { title = "Joe's Redridge", minLevel = 15, maxLevel = 25 })
guide("joe/tailoring", "joe", { title = "Joe's Tailoring", category = "Professions", author = "Ann" })
guide("joe/night", "joe", { title = "Night Run", folder = "Night routes" })
stub.login()
UI, P = Polestar.UI, Polestar.UI.Picker
function titles(entries)
	local out = {}
	for _, e in ipairs(entries) do out[#out + 1] = e.kind == "guide" and e.guide.title or ("[" .. e.text .. "]") end
	return out
end
function nav()
	local out = {}
	for _, b in ipairs(PolestarPicker.navButtons) do
		if b:IsShown() then out[#out + 1] = (b.psHeading and "# " or "") .. b.Label:GetText() end
	end
	return out
end
function rowFor(title)
	for _, f in ipairs(stub.frames) do
		if f.psGuide and rawget(f, "Range") and f:IsShown() and f.psGuide.title == title then return f end
	end
end
"##;

fn run_with(script: &str, before: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", FILES)], script: [before, SETUP, script].join("\n"), ..Default::default() }).remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, "")
}

fn strs(v: &Value) -> Vec<&str> {
	v.as_array().unwrap().iter().map(|x| x.as_str().unwrap_or("")).collect()
}

fn has(v: &Value, s: &str) -> bool {
	strs(v).contains(&s)
}

#[test]
fn our_categories_list_only_our_guides_all_lists_both() {
	let out = run(r#"
		emit({ leveling = titles(P.Entries("All", "", "Leveling")), professions = titles(P.Entries("All", "", "Professions")),
			all = titles(P.Entries("All", "", "All")) })"#);
	assert_eq!(out["leveling"], json!(["[Leveling 1–30]", "Westfall"]));
	assert_eq!(out["professions"], json!(["[Professions]", "Cooking"]));
	for t in ["Westfall", "Cooking", "Joe's Barrens", "Joe's Redridge", "Joe's Tailoring", "Night Run"] {
		assert!(has(&out["all"], t), "All lists {t}");
	}
}

#[test]
fn a_pack_s_entry_lists_its_guides_grouped_by_its_folders_categories_and_bands() {
	let out = run(r#"emit({ joe = titles(P.Entries("All", "", "pack:joe")) })"#);
	assert_eq!(out["joe"], json!(["[Leveling 1–30]", "Joe's Barrens", "Joe's Redridge", "[Night routes]", "Night Run", "[Professions]", "Joe's Tailoring"]));
}

#[test]
fn the_community_guides_heading_and_one_entry_per_shown_pack_title_author_hiding_the_pack_removes_them() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("pack:joe")
		local shown = { nav = nav(), title = PolestarPicker.Title:GetText(), joe = rowFor("Joe's Barrens") ~= nil }
		G.SetPackShown("joe", false)
		emit({ shown = shown, hidden = { nav = nav(), category = P.Category(), joe = rowFor("Joe's Barrens") ~= nil,
			all = titles(P.Entries("All", "", "All")) } })"#);
	let nav = out["shown"]["nav"].as_array().unwrap();
	assert_eq!(json!(&nav[nav.len() - 2..]), json!(["# Community guides", "Joe's Routes  ·  Joe"]));
	assert_eq!(out["shown"]["title"], "Joe's Routes");
	assert_eq!(out["shown"]["joe"], true);
	assert!(!has(&out["hidden"]["nav"], "# Community guides"), "{}", strs(&out["hidden"]["nav"]).join(", "));
	assert!(!strs(&out["hidden"]["nav"]).iter().any(|l| l.starts_with("Joe's Routes")));
	assert_eq!(out["hidden"]["category"], "All");
	assert_eq!(out["hidden"]["joe"], false);
	assert!(!has(&out["hidden"]["all"], "Joe's Barrens"));
}

#[test]
fn our_pack_switched_off_while_one_of_our_categories_is_selected_back_to_all_not_an_empty_list_blaming_the_faction() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("Professions")
		local before = { category = P.Category(), title = PolestarPicker.Title:GetText() }
		G.SetPackShown("guides", false)
		emit({ before = before, category = P.Category(), title = PolestarPicker.Title:GetText(), empty = PolestarPicker.Empty:IsShown() and PolestarPicker.Empty:GetText() or false,
			joe = rowFor("Joe's Barrens") ~= nil })"#);
	assert_eq!(out["before"], json!({ "category": "Professions", "title": "Professions" }));
	assert_eq!(out["category"], "All");
	assert_eq!(out["title"], "All guides");
	assert_eq!(out["empty"], false);
	assert_eq!(out["joe"], true);
}

#[test]
fn no_heading_without_a_shown_pack_that_has_guides() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", FILES)],
		script: r#"uistub.install()
			Polestar.Guides = uistub.realGuides
			assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "1", license = "GPL-3.0" }))
			assert(Polestar.RegisterGuide({ id = "forever/a", pack = "guides", title = "A", steps = { { goals = { { t = "level", level = 2 } } } } }))
			assert(Polestar.RegisterPack({ addon = "EmptyAddon", id = "empty", format = 1, title = "Empty", author = "E", version = "1", license = "MIT" }))
			stub.login()
			Polestar.UI.ShowPicker()
			local out = {}
			for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() then out[#out + 1] = b.Label:GetText() end end
			emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert!(!has(&out, "Community guides"), "{}", strs(&out).join(", "));
}

#[test]
fn pack_guides_carry_their_pack_s_title_in_rows_and_search_results() {
	let out = run(r#"
		UI.ShowPicker()
		P.SetCategory("All")
		local all = { joe = rowFor("Joe's Barrens").Note:GetText(), ours = rowFor("Westfall").Note:GetText() }
		P.SetQuery("barrens")
		local search = rowFor("Joe's Barrens").Note:GetText()
		P.SetQuery("")
		P.SetCategory("pack:joe")
		emit({ all = all, search = search, own = rowFor("Joe's Barrens").Note:GetText() })"#);
	assert_eq!(out["all"], json!({ "joe": "Joe's Routes", "ours": "" }));
	assert_eq!(out["search"], "Joe's Routes");
	assert_eq!(out["own"], "", "the pack's own list does not repeat its title");
}

#[test]
fn details_the_credits_line_for_every_guide_with_the_pack_s_source_the_guide_s_own_author_wins() {
	let out = run(r#"
		UI.ShowPicker()
		local function credits(id)
			P.Select(id)
			local d = P.details
			return { credits = d.Credits:IsShown() and d.Credits:GetText() or false, source = d.Source:IsShown() and d.Source:GetText() or false }
		end
		emit({ joe = credits("joe/barrens"), ann = credits("joe/tailoring"), ours = credits("forever/westfall") })"#);
	assert_eq!(out["joe"], json!({ "credits": "By Joe  ·  Joe's Routes 1.2.0  ·  CC-BY-4.0", "source": "“Written from my own play”" }));
	assert_eq!(out["ann"], json!({ "credits": "By Ann  ·  Joe's Routes 1.2.0  ·  CC-BY-4.0", "source": "“Written from my own play”" }));
	assert_eq!(out["ours"], json!({ "credits": "By Polestar", "source": false }));
}

#[test]
fn a_in_a_pack_title_and_source_prints_literally_in_the_sidebar_the_header_a_row_s_note_and_the_credits() {
	let out = run_with(
		r#"
		UI.ShowPicker()
		P.SetCategory("All")
		local note = rowFor("Joe's Barrens").Note:GetText()
		P.SetCategory("pack:joe")
		P.Select("joe/barrens")
		local d = P.details
		emit({ nav = nav(), title = PolestarPicker.Title:GetText(), note = note, credits = d.Credits:GetText(), source = d.Source:GetText() })"#,
		r#"JOE_TITLE = "Joe |cffff0000Red|r Routes"; JOE_SOURCE = "My |Hitem:1|h notes""#,
	);
	// Every "|" doubled once: the client prints "||" as one "|", so no colour or link starts.
	let title = "Joe ||cffff0000Red||r Routes";
	let nav = out["nav"].as_array().unwrap();
	assert_eq!(nav[nav.len() - 1], format!("{title}  ·  Joe").as_str());
	assert_eq!(out["title"], title);
	assert_eq!(out["note"], title);
	assert_eq!(out["credits"], format!("By Joe  ·  {title} 1.2.0  ·  CC-BY-4.0").as_str());
	assert_eq!(out["source"], "“My ||Hitem:1||h notes”");
}

#[test]
fn the_empty_states_name_polestar_guides_and_community_addons() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", FILES)],
		script: r#"uistub.install()
			Polestar.Guides = uistub.realGuides
			stub.login()
			Polestar.Set("ui.shown", true)
			Polestar.Fire("GUIDE_CHANGED", nil)
			Polestar.UI.ShowPicker()
			Polestar.UI.Picker.SetCategory("All")
			local GF = PolestarGuideFrame
			emit({ picker = PolestarPicker.Empty:GetText(), frame = { uistub.findText(GF, "No guides installed") ~= nil,
				uistub.findText(GF, "Enable Polestar Guides or a community addon in the AddOns list on the character screen, then reload.") ~= nil } })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["picker"], "No guides installed. Enable Polestar Guides or a community addon in the AddOns list on the character screen, then reload.");
	assert_eq!(out["frame"], json!([true, true]));
}

#[test]
fn credits_name_our_pack_s_author_whoever_that_is_nothing_hard_coded() {
	let out = run_with(
		r#"
		UI.ShowPicker()
		P.Select("forever/westfall")
		emit({ credits = P.details.Credits:GetText() })"#,
		r#"OURS_AUTHOR = "The Polestar Team""#,
	);
	assert_eq!(out["credits"], "By The Polestar Team");
}

#[test]
fn a_64_character_pack_title_is_cut_in_the_sidebar_the_header_and_a_row_s_note() {
	let long = "R".repeat(64);
	let out = run_with(
		r#"
		UI.ShowPicker()
		P.SetCategory("All")
		local row = rowFor("Joe's Barrens")
		local note = { text = row.Note:GetText(), w = row.Note:GetWidth(), row = row:GetWidth(), title = row.Title:GetWidth() }
		P.SetCategory("pack:joe")
		local entry
		for _, b in ipairs(PolestarPicker.navButtons) do if b:IsShown() and b.psKey == "pack:joe" then entry = b end end
		local p2, rel, rp, x = entry.Label:GetPoint(2)
		local t2, trel, trp, tx = PolestarPicker.Title:GetPoint(2)
		-- The width its anchors give it in the 240px sidebar (the stub does
		-- not resolve anchors): 64 characters wrap to many lines there, and
		-- the label keeps two.
		entry.Label:SetWidth(239 - 24 - 16 - 12 - 24)
		local fits = { lines = entry.Label:GetStringHeight() / entry.Label:GetLineHeight(), h = entry.Label:GetStringHeight(), row = entry:GetHeight() }
		emit({ note = note, fits = fits, count = entry.Count:IsShown() and math.ceil(entry.Count:GetStringWidth()) or 0, label = { n = entry.Label:GetNumPoints(), point = p2, own = rel == entry, rp = rp, x = x },
			title = { text = PolestarPicker.Title:GetText(), n = PolestarPicker.Title:GetNumPoints(), point = t2, own = trel == PolestarPicker.Header, x = tx } })"#,
		&format!("JOE_TITLE = \"{long}\""),
	);
	assert_eq!(out["note"]["text"], long.as_str());
	let w = out["note"]["w"].as_f64().unwrap();
	let row = out["note"]["row"].as_f64().unwrap();
	assert!(w <= (row * 0.45).floor(), "note {w} within 45% of {row}");
	assert!(out["note"]["title"].as_f64().unwrap() >= 40.0);
	let count = out["count"].as_i64().unwrap();
	let x = -(24 + if count != 0 { count + 8 } else { 0 });
	assert_eq!(out["label"], json!({ "n": 2, "point": "RIGHT", "own": true, "rp": "RIGHT", "x": x }), "the label ends short of the count, as wide as it is");
	assert_eq!(out["fits"]["lines"], 2, "a long label takes two lines at most");
	let (h, fits_row) = (out["fits"]["h"].as_f64().unwrap(), out["fits"]["row"].as_f64().unwrap());
	assert!(h <= fits_row, "the label ({h}) stays within its row ({fits_row})");
	assert_eq!(out["title"]["text"], long.as_str());
	assert_eq!(json!({ "n": out["title"]["n"], "point": out["title"]["point"], "own": out["title"]["own"] }), json!({ "n": 2, "point": "TOPRIGHT", "own": true }));
	assert!(out["title"]["x"].as_f64().unwrap() < 0.0);
}

#[test]
fn a_pooled_row_measures_its_note_and_title_from_scratch_longer_ones_after_shorter_ones_get_their_own_width() {
	let out = run(r#"
		assert(Polestar.RegisterPack({ addon = "AnnAddon", id = "ann", format = 1, title = "Ann's Long Winding Routes", author = "Ann", version = "1", license = "MIT" }))
		guide("ann/barrens", "ann", { title = "Ann's Barrens Loop" })
		UI.ShowPicker()
		P.SetCategory("All")
		P.SetQuery("joe's barrens")
		local first = rowFor("Joe's Barrens")
		local short = { text = first.Note:GetText(), w = first.Note:GetWidth(), title = first.Title:GetWidth() }
		P.SetQuery("ann's barrens")
		local row = rowFor("Ann's Barrens Loop")
		emit({ same = row == first, short = short, text = row.Note:GetText(), w = row.Note:GetWidth(),
			full = row.Note:GetUnboundedStringWidth(), row = row:GetWidth(),
			title = row.Title:GetWidth(), titleFull = row.Title:GetUnboundedStringWidth() })"#);
	assert_eq!(out["same"], true, "the pool hands the same row back");
	assert_eq!(out["short"]["text"], "Joe's Routes");
	assert_eq!(out["text"], "Ann's Long Winding Routes");
	let full = out["full"].as_f64().unwrap();
	assert!(full > out["short"]["w"].as_f64().unwrap(), "the second note is longer than the first");
	let row = out["row"].as_f64().unwrap();
	assert_eq!(out["w"].as_f64().unwrap(), (full + 1.0).floor().min((row * 0.45).floor()));
	let title_full = out["titleFull"].as_f64().unwrap();
	assert!(title_full > out["short"]["title"].as_f64().unwrap(), "the second title is longer than the first");
	assert_eq!(out["title"].as_f64().unwrap(), (title_full + 1.0).floor(), "the title has room and gets its whole width");
}

// The button in the guide window's empty state labelled `label`, or nil.
const FIND_BUTTON: &str = r#"
function emptyButton(label)
	for _, f in ipairs(stub.frames) do
		if rawget(f, "psAction") and rawget(f, "Label") and f:IsVisible() and f.Label:GetText() == label then return f end
	end
end
"#;

#[test]
fn our_own_guides_switched_off_every_pack_off_the_empty_states_say_so_not_the_community_addons_and_one_click_shows_them_again() {
	let out = run(&format!(
		"{FIND_BUTTON}{}",
		r#"
		G.SetPackShown("guides", false)
		G.SetPackShown("joe", false)
		Polestar.Set("ui.shown", true)
		Polestar.Fire("GUIDE_CHANGED", nil)
		UI.ShowPicker()
		P.SetCategory("All")
		local GF = PolestarGuideFrame
		local r = { picker = PolestarPicker.Empty:GetText(), title = uistub.findText(GF, "No guides shown") ~= nil,
			text = uistub.findText(GF, "Polestar's own guides are switched off on the Community guides page (/polestar packs).") ~= nil,
			community = uistub.findText(GF, "The community addons are switched off. Turn one on under Options, Community guides (/polestar packs).") ~= nil,
			options = emptyButton("Community guides") ~= nil }
		local show = emptyButton("Show Polestar's guides")
		r.show = show ~= nil
		if show then show.psAction() end
		r.shownAfter = G.PackShown("guides")
		r.joeAfter = G.PackShown("joe")
		r.westfall = rowFor("Westfall") ~= nil
		emit(r)"#
	));
	assert_eq!(out["picker"], "No guides shown: Polestar's own guides are switched off. Turn them on under Options, Community guides (/polestar packs).");
	assert_eq!(
		json!({ "title": out["title"], "text": out["text"], "community": out["community"], "options": out["options"], "show": out["show"] }),
		json!({ "title": true, "text": true, "community": false, "options": true, "show": true })
	);
	assert_eq!(json!({ "shownAfter": out["shownAfter"], "joeAfter": out["joeAfter"], "westfall": out["westfall"] }), json!({ "shownAfter": true, "joeAfter": false, "westfall": true }));
}

#[test]
fn every_community_addon_switched_off_ours_not_installed_the_empty_states_point_to_the_community_guides_page_not_the_addons_list() {
	let script = format!(
		"{}{FIND_BUTTON}{}",
		r#"uistub.install()
		Polestar.Guides = uistub.realGuides
		local G = uistub.realGuides
		assert(Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 1, title = "Joe's Routes", author = "Joe", version = "1", license = "MIT" }))
		assert(Polestar.RegisterGuide({ id = "joe/a", pack = "joe", title = "A", steps = { { goals = { { t = "level", level = 2 } } } } }))
		stub.login()
"#,
		r#"
		G.SetPackShown("joe", false)
		Polestar.Set("ui.shown", true)
		Polestar.Fire("GUIDE_CHANGED", nil)
		Polestar.UI.ShowPicker()
		Polestar.UI.Picker.SetCategory("All")
		local GF = PolestarGuideFrame
		local button = emptyButton("Community guides")
		local r = { picker = PolestarPicker.Empty:GetText(), title = uistub.findText(GF, "No guides shown") ~= nil,
			text = uistub.findText(GF, "The community addons are switched off. Turn one on under Options, Community guides (/polestar packs).") ~= nil,
			installed = uistub.findText(GF, "No guides installed") ~= nil, button = button ~= nil }
		if button then button.psAction() end
		r.options = PolestarOptions ~= nil and PolestarOptions:IsShown() and PolestarOptions.Title:GetText() or false
		emit(r)"#
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_ui.lua"], addons: vec![Addon::files("Polestar", FILES)], script, ..Default::default() }).remove(0);
	assert_eq!(out["picker"], "No guides shown: the community addons are switched off. Turn one on under Options, Community guides (/polestar packs).");
	assert_eq!(
		json!({ "title": out["title"], "text": out["text"], "installed": out["installed"], "button": out["button"] }),
		json!({ "title": true, "text": true, "installed": false, "button": true })
	);
	assert_eq!(out["options"], "Community guides");
}
