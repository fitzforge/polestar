//! Client-table rows + reference data -> professions.json (port of
//! tools/lib/professions/extract.js; schema: docs/ARCHITECTURE.md, Toolchain -> Reference data).
//!
//! A recipe is a SkillLineAbility row of a profession skill line whose spell creates an item
//! (SpellEffect 24) or enchants one (53). yellow/grey are the trivial ranks, green their floored
//! mean. The orange threshold comes from the recipe item (RequiredSkillRank), 1 for recipes known
//! with the skill, else MinSkillLineRank, else yellow (learnedAtEstimated). AcquireMethod 3
//! (retired) and Season of Discovery recipes are left out.

use forge_guide::js::{Arr, Obj, V};
use rustc_hash::{FxHashMap, FxHashSet};

use super::tables::{int, nk, Ability, Item, ItemSparse, SkillLine, SpellCasting, SpellEffect, SpellReagents, SpellTotems, Tables};
use super::trainers::{self, Finder};

/// Skill line -> kind, in JS key order (integer keys ascending).
pub const PROFESSIONS: [(i64, &str); 12] = [
	(129, "secondary"),
	(164, "primary"),
	(165, "primary"),
	(171, "primary"),
	(182, "gathering"),
	(185, "secondary"),
	(186, "gathering"),
	(197, "primary"),
	(202, "primary"),
	(333, "primary"),
	(356, "secondary"),
	(393, "gathering"),
];

pub const SOD_SPELL_MIN: i64 = 400000;
const ESTIMATE_GAP: i64 = 0;

const GOBLIN_ENGINEER: i64 = 20222;
const GNOMISH_ENGINEER: i64 = 20219;

/// Specialization recipes trainers teach without a recipe item (Gnomish/Goblin Engineering, 1.x).
fn specialization(spell: i64) -> Option<i64> {
	match spell {
		12715 | 12716 | 12717 | 12718 | 12720 | 12722 | 12755 | 12758 | 12760 | 12908 | 13240 | 23078 | 23489 => Some(GOBLIN_ENGINEER),
		12759 | 12897 | 12899 | 12902 | 12903 | 12904 | 12905 | 12906 | 12907 | 23129 | 23486 => Some(GNOMISH_ENGINEER),
		_ => None,
	}
}

/// Indexes over the raw tables shared by every profession (indexTables).
struct Ix<'a> {
	spell_name: FxHashMap<i64, Option<&'a str>>,
	effects: FxHashMap<i64, Vec<&'a SpellEffect>>,
	taught_by: FxHashMap<i64, Vec<i64>>,
	reagents: FxHashMap<i64, &'a SpellReagents>,
	totems: FxHashMap<i64, &'a SpellTotems>,
	tool_items: FxHashMap<i64, Vec<i64>>,
	casting: FxHashMap<i64, &'a SpellCasting>,
	focus: FxHashMap<i64, Option<&'a str>>,
	sparse: FxHashMap<i64, &'a ItemSparse>,
	item: FxHashMap<i64, &'a Item>,
	skill_line: FxHashMap<i64, &'a SkillLine>,
	abilities: FxHashMap<i64, Vec<&'a Ability>>,
}

fn index(t: &Tables) -> Ix<'_> {
	let spell_name = t.spell_name.iter().map(|r| (int(r.id_n), r.name.as_deref())).collect();
	let mut effects: FxHashMap<i64, Vec<&SpellEffect>> = FxHashMap::default();
	// teaching spell -> learned spells (Effect 36)
	let mut learns: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in &t.effects {
		if r.difficulty != 0 {
			continue;
		}
		let s = int(r.spell_n);
		effects.entry(s).or_default().push(r);
		if r.effect == 36 && r.trigger > 0 {
			learns.entry(s).or_default().push(r.trigger);
		}
	}
	for list in effects.values_mut() {
		list.sort_by_key(|e| e.index);
	}
	// learned spell -> items that teach it: TriggerType 6 teaches its SpellID itself (Forever),
	// else SpellID is a teaching spell (Era); Era names the item in ParentItemID, Forever links
	// them in ItemXItemEffect.
	let mut effect_items: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in &t.item_x {
		effect_items.entry(r.effect).or_default().push(int(r.item_n));
	}
	let mut taught_by: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	let none: Vec<i64> = Vec::new();
	for r in &t.item_effect {
		let parent = int(r.parent_n);
		let one = [parent];
		let parents: &[i64] = if parent != 0 { &one } else { effect_items.get(&r.id).unwrap_or(&none) };
		let single = [r.spell];
		let learned: &[i64] = if r.trigger_type == 6 { &single } else { learns.get(&r.spell).unwrap_or(&none) };
		for &s in learned {
			taught_by.entry(s).or_default().extend_from_slice(parents);
		}
	}
	// Tool category (SpellTotems.RequiredTotemCategoryID) -> its items (ItemSparse.TotemCategoryID), by id.
	let mut tool_items: FxHashMap<i64, Vec<i64>> = FxHashMap::default();
	for r in &t.sparse {
		if r.totem_category != 0 {
			tool_items.entry(r.totem_category).or_default().push(int(r.id_n));
		}
	}
	for list in tool_items.values_mut() {
		list.sort();
	}
	let mut abilities: FxHashMap<i64, Vec<&Ability>> = FxHashMap::default();
	for r in &t.abilities {
		abilities.entry(r.skill_line).or_default().push(r);
	}
	Ix {
		spell_name,
		effects,
		taught_by,
		reagents: t.reagents.iter().map(|r| (int(r.spell_n), r)).collect(),
		totems: t.totems.iter().map(|r| (int(r.spell_n), r)).collect(),
		tool_items,
		casting: t.casting.iter().map(|r| (int(r.spell_n), r)).collect(),
		focus: t.focus.iter().map(|r| (int(r.id_n), r.name.as_deref())).collect(),
		sparse: t.sparse.iter().map(|r| (int(r.id_n), r)).collect(),
		item: t.item.iter().map(|r| (int(r.id_n), r)).collect(),
		skill_line: t.skill_line.iter().map(|r| (r.id, r)).collect(),
		abilities,
	}
}

/// Item ids -> vendor stock limits (pfQuest db/items.lua): item -> npc -> limit, nk keys.
pub type Stock = FxHashMap<u64, FxHashMap<u64, f64>>;

pub struct Ctx<'a> {
	pub items: &'a Obj,
	pub npcs: &'a Obj,
	pub objects: &'a Obj,
	pub stock: &'a Stock,
	pub season: &'a FxHashSet<u64>,
}

impl Ctx<'_> {
	fn item(&self, id: i64) -> V {
		self.items.get(&id.to_string())
	}
	fn has_item(&self, id: i64) -> bool {
		self.item(id).truthy()
	}
}

fn obj_len(v: &V) -> usize {
	if v.truthy() {
		v.keys().len()
	} else {
		0
	}
}

/// sourceOf(it): vendor, drop or item (None for no item).
fn source_of(it: &V) -> Option<&'static str> {
	if !it.truthy() {
		return None;
	}
	let vendors = it.get("vendors");
	if vendors.truthy() && vendors.get("length").truthy() {
		return Some("vendor");
	}
	let d = it.get("drops");
	if d.truthy() && (obj_len(&d.get("npc")) > 0 || obj_len(&d.get("object")) > 0) {
		return Some("drop");
	}
	Some("item")
}

fn num(n: i64) -> V {
	V::Num(n as f64)
}

/// A recipe: its JSON object, and what sorting and the materials read.
struct Recipe {
	obj: Obj,
	spell: i64,
	item: Option<i64>,
	learned_at: i64,
	yellow: Option<i64>,
	materials: Vec<i64>,
}

fn extract_recipe(ix: &Ix, row: &Ability, ctx: &Ctx) -> Result<Recipe, &'static str> {
	let spell = row.spell;
	let effects: &[&SpellEffect] = ix.effects.get(&spell).map(Vec::as_slice).unwrap_or(&[]);
	let create = effects.iter().find(|e| e.effect == 24 && e.item_type > 0);
	let enchant = effects.iter().any(|e| e.effect == 53);
	if create.is_none() && !enchant {
		return Err("not a recipe");
	}
	if row.acquire == 3 {
		return Err("retired");
	}
	if spell >= SOD_SPELL_MIN && ctx.season.contains(&nk(spell as f64)) {
		return Err("season");
	}
	let made = create.map(|e| e.item_type);
	if let Some(m) = made {
		if !ctx.has_item(m) {
			return Err("season");
		}
	}
	let (yellow, grey) = (row.low, row.high);
	// Recipe items (Item ClassID 9) whose use teaches the spell, in items.json only.
	let mut recipe_items: Vec<i64> = Vec::new();
	for &id in ix.taught_by.get(&spell).map(Vec::as_slice).unwrap_or(&[]) {
		let Some(it) = ix.item.get(&id) else { continue };
		if it.class != 9 || !ctx.has_item(id) || recipe_items.contains(&id) {
			continue;
		}
		recipe_items.push(id);
	}
	recipe_items.sort();
	let r = Obj::new();
	let mut materials = Vec::new();
	r.set("spell", num(spell));
	match ix.spell_name.get(&spell) {
		Some(Some(n)) if !n.is_empty() => r.set("name", *n),
		_ => r.set("name", format!("Spell {spell}")),
	}
	if let (Some(m), Some(c)) = (made, create) {
		r.set("item", num(m));
		r.set("itemCount", (c.base_points + 1.0).max(1.0));
	}
	if enchant {
		r.set("enchant", true);
	}
	let reagents = Arr::new();
	if let Some(rg) = ix.reagents.get(&spell) {
		for i in 0..8 {
			let (item, count) = (rg.reagent[i], rg.count[i]);
			if item > 0 && count > 0 {
				let g = Obj::new();
				g.set("item", num(item));
				g.set("count", num(count));
				reagents.push(g);
				materials.push(item);
			}
		}
	}
	r.set("reagents", reagents);
	// Prefer a recipe item someone sells, then one that drops, then the lowest id.
	let rank = |id: i64| match source_of(&ctx.item(id)) {
		Some("vendor") => 0,
		Some("drop") => 1,
		_ => 2,
	};
	let recipe_item = recipe_items.iter().copied().min_by(|&a, &b| rank(a).cmp(&rank(b)).then(a.cmp(&b)));
	let learned_at;
	if let Some(ri) = recipe_item {
		let s = ix.sparse.get(&ri);
		let req = s.map_or(0, |s| s.req_rank);
		learned_at = req.max(1);
		r.set("learnedAt", num(learned_at));
		let source = source_of(&ctx.item(ri));
		r.set("source", source.map(V::str).unwrap_or(V::Null));
		r.set("recipeItem", num(ri));
		materials.push(ri);
		if source == Some("vendor") {
			r.set("cost", num(s.map_or(0, |s| s.buy)));
		}
		let ability = s.map_or(0, |s| s.ability);
		if ability != 0 {
			r.set("requires", num(ability));
		}
		// Reputation vendors: MinFactionID + MinReputation (standing 0-7, 4 = Friendly).
		let faction = s.map_or(0, |s| s.faction);
		if faction > 0 {
			let rep = Obj::new();
			rep.set("faction", num(faction));
			rep.set("standing", num(s.map_or(0, |s| s.min_rep) + 1));
			r.set("reputation", rep);
		}
	} else {
		r.set("source", "trainer");
		if row.acquire == 1 {
			learned_at = 1;
			r.set("learnedAt", 1.0);
			r.set("cost", 0.0);
		} else if row.min_rank > 1 {
			learned_at = row.min_rank;
			r.set("learnedAt", num(learned_at));
		} else if yellow > 0 {
			learned_at = (yellow - ESTIMATE_GAP).max(1);
			r.set("learnedAt", num(learned_at));
			r.set("learnedAtEstimated", true);
		} else {
			learned_at = 1;
			r.set("learnedAt", 1.0);
			r.set("learnedAtEstimated", true);
		}
	}
	if let Some(sp) = specialization(spell) {
		r.set("requires", num(sp));
	}
	let ry;
	if grey > 0 {
		let y = if yellow > 0 { yellow } else { learned_at };
		ry = Some(y);
		r.set("yellow", num(y));
		r.set("grey", num(grey));
		r.set("green", ((y + grey) as f64 / 2.0).floor());
	} else {
		ry = None;
		r.set("yellow", V::Null);
		r.set("green", V::Null);
		r.set("grey", V::Null);
	}
	if row.ups > 1 {
		r.set("skillUps", num(row.ups));
	}
	// A tool is an item (Totem_0..1, Era) or a tool category (Forever): its first item in items.json.
	if let Some(tot) = ix.totems.get(&spell) {
		let mut tools: Vec<i64> = tot.totem.iter().copied().filter(|&x| x > 0).collect();
		for &cat in &tot.category {
			let list: &[i64] = if cat > 0 { ix.tool_items.get(&cat).map(Vec::as_slice).unwrap_or(&[]) } else { &[] };
			let id = list.iter().copied().find(|&x| ctx.has_item(x)).filter(|&x| x != 0).or_else(|| list.first().copied());
			if let Some(id) = id {
				if id != 0 && !tools.contains(&id) {
					tools.push(id);
				}
			}
		}
		if !tools.is_empty() {
			r.set("tools", V::Arr(Arr::from_vec(tools.iter().map(|&t| num(t)).collect())));
			materials.extend_from_slice(&tools);
		}
	}
	if let Some(cast) = ix.casting.get(&spell) {
		if cast.focus > 0 {
			match ix.focus.get(&cast.focus) {
				Some(Some(n)) if !n.is_empty() => r.set("focus", *n),
				_ => r.set("focus", format!("focus {}", cast.focus)),
			}
		}
	}
	// The low 32 race bits, unsigned (Forever's RaceMasks_0 is a signed int32).
	let race = crate::jsv::to_int32(row.race as f64) as u32;
	if race != 0 {
		r.set("races", race);
	}
	if row.class != 0 {
		r.set("classes", num(row.class));
	}
	Ok(Recipe { obj: r, spell, item: made, learned_at, yellow: ry, materials })
}

/// Rank spells: abilities whose spell has a skill effect (118) for the line; its base points are
/// the tier (0 Apprentice .. 3 Artisan). -> tier (nk) -> spell
fn rank_spells(ix: &Ix, skill_line: i64) -> FxHashMap<u64, i64> {
	let mut out: FxHashMap<u64, i64> = FxHashMap::default();
	for row in ix.abilities.get(&skill_line).map(Vec::as_slice).unwrap_or(&[]) {
		let spell = row.spell;
		let Some(e) = ix.effects.get(&spell).and_then(|l| l.iter().find(|x| x.effect == 118 && x.misc0 == skill_line)) else { continue };
		let tier = nk(e.base_points);
		match out.get(&tier) {
			Some(&s) if spell >= s => {}
			_ => {
				out.insert(tier, spell);
			}
		}
	}
	out
}

fn sort_ids(v: &mut [V]) {
	v.sort_by(|a, b| {
		let d = a.num() - b.num();
		if d < 0.0 {
			std::cmp::Ordering::Less
		} else if d > 0.0 {
			std::cmp::Ordering::Greater
		} else {
			std::cmp::Ordering::Equal
		}
	});
}

/// `b[1] - a[1] || a[0] - b[0]` (numbers; NaN counts as equal).
fn by_chance(a: (f64, f64), b: (f64, f64)) -> std::cmp::Ordering {
	let d = b.1 - a.1;
	let d = if d != 0.0 && !d.is_nan() { d } else { a.0 - b.0 };
	d.partial_cmp(&0.0).unwrap_or(std::cmp::Ordering::Equal)
}

/// Every item a recipe needs or teaches, with where the data says it comes from.
fn material_info(ix: &Ix, id: i64, ctx: &Ctx, made_by: &FxHashMap<i64, Arr>) -> Obj {
	let it = ctx.item(id);
	let sparse = ix.sparse.get(&id);
	let m = Obj::new();
	let name = if it.truthy() { it.get("name") } else { V::Undef };
	if name.truthy() {
		m.set("name", name);
	} else {
		match sparse.and_then(|s| s.display.as_deref()) {
			Some(d) if !d.is_empty() => m.set("name", d),
			_ => m.set("name", format!("Item {id}")),
		}
	}
	if let Some(s) = sparse {
		m.set("buy", num(s.buy));
		m.set("buyCount", num(s.stack.max(1)));
		m.set("sell", num(s.sell));
		m.set("quality", num(s.quality));
		// Bonding 1 binds when picked up: nobody can sell it on the Auction House.
		if s.bonding == 1 {
			m.set("bop", true);
		}
	}
	let mut vendors: [Vec<V>; 2] = [Vec::new(), Vec::new()];
	let mut limited: [Vec<V>; 2] = [Vec::new(), Vec::new()];
	let limits = ctx.stock.get(&nk(id as f64));
	let iv = if it.truthy() { it.get("vendors") } else { V::Undef };
	if iv.truthy() {
		for v in iv.items() {
			let npc = ctx.npcs.get(&v.to_js_string());
			if !npc.truthy() {
				continue;
			}
			let f = npc.get("faction");
			let f = if f.is_nullish() {
				"AH".to_string()
			} else {
				let s = f.to_js_string();
				if s.is_empty() {
					"AH".to_string()
				} else {
					s
				}
			};
			let lim = limits.and_then(|l| l.get(&nk(v.num()))).copied().unwrap_or(0.0);
			for (side, code) in ["A", "H"].iter().enumerate() {
				if !(f.contains(code) || f == "AH") {
					continue;
				}
				let list = if lim > 0.0 { &mut limited } else { &mut vendors };
				list[side].push(v.clone());
			}
		}
	}
	for s in 0..2 {
		sort_ids(&mut vendors[s]);
		sort_ids(&mut limited[s]);
	}
	let sides = |l: [Vec<V>; 2]| {
		let o = Obj::new();
		let [a, h] = l;
		o.set("Alliance", V::Arr(Arr::from_vec(a)));
		o.set("Horde", V::Arr(Arr::from_vec(h)));
		o
	};
	if !vendors[0].is_empty() || !vendors[1].is_empty() {
		m.set("vendors", sides(vendors));
	}
	if !limited[0].is_empty() || !limited[1].is_empty() {
		m.set("limitedVendors", sides(limited));
	}
	if let Some(made) = made_by.get(&id) {
		if !made.is_empty() {
			m.set("madeBy", made.clone());
		}
	}
	let d = if it.truthy() { it.get("drops") } else { V::Undef };
	let d = if d.truthy() { d } else { V::obj() };
	let mut gather: Vec<(&str, Vec<(f64, f64)>)> = Vec::new();
	let dobj = d.get("object");
	if dobj.truthy() {
		for (oid, chance) in dobj.entries() {
			let o = ctx.objects.get(&oid);
			let roles = if o.truthy() { o.get("roles") } else { V::Undef };
			let roles = if roles.truthy() { roles.items() } else { Vec::new() };
			for role in ["herb", "mine", "fishing"] {
				if roles.iter().any(|r| r.as_str() == Some(role)) {
					let pair = (forge_guide::js::str_to_num(&oid), chance.num());
					match gather.iter_mut().find(|(k, _)| *k == role) {
						Some((_, l)) => l.push(pair),
						None => gather.push((role, vec![pair])),
					}
				}
			}
		}
	}
	if !gather.is_empty() {
		let g = Obj::new();
		for (role, mut list) in gather {
			list.sort_by(|a, b| by_chance(*a, *b));
			g.set(role, V::Arr(Arr::from_vec(list.iter().take(3).map(|x| V::Num(x.0)).collect())));
		}
		m.set("gather", g);
	}
	let dnpc = d.get("npc");
	let mut drops: Vec<(f64, f64)> = if dnpc.truthy() {
		dnpc.entries().into_iter().map(|(n, c)| (forge_guide::js::str_to_num(&n), c.num())).filter(|(n, _)| ctx.npcs.get(&forge_guide::js::num_str(*n)).truthy()).collect()
	} else {
		Vec::new()
	};
	drops.sort_by(|a, b| by_chance(*a, *b));
	if !drops.is_empty() {
		m.set("dropCount", drops.len());
		let list = Arr::new();
		for (n, c) in drops.iter().take(3) {
			let o = Obj::new();
			o.set("npc", *n);
			o.set("chance", *c);
			list.push(o);
		}
		m.set("drops", list);
	}
	m
}

pub struct Report {
	pub name: String,
	pub recipes: usize,
	/// reason -> count, in the order first met.
	pub skipped: Vec<(&'static str, usize)>,
}

pub struct Extracted {
	/// id -> profession, ascending.
	pub professions: Vec<(i64, Obj)>,
	pub report: Vec<Report>,
	pub warnings: Vec<String>,
}

/// String.prototype.trim (JS white space and line terminators, BOM included).
fn js_trim(s: &str) -> &str {
	s.trim_matches(|c: char| c.is_whitespace() || c == '\u{feff}')
}

/// extractProfessions(tables, { items, npcs, objects, stock, season, trainers }).
pub fn extract(t: &Tables, ctx: &Ctx) -> Extracted {
	let ix = index(t);
	let finder = Finder::new(ctx.npcs);
	let mut warnings = Vec::new();
	let mut report = Vec::new();
	let mut made_by: FxHashMap<i64, Arr> = FxHashMap::default();
	// (id, profession, recipes' materials, books)
	let mut all: Vec<(i64, Obj, Vec<i64>)> = Vec::new();
	for &(id, kind) in &PROFESSIONS {
		let Some(line) = ix.skill_line.get(&id) else {
			warnings.push(format!("SkillLine {id} missing from the client tables"));
			continue;
		};
		let mut recipes: Vec<Recipe> = Vec::new();
		let mut skipped: Vec<(&'static str, usize)> = Vec::new();
		let mut seen: FxHashSet<i64> = FxHashSet::default();
		for row in ix.abilities.get(&id).map(Vec::as_slice).unwrap_or(&[]) {
			match extract_recipe(&ix, row, ctx) {
				Err(skip) => {
					if skip != "not a recipe" {
						match skipped.iter_mut().find(|(k, _)| *k == skip) {
							Some((_, n)) => *n += 1,
							None => skipped.push((skip, 1)),
						}
					}
				}
				Ok(r) => {
					if seen.insert(r.spell) {
						recipes.push(r);
					}
				}
			}
		}
		recipes.sort_by(|a, b| a.learned_at.cmp(&b.learned_at).then(a.yellow.unwrap_or(0).cmp(&b.yellow.unwrap_or(0))).then(a.spell.cmp(&b.spell)));
		for r in &recipes {
			if let Some(item) = r.item {
				let o = Obj::new();
				o.set("skillLine", num(id));
				o.set("spell", num(r.spell));
				made_by.entry(item).or_default().push(o);
			}
		}
		let tr = trainers::resolve(id, &finder, kind);
		warnings.extend(tr.warnings);
		let spells = rank_spells(&ix, id);
		let ranks = Arr::new();
		let mut mats: Vec<i64> = recipes.iter().flat_map(|r| r.materials.iter().copied()).collect();
		for (i, rk) in tr.ranks.into_iter().enumerate() {
			if let Some(&s) = spells.get(&nk(i as f64)) {
				if s != 0 {
					rk.set("spell", num(s));
				}
			}
			let book = rk.get("book");
			if book.truthy() {
				mats.push(int(book.get("item").num()));
			}
			ranks.push(rk);
		}
		let name = match &line.name {
			Some(n) => js_trim(n).to_string(),
			None => "undefined".to_string(),
		};
		let prof = Obj::new();
		prof.set("id", num(id));
		prof.set("name", name.as_str());
		prof.set("kind", kind);
		prof.set("ranks", ranks);
		prof.set("trainers", tr.trainers);
		if !tr.main.is_empty() {
			let main = Obj::new();
			for (side, npc) in tr.main {
				main.set(side, npc);
			}
			prof.set("mainTrainer", main);
		}
		report.push(Report { name, recipes: recipes.len(), skipped });
		prof.set("recipes", V::Arr(Arr::from_vec(recipes.into_iter().map(|r| V::Obj(r.obj)).collect())));
		all.push((id, prof, mats));
	}
	// Materials: reagents, tools and recipe items of every profession, and rank books.
	let mut professions = Vec::with_capacity(all.len());
	for (id, prof, mut mats) in all {
		mats.sort();
		mats.dedup();
		let materials = Obj::new();
		for m in mats {
			materials.set(&m.to_string(), material_info(&ix, m, ctx, &made_by));
		}
		prof.set("materials", materials);
		professions.push((id, prof));
	}
	Extracted { professions, report, warnings }
}
