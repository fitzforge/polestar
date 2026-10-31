//! Finding World of Warcraft: Forever installs: native installs on Windows and macOS, and Wine,
//! Proton (Steam), Lutris, Bottles and Faugus prefixes under the home folder on Linux (the same
//! candidates as tools/lib/addons.js). A client folder (`_forever_`, ...) counts as Forever when
//! its `.flavor.info` says so (`wowf`, or a `wow_forever*` flavor); the beta's `_classic_beta_`
//! (`wow_classic_beta`) is accepted too.

use std::fmt;
use std::path::{Path, PathBuf};

use crate::sv;

/// The Recorder's addon folder name.
pub const ADDON: &str = "Polestar_Recorder";

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Install {
	/// The World of Warcraft folder.
	pub root: PathBuf,
	/// The client folder (`<root>/_forever_`).
	pub flavor_dir: PathBuf,
	/// `.flavor.info`'s flavor (`wowf`, `wow_classic_beta`, ...).
	pub flavor: String,
	/// The client version from `.build.info`, when present.
	pub version: Option<String>,
	pub accounts: Vec<Account>,
	/// `Interface/AddOns/Polestar_Recorder`, when the Recorder is installed.
	pub addon_dir: Option<PathBuf>,
	/// The installed Recorder's `## Version`.
	pub addon_version: Option<String>,
}

impl Install {
	/// Where the Recorder goes (whether or not it is installed).
	pub fn addons_dir(&self) -> PathBuf {
		self.flavor_dir.join("Interface").join("AddOns")
	}
}

#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Account {
	/// The account folder's name under WTF/Account. Local only: never uploaded.
	pub folder_name: String,
	/// `WTF/Account/<account>/SavedVariables/Polestar_Recorder.lua` (it may not exist yet).
	pub sv_path: PathBuf,
	/// The account's character names (from `WTF/Account/<account>/<Realm>/<Character>`), for
	/// scrubbing text. Local only.
	pub char_names: Vec<String>,
}

/// What is wrong with a folder the player picked.
#[derive(Clone, Debug, PartialEq, Eq)]
pub enum FolderProblem {
	NotFound(PathBuf),
	NotAFolder(PathBuf),
	/// No World of Warcraft client folder in or above it.
	NotWow(PathBuf),
	/// A World of Warcraft folder without a Forever client; `found` = the client folders it has
	/// (`_retail_`, `_classic_era_`, ...).
	NoForever {
		root: PathBuf,
		found: Vec<String>,
	},
	/// A client folder of another game version.
	OtherVersion {
		dir: PathBuf,
		flavor: String,
	},
	/// The Forever client has no WTF folder: the game has never been started and logged into.
	NeverLoggedIn(PathBuf),
	/// WTF exists but has no account folder yet.
	NoAccounts(PathBuf),
}

fn version_name(folder: &str) -> &str {
	match folder {
		"_retail_" => "Retail",
		"_classic_era_" => "Classic Era",
		"_classic_" => "Cataclysm/Mists Classic",
		"_ptr_" | "_xptr_" => "the Retail test realm",
		"_classic_ptr_" | "_classic_era_ptr_" => "a Classic test realm",
		"_beta_" => "the Retail beta",
		"_anniversary_" => "Anniversary",
		_ => folder,
	}
}

impl fmt::Display for FolderProblem {
	fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
		match self {
			FolderProblem::NotFound(p) => write!(f, "{} does not exist", p.display()),
			FolderProblem::NotAFolder(p) => write!(f, "{} is a file, not a folder", p.display()),
			FolderProblem::NotWow(p) => write!(f, "{} is not a World of Warcraft folder (no _forever_ or other game version folder in it)", p.display()),
			FolderProblem::NoForever { root, found } => {
				let names: Vec<&str> = found.iter().map(|n| version_name(n)).collect();
				write!(f, "{} has no WoW: Forever client", root.display())?;
				if !names.is_empty() {
					write!(f, " (it has {})", names.join(", "))?;
				}
				write!(f, "; install Forever with the Battle.net app, then pick that folder")
			}
			FolderProblem::OtherVersion { dir, flavor } => write!(f, "{} is {} ({flavor}), not WoW: Forever", dir.display(), version_name(dir.file_name().and_then(|n| n.to_str()).unwrap_or(""))),
			FolderProblem::NeverLoggedIn(p) => write!(f, "{} has no WTF folder yet: start WoW: Forever and log in with a character once", p.display()),
			FolderProblem::NoAccounts(p) => write!(f, "{} has no account folder yet: log in with a character once", p.join("WTF").join("Account").display()),
		}
	}
}

impl std::error::Error for FolderProblem {}

fn is_dir(p: &Path) -> bool {
	p.is_dir()
}

/// The last non-empty line of `.flavor.info`.
fn read_flavor(dir: &Path) -> Option<String> {
	let text = std::fs::read_to_string(dir.join(".flavor.info")).ok()?;
	text.lines().map(str::trim).rfind(|l| !l.is_empty()).map(str::to_string)
}

fn is_client_folder_name(name: &str) -> bool {
	name.len() > 2 && name.starts_with('_') && name.ends_with('_')
}

/// Whether a client folder named `name` with this flavor is Forever (or its beta).
fn is_forever(name: &str, flavor: &str) -> bool {
	flavor == "wowf" || flavor.to_ascii_lowercase().contains("forever") || (name == "_classic_beta_" && flavor == "wow_classic_beta")
}

/// `.build.info`'s Version for the client (the row whose Product is the flavor, else the first
/// active row).
fn read_version(root: &Path, flavor: &str) -> Option<String> {
	let text = std::fs::read_to_string(root.join(".build.info")).ok()?;
	let mut lines = text.lines().filter(|l| !l.trim().is_empty());
	let header: Vec<String> = lines.next()?.split('|').map(|h| h.split('!').next().unwrap_or("").to_string()).collect();
	let col = |name: &str| header.iter().position(|h| h == name);
	let (version, product, active) = (col("Version")?, col("Product"), col("Active"));
	let rows: Vec<Vec<&str>> = lines.map(|l| l.split('|').collect()).collect();
	let pick = rows.iter().find(|r| product.is_some_and(|p| r.get(p) == Some(&flavor))).or_else(|| rows.iter().find(|r| active.is_some_and(|a| r.get(a) == Some(&"1")))).or(rows.first())?;
	pick.get(version).map(|v| v.trim().to_string()).filter(|v| !v.is_empty())
}

fn sorted_dirs(p: &Path) -> Vec<(String, PathBuf)> {
	let Ok(rd) = std::fs::read_dir(p) else { return Vec::new() };
	let mut out: Vec<(String, PathBuf)> = rd.flatten().filter(|e| e.path().is_dir()).map(|e| (e.file_name().to_string_lossy().into_owned(), e.path())).collect();
	out.sort();
	out
}

fn accounts(flavor_dir: &Path) -> Vec<Account> {
	accounts_in_wtf(&flavor_dir.join("WTF"))
}

/// The accounts of a WTF folder (`<wtf>/Account/<account>`), e.g. one a player sent in.
pub fn accounts_in_wtf(wtf: &Path) -> Vec<Account> {
	let mut out = Vec::new();
	for (name, dir) in sorted_dirs(&wtf.join("Account")) {
		if name == "SavedVariables" {
			continue;
		}
		let mut char_names = Vec::new();
		for (realm, rdir) in sorted_dirs(&dir) {
			if realm == "SavedVariables" {
				continue;
			}
			for (ch, _) in sorted_dirs(&rdir) {
				if ch != "SavedVariables" && !char_names.contains(&ch) {
					char_names.push(ch);
				}
			}
		}
		out.push(Account { folder_name: name, sv_path: dir.join("SavedVariables").join(sv::FILE_NAME), char_names });
	}
	out
}

fn toc_version(addon_dir: &Path) -> Option<String> {
	let text = std::fs::read_to_string(addon_dir.join(format!("{ADDON}.toc"))).ok()?;
	text.lines().find_map(|l| {
		let rest = l.trim().strip_prefix("##")?.trim_start();
		let (k, v) = rest.split_once(':')?;
		(k.trim().eq_ignore_ascii_case("version")).then(|| v.trim().to_string()).filter(|v| !v.is_empty())
	})
}

/// The install of a Forever client folder.
fn install_of(flavor_dir: &Path, flavor: String) -> Install {
	let root = flavor_dir.parent().map(Path::to_path_buf).unwrap_or_else(|| flavor_dir.to_path_buf());
	let addon = flavor_dir.join("Interface").join("AddOns").join(ADDON);
	let addon_dir = is_dir(&addon).then_some(addon);
	Install {
		version: read_version(&root, &flavor),
		root,
		flavor_dir: flavor_dir.to_path_buf(),
		flavor,
		accounts: accounts(flavor_dir),
		addon_version: addon_dir.as_deref().and_then(toc_version),
		addon_dir,
	}
}

/// The Forever client folders of a World of Warcraft folder, live (`_forever_`) first.
fn forever_clients(root: &Path) -> Vec<(PathBuf, String)> {
	let mut out: Vec<(PathBuf, String)> = Vec::new();
	for (name, dir) in sorted_dirs(root) {
		if !is_client_folder_name(&name) {
			continue;
		}
		if let Some(flavor) = read_flavor(&dir).filter(|f| is_forever(&name, f)) {
			out.push((dir, flavor));
		}
	}
	out.sort_by_key(|(d, _)| d.file_name().is_some_and(|n| n != "_forever_"));
	out
}

const WOW_DIRS: [&[&str]; 4] = [&["Program Files (x86)", "World of Warcraft"], &["Program Files", "World of Warcraft"], &["Games", "World of Warcraft"], &["World of Warcraft"]];

const PREFIX_ROOTS: [&[&str]; 10] = [
	&[".wine"],
	&["Games"],
	&["Faugus"],
	&[".local", "share", "wineprefixes"],
	&[".local", "share", "lutris", "prefixes"],
	&[".local", "share", "bottles", "bottles"],
	&[".var", "app", "com.usebottles.bottles", "data", "bottles", "bottles"],
	&[".local", "share", "Steam", "steamapps", "compatdata"],
	&[".steam", "steam", "steamapps", "compatdata"],
	&[".var", "app", "com.valvesoftware.Steam", ".local", "share", "Steam", "steamapps", "compatdata"],
];

fn join(base: &Path, parts: &[&str]) -> PathBuf {
	parts.iter().fold(base.to_path_buf(), |p, s| p.join(s))
}

/// Wine prefixes (folders with a `drive_c`) under the home folder.
fn prefixes_under(home: &Path) -> Vec<PathBuf> {
	let mut found = Vec::new();
	let mut consider = |p: PathBuf| {
		if is_dir(&p.join("drive_c")) && !found.contains(&p) {
			found.push(p);
		}
	};
	for parts in PREFIX_ROOTS {
		let root = join(home, parts);
		if !is_dir(&root) {
			continue;
		}
		consider(root.clone());
		consider(root.join("pfx"));
		for (_, child) in sorted_dirs(&root) {
			consider(child.clone());
			consider(child.join("pfx"));
		}
	}
	found
}

/// Every World of Warcraft folder that exists: in the Wine prefixes under `home`, then the native
/// installs under each of `native_roots` (filesystem roots: `C:\` on Windows, `/` on macOS).
pub fn wow_dirs(home: Option<&Path>, native_roots: &[PathBuf]) -> Vec<PathBuf> {
	let mut out = Vec::new();
	if let Some(home) = home {
		for prefix in prefixes_under(home) {
			for parts in WOW_DIRS {
				out.push(join(&prefix.join("drive_c"), parts));
			}
		}
	}
	for root in native_roots {
		out.push(root.join("Program Files (x86)").join("World of Warcraft"));
		out.push(root.join("Program Files").join("World of Warcraft"));
		out.push(root.join("Applications").join("World of Warcraft"));
	}
	out.retain(|p| is_dir(p));
	out
}

/// The Forever installs under the given places (see [`wow_dirs`]), each client folder once.
pub fn find_installs_in(home: Option<&Path>, native_roots: &[PathBuf]) -> Vec<Install> {
	let mut seen = Vec::new();
	let mut out = Vec::new();
	for root in wow_dirs(home, native_roots) {
		for (dir, flavor) in forever_clients(&root) {
			let real = std::fs::canonicalize(&dir).unwrap_or_else(|_| dir.clone());
			if seen.contains(&real) {
				continue;
			}
			seen.push(real);
			out.push(install_of(&dir, flavor));
		}
	}
	out
}

/// Every Forever install on this computer.
pub fn find_installs() -> Vec<Install> {
	let roots: Vec<PathBuf> = if cfg!(windows) {
		let mut r = vec![PathBuf::from("C:\\")];
		if let Some(d) = std::env::var_os("SystemDrive") {
			let d = PathBuf::from(format!("{}\\", d.to_string_lossy()));
			if !r.contains(&d) {
				r.push(d);
			}
		}
		r
	} else if cfg!(target_os = "macos") {
		vec![PathBuf::from("/")]
	} else {
		Vec::new()
	};
	// std's home_dir is correct on every platform since Rust 1.85 (no `dirs`: its option-ext
	// dependency is MPL-2.0, outside the licences the forge release accepts).
	#[allow(deprecated)]
	let home = std::env::home_dir();
	find_installs_in(home.as_deref(), &roots)
}

/// The install of a folder the player picked: the World of Warcraft folder, the `_forever_`
/// folder, or any folder inside it.
pub fn check_folder(path: &Path) -> Result<Install, FolderProblem> {
	if !path.exists() {
		return Err(FolderProblem::NotFound(path.to_path_buf()));
	}
	if !path.is_dir() {
		return Err(FolderProblem::NotAFolder(path.to_path_buf()));
	}
	let path = std::fs::canonicalize(path).unwrap_or_else(|_| path.to_path_buf());
	// Inside (or at) a client folder: the nearest ancestor that is one.
	for dir in path.ancestors() {
		let name = dir.file_name().and_then(|n| n.to_str()).unwrap_or("");
		if !is_client_folder_name(name) {
			continue;
		}
		let flavor = read_flavor(dir);
		return match flavor {
			Some(f) if is_forever(name, &f) => finish(dir, f),
			Some(f) => Err(FolderProblem::OtherVersion { dir: dir.to_path_buf(), flavor: f }),
			// A client folder without .flavor.info: only `_forever_` itself is trusted by name.
			None if name == "_forever_" => finish(dir, "wowf".to_string()),
			None => continue,
		};
	}
	// A World of Warcraft folder (or the folder holding one).
	for root in [path.clone(), path.join("World of Warcraft")] {
		let clients: Vec<String> = sorted_dirs(&root).into_iter().map(|(n, _)| n).filter(|n| is_client_folder_name(n)).collect();
		if clients.is_empty() {
			continue;
		}
		if let Some((dir, flavor)) = forever_clients(&root).into_iter().next() {
			return finish(&dir, flavor);
		}
		if clients.iter().any(|n| n == "_forever_") {
			return finish(&root.join("_forever_"), "wowf".to_string());
		}
		return Err(FolderProblem::NoForever { root, found: clients });
	}
	Err(FolderProblem::NotWow(path))
}

fn finish(flavor_dir: &Path, flavor: String) -> Result<Install, FolderProblem> {
	let wtf = flavor_dir.join("WTF");
	if !is_dir(&wtf) {
		return Err(FolderProblem::NeverLoggedIn(flavor_dir.to_path_buf()));
	}
	let install = install_of(flavor_dir, flavor);
	if install.accounts.is_empty() {
		return Err(FolderProblem::NoAccounts(flavor_dir.to_path_buf()));
	}
	Ok(install)
}

#[cfg(test)]
mod tests {
	use super::*;

	fn tmp(name: &str) -> PathBuf {
		let d = std::env::temp_dir().join(format!("polestar-install-{name}-{}", std::process::id()));
		let _ = std::fs::remove_dir_all(&d);
		std::fs::create_dir_all(&d).unwrap();
		d
	}

	fn client(root: &Path, folder: &str, flavor: &str) -> PathBuf {
		let d = root.join(folder);
		std::fs::create_dir_all(&d).unwrap();
		std::fs::write(d.join(".flavor.info"), format!("#\n{flavor}\n")).unwrap();
		d
	}

	#[test]
	fn finds_a_forever_install_in_a_folder() {
		let root = tmp("ok").join("World of Warcraft");
		let f = client(&root, "_forever_", "wowf");
		client(&root, "_retail_", "wow");
		std::fs::write(root.join(".build.info"), "Branch!STRING:0|Active!DEC:1|Version!STRING:0|Product!STRING:0\neu|1|11.2.0.1|wow\neu|1|1.15.8.62345|wowf\n").unwrap();
		std::fs::create_dir_all(f.join("WTF/Account/12345#1/SavedVariables")).unwrap();
		std::fs::create_dir_all(f.join("WTF/Account/12345#1/Doomhowl/Thrall")).unwrap();
		std::fs::create_dir_all(f.join("WTF/Account/12345#1/Doomhowl/Jaina/SavedVariables")).unwrap();
		std::fs::create_dir_all(f.join("WTF/Account/SavedVariables")).unwrap();
		let addon = f.join("Interface/AddOns/Polestar_Recorder");
		std::fs::create_dir_all(&addon).unwrap();
		std::fs::write(addon.join("Polestar_Recorder.toc"), "## Interface: 11508\n## Version: 2.0.0\n").unwrap();
		for pick in [root.clone(), f.clone(), f.join("WTF/Account"), root.parent().unwrap().to_path_buf()] {
			let i = check_folder(&pick).unwrap_or_else(|e| panic!("{}: {e}", pick.display()));
			assert_eq!(i.flavor, "wowf");
			assert_eq!(i.version.as_deref(), Some("1.15.8.62345"));
			assert_eq!(i.accounts.len(), 1);
			assert_eq!(i.accounts[0].folder_name, "12345#1");
			assert_eq!(i.accounts[0].char_names, vec!["Jaina".to_string(), "Thrall".to_string()]);
			assert!(i.accounts[0].sv_path.ends_with("WTF/Account/12345#1/SavedVariables/Polestar_Recorder.lua"));
			assert_eq!(i.addon_version.as_deref(), Some("2.0.0"));
		}
		std::fs::remove_dir_all(root.parent().unwrap()).unwrap();
	}

	#[test]
	fn says_what_is_wrong_with_a_folder() {
		let base = tmp("bad");
		assert!(matches!(check_folder(&base.join("nope")), Err(FolderProblem::NotFound(_))));
		std::fs::write(base.join("file.txt"), "x").unwrap();
		assert!(matches!(check_folder(&base.join("file.txt")), Err(FolderProblem::NotAFolder(_))));
		let empty = base.join("empty");
		std::fs::create_dir_all(&empty).unwrap();
		assert!(matches!(check_folder(&empty), Err(FolderProblem::NotWow(_))));

		let retail = base.join("retail");
		client(&retail, "_retail_", "wow");
		client(&retail, "_classic_era_", "wow_classic_era");
		match check_folder(&retail) {
			Err(e @ FolderProblem::NoForever { .. }) => assert!(e.to_string().contains("(it has Classic Era, Retail)"), "{e}"),
			other => panic!("{other:?}"),
		}
		let era = client(&base.join("era"), "_classic_era_", "wow_classic_era");
		std::fs::create_dir_all(era.join("Interface")).unwrap();
		assert!(matches!(check_folder(&era.join("Interface")), Err(FolderProblem::OtherVersion { .. })));

		let fresh = client(&base.join("fresh"), "_forever_", "wowf");
		assert!(matches!(check_folder(&fresh), Err(FolderProblem::NeverLoggedIn(_))));
		std::fs::create_dir_all(fresh.join("WTF")).unwrap();
		assert!(matches!(check_folder(&fresh), Err(FolderProblem::NoAccounts(_))));

		let beta = client(&base.join("beta"), "_classic_beta_", "wow_classic_beta");
		std::fs::create_dir_all(beta.join("WTF/Account/A")).unwrap();
		assert_eq!(check_folder(&base.join("beta")).unwrap().flavor, "wow_classic_beta");
		std::fs::remove_dir_all(&base).unwrap();
	}

	#[test]
	fn finds_installs_in_wine_prefixes() {
		let home = tmp("home");
		let wow = home.join(".local/share/lutris/prefixes/wow/drive_c/Program Files (x86)/World of Warcraft");
		let f = client(&wow, "_forever_", "wowf");
		std::fs::create_dir_all(f.join("WTF/Account/A")).unwrap();
		let steam = home.join(".steam/steam/steamapps/compatdata/123/pfx/drive_c/World of Warcraft");
		client(&steam, "_retail_", "wow");
		let found = find_installs_in(Some(&home), &[]);
		assert_eq!(found.len(), 1);
		assert_eq!(found[0].flavor_dir, f);
		assert_eq!(found[0].addon_dir, None);
		std::fs::remove_dir_all(&home).unwrap();
	}
}
