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
/// Quest, creature, object and item ids are below this.
pub const MAX_ID: u64 = 1_000_000;
/// Fastest believable movement between two `pos` records on one map, in yards a second (a
/// mounted player runs 14; taxis fly about 32). Measured on the canonical map sizes of
/// [`crate::maps_table`] only, never on sizes an uploader sends; other maps are not checked.
pub const MAX_YARDS_PER_SECOND: f64 = 100.0;

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
	/// Short rule name (`epoch`, `span`, `seq`, `level`, `kill-xp`, `kill-rate`, `loot-rate`, `id`,
	/// `speed`).
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
	// The last `pos`: (map, x, y in percent, t).
	let mut last_pos: Option<(u32, f64, f64, f64)> = None;
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
				kills.push(r.t);
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
			Kind::Taxi | Kind::Land | Kind::Death | Kind::Revive | Kind::Zone | Kind::Ride | Kind::Enter | Kind::Cast => last_pos = None,
			Kind::Pos => {
				let Some(p) = r.pos() else {
					last_pos = None;
					continue;
				};
				let (x, y) = p.percent();
				if let (Some((map, lx, ly, lt)), Some((w, h))) = (last_pos, maps_table::size(p.map)) {
					if map == p.map {
						let yards = ((x - lx) * w / 100.0).hypot((y - ly) * h / 100.0);
						let seconds = (r.t - lt).max(1.0);
						if yards / seconds > MAX_YARDS_PER_SECOND {
							issue("speed", format!("{yards:.0} yd in {:.1} s on map {map}", r.t - lt));
						}
					}
				}
				last_pos = Some((p.map, x, y, r.t));
			}
			_ => {}
		}
	}
	kills.sort_by(f64::total_cmp);
	loots.sort_by(f64::total_cmp);
	let k = busiest_minute(&kills);
	if k > MAX_KILLS_PER_MINUTE {
		issue("kill-rate", format!("{k} kills in one minute"));
	}
	let l = busiest_minute(&loots);
	if l > MAX_LOOTS_PER_MINUTE {
		issue("loot-rate", format!("{l} loot windows in one minute"));
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
		// Map 1420 is 4518.75 x 3012.5 yd: 20% across in 1 s is 904 yd/s.
		let jump = "pos\t10\t1420\t1000\t1000\t0\t70\npos\t20\t1420\t3000\t1000\t0\t70\n";
		assert_eq!(rules(&chunk(jump), &ctx()), ["speed"]);
		// 2% across in 3 s is 30 yd/s.
		assert_eq!(rules(&chunk("pos\t10\t1420\t1000\t1000\t0\t70\npos\t40\t1420\t1200\t1000\t0\t70\n"), &ctx()), [] as [&str; 0]);
		// An uploader's own map record changes nothing: sizes come from the canonical table.
		let tiny = "map\t0\t1420\t3\t1415\t0\t1\t1\t0\t0\n";
		assert_eq!(rules(&chunk(&format!("{tiny}{jump}")), &ctx()), ["speed"]);
		// A map not in the table: nothing to measure, whatever its map record says.
		let unknown = "map\t0\t99999\t3\t1415\t0\t1000\t1000\t0\t0\npos\t10\t99999\t1000\t1000\t0\t70\npos\t20\t99999\t3000\t1000\t0\t70\n";
		assert_eq!(rules(&chunk(unknown), &ctx()), [] as [&str; 0]);
		// A taxi, death or zone change in between.
		for between in ["taxi\t15\t1\t2\n", "death\t15\t\t\t\t\t\n", "zone\t15\t1420\t2000\t1000\tDurotar\t\n"] {
			let c = chunk(&format!("pos\t10\t1420\t1000\t1000\t0\t70\n{between}pos\t20\t1420\t3000\t1000\t0\t70\n"));
			assert_eq!(rules(&c, &ctx()), [] as [&str; 0], "{between}");
		}
		// Another map in between is not a jump on one map.
		assert_eq!(rules(&chunk("pos\t10\t1420\t1000\t1000\t0\t70\npos\t15\t1411\t5000\t5000\t0\t70\npos\t20\t1420\t1000\t1100\t0\t70\n"), &ctx()), [] as [&str; 0]);
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
