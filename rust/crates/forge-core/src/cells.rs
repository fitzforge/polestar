//! The 200-yard zone cells the router and the walk tables key by (nav/router.js cellKey,
//! cellXY): stored on disk in the `.cells` files and the walk tables, so nav and world share it.

/// Yards per zone cell (router.js ZONE_CELL).
pub const ZONE_CELL: f64 = 200.0;

/// `(floor(wx / 200) + 512) * 1024 + floor(wy / 200) + 512`.
pub fn cell_key(wx: f64, wy: f64) -> i64 {
	((wx / ZONE_CELL).floor() as i64 + 512) * 1024 + (wy / ZONE_CELL).floor() as i64 + 512
}

/// The cell's (gx, gy) from its key.
pub fn cell_xy(key: i64) -> (i64, i64) {
	(key.div_euclid(1024) - 512, key.rem_euclid(1024) - 512)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn round_trip() {
		let k = cell_key(-8840.6, 489.7);
		assert_eq!(k, (-45 + 512) * 1024 + 2 + 512);
		assert_eq!(cell_xy(k), (-45, 2));
	}
}
