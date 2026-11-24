//! Numbers, money, capitals and counts of one in the client's language (Core/Init.lua: Polestar.Thousands,
//! Polestar.Decimal, Polestar.MoneyText, Polestar.Upper). Thousands take the client's own separator
//! (BreakUpLargeNumbers where the client has it, else LARGE_NUMBER_SEPERATOR), decimals its decimal mark
//! (DECIMAL_SEPERATOR), coins its own symbols (GOLD_AMOUNT_SYMBOL, SILVER_AMOUNT_SYMBOL, COPPER_AMOUNT_SYMBOL);
//! a client without them gets its language's own rule and Polestar's translated "g s c". A class name in capitals
//! keeps its accented and Cyrillic letters capital too: Lua's upper() turns "Jäger" into "JäGER". The client
//! values below are each test's fixture, as such a client would set them.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// GetLocale and, when `client`, the separators and coin symbols that client sets.
fn locale(loc: &str, client: Option<(&str, &str, [&str; 3])>) -> String {
	let mut out = format!("function GetLocale() return \"{loc}\" end\n");
	if let Some((large, decimal, [g, s, c])) = client {
		out += &format!("LARGE_NUMBER_SEPERATOR, DECIMAL_SEPERATOR = \"{large}\", \"{decimal}\"\nGOLD_AMOUNT_SYMBOL, SILVER_AMOUNT_SYMBOL, COPPER_AMOUNT_SYMBOL = \"{g}\", \"{s}\", \"{c}\"\n");
	}
	out
}

const PROBE: &str = r#"
local P = Polestar
emit({ P.Thousands(34000), P.Thousands(1234567), P.Thousands(999), P.Thousands(0), P.Decimal(48.75, 1), P.Decimal(1.5, 1),
	P.MoneyText(2147483647), P.MoneyText(10000), P.MoneyText(1), P.MoneyText(0) })"#;

fn probe(before: String) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::files("Polestar", &["Core/Init.lua"])], script: PROBE.into(), ..Default::default() }).remove(0)
}

#[test]
fn numbers_and_coins_take_the_clients_own_separators_and_symbols_in_every_language() {
	let nb = "\u{a0}";
	let cases = [
		("enUS", (",", ".", ["g", "s", "c"]), json!(["34,000", "1,234,567", "999", "0", "48.8", "1.5", "214,748g 36s 47c", "1g", "1c", "0c"])),
		("deDE", (".", ",", ["G", "S", "K"]), json!(["34.000", "1.234.567", "999", "0", "48,8", "1,5", "214.748G 36S 47K", "1G", "1K", "0K"])),
		("frFR", (nb, ",", ["po", "pa", "pc"]), json!([format!("34{nb}000"), format!("1{nb}234{nb}567"), "999", "0", "48,8", "1,5", format!("214{nb}748po 36pa 47pc"), "1po", "1pc", "0pc"])),
		("ruRU", (nb, ",", ["з", "с", "м"]), json!([format!("34{nb}000"), format!("1{nb}234{nb}567"), "999", "0", "48,8", "1,5", format!("214{nb}748з 36с 47м"), "1з", "1м", "0м"])),
		("koKR", (",", ".", ["골", "실", "코"]), json!(["34,000", "1,234,567", "999", "0", "48.8", "1.5", "214,748골 36실 47코", "1골", "1코", "0코"])),
		("zhCN", (",", ".", ["金", "银", "铜"]), json!(["34,000", "1,234,567", "999", "0", "48.8", "1.5", "214,748金 36银 47铜", "1金", "1铜", "0铜"])),
	];
	for (loc, client, want) in cases {
		assert_eq!(probe(locale(loc, Some(client))), want, "{loc}");
	}
}

#[test]
fn without_the_clients_separators_each_language_keeps_its_own_rule() {
	let nb = "\u{a0}";
	// Polestar's own "g s c" (English here: the language folder is not loaded in this test).
	for (loc, thousands, decimal) in [
		("enUS", "34,000", "48.8"),
		("deDE", "34.000", "48,8"),
		("esES", "34.000", "48,8"),
		("ptBR", "34.000", "48,8"),
		("frFR", &format!("34{nb}000") as &str, "48,8"),
		("ruRU", &format!("34{nb}000"), "48,8"),
		("koKR", "34,000", "48.8"),
		("zhCN", "34,000", "48.8"),
	] {
		let out = probe(locale(loc, None));
		assert_eq!(out[0], thousands, "{loc}: {out}");
		assert_eq!(out[4], decimal, "{loc}: {out}");
	}
	assert_eq!(probe(locale("enUS", None))[6], "214,748g 36s 47c");
}

#[test]
fn a_client_with_break_up_large_numbers_does_the_thousands_itself() {
	let out = probe(format!(
		"{}BreakUpLargeNumbers = function(v) return (tostring(v):reverse():gsub(\"(%d%d%d)\", \"%1'\"):reverse():gsub(\"^'\", \"\")) end\n",
		locale("deDE", Some((".", ",", ["G", "S", "K"])))
	));
	assert_eq!(out[0], "34'000", "{out}");
	assert_eq!(out[6], "214'748G 36S 47K", "{out}");
}

#[test]
fn class_names_in_capitals_keep_their_accents_and_cyrillic_letters_capital() {
	let out = emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Init.lua"])],
		script: r#"local out = {}
for i, s in ipairs({ "Jäger", "Prêtre", "Démoniste", "Pícaro", "Chamán", "Paladín", "Caçador", "Xamã", "Охотник", "Жрец", "Чернокнижник", "ёж", "사냥꾼", "猎人", "Hunter" }) do
	out[i] = Polestar.Upper(s)
end
emit(out)"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!(["JÄGER", "PRÊTRE", "DÉMONISTE", "PÍCARO", "CHAMÁN", "PALADÍN", "CAÇADOR", "XAMÃ", "ОХОТНИК", "ЖРЕЦ", "ЧЕРНОКНИЖНИК", "ЁЖ", "사냥꾼", "猎人", "HUNTER"]));
}

// Every ding in a German client: the level-up card's head from the client's class name.
#[test]
fn the_level_up_cards_head_capitalises_a_german_hunter() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"LOCALIZED_CLASS_NAMES_MALE = { HUNTER = "Jäger" }
local w = stub.world
w.class, w.className = "HUNTER", "Jäger""#
			.into(),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"emit(Polestar.UI.SpellCards.LevelModel({ level = 18, spells = { { id = 2643, rank = 1, cost = 1800 } } }).head)"#.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, "LEVEL 18 · JÄGER");
}

// "1 kills" as the last kill of a level nears: the XP line counts one in the singular.
#[test]
fn the_xp_line_counts_one_kill_in_the_singular_and_writes_its_percent_with_the_clients_decimal_mark() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: r#"function GetLocale() return "deDE" end
DECIMAL_SEPERATOR, LARGE_NUMBER_SEPERATOR = ",", ".""#
			.into(),
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"local XP = Polestar.QoL.XP
emit({ XP.Summary({ level = 23, percent = 45.2, rate = 12300, timeToLevel = 65, killsToLevel = 1, rested = 0 }),
	XP.Summary({ level = 23, percent = 45.2, rate = 12300, timeToLevel = 65, killsToLevel = 2, rested = 0 }) })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out[0], "Level 23 45,2% · 12,3k XP/h · 1m to level · 1 kill", "{out}");
	assert_eq!(out[1], "Level 23 45,2% · 12,3k XP/h · 1m to level · 2 kills", "{out}");
}
