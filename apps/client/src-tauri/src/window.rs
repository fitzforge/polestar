//! The main window is one fixed size, the size the design is laid out for:
//! not resizable, not maximizable. On a screen too small for it (a 1366×768
//! laptop at 125% or 150% scaling), it opens as large as the screen's work
//! area allows instead, and the pages' narrow layouts take over.

use tauri::{AppHandle, LogicalSize, Manager, Monitor};

/// The design's size, in logical pixels.
pub const SIZE: (f64, f64) = (880.0, 600.0);
/// Room kept between the window and the edges of the work area.
const MARGIN: f64 = 24.0;

/// The size that fits `SIZE` into a work area of `area` logical pixels.
pub fn fit(area: (f64, f64)) -> (f64, f64) {
	(SIZE.0.min((area.0 - MARGIN).floor()), SIZE.1.min((area.1 - MARGIN).floor()))
}

pub fn setup(app: &AppHandle) {
	let Some(window) = app.get_webview_window("main") else { return };
	let _ = window.set_resizable(false);
	let _ = window.set_maximizable(false);
	let monitor: Option<Monitor> = window.current_monitor().ok().flatten().or_else(|| window.primary_monitor().ok().flatten());
	let Some(monitor) = monitor else { return };
	let scale = monitor.scale_factor();
	let area = monitor.work_area().size;
	let (w, h) = fit((f64::from(area.width) / scale, f64::from(area.height) / scale));
	if (w, h) != SIZE {
		let _ = window.set_size(LogicalSize::new(w, h));
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
}
