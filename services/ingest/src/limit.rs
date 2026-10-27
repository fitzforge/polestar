//! Request limits: a token bucket per key (a token hash or an IP HMAC), in memory.
//! A restart forgets them, which is fine for limits counted in minutes.

use std::collections::HashMap;
use std::sync::{Mutex, PoisonError};
use std::time::{Duration, Instant};

/// Most buckets kept; a new key past this is refused until pruning makes room.
pub const MAX_KEYS: usize = 50_000;
/// How often buckets that have filled up again are dropped.
const PRUNE_EVERY: Duration = Duration::from_secs(60);

struct Buckets {
	map: HashMap<String, (f64, Instant)>,
	pruned: Instant,
}

pub struct RateLimiter {
	capacity: f64,
	per_second: f64,
	buckets: Mutex<Buckets>,
}

impl RateLimiter {
	/// `requests` per `window`, as a bucket of `requests` refilled evenly.
	pub fn new(requests: u32, window: Duration) -> RateLimiter {
		let capacity = f64::from(requests);
		RateLimiter { capacity, per_second: capacity / window.as_secs_f64(), buckets: Mutex::new(Buckets { map: HashMap::new(), pruned: Instant::now() }) }
	}

	/// Takes one request from `key`'s bucket; false when it is empty (or there is no room for a
	/// new bucket).
	pub fn check(&self, key: &str, now: Instant) -> bool {
		let mut b = self.buckets.lock().unwrap_or_else(PoisonError::into_inner);
		let since = now.saturating_duration_since(b.pruned);
		// Full: try to make room, but scan at most once a second.
		let full = b.map.len() >= MAX_KEYS && !b.map.contains_key(key);
		if since >= PRUNE_EVERY || (full && since >= Duration::from_secs(1)) {
			// A bucket idle this long is full again: dropping it changes nothing.
			let full_after = Duration::from_secs_f64(self.capacity / self.per_second);
			b.map.retain(|_, (_, at)| now.saturating_duration_since(*at) < full_after);
			b.pruned = now;
		}
		if b.map.len() >= MAX_KEYS && !b.map.contains_key(key) {
			return false;
		}
		let (tokens, at) = b.map.entry(key.to_owned()).or_insert((self.capacity, now));
		*tokens = (*tokens + now.saturating_duration_since(*at).as_secs_f64() * self.per_second).min(self.capacity);
		*at = now;
		if *tokens >= 1.0 {
			*tokens -= 1.0;
			true
		} else {
			false
		}
	}

	/// Buckets held.
	pub fn len(&self) -> usize {
		self.buckets.lock().unwrap_or_else(PoisonError::into_inner).map.len()
	}

	pub fn is_empty(&self) -> bool {
		self.len() == 0
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn thirty_per_minute() {
		let limiter = RateLimiter::new(30, Duration::from_secs(60));
		let t0 = Instant::now();
		assert!((0..30).all(|_| limiter.check("a", t0)));
		assert!(!limiter.check("a", t0));
		assert!(limiter.check("b", t0), "buckets are per key");
		assert!(limiter.check("a", t0 + Duration::from_secs(2)), "one request back every two seconds");
		assert!(!limiter.check("a", t0 + Duration::from_secs(2)));
	}

	#[test]
	fn pruned_on_a_timer_and_capped() {
		let limiter = RateLimiter::new(30, Duration::from_secs(60));
		let t0 = Instant::now();
		for i in 0..MAX_KEYS {
			assert!(limiter.check(&i.to_string(), t0));
		}
		assert!(!limiter.check("new", t0), "no room for a new key");
		assert!(limiter.check("1", t0), "known keys still count");
		assert!(limiter.check("new", t0 + Duration::from_secs(61)), "idle buckets pruned after a minute");
		assert_eq!(limiter.len(), 1);
	}
}
