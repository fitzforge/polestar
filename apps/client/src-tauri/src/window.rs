//! The main window opens at the size the design is laid out for. It can be
//! made larger (a tiling window manager sizes it to its tile) but not smaller,
//! and it does not maximize. On a screen too small for the design (a 1366×768
//! laptop at 125% or 150% scaling), it opens as large as the screen's work
//! area allows instead, that size is its minimum, and the pages' narrow
//! layouts take over.

use tauri::{AppHandle, LogicalSize, Manager, Monitor};

/// The design's size, in logical pixels.
pub const SIZE: (f64, f64) = (880.0, 600.0);
/// Room kept between the window and the edges of the work area.
const MARGIN: f64 = 24.0;

/// The size that fits `SIZE` into a work area of `area` logical pixels.
pub fn fit(area: (f64, f64)) -> (f64, f64) {
	(SIZE.0.min((area.0 - MARGIN).floor()), SIZE.1.min((area.1 - MARGIN).floor()))
}

/// How the window may be sized, for a work area of `area` logical pixels
/// (`None`: no monitor was found).
#[derive(Debug, PartialEq)]
pub struct Limits {
	/// The size it opens at.
	pub open: (f64, f64),
	/// The smallest it can be made; it has no largest.
	pub min: (f64, f64),
	pub resizable: bool,
	pub maximizable: bool,
}

pub fn limits(area: Option<(f64, f64)>) -> Limits {
	let open = area.map_or(SIZE, fit);
	Limits { open, min: open, resizable: true, maximizable: false }
}

pub fn setup(app: &AppHandle) {
	let Some(window) = app.get_webview_window("main") else { return };
	let monitor: Option<Monitor> = window.current_monitor().ok().flatten().or_else(|| window.primary_monitor().ok().flatten());
	let area = monitor.map(|m| {
		let scale = m.scale_factor();
		let size = m.work_area().size;
		(f64::from(size.width) / scale, f64::from(size.height) / scale)
	});
	let l = limits(area);
	let _ = window.set_resizable(l.resizable);
	let _ = window.set_maximizable(l.maximizable);
	let _ = window.set_min_size(Some(LogicalSize::new(l.min.0, l.min.1)));
	if l.open != SIZE {
		let _ = window.set_size(LogicalSize::new(l.open.0, l.open.1));
		let _ = window.center();
	}
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn keeps_its_size_where_it_fits_and_shrinks_where_it_does_not() {
		assert_eq!(fit((1920.0, 1040.0)), SIZE);
		// 1366×768 at 125% with a 40px taskbar: 1093×582 logical.
		assert_eq!(fit((1092.8, 582.4)), (880.0, 558.0));
		// At 150%: 911×485.
		assert_eq!(fit((910.7, 485.3)), (880.0, 461.0));
	}

	#[test]
	fn can_grow_but_not_shrink_below_its_opening_size_and_never_maximizes() {
		let big = limits(Some((1920.0, 1040.0)));
		assert_eq!(big, Limits { open: SIZE, min: SIZE, resizable: true, maximizable: false });
		// A small work area: it opens smaller, and that is its minimum.
		let small = limits(Some((910.7, 485.3)));
		assert_eq!((small.open, small.min), ((880.0, 461.0), (880.0, 461.0)));
		assert!(small.resizable && !small.maximizable);
		// No monitor found: the design's size.
		assert_eq!(limits(None), big);
	}

	/// The window is created from these before `setup` runs: a window that is not
	/// resizable there asks for one fixed size, which tiling window managers keep
	/// floating (#902).
	#[test]
	fn every_platform_config_opens_a_resizable_window_that_does_not_maximize() {
		for (name, text) in [
			("tauri.conf.json", include_str!("../tauri.conf.json")),
			("tauri.linux.conf.json", include_str!("../tauri.linux.conf.json")),
			("tauri.macos.conf.json", include_str!("../tauri.macos.conf.json")),
			("tauri.windows.conf.json", include_str!("../tauri.windows.conf.json")),
		] {
			let conf: serde_json::Value = serde_json::from_str(text).unwrap();
			let main = &conf["app"]["windows"][0];
			assert_eq!(main["label"], "main", "{name}");
			assert_eq!(main["resizable"], true, "{name}");
			assert_eq!(main["maximizable"], false, "{name}");
			assert_eq!((main["width"].as_f64(), main["height"].as_f64()), (Some(SIZE.0), Some(SIZE.1)), "{name}");
			assert!(main.get("maxWidth").is_none() && main.get("maxHeight").is_none(), "{name}: no largest size");
		}
	}
}
