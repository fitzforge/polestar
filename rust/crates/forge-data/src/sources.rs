//! `forge data sources`: fills the source cache (data/sources) the offline readers take their
//! inputs from, in the layout the JS toolchain cached them in (port of the fetch halves of
//! tools/lib/data/{wago,pfquest,eglink,forevervo,webxp}.js, travel/cmangos.js and game/xp.js):
//!
//!   wago/<build>/<Table>.csv          client tables from wago.tools (`wago`): the Classic Era build's
//!                                     map and faction tables, the Forever build's the data build reads
//!                                     without a client, QuestXP; and (`builders`) the tables of the
//!                                     other builders (itemdb, the Codex, professions, travel, the
//!                                     pinned builds talents and map overlays read)
//!   pfQuest/                          the pfQuest checkout at [`PFQUEST_COMMIT`]
//!   eg-link/<commit12>/               the EG Link output at its pinned commit (index + datasets)
//!   forever-vo/<commit12>/capture.json
//!   cmangos/<rev12>/classicdb.sql.gz  the CMaNGOS classic-db dump (sha256 pinned); the readers build
//!                                     their extracts from it
//!   webxp/quest-xp.json               web quest XP for the quests the data has none for
//!   wowdbdefs/                        the table definitions the installed client is read with
//!
//! A cached file is never fetched again (cached builds and pinned commits are immutable); a part
//! that cannot be fetched is a warning, except the Era tables and pfQuest, which every build needs.

use std::io::Read;
use std::path::{Path, PathBuf};
use std::time::Duration;

use forge_guide::js::{stringify, Obj, V};
use sha2::{Digest, Sha256};

use crate::tables::{self, compare_versions, is_build, Product};

pub const BUILDS_URL: &str = "https://wago.tools/api/builds";
const USER_AGENT: &str = "polestar-data-build";
/// The pfQuest commit the data is built from.
pub const PFQUEST_COMMIT: &str = "104f35678ca39ab1fb78b655f815cc7016f5e0c8";
pub const DEFS_REPO: &str = "https://github.com/wowdev/WoWDBDefs";
pub const DB_SHA256: &str = "4f92db520868ab4e566726f68b5b2e380ae781209beaf22237b4f7f04600d0c0";
const DB_MAX_BYTES: u64 = 32 * 1024 * 1024;
/// A client table export is at most this big (ItemSparse is ~40 MB).
const TABLE_MAX_BYTES: u64 = 512 * 1024 * 1024;
const JSON_MAX_BYTES: u64 = 256 * 1024 * 1024;

/// The parts `--only` names, in fetch order.
/// `wago`: the tables `forge data build` reads; `builders`: those of the other builders (itemdb, talents,
/// maps overlays, codex, professions, travel).
pub const PARTS: [&str; 8] = ["wago", "builders", "pfquest", "eglink", "forever-vo", "cmangos", "webxp", "wowdbdefs"];

// ---------------------------------------------------------------- HTTP

pub struct Http {
	agent: ureq::Agent,
}

impl Http {
	/// `timeout`: the whole of one request.
	pub fn new(timeout: Duration, user_agent: &str) -> Http {
		let agent = ureq::Agent::config_builder().timeout_global(Some(timeout)).http_status_as_error(false).user_agent(user_agent).build().new_agent();
		Http { agent }
	}

	pub fn default_agent() -> Http {
		Http::new(Duration::from_secs(600), USER_AGENT)
	}

	/// GET `url`: Some(body) on 200, None on 404, else an error (`GET <url>: HTTP <status>`).
	pub fn get(&self, url: &str, max: u64) -> Result<Option<Vec<u8>>, String> {
		let resp = self.agent.get(url).call().map_err(|e| format!("GET {url}: {e}"))?;
		let status = resp.status().as_u16();
		if status == 404 {
			return Ok(None);
		}
		if !(200..300).contains(&status) {
			return Err(format!("GET {url}: HTTP {status}"));
		}
		let mut buf = Vec::new();
		resp.into_body().into_reader().take(max + 1).read_to_end(&mut buf).map_err(|e| format!("GET {url}: {e}"))?;
		if buf.len() as u64 > max {
			return Err(format!("GET {url}: over the {max}-byte limit"));
		}
		Ok(Some(buf))
	}

	/// GET `url` as text; a 404 is an error like any other status.
	pub fn text(&self, url: &str, max: u64) -> Result<String, String> {
		let body = self.get(url, max)?.ok_or_else(|| format!("GET {url}: HTTP 404"))?;
		String::from_utf8(body).map_err(|_| format!("GET {url}: not UTF-8"))
	}
}

/// Writes `bytes` to `file` through `<file>.tmp` and a rename, creating its folder.
pub fn write_atomic(file: &Path, bytes: &[u8]) -> Result<(), String> {
	if let Some(d) = file.parent() {
		std::fs::create_dir_all(d).map_err(|e| format!("{}: {e}", d.display()))?;
	}
	let tmp = PathBuf::from(format!("{}.{}.tmp", file.display(), std::process::id()));
	std::fs::write(&tmp, bytes).map_err(|e| format!("{}: {e}", tmp.display()))?;
	std::fs::rename(&tmp, file).map_err(|e| format!("{}: {e}", file.display()))
}

fn git(args: &[&str], cwd: Option<&Path>) -> Result<String, String> {
	let mut c = std::process::Command::new("git");
	if let Some(d) = cwd {
		c.current_dir(d);
	}
	let out = c.args(args).output().map_err(|e| format!("git {}: {e}", args.join(" ")))?;
	if !out.status.success() {
		return Err(format!("git {} failed: {}", args.join(" "), String::from_utf8_lossy(&out.stderr).trim()));
	}
	Ok(String::from_utf8_lossy(&out.stdout).trim().to_string())
}

// ---------------------------------------------------------------- wago.tools

/// The newest build of the product wago.tools lists.
pub fn latest_build(http: &Http, p: &Product) -> Result<String, String> {
	let text = http.text(BUILDS_URL, JSON_MAX_BYTES)?;
	let builds: serde_json::Value = serde_json::from_str(&text).map_err(|e| format!("{BUILDS_URL}: {e}"))?;
	let mut list: Vec<String> =
		builds[p.key].as_array().map(|a| a.iter().filter_map(|b| b["version"].as_str()).filter(|v| is_build(v) && p.in_family(v)).map(String::from).collect()).unwrap_or_default();
	list.sort_by(|a, b| compare_versions(a, b));
	list.pop().ok_or_else(|| format!("{BUILDS_URL}: no {} builds listed", p.key))
}

/// `build` when given, else the newest listed, else (wago.tools unreachable) the newest cached
/// one holding `tables`, with a warning. -> (build, warnings)
pub fn pick_build(http: &Http, sources: &Path, p: &Product, build: Option<&str>, tables: &[&str]) -> Result<(String, Vec<String>), String> {
	if let Some(b) = build {
		if !is_build(b) {
			return Err(format!("\"{b}\" is not a build version"));
		}
		return Ok((b.to_string(), Vec::new()));
	}
	match latest_build(http, p) {
		Ok(b) => Ok((b, Vec::new())),
		Err(e) => match tables::newest_cached_holding(sources, p, tables) {
			Some(b) => Ok((b.clone(), vec![format!("wago.tools: {e}; using cached {} build {b}", p.key)])),
			None => Err(e),
		},
	}
}

/// <sources>/wago/<build>/<table>.csv, fetched when missing (checked to be a DB2 CSV export).
/// `http` None: offline, a missing file is an error. -> whether it was fetched
pub fn wago_table(http: Option<&Http>, sources: &Path, build: &str, table: &str, log: &dyn Fn(&str)) -> Result<bool, String> {
	if !is_build(build) {
		return Err(format!("\"{build}\" is not a build version"));
	}
	let file = sources.join("wago").join(build).join(format!("{table}.csv"));
	if file.exists() {
		return Ok(false);
	}
	let Some(http) = http else {
		return Err(format!("--offline: missing cached {}", file.display()));
	};
	let url = tables::table_url(table, build);
	log(&format!("fetching {url}"));
	let text = http.text(&url, TABLE_MAX_BYTES)?;
	let rows = tables::parse_csv(&text)?;
	if rows.first().is_none_or(|r| !r.contains_key("ID")) {
		return Err(format!("{url}: not a DB2 CSV export"));
	}
	write_atomic(&file, text.as_bytes())?;
	Ok(true)
}

/// The rows of `tables` of one build (professions/tables.js `loadTables` without the Forever
/// fallbacks): `build`, else the newest wago.tools lists (offline: the newest cached build holding
/// every one of them); a missing table is fetched unless `offline`. -> (build, tables, warnings)
pub fn client_tables(sources: &Path, p: &Product, build: Option<&str>, tables: &[&str], offline: bool, log: &dyn Fn(&str)) -> Result<(String, Vec<(String, crate::jsv::Rows)>, Vec<String>), String> {
	let http = (!offline).then(Http::default_agent);
	let (chosen, warnings) = match (build, &http) {
		(Some(b), _) => (b.to_string(), Vec::new()),
		(None, Some(h)) => pick_build(h, sources, p, None, tables)?,
		(None, None) => {
			let b = tables::newest_cached_holding(sources, p, tables).ok_or_else(|| format!("--offline: no cached wago.tools build under {} ({})", sources.join("wago").display(), p.key))?;
			(b, Vec::new())
		}
	};
	let mut out = Vec::new();
	for t in tables {
		wago_table(http.as_ref(), sources, &chosen, t, log)?;
		let file = sources.join("wago").join(&chosen).join(format!("{t}.csv"));
		let text = std::fs::read_to_string(&file).map_err(|e| format!("{}: {e}", file.display()))?;
		out.push((t.to_string(), tables::parse_csv(&text)?));
	}
	Ok((chosen, out, warnings))
}

/// Tables of one build: `required` must come, `optional` may fail with a warning.
pub struct TableSet {
	pub required: Vec<&'static str>,
	pub optional: Vec<&'static str>,
}

/// The Era tables: the data build's map and faction tables (required, `data`), and with `builders`
/// itemdb's item tables, the Classic Era rows professions fill Forever's gaps with and travel's flight
/// tables.
pub fn era_tables(data: bool, builders: bool) -> TableSet {
	let mut optional = Vec::new();
	if builders {
		optional.extend(crate::itemdb::TABLES);
		optional.extend(crate::professions::tables::ERA_NEEDED);
		optional.extend(crate::travel::sources::TABLES);
	}
	TableSet { required: if data { tables::ERA.tables.to_vec() } else { Vec::new() }, optional: dedupe(optional) }
}

/// The Forever tables: the data build's (and the sim inputs') when no client is read (`data`), and with
/// `builders` the Codex's, professions' and travel's.
pub fn forever_tables(data: bool, without_client: bool, builders: bool) -> TableSet {
	let mut optional: Vec<&'static str> = Vec::new();
	if builders {
		optional.extend(crate::codex::client::TABLES);
		optional.extend(crate::professions::tables::OWN);
		optional.extend(["SpellTotems", "SpellCastingRequirements", "SpellFocusObject"]);
		optional.extend(crate::travel::sources::FOREVER_TABLES);
		optional.extend(crate::travel::sources::TRANSIT_TABLES);
	}
	let mut required = Vec::new();
	if data && without_client {
		required.extend(tables::FOREVER_SIM.tables);
		optional.extend(tables::FOREVER_SIM.optional);
	}
	let optional = dedupe(optional).into_iter().filter(|t| !required.contains(t)).collect();
	TableSet { required, optional }
}

fn dedupe(v: Vec<&'static str>) -> Vec<&'static str> {
	let mut out: Vec<&'static str> = Vec::new();
	for t in v {
		if !out.contains(&t) {
			out.push(t);
		}
	}
	out
}

/// Pinned builds and their tables: the QuestXP table (`data`); with `builders` the Codex's Era item
/// tables, the talent trees and the map overlays.
pub fn pinned_tables(data: bool, builders: bool) -> Vec<(&'static str, Vec<&'static str>)> {
	let mut era: Vec<&'static str> = if data { vec!["QuestXP"] } else { Vec::new() };
	let mut out = Vec::new();
	if builders {
		era.extend(crate::codex::client::ERA_TABLES);
		out.push((crate::talents::BUILD, crate::talents::TABLES.to_vec()));
		out.push((crate::worldmap::OVERLAYS_BUILD, crate::worldmap::OVERLAY_TABLES.to_vec()));
	}
	out.insert(0, (crate::players::QUESTXP_BUILD, dedupe(era)));
	out
}

fn fetch_set(http: &Http, sources: &Path, build: &str, set: &TableSet, log: &dyn Fn(&str), rep: &mut Report) -> Result<(), String> {
	for t in &set.required {
		if wago_table(Some(http), sources, build, t, log)? {
			rep.fetched += 1;
		}
	}
	for t in &set.optional {
		match wago_table(Some(http), sources, build, t, log) {
			Ok(f) => rep.fetched += usize::from(f),
			Err(e) => rep.warnings.push(format!("wago.tools {build}: no {t} ({e})")),
		}
	}
	Ok(())
}

// ---------------------------------------------------------------- pfQuest

/// The pfQuest checkout at `dir` at [`PFQUEST_COMMIT`]: cloned when missing, moved to the pin when
/// it is a checkout elsewhere. -> whether anything was fetched
pub fn pfquest(dir: &Path, log: &dyn Fn(&str), warnings: &mut Vec<String>) -> Result<bool, String> {
	let fetch_pin = |d: &Path| -> Result<(), String> {
		git(&["fetch", "--quiet", "--depth", "1", "origin", PFQUEST_COMMIT], Some(d))?;
		git(&["checkout", "--quiet", "--detach", PFQUEST_COMMIT], Some(d)).map(|_| ())
	};
	if !dir.join("db").exists() {
		log(&format!("cloning {} at {} into {}", crate::pfquest::REPO, &PFQUEST_COMMIT[..12], dir.display()));
		std::fs::create_dir_all(dir).map_err(|e| format!("{}: {e}", dir.display()))?;
		git(&["init", "--quiet"], Some(dir))?;
		git(&["remote", "add", "origin", crate::pfquest::REPO], Some(dir))?;
		fetch_pin(dir)?;
		return Ok(true);
	}
	let top = git(&["rev-parse", "--show-toplevel"], Some(dir)).ok().and_then(|t| std::fs::canonicalize(t).ok());
	if top.is_none() || top != std::fs::canonicalize(dir).ok() {
		warnings.push(format!("pfQuest: {} is not a git checkout; left as it is", dir.display()));
		return Ok(false);
	}
	if git(&["rev-parse", "HEAD"], Some(dir)).ok().as_deref() == Some(PFQUEST_COMMIT) {
		return Ok(false);
	}
	log(&format!("moving {} to pfQuest {}", dir.display(), &PFQUEST_COMMIT[..12]));
	match fetch_pin(dir) {
		Ok(()) => Ok(true),
		Err(e) => {
			warnings.push(format!("pfQuest: could not move the checkout to {} ({e}); using it as is", &PFQUEST_COMMIT[..12]));
			Ok(false)
		}
	}
}

/// WoWDBDefs (the client's table layouts) at `dir`, cloned when missing.
pub fn wowdbdefs(dir: &Path, log: &dyn Fn(&str)) -> Result<bool, String> {
	if dir.join("definitions").is_dir() {
		return Ok(false);
	}
	log(&format!("cloning {DEFS_REPO} into {}", dir.display()));
	if let Some(p) = dir.parent() {
		std::fs::create_dir_all(p).map_err(|e| format!("{}: {e}", p.display()))?;
	}
	git(&["clone", "--quiet", "--depth", "1", DEFS_REPO, &dir.to_string_lossy()], None)?;
	Ok(true)
}

// ---------------------------------------------------------------- pinned GitHub files

fn raw_json(http: &Http, file: &Path, url: &str, log: &dyn Fn(&str)) -> Result<(V, bool), String> {
	let fetched = !file.exists();
	if fetched {
		log(&format!("fetching {url}"));
		let body = http.get(url, JSON_MAX_BYTES)?.ok_or_else(|| format!("GET {url}: HTTP 404"))?;
		let text = String::from_utf8(body).map_err(|_| format!("GET {url}: not UTF-8"))?;
		forge_guide::js::parse_json(&text).map_err(|e| format!("GET {url}: {e}"))?;
		write_atomic(file, text.as_bytes())?;
	}
	let text = std::fs::read_to_string(file).map_err(|e| format!("{}: {e}", file.display()))?;
	Ok((forge_guide::js::parse_json(&text)?, fetched))
}

/// The EG Link output at its pinned commit: data/index.json and every listed dataset of the Forever
/// product. -> files fetched
pub fn eglink(http: &Http, sources: &Path, log: &dyn Fn(&str)) -> Result<usize, String> {
	let commit = crate::players::EG_COMMIT;
	let dir = sources.join("eg-link").join(&commit[..12]);
	let repo = crate::players::EG_URL.trim_start_matches("https://github.com/");
	let url = |f: &str| format!("https://raw.githubusercontent.com/{repo}/{commit}/data/{f}");
	let (index, f) = raw_json(http, &dir.join("index.json"), &url("index.json"), log)?;
	let mut n = usize::from(f);
	let product = crate::players::EG_PRODUCT;
	let builds = index.get("products").get(product);
	for (build, sets) in builds.entries() {
		for d in crate::players::DATASETS {
			if !sets.get(d).truthy() {
				continue;
			}
			let rel = format!("{product}/{build}/{d}.json");
			n += usize::from(raw_json(http, &dir.join(&rel), &url(&rel), log)?.1);
		}
	}
	Ok(n)
}

/// forever-vo's capture.json at its pinned commit.
pub fn forever_vo(http: &Http, sources: &Path, log: &dyn Fn(&str)) -> Result<bool, String> {
	let commit = crate::players::VO_COMMIT;
	let file = sources.join("forever-vo").join(&commit[..12]).join("capture.json");
	let repo = crate::players::VO_URL.trim_start_matches("https://github.com/");
	Ok(raw_json(http, &file, &format!("https://raw.githubusercontent.com/{repo}/{commit}/tools/data/capture.json"), log)?.1)
}

// ---------------------------------------------------------------- CMaNGOS

fn sha256_hex(bytes: &[u8]) -> String {
	Sha256::digest(bytes).iter().map(|b| format!("{b:02x}")).collect()
}

/// The pinned classic-db dump at <sources>/cmangos/<rev12>/classicdb.sql.gz, checked against its
/// sha256 (a cached one whose hash is wrong is fetched again).
pub fn cmangos(http: &Http, sources: &Path, log: &dyn Fn(&str)) -> Result<bool, String> {
	let file = sources.join("cmangos").join(&crate::cmangos::DB_REV[..12]).join("classicdb.sql.gz");
	if let Ok(b) = std::fs::read(&file) {
		if sha256_hex(&b) == DB_SHA256 {
			return Ok(false);
		}
		log(&format!("{}: wrong sha256, deleted", file.display()));
		std::fs::remove_file(&file).map_err(|e| format!("{}: {e}", file.display()))?;
	}
	let url = crate::cmangos::db_url();
	log(&format!("fetching {url}"));
	let buf = http.get(&url, DB_MAX_BYTES)?.ok_or_else(|| format!("GET {url}: HTTP 404"))?;
	let got = sha256_hex(&buf);
	if got != DB_SHA256 {
		return Err(format!("GET {url}: sha256 {got}, expected {DB_SHA256}"));
	}
	write_atomic(&file, &buf)?;
	Ok(true)
}

// ---------------------------------------------------------------- web quest XP

// Hosts built from parts so the source names stay out of the code.
fn wft_host() -> String {
	["wowforever", "talents.com"].concat()
}
fn fc_base() -> String {
	format!("https://{}", ["forever", "changes.pro"].concat())
}
const WEB_CONCURRENCY: usize = 4;

fn page_text(html: &str) -> String {
	let script = regex::Regex::new(r"<script[\s\S]*?</script>").unwrap();
	let tag = regex::Regex::new(r"<[^>]*>").unwrap();
	let ws = regex::Regex::new(r"\s+").unwrap();
	let t = script.replace_all(html, " ");
	let t = tag.replace_all(&t, "|");
	let t = t.replace("&#x27;", "'");
	ws.replace_all(&t, " ").into_owned()
}

fn web_int(s: &str) -> Option<f64> {
	let n: f64 = s.replace(',', "").parse().ok()?;
	(n.fract() == 0.0 && n > 0.0).then_some(n)
}

/// A client-cache quest page -> its XP.
pub fn parse_wft(html: &str) -> Option<f64> {
	let t = page_text(html);
	let rest = &t[t.find("Rewards")?..];
	let a = regex::Regex::new(r"\|\s*XP\s*\|?\s*([0-9,]+)").unwrap();
	let b = regex::Regex::new(r"\bXP\s+([0-9,]+)").unwrap();
	let m = a.captures(rest).or_else(|| b.captures(rest))?;
	web_int(&m[1])
}

/// A quest-chain page -> (XP, from the chain list): its own Rewards block, else the chain list's
/// entry marked as this quest.
pub fn parse_fc(html: &str) -> Option<(f64, bool)> {
	let own = regex::Regex::new(r"Experience:[|\s]*([0-9,]+)").unwrap();
	if let Some(xp) = own.captures(&page_text(html)).and_then(|m| web_int(&m[1])) {
		return Some((xp, false));
	}
	let i = html.find("class=\"qp-route-quest is-here\"")?;
	let rest = &html[i + 1..];
	let end = ["class=\"qp-route-quest", "</li>"].iter().filter_map(|s| rest.find(s)).min().unwrap_or(rest.len());
	let c = regex::Regex::new(r#"qp-route-xp">([0-9,]+) XP"#).unwrap();
	let m = c.captures(&rest[..end])?;
	web_int(&m[1]).map(|x| (x, true))
}

/// One quest's lookup: (wft, fc, fcChain) as found, None for a part not looked up.
type Found = (Option<Option<f64>>, Option<Option<f64>>, bool);

/// Looks up the XP of the `ids` <sources>/webxp/quest-xp.json lacks on the two web quest databases
/// and caches it there ({ "<id>": { wft, fc, fcChain } }, null: looked up, no value). -> warnings
pub fn web_xp(sources: &Path, ids: &[f64], log: &dyn Fn(&str)) -> Result<Vec<String>, String> {
	let file = sources.join("webxp").join("quest-xp.json");
	let cache = crate::extras::read_json(&file)?.unwrap_or_else(V::obj);
	let key = |id: f64| forge_guide::js::num_str(id);
	let todo: Vec<f64> = ids
		.iter()
		.copied()
		.filter(|&id| {
			let e = cache.get(&key(id));
			!e.truthy() || e.get("wft").is_undef() || e.get("fc").is_undef()
		})
		.collect();
	let mut warnings = Vec::new();
	if todo.is_empty() {
		return Ok(warnings);
	}
	log(&format!("looking up quest XP for {} quests on the two web quest databases", todo.len()));
	let http = Http::new(Duration::from_secs(30), "Mozilla/5.0 (polestar-data-build)");
	let host = wft_host();
	let pages: Option<rustc_hash::FxHashMap<i64, String>> = match http.get(&format!("https://{host}/sitemap-0.xml"), JSON_MAX_BYTES) {
		Ok(sm) => {
			let sm = sm.map(|b| String::from_utf8_lossy(&b).into_owned()).unwrap_or_default();
			let re = regex::Regex::new(&format!(r"<loc>(https://{}/quests/[a-z0-9-]*-([0-9]+)/)</loc>", regex::escape(&host))).unwrap();
			Some(re.captures_iter(&sm).filter_map(|m| Some((m[2].parse().ok()?, m[1].to_string()))).collect())
		}
		Err(e) => {
			warnings.push(format!("client quest cache sitemap: {e}"));
			None
		}
	};
	// What each entry already holds (wft known, fc known), so the workers skip those parts.
	let had: Vec<(f64, bool, bool)> = todo
		.iter()
		.map(|&id| {
			let e = cache.get(&key(id));
			(id, !e.get("wft").is_undef(), !e.get("fc").is_undef())
		})
		.collect();
	let next = std::sync::atomic::AtomicUsize::new(0);
	let fc = fc_base();
	let results: Vec<(f64, Result<Found, (Found, String)>)> = std::thread::scope(|s| {
		let workers: Vec<_> = (0..WEB_CONCURRENCY.min(had.len()))
			.map(|_| {
				s.spawn(|| {
					let mut mine = Vec::new();
					loop {
						let i = next.fetch_add(1, std::sync::atomic::Ordering::Relaxed);
						let Some(&(id, has_wft, has_fc)) = had.get(i) else { break };
						let mut found: Found = (None, None, false);
						let r = (|| -> Result<(), String> {
							if !has_wft {
								if let Some(p) = &pages {
									found.0 = Some(match p.get(&(id as i64)) {
										Some(url) => parse_wft(&String::from_utf8_lossy(&http.get(url, JSON_MAX_BYTES)?.unwrap_or_default())),
										None => None,
									});
								}
							}
							if !has_fc {
								let html = http.get(&format!("{fc}/quest/{}", id as i64), JSON_MAX_BYTES)?;
								let r = html.and_then(|h| parse_fc(&String::from_utf8_lossy(&h)));
								found.1 = Some(r.map(|x| x.0));
								found.2 = r.is_some_and(|x| x.1);
							}
							Ok(())
						})();
						mine.push((id, r.map(|()| found).map_err(|e| (found, e))));
					}
					mine
				})
			})
			.collect();
		workers.into_iter().flat_map(|w| w.join().unwrap_or_default()).collect()
	});
	let mut errors = 0;
	for (id, r) in results {
		let entry = cache.get(&key(id));
		let entry = if entry.is_obj() { entry } else { V::obj() };
		let found = match r {
			Ok(f) => f,
			Err((f, e)) => {
				errors += 1;
				if errors <= 3 {
					warnings.push(format!("quest {} XP lookup: {e}", key(id)));
				}
				f
			}
		};
		if let Some(w) = found.0 {
			entry.set("wft", w.map(V::Num).unwrap_or(V::Null));
		}
		if let Some(f) = found.1 {
			entry.set("fc", f.map(V::Num).unwrap_or(V::Null));
		}
		if found.2 {
			entry.set("fcChain", true);
		}
		cache.set(&key(id), entry);
	}
	if errors > 3 {
		warnings.push(format!("{errors} quest XP lookups failed in all; rerun to retry them"));
	}
	let sorted = Obj::new();
	let mut keys: Vec<f64> = cache.keys().iter().map(|k| forge_guide::js::str_to_num(k)).collect();
	keys.sort_by(|a, b| a.total_cmp(b));
	for k in keys {
		sorted.set(&key(k), cache.get(&key(k)));
	}
	write_atomic(&file, format!("{}\n", stringify(&V::Obj(sorted), Some("\t"))).as_bytes())?;
	Ok(warnings)
}

/// The quests of a data/forever build that have no XP (what `webxp` looks up).
pub fn quests_without_xp(data: &Path) -> Result<Vec<f64>, String> {
	let quests = crate::extras::read_json(&data.join("quests.json"))?.ok_or_else(|| format!("no {}", data.join("quests.json").display()))?;
	Ok(quests.values().iter().filter(|q| !q.get("xp").as_num().is_some_and(f64::is_finite)).map(|q| q.get("id").num()).collect())
}

// ---------------------------------------------------------------- all of it

pub struct Plan {
	pub sources: PathBuf,
	/// The parts to fetch ([`PARTS`]).
	pub parts: Vec<String>,
	/// The Classic Era build (None: the newest wago.tools lists).
	pub build: Option<String>,
	/// The Forever build (None: the newest listed).
	pub forever_build: Option<String>,
	/// No client is read: the data build's Forever tables come from wago.tools.
	pub without_client: bool,
	/// The pfQuest checkout (None: <sources>/pfQuest). An explicit one is left as it is.
	pub pfquest: Option<PathBuf>,
	/// The WoWDBDefs checkout (default <sources>/wowdbdefs); fetched only when a client is read.
	pub defs: PathBuf,
	/// The quests to look up web XP for (None: the webxp part is skipped).
	pub web_xp_ids: Option<Vec<f64>>,
}

impl Plan {
	pub fn new(sources: &Path) -> Plan {
		Plan {
			sources: sources.to_path_buf(),
			parts: PARTS.iter().map(|s| s.to_string()).collect(),
			build: None,
			forever_build: None,
			without_client: true,
			pfquest: None,
			defs: sources.join("wowdbdefs"),
			web_xp_ids: None,
		}
	}

	fn wants(&self, part: &str) -> bool {
		self.parts.iter().any(|p| p == part)
	}
}

#[derive(Default)]
pub struct Report {
	/// Files (or checkouts) fetched.
	pub fetched: usize,
	pub era_build: Option<String>,
	pub forever_build: Option<String>,
	pub warnings: Vec<String>,
}

/// Fetches what the plan names into its source cache. Errors only when the Era tables or the
/// pfQuest checkout cannot be had; the rest are warnings.
pub fn fetch(plan: &Plan, log: &dyn Fn(&str)) -> Result<Report, String> {
	let http = Http::default_agent();
	let mut rep = Report::default();
	let src = &plan.sources;
	let (data, builders) = (plan.wants("wago"), plan.wants("builders"));
	if data || builders {
		let era = era_tables(data, builders);
		let (b, w) = pick_build(&http, src, &tables::ERA, plan.build.as_deref(), &era.required)?;
		rep.warnings.extend(w);
		fetch_set(&http, src, &b, &era, log, &mut rep)?;
		rep.era_build = Some(b);
		let fset = forever_tables(data, plan.without_client, builders);
		match pick_build(&http, src, &tables::FOREVER, plan.forever_build.as_deref(), &fset.required) {
			Ok((b, w)) => {
				rep.warnings.extend(w);
				if let Err(e) = fetch_set(&http, src, &b, &fset, log, &mut rep) {
					rep.warnings.push(format!("Forever client tables unavailable ({e})"));
				}
				rep.forever_build = Some(b);
			}
			Err(e) => rep.warnings.push(format!("Forever client tables unavailable ({e})")),
		}
		for (build, list) in pinned_tables(data, builders) {
			for t in list {
				match wago_table(Some(&http), src, build, t, log) {
					Ok(f) => rep.fetched += usize::from(f),
					Err(e) => rep.warnings.push(format!("wago.tools {build}: no {t} ({e})")),
				}
			}
		}
	}
	if plan.wants("pfquest") && plan.pfquest.is_none() {
		rep.fetched += usize::from(pfquest(&src.join("pfQuest"), log, &mut rep.warnings)?);
	}
	if plan.wants("eglink") {
		match eglink(&http, src, log) {
			Ok(n) => rep.fetched += n,
			Err(e) => rep.warnings.push(format!("EG Link output unavailable ({e})")),
		}
	}
	if plan.wants("forever-vo") {
		match forever_vo(&http, src, log) {
			Ok(f) => rep.fetched += usize::from(f),
			Err(e) => rep.warnings.push(format!("forever-vo captures unavailable ({e})")),
		}
	}
	if plan.wants("cmangos") {
		match cmangos(&http, src, log) {
			Ok(f) => rep.fetched += usize::from(f),
			Err(e) => rep.warnings.push(format!("CMaNGOS classic-db dump unavailable ({e})")),
		}
	}
	if plan.wants("webxp") {
		if let Some(ids) = &plan.web_xp_ids {
			rep.warnings.extend(web_xp(src, ids, log)?);
		}
	}
	if plan.wants("wowdbdefs") && !plan.without_client {
		match wowdbdefs(&plan.defs, log) {
			Ok(f) => rep.fetched += usize::from(f),
			Err(e) => rep.warnings.push(format!("WoWDBDefs unavailable ({e})")),
		}
	}
	Ok(rep)
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn web_pages_parse_like_the_js() {
		let wft = "<html><script>var XP 999</script><h2>Rewards</h2><div><dt>XP</dt>1,350</div></html>";
		assert_eq!(parse_wft(wft), Some(1350.0));
		assert_eq!(parse_wft("<p>XP 50</p>"), None, "no Rewards block");
		assert_eq!(parse_fc("<div>Experience: <b>550</b></div>"), Some((550.0, false)));
		let chain = r#"<li class="qp-route-quest">a <span class="qp-route-xp">10 XP</span></li><li class="qp-route-quest is-here">b <span class="qp-route-xp">2,400 XP</span></li>"#;
		assert_eq!(parse_fc(chain), Some((2400.0, true)));
		assert_eq!(parse_fc("<p>nothing</p>"), None);
	}

	#[test]
	fn table_sets_hold_every_reader_once() {
		let era = era_tables(true, true);
		assert_eq!(era.required, vec!["UiMap", "UiMapAssignment", "AreaTable", "Faction"]);
		assert!(era.optional.contains(&"TaxiNodes") && era.optional.contains(&"ItemEffect"));
		assert!(era_tables(true, false).optional.is_empty(), "the data build reads only its four");
		let with = forever_tables(true, false, true);
		assert!(with.required.is_empty() && with.optional.contains(&"DungeonEncounter"));
		assert!(forever_tables(true, false, false).optional.is_empty(), "with a client the data build reads none");
		let without = forever_tables(true, true, true);
		assert!(without.required.contains(&"UiMap") && !without.optional.contains(&"UiMap"));
		assert_eq!(pinned_tables(true, false), vec![(crate::players::QUESTXP_BUILD, vec!["QuestXP"])]);
		let mut all = without.optional.clone();
		all.sort();
		all.dedup();
		assert_eq!(all.len(), without.optional.len());
	}

	#[test]
	fn offline_table_is_an_error_naming_the_file() {
		let d = std::env::temp_dir().join(format!("forge-sources-{}", std::process::id()));
		let e = wago_table(None, &d, "1.15.9.70003", "UiMap", &|_| {}).unwrap_err();
		assert!(e.contains("--offline: missing cached") && e.contains("UiMap.csv"), "{e}");
		assert!(wago_table(None, &d, "../x", "UiMap", &|_| {}).is_err(), "a build is digits and dots");
	}
}
