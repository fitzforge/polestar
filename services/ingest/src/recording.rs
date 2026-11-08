//! Decoding uploaded chunks with the recording library: every chunk is validated whole, checked
//! for plausibility, and the server keeps only counts beside the text. Chunks are decoded one at
//! a time and the decoded form is dropped straight away, so an upload never holds more than one.

use std::collections::{BTreeMap, BTreeSet};

use polestar_recording::api::{Rejected, UploadChunk, MAX_CHUNK_BYTES, MAX_CHUNK_RECORDS, MAX_UNKNOWN_RECORDS};
use polestar_recording::plausible::{self, check_chunk};
use polestar_recording::record::{decode_chunk, Kind};

use crate::db::{NewChunk, Prepared};

/// Longest rejection reason sent back; library messages are short, this only bounds them.
const MAX_REASON: usize = 300;

/// Decodes one uploaded chunk and runs the plausibility checks on it against `ctx` (the
/// install as the server holds it plus the upload's chunks before this one), which it then
/// updates. A chunk is stored only when it is within the size caps, every known record in it is
/// well formed and its own `chunk` record carries the seq it was uploaded under. Records of
/// unknown kinds are dropped from the stored text. Chunks from a build below `min_build`, or with
/// no `session` record saying which build, are stored flagged.
pub fn prepare(upload: UploadChunk, min_build: u32, ctx: &mut plausible::Context) -> Prepared {
	if upload.text.len() > MAX_CHUNK_BYTES {
		return reject(upload.seq, format!("chunk over {} KiB", MAX_CHUNK_BYTES / 1024), "chunk over the size cap".into());
	}
	// The `chunk` header is not a record.
	let records = upload.text.split('\n').filter(|l| !l.is_empty()).count().saturating_sub(1);
	if records > MAX_CHUNK_RECORDS {
		return reject(upload.seq, format!("chunk has {records} records, at most {MAX_CHUNK_RECORDS}"), "chunk over the record cap".into());
	}
	let decoded = match decode_chunk(&upload.text) {
		Ok(c) => c,
		Err(e) => {
			let class = match e.kind {
				Some(kind) => format!("{kind}: {}", e.message),
				None => e.message.clone(),
			};
			return reject(upload.seq, e.to_string(), reason_class(&class));
		}
	};
	if decoded.seq != upload.seq {
		return reject(upload.seq, format!("chunk record says seq {}", decoded.seq), "chunk record says another seq".into());
	}
	if decoded.skipped_unknown as usize > MAX_UNKNOWN_RECORDS {
		return reject(upload.seq, format!("chunk has {} records of unknown kinds, at most {MAX_UNKNOWN_RECORDS}", decoded.skipped_unknown), "too many records of unknown kinds".into());
	}
	let session = decoded.session();
	let build = session.and_then(|s| s.int("build")).and_then(|b| u32::try_from(b).ok());
	let locale = session.map(|s| s.get("locale")).filter(|l| !l.is_empty()).map(str::to_owned);
	let mut kinds: BTreeMap<String, u64> = BTreeMap::new();
	for record in &decoded.records {
		*kinds.entry(record.kind.as_str().to_owned()).or_default() += 1;
	}
	let quests = quests_of(&decoded);
	let suspect = check_chunk(&decoded, ctx).iter().map(ToString::to_string).collect();
	if ctx.highest.is_none_or(|(seq, _)| decoded.seq > seq) {
		ctx.highest = Some((decoded.seq, decoded.epoch));
	}
	let text = if decoded.skipped_unknown > 0 { strip_unknown(&upload.text) } else { upload.text };
	let flagged = build.is_none_or(|b| b < min_build);
	// Compressed here, outside the database lock.
	let ztext = crate::db::compress(&text);
	Prepared::Ok(Box::new(NewChunk { seq: upload.seq, epoch: decoded.epoch, ztext, text_len: text.len(), build, locale, flagged, suspect, kinds, quests }))
}

/// The quests a chunk's records name: the kinds whose `q` is a single quest id; ids no quest has
/// are not counted.
fn quests_of(decoded: &polestar_recording::record::Chunk) -> BTreeSet<u32> {
	let mut quests = BTreeSet::new();
	for record in &decoded.records {
		if matches!(record.kind, Kind::Detail | Kind::Text | Kind::Accept | Kind::Objectives | Kind::Progress | Kind::Complete | Kind::Turnin | Kind::Abandon | Kind::Escort) {
			if let Some(q) = record.int("q").filter(|q| (1..plausible::MAX_ID as i64).contains(q)).and_then(|q| u32::try_from(q).ok()) {
				quests.insert(q);
			}
		}
	}
	quests
}

/// The plausibility rules a held suspect chunk is judged by again ([`recheck`]): the ones that need
/// nothing but the chunk itself. The others (`seq`, and `epoch` against the install's other chunks)
/// depend on what the server held when it arrived, so a chunk they flagged stays suspect.
pub const RECHECKED_RULES: [&str; 2] = ["speed", "kill-rate"];

/// A held suspect chunk judged by the current rules, as if it arrived at `received`: its quests when
/// it passes now, None when it stays suspect. Only a chunk whose every reason (`reasons`, one per
/// line, `rule: detail`) is one of [`RECHECKED_RULES`] can pass.
pub fn recheck(text: &str, received: i64, reasons: &str) -> Option<BTreeSet<u32>> {
	if !reasons.lines().all(|l| RECHECKED_RULES.contains(&l.split(':').next().unwrap_or("").trim())) {
		return None;
	}
	let decoded = decode_chunk(text).ok()?;
	check_chunk(&decoded, &plausible::Context { now: received, highest: None }).is_empty().then(|| quests_of(&decoded))
}

/// The chunk text without its records of unknown kinds (the `chunk` header stays first).
fn strip_unknown(text: &str) -> String {
	let mut out = String::with_capacity(text.len());
	for (i, line) in text.split('\n').filter(|l| !l.is_empty()).enumerate() {
		let kind = line.split('\t').next().unwrap_or("");
		if i == 0 || Kind::parse(kind).is_some() {
			out.push_str(line);
			out.push('\n');
		}
	}
	out
}

/// Longest reason class kept, in bytes.
const MAX_CLASS: usize = 120;

/// A rejection reason without what the uploader sent: the quoted value (`'-300'`, a list item;
/// the library quotes at most one, which may itself hold a `'`) is dropped from the first quote
/// to the last, and numbers become `N`, so the class names the rule and never a player's data,
/// and one rule always counts under one class (`turnin: field money: bad value`).
pub fn reason_class(reason: &str) -> String {
	let kept = match (reason.find('\''), reason.rfind('\'')) {
		(Some(a), Some(b)) if a < b => format!("{}{}", &reason[..a], &reason[b + 1..]),
		(Some(a), _) => reason[..a].to_string(),
		_ => reason.to_string(),
	};
	let mut out = String::with_capacity(kept.len().min(MAX_CLASS));
	let mut digits = false;
	for c in kept.chars() {
		let piece = if c.is_ascii_digit() {
			if digits {
				continue;
			}
			digits = true;
			'N'
		} else {
			digits = false;
			if c.is_control() || (c == ' ' && out.ends_with(' ')) {
				continue;
			}
			c
		};
		if out.len() + piece.len_utf8() > MAX_CLASS {
			break;
		}
		out.push(piece);
	}
	out.trim().to_string()
}

fn reject(seq: u64, mut reason: String, class: String) -> Prepared {
	if reason.len() > MAX_REASON {
		let mut end = MAX_REASON;
		while !reason.is_char_boundary(end) {
			end -= 1;
		}
		reason.truncate(end);
	}
	Prepared::Rejected(Rejected { seq, reason }, class)
}

#[cfg(test)]
mod tests {
	use super::*;

	const HEAD: &str = "chunk\t0\t1\t1793000000\tabcdefghij\n";

	fn prep(text: String) -> Prepared {
		prepare(UploadChunk { seq: 1, text }, 0, &mut plausible::Context { now: 1_793_000_100, highest: None })
	}

	#[test]
	fn caps_chunk_bytes_records_and_unknown_kinds() {
		let afk = |n: usize| "afk\t1\t1\n".repeat(n);
		assert!(matches!(prep(format!("{HEAD}{}", afk(MAX_CHUNK_RECORDS))), Prepared::Ok(_)));
		let Prepared::Rejected(r, class) = prep(format!("{HEAD}{}", afk(MAX_CHUNK_RECORDS + 1))) else { panic!("over the record cap") };
		assert!(r.reason.contains("records"), "{}", r.reason);
		assert_eq!(class, "chunk over the record cap");
		let big = format!("{HEAD}{}", "x".repeat(MAX_CHUNK_BYTES));
		let Prepared::Rejected(r, _) = prep(big) else { panic!("over 64 KiB") };
		assert!(r.reason.contains("KiB"), "{}", r.reason);
		let Prepared::Rejected(r, _) = prep(format!("{HEAD}{}", "x\n".repeat(MAX_UNKNOWN_RECORDS + 1))) else { panic!("too many unknown") };
		assert!(r.reason.contains("unknown"), "{}", r.reason);
	}

	#[test]
	fn a_reject_is_counted_by_its_rule_never_by_what_was_sent() {
		// The player sees the full reason; the count keeps only the rule.
		let Prepared::Rejected(r, class) = prep(format!("{HEAD}afk\t0\t1\nturnin\t412\t2945\to\t142487\t\t\t\t31\t-5\t0\t\n")) else { panic!("rejected") };
		assert_eq!((r.reason.as_str(), class.as_str()), ("record 3 (turnin): field xp: bad value '-5'", "turnin: field xp: bad value"));
		for (reason, want) in [
			("field race: bad value 'Mak'gora Champion'", "field race: bad value"),
			("list item 'Ana Smith:12:x:y' has 4 parts, expected 3", "list item has N parts, expected N"),
			("position: bad position '10001 5' (0..=10000)", "position: bad position (N..=N)"),
			("field text: bad value 'unclosed", "field text: bad value"),
			("text longer than 4000 bytes", "text longer than N bytes"),
		] {
			assert_eq!(reason_class(reason), want, "{reason}");
		}
		assert!(reason_class(&"x".repeat(500)).len() <= MAX_CLASS);
	}

	#[test]
	fn unknown_kinds_are_not_stored() {
		let Prepared::Ok(c) = prep(format!("{HEAD}newkind\t1\tName\nafk\t2\t1\n\nother\t3\n")) else { panic!("stored") };
		let text = |c: &NewChunk| String::from_utf8(zstd::stream::decode_all(&c.ztext[..]).unwrap()).unwrap();
		assert_eq!(text(&c), format!("{HEAD}afk\t2\t1\n"));
		let Prepared::Ok(c) = prep(format!("{HEAD}afk\t2\t1")) else { panic!("stored") };
		assert_eq!(text(&c), format!("{HEAD}afk\t2\t1"), "a chunk of known kinds is stored as sent");
	}

	#[test]
	fn quest_ids_no_quest_has_are_not_counted() {
		let Prepared::Ok(c) = prep(format!("{HEAD}complete\t0\t364\ncomplete\t1\t{}\ncomplete\t2\t0\n", plausible::MAX_ID)) else { panic!("stored") };
		assert_eq!(c.quests, BTreeSet::from([364]));
	}

	#[test]
	fn a_turnin_that_costs_money_is_stored() {
		// Grime-Encrusted Ring costs 3 silver to hand in: the game reports money -300. Rejected whole
		// before (a 0.3.5 player's "field money: bad value '-300'").
		let Prepared::Ok(c) = prep(format!("{HEAD}accept\t0\t2945\ti\t9326\t\t\t\t31\t2700\t\t\t\nturnin\t412\t2945\to\t142487\t\t\t\t31\t2700\t-300\t\n")) else { panic!("stored") };
		assert_eq!((c.quests.clone(), c.suspect.len()), (BTreeSet::from([2945]), 0));
	}

	#[test]
	fn a_held_chunk_passes_again_only_when_its_reasons_are_rechecked_rules_and_it_passes_them() {
		// One portal jump (Teldrassil, 1438): withheld by the old speed rule, plausible now.
		let portal = format!("{HEAD}accept\t0\t364\tc\t1568\t\t\t\t12\t250\t\t\t\npos\t10\t1438\t5604\t8992\t0\t71\npos\t30\t1438\t2360\t5554\t16\t25\n");
		assert_eq!(recheck(&portal, 1_793_000_100, "speed: 2022 yd in 2.0 s on map 1438"), Some(BTreeSet::from([364])));
		// A reason only the upload's context can judge keeps it suspect.
		assert_eq!(recheck(&portal, 1_793_000_100, "speed: 2022 yd in 2.0 s on map 1438\nepoch: seq 2 starts at 1 but seq 3 at 2"), None);
		// Still implausible under the current rules: a jump there and straight back.
		let hack = format!("{portal}pos\t50\t1438\t5604\t8992\t0\t71\n");
		assert_eq!(recheck(&hack, 1_793_000_100, "speed: x"), None);
		// The age rule is judged at the chunk's arrival, not today.
		assert_eq!(recheck(&portal, 1_793_000_100 + 40 * 86_400, "speed: x"), None);
	}
}
