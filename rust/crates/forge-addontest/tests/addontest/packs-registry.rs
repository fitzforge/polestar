//! The guide pack registry (addon/Polestar/Core/Guides.lua): pack ids and ownership, clashes, formats, problems
//! recorded per pack, map frames and author text escaped once at registration.

use forge_addontest::{emitted, is_match, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
G = Polestar.Guides
function pack(id, addon, extra)
	local m = { addon = addon or "JoeAddon", id = id, format = 1, title = "Joe's Routes", author = "Joe", version = "1.0.0", license = "MIT" }
	for k, v in pairs(extra or {}) do m[k] = v end
	return { Polestar.RegisterPack(m) }
end
function guide(id, packId, extra)
	local g = { id = id, pack = packId, title = "Guide " .. id, steps = { { goals = { { t = "level", level = 2 } } } } }
	for k, v in pairs(extra or {}) do g[k] = v end
	return { Polestar.RegisterGuide(g) }
end
function messages(r)
	local out = {}
	for i, p in ipairs(r.problems) do out[i] = p.kind .. ": " .. p.message end
	return out
end
"#;

fn run_before(script: &str, before: &str) -> Value {
	emitted(&RunAddon { before: before.into(), addons: vec![Addon::files("Polestar", &["Core/Core.xml"])], login: false, script: format!("{PRELUDE}{script}"), ..Default::default() }).remove(0)
}

fn run(script: &str) -> Value {
	run_before(script, "")
}

fn len(v: &Value) -> usize {
	v.as_array().unwrap().len()
}

#[test]
fn a_pack_registers_and_its_own_guides_join_it() {
	let out = run(r#"
		local p = pack("joe")
		local g = guide("joe/a", "joe")
		local r = G.Pack("joe")
		emit({ p = p[1], g = g[1], count = r.guideCount, status = r.status, guides = r.guides, got = G.Get("joe/a").id, official = r.official })
	"#);
	assert_eq!(out, json!({ "p": true, "g": true, "count": 1, "status": "on", "guides": ["joe/a"], "got": "joe/a", "official": false }));
}

#[test]
fn a_guide_outside_its_pack_s_prefix_is_refused_and_the_problem_names_the_prefix() {
	let out = run(r#"
		pack("joe")
		local a = guide("forever/x", "joe")
		local b = guide("joe-routes/x", "joe")
		emit({ a = a[1], b = b[1], got = G.Get("forever/x") ~= nil or G.Get("joe-routes/x") ~= nil, problems = G.Pack("joe").problems })
	"#);
	assert_eq!(out["a"], false);
	assert_eq!(out["b"], false);
	assert_eq!(out["got"], false);
	assert_eq!(len(&out["problems"]), 2);
	for p in out["problems"].as_array().unwrap() {
		assert_eq!(p["kind"], "guide-refused");
		assert!(is_match(p["message"].as_str().unwrap(), r"joe/"));
	}
	let guides: Vec<Value> = out["problems"].as_array().unwrap().iter().map(|p| p["guide"].clone()).collect();
	assert_eq!(json!(guides), json!(["forever/x", "joe-routes/x"]));
}

#[test]
fn a_pack_id_already_taken_refuses_the_second_pack_whole_the_guides_it_registers_while_loading_stay_out_even_under_the_holder_s_ids() {
	let out = run(r#"
		pack("joe", "A")
		guide("joe/a", "joe")
		stub.addonLoaded("A")
		local second = pack("joe", "B")
		local same = guide("joe/a", "joe", { title = "Not A" })
		local own = guide("joe/b", "joe")
		stub.addonLoaded("B")
		local later = guide("joe/c", "joe")
		local refused
		for _, r in ipairs(G.Packs()) do if r.addon == "B" then refused = r end end
		local a = G.Pack("joe")
		emit({ second = second[1], same = same[1], own = own[1], later = later[1], status = refused.status, problems = messages(refused),
			reason = refused.reason, holder = a.addon, guides = a.guides, title = G.Get("joe/a").title, hasB = G.Get("joe/b") ~= nil, n = #G.Packs() })
	"#);
	assert_eq!(out["second"], false);
	assert_eq!(out["same"], false, "B's guide under the holder's id is dropped");
	assert_eq!(out["own"], false);
	assert_eq!(out["later"], true, "after B has loaded, a guide for pack joe goes to its holder");
	assert_eq!(out["status"], "refused");
	assert_eq!(len(&out["problems"]), 1);
	let p0 = out["problems"][0].as_str().unwrap();
	assert!(is_match(p0, r"^pack-refused: "));
	assert!(is_match(p0, r"\bA\b"));
	assert!(is_match(p0, r"\bB\b"));
	assert!(is_match(p0, r" 2 guides dropped\.$"));
	assert_eq!(out["reason"], p0.strip_prefix("pack-refused: ").unwrap_or(p0));
	assert_eq!(out["holder"], "A");
	assert_eq!(out["guides"], json!(["joe/a", "joe/c"]));
	assert_eq!(out["title"], "Guide joe/a", "the holder's guide is untouched");
	assert_eq!(out["hasB"], false);
	assert_eq!(out["n"], 2);
}

#[test]
fn a_pack_refused_for_a_reserved_id_drops_the_guides_it_registers_while_loading() {
	let out = run(r#"
		pack("guides", "Polestar_Guides")
		guide("forever/a", "guides")
		stub.addonLoaded("Polestar_Guides")
		pack("guides", "Imposter")
		local g = guide("forever/a", "guides", { title = "Not ours" })
		local refused
		for _, r in ipairs(G.Packs()) do if r.addon == "Imposter" then refused = r end end
		emit({ g = g[1], title = G.Get("forever/a").title, problems = messages(refused) })
	"#);
	assert_eq!(out["g"], false);
	assert_eq!(out["title"], "Guide forever/a");
	assert_eq!(out["problems"], json!(["pack-refused: Pack id guides is reserved for Polestar. 1 guide dropped."]));
}

#[test]
fn a_guide_registered_before_its_pack_is_refused_and_the_pack_records_it() {
	let out = run(r#"
		local g = guide("joe/a", "joe")
		local stray = guide("nobody/a", "nobody")
		pack("joe")
		emit({ g = g[1], stray = stray[1], got = G.Get("joe/a") ~= nil, problems = G.Pack("joe").problems, count = G.Pack("joe").guideCount })
	"#);
	assert_eq!(out["g"], false);
	assert_eq!(out["stray"], false);
	assert_eq!(out["got"], false);
	assert_eq!(out["count"], 0);
	assert_eq!(len(&out["problems"]), 1);
	assert_eq!(out["problems"][0]["kind"], "guide-refused");
	assert_eq!(out["problems"][0]["guide"], "joe/a");
	assert!(is_match(out["problems"][0]["message"].as_str().unwrap(), r"before its pack"));
}

#[test]
fn a_pack_of_a_format_the_core_does_not_read_is_refused_whole_with_the_version_it_needs() {
	let out = run_before(
		r#"
		local p = pack("joe", "JoeAddon", { format = 99 })
		local g1 = guide("joe/a", "joe")
		local g2 = guide("joe/b", "joe")
		local r = G.Pack("joe")
		emit({ p = p[1], g = g1[1] or g2[1], status = r.status, needs = r.needs, problems = messages(r), got = G.Get("joe/a") ~= nil })
	"#,
		r#"stub.addonMeta.JoeAddon = { ["X-Polestar-Needs"] = "0.3.0" }"#,
	);
	assert_eq!(out["p"], false);
	assert_eq!(out["g"], false);
	assert_eq!(out["status"], "too-new");
	assert_eq!(out["needs"], "0.3.0");
	assert_eq!(len(&out["problems"]), 1);
	assert!(is_match(out["problems"][0].as_str().unwrap(), r"0\.3\.0"));
	assert_eq!(out["got"], false);
}

#[test]
fn an_unknown_verb_refuses_only_that_guide() {
	let out = run(r#"
		pack("joe")
		local bad = guide("joe/bad", "joe", { steps = { { goals = { { t = "dance" } } } } })
		local good = guide("joe/good", "joe")
		local r = G.Pack("joe")
		emit({ bad = bad[1], good = good[1], status = r.status, guides = r.guides, problems = r.problems })
	"#);
	assert_eq!(out["bad"], false);
	assert_eq!(out["good"], true);
	assert_eq!(out["status"], "on");
	assert_eq!(out["guides"], json!(["joe/good"]));
	assert_eq!(len(&out["problems"]), 1);
	assert_eq!(out["problems"][0]["guide"], "joe/bad");
	assert!(is_match(out["problems"][0]["message"].as_str().unwrap(), r"unknown verb dance"));
}

#[test]
fn a_pack_registering_its_own_id_again_replaces_the_guide_in_its_first_slot() {
	let out = run(r#"
		pack("joe")
		guide("joe/a", "joe", { title = "One" })
		guide("joe/z", "joe")
		local again = guide("joe/a", "joe", { title = "Two" })
		local ids = {}
		for i, h in ipairs(G.List()) do ids[i] = h.id end
		emit({ again = again[1], title = G.Get("joe/a").title, header = G.List()[1].title, ids = ids, count = G.Pack("joe").guideCount })
	"#);
	assert_eq!(out, json!({ "again": true, "title": "Two", "header": "Two", "ids": ["joe/a", "joe/z"], "count": 2 }));
}

#[test]
fn reserved_internal_and_malformed_pack_ids_are_refused() {
	let out = run(r#"
		local res = {}
		res.forever = pack("forever")[1]
		res.polestar = pack("polestar")[1]
		res.draft = pack("draft")[1]
		res.guidesElsewhere = pack("guides", "NotOurs")[1]
		res.lookupPlain = pack("lookup")[1]
		res.internalOther = Polestar.RegisterPack({ id = "joe", title = "Joe", internal = true })
		res.upper = pack("Joe")[1]
		res.short = pack("x")[1]
		res.long = pack(string.rep("a", 33))[1]
		res.ok = pack("joe")[1]
		res.internalLookup = Polestar.RegisterPack({ id = "lookup", title = "Lookup", internal = true })
		local listed = {}
		for _, r in ipairs(G.Packs()) do listed[#listed + 1] = r.id .. ":" .. r.status end
		emit({ res = res, listed = listed, lookupInternal = G.Pack("lookup").internal, guidesHeld = G.Pack("guides").status })
	"#);
	assert_eq!(
		out["res"],
		json!({
			"forever": false, "polestar": false, "draft": false, "guidesElsewhere": false, "lookupPlain": false,
			"internalOther": false, "upper": false, "short": false, "long": false, "ok": true, "internalLookup": true,
		})
	);
	assert_eq!(out["lookupInternal"], true);
	assert_eq!(out["guidesHeld"], "refused");
	let listed = out["listed"].as_array().unwrap();
	assert!(!listed.iter().any(|s| s.as_str().unwrap_or("").starts_with("lookup:on")), "the internal pack is not listed");
	assert!(listed.iter().any(|s| s == "joe:on"));
}

#[test]
fn our_pack_is_only_ours_from_polestar_guides_and_comes_first_in_the_list() {
	let out = run(r#"
		pack("aaa", "Aaa", { title = "Aardvark" })
		local ours = pack("guides", "Polestar_Guides", { title = "Polestar Guides" })
		pack("zed", "Zed", { title = "beta" })
		guide("forever/a", "guides")
		guide("draft/b", "guides")
		local wrong = guide("guides/c", "guides")
		local ids = {}
		for i, r in ipairs(G.Packs()) do ids[i] = r.id end
		emit({ ours = ours[1], official = G.Pack("guides").official, ids = ids, count = G.Pack("guides").guideCount, wrong = wrong[1],
			owns = { G.OwnsId("guides", "forever/x"), G.OwnsId("guides", "draft/x"), G.OwnsId("lookup", "lookup/x"), G.OwnsId("joe", "joe/x"), G.OwnsId("joe", "joex/y") } })
	"#);
	assert_eq!(out["ours"], true);
	assert_eq!(out["official"], true);
	assert_eq!(out["ids"], json!(["guides", "aaa", "zed"]));
	assert_eq!(out["count"], 2);
	assert_eq!(out["wrong"], false);
	assert_eq!(out["owns"], json!([true, true, true, true, false]));
}

const MAP_FRAMES: &str = r#"
		pack("joe")
		local A = { c = 0, left = 1, right = -1, top = 1, bottom = -1 }
		local B = { c = 0, left = 2, right = -2, top = 2, bottom = -2 }
		local C = { c = 1, left = 3, right = -3, top = 3, bottom = -3 }
		local calls = {
			joe = function() Polestar.RegisterMapFrames({ era = { [1429] = A, [9999] = C } }, "joe") end,
			guides = function() Polestar.RegisterMapFrames({ era = { [1429] = B } }, "guides") end,
		}
		calls.{first}(); calls.{second}()
		local era = Polestar.MapFrames.era
		emit({ era[1429] == B, era[9999] == C })
	"#;

#[test]
fn map_frames_ours_win_for_a_map_both_cover_whatever_the_load_order_packs_add_the_maps_ours_lack() {
	let script = |first: &str, second: &str| MAP_FRAMES.replace("{first}", first).replace("{second}", second);
	assert_eq!(run(&script("joe", "guides")), json!([true, true]));
	assert_eq!(run(&script("guides", "joe")), json!([true, true]));
}

#[test]
fn author_text_prints_literally_every_doubled_once_at_registration_ids_unchanged() {
	let out = run(r#"
		pack("joe", "JoeAddon", { title = "Joe|r", notes = "a|b" })
		guide("joe/a", "joe", { title = "|cffff0000Red|r", next = "joe/b", steps = {
			{ title = "S|1", goals = { { t = "note", text = "x|y" }, { t = "level", level = 2, note = "n|n", text = "lvl|2" } } } } })
		local g = G.Get("joe/a")
		local r = G.Pack("joe")
		emit({ title = g.title, header = G.List()[1].title, step = g.steps[1].title, text = g.steps[1].goals[1].text,
			note = g.steps[1].goals[2].note, text2 = g.steps[1].goals[2].text, id = g.id, next = g.next, pack = g.pack,
			packTitle = r.title, packNotes = r.notes, esc = Polestar.EscapeText("a|b|c"), plain = Polestar.EscapeText("abc") })
	"#);
	assert_eq!(
		out,
		json!({
			"title": "||cffff0000Red||r", "header": "||cffff0000Red||r", "step": "S||1", "text": "x||y", "note": "n||n", "text2": "lvl||2",
			"id": "joe/a", "next": "joe/b", "pack": "joe", "packTitle": "Joe||r", "packNotes": "a||b", "esc": "a||b||c", "plain": "abc",
		})
	);
}

#[test]
fn a_pack_missing_a_required_field_is_refused_and_the_problem_names_the_field() {
	let out = run(r#"
		local p = Polestar.RegisterPack({ addon = "JoeAddon", id = "joe", format = 1, title = "Joe", version = "1", license = "MIT" })
		local g = guide("joe/a", "joe")
		local r = G.Pack("joe")
		emit({ p = p, g = g[1], status = r.status, problems = messages(r) })
	"#);
	assert_eq!(out["p"], false);
	assert_eq!(out["g"], false);
	assert_eq!(out["status"], "refused");
	assert_eq!(len(&out["problems"]), 1);
	assert!(is_match(out["problems"][0].as_str().unwrap(), r"author"));
}

#[test]
fn a_pack_misusing_internal_or_the_lookup_id_is_refused_listed_with_its_problem_and_never_reported_broken() {
	let out = run_before(
		r#"
		local a = { Polestar.RegisterPack({ addon = "IntlAddon", id = "intl", format = 1, title = "Intl", author = "I", version = "1", license = "MIT", internal = true }) }
		local b = { Polestar.RegisterPack({ addon = "LookAddon", id = "lookup", format = 1, title = "Look", author = "L", version = "1", license = "MIT" }) }
		G.ScanInstalled()
		local rows = {}
		for _, r in ipairs(G.Packs()) do rows[r.addon] = { id = r.id, status = r.status, problems = messages(r) } end
		emit({ a = a[1], b = b[1], rows = rows, count = G.ProblemCount() })
	"#,
		r#"stub.addons = { { name = "IntlAddon", loaded = true }, { name = "LookAddon", loaded = true } }
		stub.addonMeta.IntlAddon = { ["X-Polestar-Pack"] = "intl", ["X-Polestar-Format"] = "1" }
		stub.addonMeta.LookAddon = { ["X-Polestar-Pack"] = "lookup", ["X-Polestar-Format"] = "1" }"#,
	);
	assert_eq!(out["a"], false);
	assert_eq!(out["b"], false);
	let mut keys: Vec<&str> = out["rows"].as_object().unwrap().keys().map(|k| k.as_str()).collect();
	keys.sort();
	assert_eq!(keys, vec!["IntlAddon", "LookAddon"]);
	assert_eq!(out["rows"]["IntlAddon"]["status"], "refused");
	assert_eq!(len(&out["rows"]["IntlAddon"]["problems"]), 1);
	let p0 = out["rows"]["IntlAddon"]["problems"][0].as_str().unwrap();
	assert!(is_match(p0, r"^pack-refused: .*internal"));
	assert!(!is_match(p0, r"reserved"));
	assert_eq!(out["rows"]["LookAddon"]["status"], "refused");
	assert_eq!(out["rows"]["LookAddon"]["problems"], json!(["pack-refused: Pack id lookup is reserved for Polestar."]));
	assert_eq!(out["count"], 2);
}

#[test]
fn an_internal_pack_whose_id_is_taken_or_reserved_is_refused_whole_its_guides_stay_out_of_the_holder() {
	let out = run(r#"
		pack("joe", "A")
		guide("joe/a", "joe")
		stub.addonLoaded("A")
		pack("joe", "B", { internal = true })
		local taken = guide("joe/b", "joe")
		stub.addonLoaded("B")
		pack("guides", "Polestar_Guides")
		stub.addonLoaded("Polestar_Guides")
		pack("guides", "C", { internal = true })
		local reserved = guide("forever/x", "guides")
		emit({ taken = taken[1], reserved = reserved[1], hasB = G.Get("joe/b") ~= nil, hasX = G.Get("forever/x") ~= nil, guides = G.Pack("joe").guides })
	"#);
	assert_eq!(out, json!({ "taken": false, "reserved": false, "hasB": false, "hasX": false, "guides": ["joe/a"] }));
}

#[test]
fn map_frames_of_a_refused_pack_are_ignored_even_under_the_holder_s_id() {
	let out = run(r#"
		local A = { c = 0, left = 1, right = -1, top = 1, bottom = -1 }
		local B = { c = 1, left = 2, right = -2, top = 2, bottom = -2 }
		pack("joe", "A")
		stub.addonLoaded("A")
		pack("joe", "B")
		Polestar.RegisterMapFrames({ era = { [9999] = B } }, "joe")
		pack("guides", "C")
		Polestar.RegisterMapFrames({ era = { [8888] = B } }, "guides")
		stub.addonLoaded("C")
		Polestar.RegisterMapFrames({ era = { [7777] = A } }, "joe")
		local era = Polestar.MapFrames.era
		emit({ era[9999] == nil, era[8888] == nil, era[7777] == A })
	"#);
	assert_eq!(out, json!([true, true, true]));
}

#[test]
fn a_step_picture_is_a_file_in_the_pack_s_addon_folder_its_texture_path_comes_from_the_addon_that_registered_the_pack() {
	let out = run(r#"
		pack("joe", "PolestarPack_Joe")
		local ok = guide("joe/a", "joe", { steps = {
			{ note = "The mouth is behind the farm.", image = { file = "media\\fargodeep-mine", w = 512, h = 256 }, goals = { { t = "level", level = 2 } } },
			{ image = { file = "media/shots/gate.blp" }, goals = { { t = "level", level = 3 } } },
			{ note = "No picture.", goals = { { t = "level", level = 4 } } },
		} })
		local s = G.Get("joe/a").steps
		emit({ ok = ok[1], first = s[1].image, second = s[2].image.texture, third = s[3].image == nil })
	"#);
	assert_eq!(out["ok"], true);
	assert_eq!(out["first"], json!({ "file": r"media\fargodeep-mine", "w": 512, "h": 256, "texture": r"Interface\AddOns\PolestarPack_Joe\media\fargodeep-mine" }));
	assert_eq!(out["second"], r"Interface\AddOns\PolestarPack_Joe\media\shots\gate.blp");
	assert_eq!(out["third"], true, "a step without a picture gets none");
}

#[test]
fn a_step_picture_outside_the_pack_s_folder_of_another_kind_or_without_a_path_refuses_the_guide() {
	let out = run(r#"
		pack("joe")
		local out = {}
		for i, image in ipairs({
			"media\\cave", { w = 512, h = 256 }, { file = "" }, { file = "\\media\\cave" }, { file = "C:\\cave" }, { file = "..\\cave" },
			{ file = "media\\..\\cave" }, { file = "media/cave.png" }, { file = "media\\my cave" }, { file = "media\\\\cave" },
			{ file = "media\\cave", w = 0, h = 256 }, { file = "media\\cave", w = 512, h = "256" },
		}) do
			local r = guide("joe/bad" .. i, "joe", { steps = { { image = image, goals = { { t = "level", level = 2 } } } } })
			out[i] = r[2] or "accepted"
		end
		out[#out + 1] = guide("joe/good", "joe", { steps = { { image = { file = "Media/Shots/Cave_1.TGA" }, goals = { { t = "level", level = 2 } } } } })[1]
		emit(out)
	"#);
	let mut want: Vec<Value> = vec![json!("step 1: bad image"); 12];
	want.push(json!(true));
	assert_eq!(out, json!(want));
}
