//! Guiding Stars (addon/Polestar/UI/Thanks.lua, an options page): three columns, supporters, contributors and
//! bug reporters, each a podium over its list, then the translators and the ideas side by side; every label fits
//! its column in every shipped locale, and a Chinese or Korean name takes the client's font for its script (#353).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];
const LOCALES: [&str; 10] = ["enUS", "deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW"];

const HELPERS: &str = r#"
local UI, W = Polestar.UI, Polestar.Widgets
local function plain(s) return (tostring(s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function open()
	UI.ShowOptions("thanks")
	return UI.Options.view
end
local function x(f) return (select(4, f:GetPoint(1))) end
-- The page's own words against the room each has: { what, text, width, room, cut }. Names are data and may
-- end in an ellipsis; the labels may not. With no names, the podiums' "No names here yet." counts too.
local function labels(v, empty)
	local out = {}
	local function add(what, fs, room) out[#out + 1] = { what = what, text = plain(fs:GetText()), width = W.TextWidth(fs), room = room, cut = fs:IsTruncated() } end
	for i, p in ipairs(v.Podiums) do
		add("podium " .. i .. " title", p.Title.Text, p:GetWidth())
		if empty then out[#out + 1] = { what = "podium " .. i .. " empty", text = p.Rest[1]:GetText(), width = 0, room = 0, cut = p.Rest[1]:IsTruncated() } end
	end
	local nameRoom = math.huge
	for _, key in ipairs({ "Supporters", "Contributors", "BugReporters", "Translators", "Ideas" }) do
		local p = v[key]
		add(key .. " title", p.Title, p:GetWidth() - 32)
		add(key .. " note", p.Note, p:GetWidth() - 32)
		for _, r in ipairs(p.rows) do
			if r:IsShown() then nameRoom = math.min(nameRoom, r.Name:GetWidth()) end
		end
	end
	return out, nameRoom
end
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &FILES)],
		script: format!("uistub.install()\nstub.login()\n{HELPERS}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn three_columns_supporters_contributors_and_bug_reporters_each_a_podium_over_its_list() {
	let out = run(
		"",
		r#"
		Polestar.Credits = {
			supporters = { "Ann", "Bo", "Cy", "Di" },
			contributors = { { name = "dev1", prs = 40 }, { name = "dev2", prs = 3 }, { name = "dev3", prs = 1 } },
			bugReporters = { { name = "大地瓜", reports = 22 }, { name = "Tazul | Robin", reports = 7 }, { name = "김민준", reports = 5 }, { name = "Erá", reports = 3 } },
		}
		local v = open()
		local function podium(p) return { title = p.Title.Text:GetText(), name = plain(p.Name:GetText()), rest = { plain(p.Rest[1]:GetText()), plain(p.Rest[2]:GetText()) } } end
		local function panel(p)
			local rows = {}
			for i, r in ipairs(p.rows) do
				if r:IsShown() then rows[i] = { rank = r.Rank:GetText(), name = r.Name:GetText(), count = r.Count:GetText(), font = (r.Name:GetFont()) } end
			end
			return { title = p.Title:GetText(), note = p.Note:GetText(), x = x(p), w = p:GetWidth(), h = p:GetHeight(), rows = rows }
		end
		local sup, con, rep = UI.Thanks.Names()
		emit({
			body = UI.Options.frame.BodyWidth,
			podiums = { podium(v.Podiums[1]), podium(v.Podiums[2]), podium(v.Podiums[3]) },
			podiumX = { x(v.Podiums[1]), x(v.Podiums[2]), x(v.Podiums[3]) },
			podiumFont = (v.Podiums[3].Name:GetFont()),
			panels = { panel(v.Supporters), panel(v.Contributors), panel(v.BugReporters) },
			names = { #sup, #con, #rep, rep[1] },
		})"#,
	);
	let p = &out["podiums"];
	assert_eq!(p[0], json!({ "title": "TOP SUPPORTER", "name": "Ann", "rest": ["#2  Bo", "#3  Cy"] }));
	assert_eq!(p[1], json!({ "title": "TOP CONTRIBUTOR", "name": "dev1", "rest": ["#2  dev2", "#3  dev3"] }));
	// A pipe in a name is escaped so it shows as typed.
	assert_eq!(p[2], json!({ "title": "TOP BUG REPORTER", "name": "大地瓜", "rest": ["#2  Tazul || Robin", "#3  김민준"] }));

	let panels = &out["panels"];
	let field = |key: &str| -> Vec<String> { (0..3).map(|i| panels[i][key].as_str().unwrap().to_string()).collect() };
	assert_eq!(field("title"), ["SUPPORTERS", "CONTRIBUTORS", "BUG REPORTERS"]);
	assert_eq!(field("note"), ["", "Pull requests on GitHub", "Confirmed reports"]);
	let rows = |i: usize| -> Vec<(String, String, String)> {
		panels[i]["rows"].as_array().unwrap().iter().map(|r| (r["rank"].as_str().unwrap().into(), r["name"].as_str().unwrap().into(), r["count"].as_str().unwrap().into())).collect()
	};
	assert_eq!(rows(0)[3], ("4.".into(), "Di".into(), "".into()), "supporters have no count");
	assert_eq!(rows(1)[0], ("1.".into(), "dev1".into(), "40".into()));
	assert_eq!(
		rows(2),
		[("1.".into(), "大地瓜".into(), "22".into()), ("2.".into(), "Tazul || Robin".into(), "7".into()), ("3.".into(), "김민준".into(), "5".into()), ("4.".into(), "Erá".into(), "3".into())]
	);

	// Three equal columns side by side inside the page, each podium over its list, the lists one height.
	let body = out["body"].as_f64().unwrap();
	let xs: Vec<f64> = (0..3).map(|i| panels[i]["x"].as_f64().unwrap()).collect();
	let w = panels[0]["w"].as_f64().unwrap();
	assert!(w > 150.0, "a column {w} wide");
	for i in 0..3 {
		assert_eq!(panels[i]["w"].as_f64().unwrap(), w);
		assert_eq!(panels[i]["h"], panels[0]["h"]);
		assert_eq!(out["podiumX"][i].as_f64().unwrap(), xs[i], "podium {i} over its list");
	}
	assert!(xs[1] >= xs[0] + w + 16.0 && xs[2] >= xs[1] + w + 16.0, "side by side: {xs:?}");
	assert!(xs[2] + w <= xs[0] + body, "inside the page: {xs:?} + {w} > {body}");

	// #353: Chinese and Hangul names take the client's font for their script.
	assert_eq!(panels[2]["rows"][0]["font"], "Fonts\\ARKai_T.ttf");
	assert_eq!(panels[2]["rows"][2]["font"], "Fonts\\2002.TTF");
	assert_ne!(panels[2]["rows"][3]["font"], "Fonts\\ARKai_T.ttf");
	assert_eq!(out["podiumFont"], "Fonts\\ARKai_T.ttf");

	// The header's "Special thanks to" draws from all three lists.
	assert_eq!(out["names"], json!([4, 3, 4, "大地瓜"]));
}

// The translators (the locales' list, their language beside each, a Chinese name in a Chinese font) and the
// ideas that shipped (who, and the pull request or issue), two halves under the three columns.
#[test]
fn translators_and_ideas_two_halves_under_the_three_columns() {
	let out = run(
		"",
		r#"
		Polestar.Credits = {
			supporters = { "Ann" },
			contributors = { { name = "dev1", prs = 4 } },
			bugReporters = { { name = "Bo", reports = 2 } },
			translators = { { name = "Cortexyn", locale = "deDE", language = "German" }, { name = "CDVolvik", locale = "esMX", language = "Spanish (Latin America)" }, { name = "山猫", locale = "zhCN", language = "Chinese (simplified)" } },
			ideas = { { name = "CDVolvik", ref = 1012 } },
		}
		local v = open()
		local function panel(p)
			local rows = {}
			for i, r in ipairs(p.rows) do
				if r:IsShown() then rows[i] = { rank = r.Rank:IsShown() and r.Rank:GetText() or false, name = r.Name:GetText(), side = r.Count:GetText(), font = (r.Name:GetFont()) } end
			end
			local _, _, _, px, py = p:GetPoint(1)
			return { title = p.Title:GetText(), note = p.Note:GetText(), x = px, y = py, w = p:GetWidth(), h = p:GetHeight(), rows = rows }
		end
		local _, _, _, tra, idea = UI.Thanks.Names()
		local _, _, _, _, repY = v.BugReporters:GetPoint(1)
		emit({
			body = UI.Options.frame.BodyWidth,
			rep = { x = x(v.Supporters), y = repY, h = v.BugReporters:GetHeight() },
			translators = panel(v.Translators), ideas = panel(v.Ideas),
			names = { #tra, #idea, tra[3], idea[1] },
		})"#,
	);
	let (t, i) = (&out["translators"], &out["ideas"]);
	assert_eq!((t["title"].as_str().unwrap(), t["note"].as_str().unwrap()), ("TRANSLATORS", "Language"));
	assert_eq!((i["title"].as_str().unwrap(), i["note"].as_str().unwrap()), ("IDEAS", "Pull request or issue"));
	let rows = |p: &Value| -> Vec<(Value, String, String)> {
		p["rows"].as_array().unwrap().iter().map(|r| (r["rank"].clone(), r["name"].as_str().unwrap().into(), r["side"].as_str().unwrap().into())).collect()
	};
	assert_eq!(
		rows(t),
		[(json!(false), "Cortexyn".into(), "German".into()), (json!(false), "CDVolvik".into(), "Spanish (Latin America)".into()), (json!(false), "山猫".into(), "Chinese (simplified)".into())],
		"unranked, each beside its language"
	);
	assert_eq!(rows(i), [(json!(false), "CDVolvik".to_string(), "#1012".to_string())]);
	// #353: the Chinese translator's name in a font that has its glyphs.
	assert_eq!(t["rows"][2]["font"], "Fonts\\ARKai_T.ttf");
	assert_ne!(t["rows"][0]["font"], "Fonts\\ARKai_T.ttf");
	// Two equal halves side by side, under the three columns, inside the page, one height.
	let body = out["body"].as_f64().unwrap();
	let (tx, ix, w) = (t["x"].as_f64().unwrap(), i["x"].as_f64().unwrap(), t["w"].as_f64().unwrap());
	assert_eq!(i["w"].as_f64().unwrap(), w);
	assert_eq!(t["h"], i["h"]);
	assert_eq!(tx, out["rep"]["x"].as_f64().unwrap(), "lined up with the first column");
	assert!(w > body / 3.0 && ix >= tx + w + 16.0 && ix + w <= tx + body, "halves: {tx} {ix} {w} in {body}");
	let below = out["rep"]["y"].as_f64().unwrap() - out["rep"]["h"].as_f64().unwrap();
	assert!(t["y"].as_f64().unwrap() < below, "under the three columns: {} vs {below}", t["y"]);
	// The header's "Special thanks to" draws from these lists too.
	assert_eq!(out["names"], json!([3, 1, "山猫", "CDVolvik"]));
}

// The language beside a translator is an interface key: a German client shows it in German once its file
// translates it, else in English.
#[test]
fn a_translators_language_shows_in_the_clients_language() {
	let out = run(
		"function GetLocale() return \"deDE\" end\n",
		r#"
		Polestar.L["French"] = "Französisch"
		Polestar.Credits = { supporters = {}, contributors = {}, bugReporters = {}, translators = { { name = "Yendi", locale = "frFR", language = "French" }, { name = "julen92", locale = "esES", language = "Spanish (Spain)" } }, ideas = {} }
		local v = open()
		emit({ v.Translators.rows[1].Count:GetText(), v.Translators.rows[2].Count:GetText() })"#,
	);
	assert_eq!(out[0], "Französisch");
	assert_eq!(out[1], "Spanish (Spain)", "untranslated: the English");
}

#[test]
fn every_label_fits_its_column_in_every_locale_with_names_and_with_none() {
	for locale in LOCALES {
		let out = run(
			&format!("function GetLocale() return \"{locale}\" end\n"),
			r#"
			local full, nameRoom = labels(open())
			Polestar.Credits = { supporters = {}, contributors = {}, bugReporters = {} }
			local empty = labels(open(), true)
			emit({ full = full, empty = empty, nameRoom = nameRoom })"#,
		);
		assert!(out["nameRoom"].as_f64().unwrap() >= 100.0, "{locale}: a name gets {} of its row", out["nameRoom"]);
		for case in ["full", "empty"] {
			for l in out[case].as_array().unwrap() {
				let (what, text) = (l["what"].as_str().unwrap(), l["text"].as_str().unwrap());
				let (width, room) = (l["width"].as_f64().unwrap(), l["room"].as_f64().unwrap());
				assert!(!text.is_empty() || what == "Supporters note", "{locale} {case}: {what} is blank");
				assert_eq!(l["cut"], false, "{locale} {case}: {what} \"{text}\" is cut short");
				assert!(width <= room, "{locale} {case}: {what} \"{text}\" is {width} wide in {room}");
			}
		}
	}
}

// RegressVisual V4: a long top name ends in an ellipsis in its column; hovering the podium then shows its names
// in full. A name that fits shows no tooltip.
#[test]
fn a_podium_cut_short_shows_its_names_in_full_on_hover() {
	let out = run(
		"",
		r#"
		local long = "Sample Supporter With A Very Long Name Indeed"
		Polestar.Credits = { supporters = { long, "Bo" }, contributors = { { name = "dev1", prs = 4 } }, bugReporters = {} }
		local v = open()
		local p1, p2 = v.Podiums[1], v.Podiums[2]
		local function tip(p)
			GameTooltip:Hide()
			GameTooltip.owner, GameTooltip.lines = nil, {}
			stub.RunScript(p, "OnEnter")
			local shown = GameTooltip:IsShown() and GameTooltip:GetOwner() == p
			local text = shown and GameTooltip.lines[1] or false
			stub.RunScript(p, "OnLeave")
			return { shown = shown and true or false, text = text }
		end
		emit({ cut = p1.Name:IsTruncated(), long = tip(p1), short = tip(p2) })"#,
	);
	assert_eq!(out["cut"], true, "the long name is cut short in its column");
	assert_eq!(out["long"]["shown"], true);
	assert_eq!(out["long"]["text"], "Sample Supporter With A Very Long Name Indeed");
	assert_eq!(out["short"]["shown"], false, "a name that fits: no tooltip");
}
