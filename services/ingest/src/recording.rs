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
		return reject(upload.seq, format!("chunk over {} KiB", MAX_CHUNK_BYTES / 1024));
	}
	// The `chunk` header is not a record.
	let records = upload.text.split('\n').filter(|l| !l.is_empty()).count().saturating_sub(1);
	if records > MAX_CHUNK_RECORDS {
		return reject(upload.seq, format!("chunk has {records} records, at most {MAX_CHUNK_RECORDS}"));
	}
	let decoded = match decode_chunk(&upload.text) {
		Ok(c) => c,
		Err(e) => return reject(upload.seq, e.to_string()),
	};
	if decoded.seq != upload.seq {
		return reject(upload.seq, format!("chunk record says seq {}", decoded.seq));
	}
	if decoded.skipped_unknown as usize > MAX_UNKNOWN_RECORDS {
		return reject(upload.seq, format!("chunk has {} records of unknown kinds, at most {MAX_UNKNOWN_RECORDS}", decoded.skipped_unknown));
	}
	let session = decoded.session();
	let build = session.and_then(|s| s.int("build")).and_then(|b| u32::try_from(b).ok());
	let locale = session.map(|s| s.get("locale")).filter(|l| !l.is_empty()).map(str::to_owned);
	let mut kinds: BTreeMap<String, u64> = BTreeMap::new();
	let mut quests = BTreeSet::new();
	for record in &decoded.records {
		*kinds.entry(record.kind.as_str().to_owned()).or_default() += 1;
		// The kinds whose `q` is a single quest id.
		if matches!(record.kind, Kind::Detail | Kind::Text | Kind::Accept | Kind::Objectives | Kind::Progress | Kind::Complete | Kind::Turnin | Kind::Abandon | Kind::Escort) {
			if let Some(q) = record.int("q").and_then(|q| u32::try_from(q).ok()) {
				quests.insert(q);
			}
		}
	}
	let suspect = check_chunk(&decoded, ctx).iter().map(ToString::to_string).collect();
	if ctx.highest.is_none_or(|(seq, _)| decoded.seq > seq) {
		ctx.highest = Some((decoded.seq, decoded.epoch));
	}
	let text = if decoded.skipped_unknown > 0 { strip_unknown(&upload.text) } else { upload.text };
	let flagged = build.is_none_or(|b| b < min_build);
	Prepared::Ok(Box::new(NewChunk { seq: upload.seq, epoch: decoded.epoch, text, build, locale, flagged, suspect, kinds, quests }))
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

fn reject(seq: u64, mut reason: String) -> Prepared {
	if reason.len() > MAX_REASON {
		let mut end = MAX_REASON;
		while !reason.is_char_boundary(end) {
			end -= 1;
		}
		reason.truncate(end);
	}
	Prepared::Rejected(Rejected { seq, reason })
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
		let Prepared::Rejected(r) = prep(format!("{HEAD}{}", afk(MAX_CHUNK_RECORDS + 1))) else { panic!("over the record cap") };
		assert!(r.reason.contains("records"), "{}", r.reason);
		let big = format!("{HEAD}{}", "x".repeat(MAX_CHUNK_BYTES));
		let Prepared::Rejected(r) = prep(big) else { panic!("over 64 KiB") };
		assert!(r.reason.contains("KiB"), "{}", r.reason);
		let Prepared::Rejected(r) = prep(format!("{HEAD}{}", "x\n".repeat(MAX_UNKNOWN_RECORDS + 1))) else { panic!("too many unknown") };
		assert!(r.reason.contains("unknown"), "{}", r.reason);
	}

	#[test]
	fn unknown_kinds_are_not_stored() {
		let Prepared::Ok(c) = prep(format!("{HEAD}newkind\t1\tName\nafk\t2\t1\n\nother\t3\n")) else { panic!("stored") };
		assert_eq!(c.text, format!("{HEAD}afk\t2\t1\n"));
		let Prepared::Ok(c) = prep(format!("{HEAD}afk\t2\t1")) else { panic!("stored") };
		assert_eq!(c.text, format!("{HEAD}afk\t2\t1"), "a chunk of known kinds is stored as sent");
	}
}
