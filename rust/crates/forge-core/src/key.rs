//! Content keys: a hash of input bytes, never of source text or timestamps. SHA-1 hex, the
//! digest the JS tools use (`requires.js fileHash`, `world.js worldInputs`), so a key computed
//! here equals the JS one for the same bytes.

/// SHA-1 hex digest of `bytes`.
pub fn content_key(bytes: &[u8]) -> String {
	sha1_smol::Sha1::from(bytes).digest().to_string()
}

/// Incremental content key over several inputs.
#[derive(Default, Clone)]
pub struct ContentHasher(sha1_smol::Sha1);

impl ContentHasher {
	pub fn new() -> Self {
		Self(sha1_smol::Sha1::new())
	}
	pub fn update(&mut self, bytes: &[u8]) -> &mut Self {
		self.0.update(bytes);
		self
	}
	pub fn hex(&self) -> String {
		self.0.digest().to_string()
	}
}

#[cfg(test)]
mod tests {
	#[test]
	fn sha1_hex() {
		assert_eq!(super::content_key(b"abc"), "a9993e364706816aba3e25717850c26c9cd0d89d");
		let mut h = super::ContentHasher::new();
		h.update(b"a").update(b"bc");
		assert_eq!(h.hex(), "a9993e364706816aba3e25717850c26c9cd0d89d");
	}
}
