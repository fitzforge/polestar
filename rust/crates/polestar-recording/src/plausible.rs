//! Plausibility checks for a decoded chunk (docs/RECORDING.md "Trust"). [`crate::record`] makes
//! sure every record is well formed; this looks at whether the values could come from a real
//! game session. The ingest server stores a chunk with issues as suspect and leaves it out of the
//! export; nothing here rejects a chunk, and every bound is generous: an honest player must
//! never trip one.

use std::fmt;

use crate::maps_table;
use crate::record::{Chunk, Kind};

/// How far back a chunk's epoch may be (30 days).
pub const MAX_AGE: i64 = 30 * 86_400;
/// How far ahead of the server's clock a chunk's epoch may be (10 minutes).
pub const MAX_AHEAD: i64 = 600;
/// Longest span from a chunk's epoch to its last record (2 hours; the addon closes chunks after 5
/// minutes).
pub const MAX_SPAN: f64 = 7200.0;
/// How far below the install's highest seq a chunk may be: the addon keeps at most 4 MiB of
/// chunks, so an older one cannot still be waiting to be uploaded.
pub const SEQ_WINDOW: u64 = 400;
/// Highest character level.
pub const MAX_LEVEL: i64 = 60;
/// Most kills, and most loot windows, in any 60 seconds.
pub const MAX_KILLS_PER_MINUTE: usize = 40;
pub const MAX_LOOTS_PER_MINUTE: usize = 60;
/// Most `gather` and most `refuse` records in any 60 seconds (the addon writes at most 20 and 10).
pub const MAX_GATHERS_PER_MINUTE: usize = 30;
pub const MAX_REFUSES_PER_MINUTE: usize = 30;
/// Largest group: a raid of 40.
pub const MAX_GROUP: i64 = 40;
/// Quest, creature, object and item ids are below this.
pub const MAX_ID: u64 = 1_000_000;
/// Fastest believable movement between two `pos` records on one map, in yards a second (a
/// mounted player runs 14; taxis fly about 32). Measured on the canonical map sizes of
/// [`crate::maps_table`] only, never on sizes an uploader sends; other maps are not checked.
/// One faster jump on its own is a teleport the game made (the spirit healer after a release, a
/// portal such as Rut'theran's, a quest teleport) and passes; two in a row, or
/// [`MAX_JUMPS`] in one chunk, are flagged.
pub const MAX_YARDS_PER_SECOND: f64 = 100.0;
/// Most single jumps faster than [`MAX_YARDS_PER_SECOND`] one chunk (at most 5 minutes of play) may
/// hold.
pub const MAX_JUMPS: usize = 2;

/// What the server knows about the chunk's install before this chunk.
#[derive(Clone, Debug, Default)]
pub struct Context {
	/// Unix seconds.
	pub now: i64,
	/// The install's highest seq so far and that chunk's epoch.
	pub highest: Option<(u64, i64)>,
}

/// One failed check.
#[derive(Clone, Debug, PartialEq)]
pub struct Issue {
	/// Short rule name (`epoch`, `span`, `seq`, `level`, `kill-xp`, `kill-rate`, `loot-rate`,
	/// `gather-rate`, `refuse-rate`, `group`, `id`, `speed`).
	pub rule: &'static str,
	pub detail: String,
}

impl fmt::Display for Issue {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		write!(f, "{}: {}", self.rule, self.detail)
	}
}

/// The most XP one kill can give a character of `level` (or of a mob of that level): twice
/// Classic's best case, an elite (x2) four or more levels above the player (+20%), on top of the
/// base 5 x level + 45. Rested bonus XP is at most as much again and is checked on its own.
pub fn max_kill_xp(level: i64) -> u64 {
	let level = level.clamp(1, MAX_LEVEL + 3) as f64;
	((5.0 * level + 45.0) * 2.0 * 1.2 * 2.0).ceil() as u64
}

/// Fields that hold quest, creature/object or item ids, as single values or as the first part
/// of each list item (`Record::ids` reads both).
const ID_FIELDS: [&str; 17] =
	["q", "npcId", "killerNpc", "srcId", "targetId", "objectId", "startItem", "chosenItem", "itemId", "available", "active", "log", "done", "notOffered", "items", "choices", "wanted"];

/// The largest count of `times` (sorted) inside any 60-second window.
fn busiest_minute(times: &[f64]) -> usize {
	let mut best = 0;
	let mut start = 0;
	for (end, t) in times.iter().enumerate() {
		while t - times[start] >= 60.0 {
			start += 1;
		}
		best = best.max(end - start + 1);
	}
	best
}

/// Every plausibility issue of `chunk`; empty when it looks like a real session.
pub fn check_chunk(chunk: &Chunk, ctx: &Context) -> Vec<Issue> {
	let mut issues = Vec::new();
	let mut issue = |rule: &'static str, detail: String| {
		// One issue per rule is enough to judge a chunk.
		if !issues.iter().any(|i: &Issue| i.rule == rule) {
			issues.push(Issue { rule, detail });
		}
	};

	if chunk.epoch < ctx.now.saturating_sub(MAX_AGE) || chunk.epoch > ctx.now.saturating_add(MAX_AHEAD) {
		issue("epoch", format!("server epoch {} is not within 30 days before now ({})", chunk.epoch, ctx.now));
	}
	// `dt` is never negative: the decoder only reads unsigned dt, so no record is before the epoch.
	if let Some(last) = chunk.records.iter().map(|r| r.t).reduce(f64::max) {
		let span = last - chunk.epoch as f64;
		if span > MAX_SPAN {
			issue("span", format!("the chunk spans {span:.0} s"));
		}
	}
	if let Some((seq, epoch)) = ctx.highest {
		if chunk.seq.saturating_add(SEQ_WINDOW) < seq {
			issue("seq", format!("seq {} is more than {SEQ_WINDOW} below the install's {seq}", chunk.seq));
		}
		if chunk.seq > seq && chunk.epoch.saturating_add(MAX_AHEAD) < epoch {
			issue("epoch", format!("seq {} starts at {} but seq {seq} at {epoch}", chunk.seq, chunk.epoch));
		}
	}

	let mut player_level: Option<i64> = None;
	let mut kills = Vec::new();
	let mut loots = Vec::new();
	let mut spawns = Vec::new();
	let mut gathers = Vec::new();
	let mut refuses = Vec::new();
	// The last `pos`: (map, x, y in percent, t).
	let mut last_pos: Option<(u32, f64, f64, f64)> = None;
	// The jump of the last `pos` segment when it was one, and how many jumps the chunk holds so far:
	// one jump is a teleport (spirit healer, portal, quest teleport), a speed hack keeps going.
	let mut jump: Option<String> = None;
	let mut jumps = 0;
	// Kills of creatures another player tagged (`tapped` 1), and their `spawn` records, are what a
	// crowd around the player kills (the launch rush): they don't count towards the player's own kill
	// rate. A `spawn` with no `kill` before it in the chunk counts.
	let mut own_kill = true;
	for r in &chunk.records {
		for field in ID_FIELDS {
			if let Some(id) = r.ids(field).into_iter().find(|id| *id >= MAX_ID) {
				issue("id", format!("{} {field} {id}", r.kind));
			}
		}
		match r.kind {
			Kind::Session | Kind::Level | Kind::Accept | Kind::Turnin => {
				if let Some(level) = r.int("level") {
					if (1..=MAX_LEVEL).contains(&level) {
						player_level = Some(level);
					} else {
						issue("level", format!("{} level {level}", r.kind));
					}
				}
			}
			Kind::Kill => {
				own_kill = r.int("tapped") != Some(1);
				if own_kill {
					kills.push(r.t);
				}
				let mob = r.int("level").filter(|l| *l > 0);
				let level = match (player_level, mob) {
					(Some(p), Some(m)) => p.max(m),
					(Some(p), None) => p,
					(None, Some(m)) => m,
					(None, None) => MAX_LEVEL,
				};
				let bound = max_kill_xp(level);
				for field in ["xp", "rested"] {
					if let Some(xp) = r.int(field).filter(|xp| *xp as u64 > bound) {
						issue("kill-xp", format!("kill {field} {xp} at level {level} (at most {bound})"));
					}
				}
			}
			Kind::Loot => loots.push(r.t),
			Kind::Spawn => {
				if own_kill {
					spawns.push(r.t);
				}
			}
			Kind::Gather => gathers.push(r.t),
			Kind::Refuse => refuses.push(r.t),
			Kind::Group => {
				if let Some(size) = r.int("size").filter(|s| *s > MAX_GROUP) {
					issue("group", format!("group of {size}"));
				}
			}
			Kind::Taxi | Kind::Land | Kind::Death | Kind::Revive | Kind::Zone | Kind::Ride | Kind::Enter | Kind::Cast => {
				last_pos = None;
				jump = None;
			}
			Kind::Pos => {
				let Some(p) = r.pos() else {
					last_pos = None;
					jump = None;
					continue;
				};
				let (x, y) = p.percent();
				let mut fast = None;
				if let (Some((map, lx, ly, lt)), Some((w, h))) = (last_pos, maps_table::size(p.map)) {
					if map == p.map {
						let yards = ((x - lx) * w / 100.0).hypot((y - ly) * h / 100.0);
						let seconds = (r.t - lt).max(1.0);
						if yards / seconds > MAX_YARDS_PER_SECOND {
							fast = Some(format!("{yards:.0} yd in {:.1} s on map {map}", r.t - lt));
						}
					}
				}
				if let Some(f) = &fast {
					jumps += 1;
					if let Some(first) = &jump {
						issue("speed", format!("{first}, then {f}"));
					} else if jumps > MAX_JUMPS {
						issue("speed", format!("{jumps} jumps in one chunk, the last {f}"));
					}
				}
				jump = fast;
				last_pos = Some((p.map, x, y, r.t));
			}
			_ => {}
		}
	}
	for (rule, what, mut times, max) in [
		("kill-rate", "kills", kills, MAX_KILLS_PER_MINUTE),
		("kill-rate", "spawns", spawns, MAX_KILLS_PER_MINUTE),
		("loot-rate", "loot windows", loots, MAX_LOOTS_PER_MINUTE),
		("gather-rate", "gathers", gathers, MAX_GATHERS_PER_MINUTE),
		("refuse-rate", "refusals", refuses, MAX_REFUSES_PER_MINUTE),
	] {
		times.sort_by(f64::total_cmp);
		let n = busiest_minute(&times);
		if n > max {
			issue(rule, format!("{n} {what} in one minute"));
		}
	}
	issues
}

#[cfg(test)]
mod tests {
	use super::*;
	use crate::record::decode_chunk;

	const EPOCH: i64 = 1_793_000_000;
	const HEAD: &str = "chunk\t0\t38\t1793000000\tabcdefghij\n";
	const SESSION: &str = "session\t0\tabcdefghij\tScourge\tWARRIOR\tHorde\t2\t12\tenUS\t70532\t11508\t3\t\t2.0.0\t\t\n";

	fn chunk(body: &str) -> Chunk {
		decode_chunk(&format!("{HEAD}{SESSION}{body}")).unwrap()
	}

	fn ctx() -> Context {
		Context { now: EPOCH + 3600, ..Context::default() }
	}

	fn rules(c: &Chunk, ctx: &Context) -> Vec<&'static str> {
		check_chunk(c, ctx).iter().map(|i| i.rule).collect()
	}

	#[test]
	fn a_real_looking_chunk_passes() {
		let c = chunk(concat!(
			"map\t0\t1420\t3\t1415\t0\t1000\t1000\t0\t0\n",
			"pos\t10\t1420\t1000\t1000\t0\t70\n",
			"pos\t50\t1420\t1300\t1400\t0\t70\n",
			"accept\t60\t364\tc\t1568\t1420\t1300\t1400\t12\t250\t\t2224:1\t\n",
			"kill\t70\t1501\t13\te\t1420\t1300\t1400\t240\t240\t0\t364:1\n",
			"loot\t80\tc\t1501\t1420\t1300\t1400\t\t2589:2\t364:2\n",
			"level\t3000\t13\t1420\t1300\t1400\t3600\n",
		));
		assert_eq!(check_chunk(&c, &ctx()), []);
	}

	#[test]
	fn epoch_within_thirty_days_and_ten_minutes_ahead() {
		let c = chunk("");
		assert_eq!(rules(&c, &Context { now: EPOCH + MAX_AGE, ..ctx() }), [] as [&str; 0]);
		assert_eq!(rules(&c, &Context { now: EPOCH + MAX_AGE + 1, ..ctx() }), ["epoch"]);
		assert_eq!(rules(&c, &Context { now: EPOCH - MAX_AHEAD, ..ctx() }), [] as [&str; 0]);
		assert_eq!(rules(&c, &Context { now: EPOCH - MAX_AHEAD - 1, ..ctx() }), ["epoch"]);
	}

	#[test]
	fn epoch_follows_seq() {
		let c = chunk("");
		// A later seq starting well before the install's highest chunk.
		assert_eq!(rules(&c, &Context { highest: Some((37, EPOCH + MAX_AHEAD + 1)), ..ctx() }), ["epoch"]);
		assert_eq!(rules(&c, &Context { highest: Some((37, EPOCH + 300)), ..ctx() }), [] as [&str; 0]);
	}

	#[test]
	fn no_negative_dt_and_at_most_two_hours() {
		assert!(decode_chunk(&format!("{HEAD}pos\t-5\t1420\t1\t1\t0\t0")).is_err(), "the decoder refuses a negative dt");
		assert_eq!(rules(&chunk("afk\t72000\t1"), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk("afk\t72001\t1"), &ctx()), ["span"]);
	}

	#[test]
	fn seq_within_the_window() {
		let c = chunk("");
		assert_eq!(rules(&c, &Context { highest: Some((38 + SEQ_WINDOW, EPOCH + 9000)), ..ctx() }), [] as [&str; 0]);
		assert_eq!(rules(&c, &Context { highest: Some((39 + SEQ_WINDOW, EPOCH + 9000)), ..ctx() }), ["seq"]);
	}

	#[test]
	fn levels_one_to_sixty() {
		assert_eq!(rules(&chunk("level\t5\t60\t\t\t\t\n"), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk("level\t5\t61\t\t\t\t\n"), &ctx()), ["level"]);
		assert_eq!(rules(&chunk("turnin\t5\t364\tc\t1568\t\t\t\t0\t\t\t\n"), &ctx()), ["level"]);
		let session = SESSION.replace("\t12\tenUS", "\t99\tenUS");
		let c = decode_chunk(&format!("{HEAD}{session}")).unwrap();
		assert_eq!(rules(&c, &ctx()), ["level"]);
	}

	#[test]
	fn kill_xp_bounded_by_level() {
		// Level 12 (from the session), a level 13 mob: at most max_kill_xp(13).
		let bound = max_kill_xp(13);
		assert_eq!(bound, 528);
		assert_eq!(rules(&chunk(&format!("kill\t5\t1501\t13\te\t\t\t\t{bound}\t{bound}\t0\t\n")), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk(&format!("kill\t5\t1501\t13\te\t\t\t\t{}\t\t0\t\n", bound + 1)), &ctx()), ["kill-xp"]);
		// Rested is counted on its own.
		assert_eq!(rules(&chunk(&format!("kill\t5\t1501\t13\te\t\t\t\t10\t{}\t0\t\n", bound + 1)), &ctx()), ["kill-xp"]);
		// A skull mob (-1) uses the player's level.
		assert_eq!(rules(&chunk(&format!("kill\t5\t1501\t-1\tb\t\t\t\t{}\t\t0\t\n", max_kill_xp(12) + 1)), &ctx()), ["kill-xp"]);
	}

	#[test]
	fn kills_and_loot_per_minute() {
		let kills = |n: usize, every: usize| (0..n).map(|i| format!("kill\t{}\t1501\t13\tn\t\t\t\t50\t\t0\t\n", i * every)).collect::<String>();
		assert_eq!(rules(&chunk(&kills(MAX_KILLS_PER_MINUTE, 1)), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk(&kills(MAX_KILLS_PER_MINUTE + 1, 1)), &ctx()), ["kill-rate"]);
		// Spread over more than a minute: 41 kills, one every 1.5 s.
		assert_eq!(rules(&chunk(&kills(MAX_KILLS_PER_MINUTE + 1, 15)), &ctx()), [] as [&str; 0]);
		let loots = |n: usize| (0..n).map(|i| format!("loot\t{i}\tc\t1501\t\t\t\t\t2589:1\t\n")).collect::<String>();
		assert_eq!(rules(&chunk(&loots(MAX_LOOTS_PER_MINUTE)), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk(&loots(MAX_LOOTS_PER_MINUTE + 1)), &ctx()), ["loot-rate"]);
	}

	#[test]
	fn gathers_refusals_and_spawns_per_minute_and_groups_up_to_forty() {
		// n records of `rec` (its kind, then its fields), one a second.
		let many = |n: usize, rec: &str| {
			let (kind, fields) = rec.split_once('\t').unwrap();
			(0..n).map(|i| format!("{kind}\t{}\t{fields}\n", i * 10)).collect::<String>()
		};
		let gather = "gather\t1617\t1420\t1300\t1400\th\t182\t57";
		let refuse = "refuse\t1420\t1300\t1400\tc\t1568\tERR_QUEST_NEED_PREREQS";
		let spawn = "spawn\t1501\t000043F59F\t1420\t1300\t1400";
		assert_eq!(rules(&chunk(&many(MAX_GATHERS_PER_MINUTE, gather)), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk(&many(MAX_GATHERS_PER_MINUTE + 1, gather)), &ctx()), ["gather-rate"]);
		assert_eq!(rules(&chunk(&many(MAX_REFUSES_PER_MINUTE, refuse)), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk(&many(MAX_REFUSES_PER_MINUTE + 1, refuse)), &ctx()), ["refuse-rate"]);
		assert_eq!(rules(&chunk(&many(MAX_KILLS_PER_MINUTE + 1, spawn)), &ctx()), ["kill-rate"]);
		assert_eq!(rules(&chunk("group\t5\t40\t1\n"), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk("group\t5\t41\t1\n"), &ctx()), ["group"]);
		assert_eq!(rules(&chunk("gather\t5\t1000000\t\t\t\th\t182\t57\n"), &ctx()), ["id"]);
	}

	#[test]
	fn ids_below_a_million() {
		assert_eq!(rules(&chunk("complete\t5\t999999\n"), &ctx()), [] as [&str; 0]);
		assert_eq!(rules(&chunk("complete\t5\t1000000\n"), &ctx()), ["id"]);
		assert_eq!(rules(&chunk("kill\t5\t1000000\t13\tn\t\t\t\t50\t\t0\t\n"), &ctx()), ["id"]);
		assert_eq!(rules(&chunk("loot\t5\tc\t1501\t\t\t\t\t2589:1;1234567:1\t\n"), &ctx()), ["id"]);
		assert_eq!(rules(&chunk("offer\t5\tc\t1568\t\t\t\t364;5000000\t\t\t\n"), &ctx()), ["id"]);
		assert_eq!(rules(&chunk("death\t5\t\t\t\t2000000\t15\n"), &ctx()), ["id"]);
	}

	#[test]
	fn position_jumps() {
		// Map 1420 is 4518.75 x 3012.5 yd: 20% across in 1 s is 904 yd/s, and back again.
		let jump = "pos\t10\t1420\t1000\t1000\t0\t70\npos\t20\t1420\t3000\t1000\t0\t70\n";
		let hack = "pos\t10\t1420\t1000\t1000\t0\t70\npos\t20\t1420\t3000\t1000\t0\t70\npos\t30\t1420\t1000\t1000\t0\t70\n";
		assert_eq!(rules(&chunk(hack), &ctx()), ["speed"]);
		// One jump alone is a teleport the game made.
		assert_eq!(rules(&chunk(jump), &ctx()), [] as [&str; 0]);
		// 2% across in 3 s is 30 yd/s.
		assert_eq!(rules(&chunk("pos\t10\t1420\t1000\t1000\t0\t70\npos\t40\t1420\t1200\t1000\t0\t70\n"), &ctx()), [] as [&str; 0]);
		// An uploader's own map record changes nothing: sizes come from the canonical table.
		let tiny = "map\t0\t1420\t3\t1415\t0\t1\t1\t0\t0\n";
		assert_eq!(rules(&chunk(&format!("{tiny}{hack}")), &ctx()), ["speed"]);
		// A map not in the table: nothing to measure, whatever its map record says.
		let unknown = "map\t0\t99999\t3\t1415\t0\t1000\t1000\t0\t0\npos\t10\t99999\t1000\t1000\t0\t70\npos\t20\t99999\t3000\t1000\t0\t70\npos\t30\t99999\t1000\t1000\t0\t70\n";
		assert_eq!(rules(&chunk(unknown), &ctx()), [] as [&str; 0]);
		// A taxi, death or zone change in between starts the measure again.
		for between in ["taxi\t25\t1\t2\n", "death\t25\t\t\t\t\t\n", "zone\t25\t1420\t2000\t1000\tDurotar\t\n"] {
			let c = chunk(&format!("{jump}{between}pos\t30\t1420\t1000\t1000\t0\t70\n"));
			assert_eq!(rules(&c, &ctx()), [] as [&str; 0], "{between}");
		}
		// Another map in between is not a jump on one map.
		assert_eq!(rules(&chunk("pos\t10\t1420\t1000\t1000\t0\t70\npos\t15\t1411\t5000\t5000\t0\t70\npos\t20\t1420\t1000\t1100\t0\t70\n"), &ctx()), [] as [&str; 0]);
	}

	#[test]
	fn teleports_the_game_makes_pass() {
		// Released after a death: dead at the corpse, then a ghost at the spirit healer 345 yd away
		// 3.2 s later (Dun Morogh, 1426; a recorded case the old rule withheld).
		let release = "death\t1969\t1426\t4112\t4958\t271530\t8\npos\t2009\t1426\t4112\t4958\t36\t0\npos\t2041\t1426\t4711\t5501\t32\t88\npos\t2081\t1426\t4711\t5408\t32\t88\n";
		assert_eq!(rules(&chunk(release), &ctx()), [] as [&str; 0]);
		// The Rut'theran portal to Darnassus: 2,022 yd across Teldrassil (1438) in 2.1 s.
		let portal = "pos\t1694\t1438\t5621\t9067\t0\t71\npos\t1734\t1438\t5604\t8992\t0\t71\npos\t1755\t1438\t2360\t5554\t16\t25\npos\t1765\t1438\t2370\t5560\t0\t71\n";
		assert_eq!(rules(&chunk(portal), &ctx()), [] as [&str; 0]);
		// Two teleports in one chunk, with walking between, still pass; a third is flagged.
		let walk_back = "pos\t1800\t1438\t2380\t5570\t0\t71\npos\t1820\t1438\t5604\t8992\t0\t71\npos\t1830\t1438\t5610\t9000\t0\t71\n";
		assert_eq!(rules(&chunk(&format!("{portal}{walk_back}")), &ctx()), [] as [&str; 0]);
		let again = "pos\t1850\t1438\t2360\t5554\t0\t71\n";
		assert_eq!(rules(&chunk(&format!("{portal}{walk_back}{again}")), &ctx()), ["speed"]);
	}

	#[test]
	fn kills_others_tagged_do_not_count_towards_the_kill_rate() {
		// The launch rush: 60 kills in a minute around the player, 41 of them tagged by others.
		let kill = |t: usize, tapped: u8| format!("kill\t{t}\t1501\t1\tn\t\t\t\t\t\t{tapped}\t\nspawn\t{t}\t1501\t00{t:04X}\t\t\t\n");
		let rush: String = (0..60).map(|i| kill(i * 10, u8::from(i % 3 != 0))).collect();
		assert_eq!(rules(&chunk(&rush), &ctx()), [] as [&str; 0]);
		// 41 of the player's own in a minute are too many, with or without others' around them.
		let own: String = (0..41).map(|i| kill(i * 10, 0)).collect();
		assert_eq!(rules(&chunk(&own), &ctx()), ["kill-rate"]);
		assert_eq!(rules(&chunk(&format!("{own}{rush}")), &ctx()), ["kill-rate"]);
	}

	#[test]
	fn no_overflow_at_the_extremes() {
		let c = decode_chunk(&format!("chunk\t0\t{}\t{}\tabcdefghij\n", u64::MAX / 2, i64::MAX)).unwrap();
		// Saturating: `now + MAX_AHEAD` does not wrap around to flag the epoch.
		let ctx = Context { now: i64::MAX, highest: Some((u64::MAX, i64::MAX)) };
		assert_eq!(rules(&c, &ctx), ["seq"]);
		assert_eq!(rules(&c, &Context { now: i64::MIN, highest: None }), ["epoch"]);
	}
}
