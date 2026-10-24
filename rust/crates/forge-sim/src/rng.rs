//! A deterministic generator (SplitMix64) and a normal draw on the pure-Rust `libm`, so native
//! and wasm runs draw the same numbers.

#[derive(Clone, Debug)]
pub struct Rng(u64);

impl Rng {
	pub fn new(seed: u64) -> Rng {
		Rng(seed ^ 0x9e37_79b9_7f4a_7c15)
	}
	#[allow(clippy::should_implement_trait)]
	pub fn next(&mut self) -> u64 {
		self.0 = self.0.wrapping_add(0x9e37_79b9_7f4a_7c15);
		let mut z = self.0;
		z = (z ^ (z >> 30)).wrapping_mul(0xbf58_476d_1ce4_e5b9);
		z = (z ^ (z >> 27)).wrapping_mul(0x94d0_49bb_1331_11eb);
		z ^ (z >> 31)
	}
	pub fn below(&mut self, n: usize) -> usize {
		if n == 0 {
			0
		} else {
			(self.next() % n as u64) as usize
		}
	}
	/// Uniform in [0, 1).
	pub fn unit(&mut self) -> f64 {
		(self.next() >> 11) as f64 / (1u64 << 53) as f64
	}
	pub fn chance(&mut self, p: f64) -> bool {
		self.unit() <= p
	}
	/// Standard normal (Box-Muller, one of the pair).
	pub fn normal(&mut self) -> f64 {
		let u = 1.0 - self.unit();
		let v = self.unit();
		libm::sqrt(-2.0 * libm::log(u)) * libm::cos(2.0 * std::f64::consts::PI * v)
	}
}
