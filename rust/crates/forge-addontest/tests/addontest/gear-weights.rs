//! Polestar's own stat weights (addon/Polestar/Gear/Weights.lua, Gear.lua's Gear.WeightsFor, docs/gear-weights.md): the
//! level bands and the authored table, with the formula weights worked out for the band at the player's level (health,
//! mana, haste, expertise, armor penetration); known upgrades scoring the right way; an off hand weighed at a scale's own
//! off-hand weight.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_gear.lua"],
		before: r#"w = stub.world; g = stub.gear
w.class, w.className, w.classID, w.level = "WARRIOR", "Warrior", 1, 30
w.race, w.raceName, w.raceID, w.faction = "Troll", "Troll", 8, "Horde""#
			.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Gear/Gear.xml"])],
		login: true,
		script: ["G = Polestar.Gear\n", script].concat(),
		..Default::default()
	})
}

// The rules of docs/gear-weights.md ("Polestar's formula weights"), written out again here, for every spec at every
// level: a band's (or the authored table's) own numbers, the formula weights in their place.
#[test]
fn every_spec_s_weights_are_its_band_with_the_formula_weights_at_the_level() {
	let out = run(r#"
		local FORMULA = { health = true, mana = true, haste = true, expertise = true, armorPen = true }
		local bad, n = {}, 0
		local function no(s) bad[#bad + 1] = s end
		for class, meta in pairs(G.CLASSES) do
			for _, s in ipairs(meta.specs) do
				local authored = G.WEIGHTS[class][s.key]
				for _, level in ipairs({ 1, 9, 10, 24, 25, 33, 40, 49, 50, 59, 60, 70 }) do
					n = n + 1
					local where = class .. "." .. s.key .. "@" .. level
					local got, info = G.WeightsFor(class, s.key, level)
					local bands = G.WEIGHT_BANDS[class] and G.WEIGHT_BANDS[class][s.key]
					local base = authored
					if bands then
						base = bands[#bands]
						for _, b in ipairs(bands) do if level <= b.upTo then base = b break end end
						if info ~= base then no(where .. " band") end
						base = base.weights
					end
					-- The band's own numbers, Forever's ratings from the authored table where it has none.
					local want = {}
					for k, v in pairs(base) do want[k] = v end
					for _, k in ipairs({ "haste", "expertise", "armorPen" }) do if want[k] == nil then want[k] = authored[k] end end
					-- The formula weights.
					local lv = math.min(level, 60)
					if (want.sta or 0) > 0 then want.health = want.sta / 10 end
					local perCrit = G.IntPerSpellCrit(class, lv)
					if perCrit and (want.int or 0) > 0 then want.mana = math.max(0, want.int - (want.spellCrit or 0) / perCrit) / 15 end
					local crit, ref = "crit", authored.crit or 0
					if ref <= 0 then crit, ref = "spellCrit", authored.spellCrit or 0 end
					if authored.haste and ref > 0 and (want[crit] or 0) > 0 then want.haste = want[crit] * authored.haste / ref end
					if authored.expertise and (authored.hit or 0) > 0 and (want.hit or 0) > 0 then want.expertise = want.hit * authored.expertise / authored.hit end
					if (authored.crit or 0) > 0 and (want.crit or 0) > 0 then want.armorPen = want.crit * G.ArmorShare(lv) end
					-- Weapon DPS: Feral's 14 attack power per DPS, a caster's tiebreak.
					if want.dps == nil then want.dps = (class == "DRUID" and s.key == "feral" and want.ap) and 14 * want.ap or 0.01 end
					for k, v in pairs(want) do
						if not got[k] or math.abs(got[k] - v) > 1e-9 then no(where .. " " .. k .. " " .. tostring(got[k]) .. " want " .. v) end
					end
					for k in pairs(got) do if want[k] == nil then no(where .. " extra " .. k) end end
				end
			end
		end
		emit({ n = n, bad = #bad, first = { bad[1] or false, bad[2] or false, bad[3] or false } })
	"#);
	assert_eq!(out[0]["bad"], 0, "first differences: {}", out[0]["first"]);
	assert_eq!(out[0]["n"], 27 * 12);
}

// The game's numbers behind the formula weights, as docs/gear-weights.md gives them, and a few weights they make.
#[test]
fn the_formula_weights_come_from_the_documented_game_numbers() {
	let out = run(r#"
		local holy60, holy30 = G.WeightsFor("PALADIN", "holy", 60), G.WeightsFor("PALADIN", "holy", 30)
		local arms60, arms12 = G.WeightsFor("WARRIOR", "arms", 60), G.WeightsFor("WARRIOR", "arms", 12)
		emit({ int = { G.IntPerSpellCrit("MAGE", 1), G.IntPerSpellCrit("MAGE", 60), G.IntPerSpellCrit("PALADIN", 30), G.IntPerSpellCrit("WARRIOR", 60) or false },
			armor = { G.ArmorShare(60), G.ArmorShare(12), G.ArmorShare(80) },
			holy = { mana60 = holy60.mana, int60 = holy60.int, crit60 = holy60.spellCrit, mana30 = holy30.mana, int30 = holy30.int, crit30 = holy30.spellCrit },
			arms = { health = arms60.health, sta = arms60.sta, pen60 = arms60.armorPen, crit60 = arms60.crit, pen12 = arms12.armorPen, crit12 = arms12.crit,
				haste = arms12.haste, expertise = arms12.expertise, hit = arms12.hit, mana = arms60.mana or false },
			frost = G.WeightsFor("MAGE", "frost", 60).armorPen or false })
	"#);
	let o = &out[0];
	let f = |v: &Value| v.as_f64().unwrap();
	let close = |a: f64, b: f64| (a - b).abs() < 1e-9;
	assert!(close(f(&o["int"][0]), 59.5 * 0.2) && close(f(&o["int"][1]), 59.5), "Intellect per 1% spell crit, Mage: {}", o["int"]);
	assert!(close(f(&o["int"][2]), 54.0 * (0.2 + 0.8 * 29.0 / 59.0)), "Paladin at 30: {}", o["int"]);
	assert_eq!(o["int"][3], false, "a Warrior has no mana");
	assert!(close(f(&o["armor"][0]), 3466.0 / (3466.0 + 400.0 + 85.0 * 60.0)), "a level 60 mob's armor: {}", o["armor"]);
	assert!(close(f(&o["armor"][1]), 552.0 / (552.0 + 400.0 + 85.0 * 12.0)), "a level 12 mob's armor: {}", o["armor"]);
	assert!(close(f(&o["armor"][2]), f(&o["armor"][0])), "past 60, a level 60 mob's: {}", o["armor"]);
	let h = &o["holy"];
	assert!(close(f(&h["mana60"]), (f(&h["int60"]) - f(&h["crit60"]) / 54.0) / 15.0), "Holy's mana at 60: {h}");
	assert!(close(f(&h["mana30"]), (f(&h["int30"]) - f(&h["crit30"]) / (54.0 * (0.2 + 0.8 * 29.0 / 59.0))) / 15.0), "at 30: {h}");
	assert!(f(&h["mana30"]) < f(&h["mana60"]), "a point of spell crit costs less Intellect at 30, so more of it is crit: {h}");
	let a = &o["arms"];
	assert!(close(f(&a["health"]), f(&a["sta"]) / 10.0), "health: {a}");
	assert!(close(f(&a["pen60"]), f(&a["crit60"]) * 3466.0 / (3466.0 + 400.0 + 85.0 * 60.0)), "armor penetration at 60: {a}");
	assert!(close(f(&a["pen12"]), f(&a["crit12"]) * 552.0 / (552.0 + 400.0 + 85.0 * 12.0)), "at 12: {a}");
	assert!(close(f(&a["haste"]), f(&a["crit12"]) * 0.6) && close(f(&a["expertise"]), f(&a["hit"]) * 0.9), "Arms' ratios 6/10 and 8.1/9: {a}");
	assert_eq!(a["mana"], false);
	assert_eq!(o["frost"], false, "spells ignore armor: no armor penetration for a caster");
}

#[test]
fn known_upgrades_score_the_right_way() {
	let out = run(r#"
		local function score(class, key, level, inv, stats, off)
			return G.ScoreWith({ inv = inv, class = 4, subclass = 0, stats = stats }, G.WeightsFor(class, key, level), off)
		end
		emit({
			-- A two-hander 5 DPS better beats one with 5 more Strength (weapon DPS about 7 Strength).
			arms = score("WARRIOR", "arms", 30, 17, { dps = 30 }) > score("WARRIOR", "arms", 30, 17, { dps = 25, str = 5 }),
			-- Spell damage beats Intellect for a Frost Mage; Frost damage counts more than three times Fire damage.
			mage = { score("MAGE", "frost", 60, 5, { sp = 20 }) > score("MAGE", "frost", 60, 5, { int = 20 }),
				score("MAGE", "frost", 30, 5, { spFrost = 20 }) > score("MAGE", "frost", 30, 5, { spFire = 20 }) * 3 },
			-- Healing beats "+spell power" of fewer points for a Holy Priest.
			priest = score("PRIEST", "holy", 60, 5, { heal = 22 }) > score("PRIEST", "holy", 60, 5, { sp = 12, heal = 12 }),
			-- A tank's Stamina beats Strength; a Rogue's Agility beats Strength.
			prot = score("WARRIOR", "protection", 60, 5, { sta = 10 }) > score("WARRIOR", "protection", 60, 5, { str = 10 }),
			rogue = score("ROGUE", "combat", 40, 5, { agi = 10 }) > score("ROGUE", "combat", 40, 5, { str = 10 }),
			-- A Hunter's bow DPS outweighs melee weapon DPS many times over.
			hunter = score("HUNTER", "beastmastery", 30, 15, { dps = 5 }) > 10 * score("HUNTER", "beastmastery", 30, 17, { dps = 5 }),
			-- Feral weighs the weapon's DPS (Forever's forms hit with it): 5 DPS beat 25 Strength.
			feral = score("DRUID", "feral", 30, 17, { dps = 5 }) > score("DRUID", "feral", 30, 5, { str = 25 }),
			-- Stamina is health: 10 Stamina weigh as much as 100 health.
			health = math.abs(score("WARRIOR", "arms", 30, 5, { sta = 10 }) - score("WARRIOR", "arms", 30, 5, { health = 100 })) < 1e-9,
		})
	"#);
	let o = &out[0];
	for k in ["arms", "priest", "prot", "rogue", "hunter", "feral", "health"] {
		assert_eq!(o[k], true, "{k}: {o}");
	}
	assert_eq!(o["mage"], json!([true, true]));
}

#[test]
fn an_off_hand_weapon_counts_at_a_scale_s_own_off_hand_weight_else_half_of_the_main_hand_s() {
	let out = run(r#"
		local dagger = { inv = 13, class = 2, subclass = 15, stats = { dps = 10 } }
		local pawn = G.Pawn.Weights(assert(G.Pawn.Parse('( Pawn: v1: "O": OffHandDps=2, MeleeDps=3 )')))
		local arms = G.WeightsFor("WARRIOR", "fury", 30)
		emit({ pawn = pawn, own = { G.ScoreWith(dagger, pawn, true), G.ScoreWith(dagger, pawn) },
			half = { G.ScoreWith(dagger, arms, true), arms.dps, arms.ohDps or false } })
	"#);
	let o = &out[0];
	assert_eq!(o["pawn"], json!({ "ohDps": 2, "dps": 3 }), "Pawn's OffHandDps is the off hand's weapon DPS weight");
	assert_eq!(o["own"], json!([20, 30]), "in the off hand at its own weight, in the main hand at the melee one");
	assert_eq!(o["half"][2], false, "Polestar's own weights have no off-hand weight");
	let (off, dps) = (o["half"][0].as_f64().unwrap(), o["half"][1].as_f64().unwrap());
	assert!((off - 5.0 * dps).abs() < 1e-9, "half of the main hand's: {}", o["half"]);
}
