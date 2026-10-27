//! How the window is drawn on Linux. WebKitGTK's DMA-BUF renderer hands
//! frames to the compositor on the GPU; its fallback copies every frame
//! through shared memory, which is what makes motion stutter on large windows.
//! The DMA-BUF renderer stays on unless it is known to fail: NVIDIA drivers
//! before 560 ("Failed to create GBM buffer", a blank window), and machines
//! without a GPU render node (virtual machines). A player's own
//! `WEBKIT_DISABLE_DMABUF_RENDERER` always wins.

use std::sync::OnceLock;

static RENDERER: OnceLock<String> = OnceLock::new();

/// Oldest NVIDIA driver whose GBM works with WebKitGTK's DMA-BUF renderer.
#[cfg(target_os = "linux")]
const NVIDIA_GBM: u32 = 560;

/// Chooses the renderer; call first thing in `main`, before any thread starts.
pub fn choose() {
	let text = pick();
	eprintln!("Polestar Client rendering: {text}");
	let _ = RENDERER.set(text);
}

/// What `choose` decided, for the log and the window's diagnostics.
pub fn describe() -> String {
	RENDERER.get().cloned().unwrap_or_else(|| "system default".to_owned())
}

#[cfg(not(target_os = "linux"))]
fn pick() -> String {
	"system default".to_owned()
}

#[cfg(target_os = "linux")]
fn pick() -> String {
	const VAR: &str = "WEBKIT_DISABLE_DMABUF_RENDERER";
	if let Some(v) = std::env::var_os(VAR) {
		let off = v != "0";
		return format!("{} ({VAR}={} set outside the client)", if off { "shared memory" } else { "DMA-BUF (GPU)" }, v.to_string_lossy());
	}
	let nvidia = std::fs::read_to_string("/proc/driver/nvidia/version").ok().and_then(|t| nvidia_major(&t));
	let render_node = std::fs::read_dir("/dev/dri").map(|d| d.flatten().any(|e| e.file_name().to_string_lossy().starts_with("renderD"))).unwrap_or(false);
	let fallback = match nvidia {
		Some(major) if major < NVIDIA_GBM => Some(format!("NVIDIA driver {major} is older than {NVIDIA_GBM}")),
		_ if !render_node => Some("no GPU render node".to_owned()),
		_ => None,
	};
	match fallback {
		Some(why) => {
			// Before any thread exists (see `choose`), so nothing reads the environment meanwhile.
			std::env::set_var(VAR, "1");
			format!("shared memory ({why})")
		}
		None => format!("DMA-BUF (GPU{})", nvidia.map(|m| format!(", NVIDIA {m}")).unwrap_or_default()),
	}
}

/// The driver's major version from `/proc/driver/nvidia/version`
/// ("NVRM version: NVIDIA UNIX Open Kernel Module for x86_64  615.78.08  Release Build ...").
#[cfg(target_os = "linux")]
fn nvidia_major(text: &str) -> Option<u32> {
	let line = text.lines().next()?;
	line.split_whitespace().find_map(|w| {
		let (major, rest) = w.split_once('.')?;
		(rest.contains('.') || rest.chars().all(|c| c.is_ascii_digit())).then_some(())?;
		major.parse().ok()
	})
}

#[cfg(all(test, target_os = "linux"))]
mod tests {
	use super::nvidia_major;

	#[test]
	fn reads_the_nvidia_driver_version() {
		assert_eq!(nvidia_major("NVRM version: NVIDIA UNIX Open Kernel Module for x86_64  615.78.08  Release Build  (notroot@)  Fri Oct 23"), Some(615));
		assert_eq!(nvidia_major("NVRM version: NVIDIA UNIX x86_64 Kernel Module  535.183.01  Sun May 12 19:39:15 UTC 2024\nGCC version:  gcc 13"), Some(535));
		assert_eq!(nvidia_major("NVRM version: something else"), None);
	}
}
