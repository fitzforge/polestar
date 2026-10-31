//! App updates through tauri-plugin-updater. Client releases are tagged
//! `client-v<version>` in the Polestar repository, beside the addon's own
//! `v*` releases, so "the latest release" is not ours: the newest published
//! `client-v*` release is looked up first and its `latest.json` (written by
//! the release workflow and signed with the key whose public half is in
//! tauri.conf.json) is handed to the updater.

use serde::Deserialize;
use tauri::{AppHandle, Url};
use tauri_plugin_updater::{Update, UpdaterExt};

use crate::addons::{newer, REPO};

const TAG_PREFIX: &str = "client-v";

#[derive(Clone)]
pub struct Available {
	pub version: String,
	update: Update,
}

#[derive(Deserialize)]
struct GhRelease {
	tag_name: String,
	draft: bool,
	prerelease: bool,
}

/// The newest published client release's `latest.json`, if any.
async fn manifest_url(http: &reqwest::Client) -> Result<Option<Url>, String> {
	let releases: Vec<GhRelease> = http
		.get(format!("https://api.github.com/repos/{REPO}/releases?per_page=50"))
		.header("Accept", "application/vnd.github+json")
		.header("X-GitHub-Api-Version", "2022-11-28")
		.send()
		.await
		.and_then(|r| r.error_for_status())
		.map_err(|e| e.to_string())?
		.json()
		.await
		.map_err(|e| e.to_string())?;
	let newest = releases
		.into_iter()
		.filter(|r| !r.draft && !r.prerelease && r.tag_name.starts_with(TAG_PREFIX))
		.max_by(|a, b| {
			let (a, b) = (&a.tag_name[TAG_PREFIX.len()..], &b.tag_name[TAG_PREFIX.len()..]);
			if newer(a, b) {
				std::cmp::Ordering::Greater
			} else if newer(b, a) {
				std::cmp::Ordering::Less
			} else {
				std::cmp::Ordering::Equal
			}
		});
	let Some(release) = newest else { return Ok(None) };
	let url = format!("https://github.com/{REPO}/releases/download/{}/latest.json", release.tag_name);
	Url::parse(&url).map(Some).map_err(|e| e.to_string())
}

/// Checks for a newer client; `None` when this one is the newest.
pub async fn check(app: &AppHandle, http: &reqwest::Client) -> Result<Option<Available>, String> {
	let Some(url) = manifest_url(http).await? else { return Ok(None) };
	let updater = app.updater_builder().endpoints(vec![url]).map_err(|e| e.to_string())?.build().map_err(|e| e.to_string())?;
	let update = updater.check().await.map_err(|e| e.to_string())?;
	Ok(update.map(|update| Available { version: update.version.clone(), update }))
}

/// Downloads, verifies and installs the update, then restarts the app.
pub async fn install(app: &AppHandle, available: Available) -> Result<(), String> {
	available.update.download_and_install(|_, _| {}, || {}).await.map_err(|e| e.to_string())?;
	app.restart();
}
