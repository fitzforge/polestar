//! `profession build` (professions.json, its report and warnings) against the JavaScript's output on
//! client table slices for four professions, the world slice's npcs and objects, an items.json cut and
//! pfQuest's vendor stock: rust/tests/golden/professions (README there).

use crate::common;

use forge_data::professions::{build, Options};

#[test]
fn professions_match_golden() {
	let g = common::golden("professions");
	let input = g.join("input");
	// The build reads one data folder: the golden's items.json beside the world slice's npcs and objects.
	let data = common::scratch("professions");
	std::fs::copy(input.join("data/items.json"), data.join("items.json")).unwrap();
	let world = common::golden("world").join("root/data/forever");
	for f in ["npcs.json", "objects.json"] {
		std::fs::copy(world.join(f), data.join(f)).unwrap();
	}
	let mut o = Options::new(&input);
	o.data = data;
	o.sources = input.join("sources");
	o.tdb = input.join("no-tdb.sqlite");
	let out = build(&o).unwrap();
	let want = g.join("expected");
	let mut check = common::Check::new();
	let mut names = Vec::new();
	for (name, text) in &out.files {
		check.file(name, text, &want.join(name));
		names.push(name.clone());
	}
	let report = format!("wrote professions.json from Forever build {} (gaps filled from Classic Era {}):\n{}\n", out.build, out.era_build, out.report.join("\n"));
	check.file("report.txt", &report, &want.join("report.txt"));
	let warnings: String = out.warnings.iter().map(|w| format!("warning: {w}\n")).collect();
	check.file("warnings.txt", &warnings, &want.join("warnings.txt"));
	// POLESTAR_BLESS=1 rewrites the golden from this build (review the diff before committing).
	if std::env::var_os("POLESTAR_BLESS").is_some() {
		for (name, text) in &out.files {
			std::fs::write(want.join(name), text).unwrap();
		}
		std::fs::write(want.join("report.txt"), &report).unwrap();
		std::fs::write(want.join("warnings.txt"), &warnings).unwrap();
	}
	names.extend(["report.txt".into(), "warnings.txt".into()]);
	check.all_of(&want, &names);
	check.finish("profession build");
}

/// The Node draft tests' fixture (tests/fixtures/professions): its professions.json is this build's
/// output, so the facts the former JS build tests checked on it hold here (Forever's thresholds over
/// Era's, #109; season and retired spells left out; Forever's own spells and columns; limited-stock
/// vendors apart; binds-when-picked-up recipe items, #315; Era fills the spells Forever lacks).
#[test]
fn draft_fixture_is_this_build() {
	let fx = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../tests/fixtures/professions");
	let mut o = Options::new(&fx);
	o.data = fx.join("data");
	o.sources = fx.clone();
	o.tdb = fx.join("no-tdb.sqlite");
	let out = build(&o).unwrap();
	let mut check = common::Check::new();
	for (name, text) in &out.files {
		check.file(name, text, &fx.join("data").join(name));
	}
	check.finish("profession build on tests/fixtures/professions");
	assert!(out.report.iter().any(|l| l.trim_start().starts_with("Tailoring") && l.ends_with("6 recipes (left out: 1 season, 1 retired)")), "{:?}", out.report);
	// The fixture's TDB extract (forever-tdb/extract.json) has a sniffed trainer list teaching Faction
	// Banner at 50 for 5 silver: that skill and price, not the yellow-rank estimate (55).
	let text = &out.files[0].1;
	assert!(text.contains(r#""spell":1257000,"name":"Faction Banner""#) && text.contains(r#""learnedAt":50,"cost":500"#), "Faction Banner's learnedAt and cost from the sniffed list");
	// No sniffed Forever list teaches Red Linen Shirt; a Classic list teaches it at 40 (Era yellow 65).
	// Forever moved its yellow to 50, so it is learned at 25 (no price: Classic's says nothing of
	// Forever's).
	assert!(
		text.contains(r#""spell":2392,"name":"Red Linen Shirt""#) && text.contains(r#""learnedAt":25,"learnedAtEstimated":true,"learnedAtFrom":"classic","yellow":50"#),
		"Red Linen Shirt's learnedAt from the Classic list, shifted"
	);
	// The extract's currencyVendors: Far Vendor sells Coarse Thread for a currency (an extended cost),
	// so it is neither a gold nor a limited-stock vendor of it; the sniffed gold rows keep the rest.
	assert!(
		text.contains(r#""name":"Coarse Thread","buy":10,"buyCount":1,"sell":2,"quality":1,"vendors":{"Alliance":[1347],"Horde":[3364]},"currencyVendors":{"Alliance":[5000],"Horde":[]}"#),
		"Coarse Thread's currency vendor kept apart"
	);
	// A sniffed list teaches Red Linen Robe at 40 for 2 silver: a trainer recipe, though Pattern: Red
	// Linen Robe exists (and leaves the materials).
	assert!(
		text.contains(r#""spell":2389,"name":"Red Linen Robe","item":2572,"itemCount":1,"reagents":[{"item":2996,"count":2},{"item":2604,"count":1}],"source":"trainer","learnedAt":40,"cost":200"#),
		"Red Linen Robe taught by the sniffed list"
	);
	// The extract's vendorLimits: Borya keeps two Red Dye at a time (npc_vendor maxcount), a limited
	// seller though pfQuest has no limit for it.
	assert!(
		text.contains(r#""name":"Red Dye","buy":50,"buyCount":1,"sell":12,"quality":1,"vendors":{"Alliance":[5000],"Horde":[]},"limitedVendors":{"Alliance":[],"Horde":[3364]}"#),
		"Red Dye's sniffed stock limit"
	);
}
