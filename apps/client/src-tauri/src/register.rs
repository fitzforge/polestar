//! The proof of work behind `POST /v1/register` (docs/RECORDING.md "Upload API"): the server
//! hands out a token only for a solved challenge, so every contributor costs some computing time.

use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use std::thread;

use sha2::{Digest, Sha256};

/// The most work the client agrees to do (2^28 hashes, well under a minute on one core); a server
/// asking for more is refused rather than left to spin the CPU.
pub const MAX_DIFFICULTY: u32 = 28;

/// Challenges fetched in a row when the server says the last one expired or was already used.
pub const TRIES: u32 = 3;

/// Whether an answer to a solution means only that the challenge went stale (it expired, or was
/// used, while this PC solved it): a new challenge is worth asking for straight away.
pub fn stale(status: u16, message: &str) -> bool {
	status == 400 && matches!(message, "challenge expired" | "challenge already used")
}

/// How many tries each thread makes between looks at whether another thread has finished.
const BATCH: u64 = 4096;

/// A solution of `challenge`: a number whose SHA-256(`challenge` + ":" + the number in decimal)
/// has at least `difficulty` (at most 128) leading zero bits. Every core searches its own
/// residue class; the smallest number any of them found is returned.
pub fn solve(challenge: &str, difficulty: u32) -> u64 {
	let threads = thread::available_parallelism().map_or(1, |n| n.get()) as u64;
	let mut prefix = Sha256::new();
	prefix.update(challenge.as_bytes());
	prefix.update(b":");
	let done = AtomicBool::new(false);
	let best = AtomicU64::new(u64::MAX);
	thread::scope(|scope| {
		for start in 0..threads {
			let (prefix, done, best) = (&prefix, &done, &best);
			scope.spawn(move || {
				let mut n = start;
				let mut digits = [0u8; 20];
				while !done.load(Ordering::Relaxed) {
					for _ in 0..BATCH {
						let mut h = prefix.clone();
						h.update(decimal(n, &mut digits));
						let hash = h.finalize();
						let head = u128::from_be_bytes(hash[..16].try_into().expect("a SHA-256 is 32 bytes"));
						if head.leading_zeros() >= difficulty {
							best.fetch_min(n, Ordering::Relaxed);
							done.store(true, Ordering::Relaxed);
							return;
						}
						n += threads;
					}
				}
			});
		}
	});
	best.load(Ordering::Relaxed)
}

/// `n` in decimal, written into the end of `buf`.
fn decimal(mut n: u64, buf: &mut [u8; 20]) -> &[u8] {
	let mut i = buf.len();
	loop {
		i -= 1;
		buf[i] = b'0' + (n % 10) as u8;
		n /= 10;
		if n == 0 {
			return &buf[i..];
		}
	}
}

#[cfg(test)]
mod tests {
	use super::*;
	use polestar_recording::api;

	#[test]
	fn solves_a_fixed_challenge_the_way_the_server_checks_it() {
		let challenge = "0123456789abcdef0123456789abcdef";
		let n = solve(challenge, 16);
		assert!(api::pow_ok(challenge, n, 16), "{n} solves it");
		let mut buf = [0u8; 20];
		assert_eq!(decimal(0, &mut buf), b"0");
		assert_eq!(decimal(u64::MAX, &mut buf), u64::MAX.to_string().as_bytes());
	}

	#[test]
	fn only_a_stale_challenge_is_asked_for_again() {
		assert!(stale(400, "challenge expired") && stale(400, "challenge already used"));
		assert!(!stale(400, "wrong solution") && !stale(400, "bad challenge") && !stale(429, "challenge expired"));
	}
}
