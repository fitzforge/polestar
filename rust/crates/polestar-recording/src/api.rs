//! The upload API's bodies (docs/RECORDING.md "Upload API"). Times are unix seconds.

use std::collections::BTreeMap;

use serde::{Deserialize, Serialize};

/// Largest `POST /v1/upload` body, in bytes.
pub const MAX_UPLOAD_BYTES: usize = 2 * 1024 * 1024;
/// Most chunks in one upload.
pub const MAX_UPLOAD_CHUNKS: usize = 256;
/// Largest chunk text, in bytes: the server rejects a bigger chunk (the addon closes chunks at
/// 16 KiB), and uploaders skip one rather than truncate it.
pub const MAX_CHUNK_BYTES: usize = 64 * 1024;
/// Most records in one chunk: its non-empty lines after the `chunk` header, of known kinds and
/// unknown ones alike.
pub const MAX_CHUNK_RECORDS: usize = 4096;
/// Most records of kinds the server does not know in one chunk. The server stores a chunk
/// without them.
pub const MAX_UNKNOWN_RECORDS: usize = 64;

/// The server's default proof-of-work difficulty (leading zero bits).
pub const POW_BITS: u32 = 22;

/// `POST /v1/register` with `{}`: a challenge to solve. `challenge` is 32 hex digits.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct RegisterChallenge {
	pub challenge: String,
	/// Leading zero bits SHA-256(`challenge:solution`) must have.
	pub difficulty: u32,
	/// Unix seconds after which the challenge is refused.
	pub expires: i64,
}

/// `POST /v1/register` with a solved challenge. `solution` is a u64 in decimal.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct RegisterSolution {
	pub challenge: String,
	pub solution: String,
}

/// The answer to a solved challenge: the bearer token (64 hex digits), made by the server.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct RegisterResponse {
	pub token: String,
}

/// Leading zero bits of a hash.
fn leading_zero_bits(hash: &[u8]) -> u32 {
	let mut bits = 0;
	for b in hash {
		if *b == 0 {
			bits += 8;
		} else {
			return bits + b.leading_zeros();
		}
	}
	bits
}

/// Whether `solution` solves `challenge`: SHA-256(`challenge` + ":" + `solution` in decimal) has
/// at least `difficulty` leading zero bits.
pub fn pow_ok(challenge: &str, solution: u64, difficulty: u32) -> bool {
	use sha2::{Digest, Sha256};
	let mut h = Sha256::new();
	h.update(challenge.as_bytes());
	h.update(b":");
	h.update(solution.to_string().as_bytes());
	leading_zero_bits(&h.finalize()) >= difficulty
}

/// The smallest solution of `challenge` (about 2^`difficulty` hashes).
pub fn pow_solve(challenge: &str, difficulty: u32) -> u64 {
	(0..=u64::MAX).find(|n| pow_ok(challenge, *n, difficulty)).unwrap_or(u64::MAX)
}

/// `POST /v1/upload`.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct UploadRequest {
	/// The uploader's version.
	pub uploader: String,
	/// The addon install id (`PolestarRecorderDB.install`).
	pub install: String,
	pub chunks: Vec<UploadChunk>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct UploadChunk {
	pub seq: u64,
	pub text: String,
}

#[derive(Clone, Debug, Default, PartialEq, Eq, Serialize, Deserialize)]
pub struct UploadResponse {
	pub accepted: Vec<u64>,
	pub duplicate: Vec<u64>,
	pub rejected: Vec<Rejected>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Rejected {
	pub seq: u64,
	pub reason: String,
}

/// `GET /v1/me`: what the server holds from this token.
#[derive(Clone, Debug, Default, PartialEq, Eq, Serialize, Deserialize)]
pub struct MeResponse {
	pub chunks: u64,
	/// Records by kind (wire names).
	pub records: BTreeMap<String, u64>,
	pub first_upload: Option<i64>,
	pub last_upload: Option<i64>,
}

/// `GET /v1/stats`: public totals.
#[derive(Clone, Debug, Default, PartialEq, Eq, Serialize, Deserialize)]
pub struct Stats {
	pub contributors: u64,
	pub chunks: u64,
	pub records: BTreeMap<String, u64>,
	/// Distinct quests seen.
	pub quests: u64,
	/// The last 30 days, oldest first.
	pub last30: Vec<StatsDay>,
}

#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct StatsDay {
	/// `YYYY-MM-DD` (UTC).
	pub day: String,
	pub chunks: u64,
	pub contributors: u64,
}

/// One line of `GET /v1/export` (NDJSON).
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct ExportLine {
	pub id: i64,
	/// The contributor: 16 hex digits of the token's SHA-256.
	pub contributor: String,
	/// The contributor's registration cohort, 16 hex digits: a random id the server gave every
	/// contributor registered from the same network (IPv4 address, IPv6 /48) on the same UTC
	/// day. Count independent contributors by distinct cohorts. Contributors registered before
	/// cohorts existed each have their own (their `contributor`).
	#[serde(default)]
	pub cohort: String,
	pub install: String,
	pub seq: u64,
	pub received: i64,
	pub text: String,
	/// From a build the server does not accept (stored but flagged).
	#[serde(default)]
	pub flagged: bool,
	/// When the contributor was first seen (unix seconds).
	#[serde(default, rename = "contributorSince")]
	pub contributor_since: i64,
	/// How many chunks the server holds from the contributor (export-eligible or not).
	#[serde(default, rename = "contributorChunks")]
	pub contributor_chunks: u64,
	/// Failed the server's plausibility checks (only exported with `include=suspect`).
	#[serde(default, skip_serializing_if = "std::ops::Not::not")]
	pub suspect: bool,
	/// Why, when `suspect`.
	#[serde(default, rename = "suspectReasons", skip_serializing_if = "Vec::is_empty")]
	pub suspect_reasons: Vec<String>,
}

/// One line of `GET /v1/export/tombstones` (NDJSON): a contributor whose chunks must go from
/// every copy of the export.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct Tombstone {
	/// 16 hex digits, as in [`ExportLine::contributor`].
	pub contributor: String,
	/// Unix seconds.
	pub at: i64,
	/// `deleted` (the contributor deleted its data) or `blocked` (by the maintainer).
	pub why: String,
}

/// One line of `GET /v1/admin/contributors`.
#[derive(Clone, Debug, PartialEq, Eq, Serialize, Deserialize)]
pub struct AdminContributor {
	/// SHA-256 of the token, 64 hex digits.
	pub hash: String,
	#[serde(rename = "firstSeen")]
	pub first_seen: i64,
	#[serde(rename = "lastSeen")]
	pub last_seen: i64,
	pub chunks: u64,
	#[serde(rename = "suspectChunks")]
	pub suspect_chunks: u64,
	pub blocked: bool,
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn proof_of_work() {
		let challenge = "0123456789abcdef0123456789abcdef";
		let n = pow_solve(challenge, 12);
		assert!(pow_ok(challenge, n, 12));
		assert!((0..n).all(|m| !pow_ok(challenge, m, 12)), "the smallest solution");
		assert!(pow_ok(challenge, 7, 0));
		assert_eq!(leading_zero_bits(&[0, 0, 0x10, 0xff]), 19);
		assert_eq!(leading_zero_bits(&[0; 4]), 32);
	}
}
