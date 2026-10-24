//! `forge data publish`: the public quest-data release ("public tier").
//!
//! The full KB stays local. The release holds only values an independent, shippable source holds
//! (client tables, CMaNGOS/VMaNGOS, ForeverTDB, EG Link, pfQuest, QuestieDB, Factoruide rows not
//! sourced from the site, the Factoruide collector, our recordings, and our corrections when an
//! independent source agrees), in our own clean schema, without per-value source names. Every
//! value's provenance goes to a private sidecar sqlite outside the release folder.
//!
//! Without a KB (CI, contributors) the release is built from the public data builds alone, with
//! corrections applied only when one of their `source` kinds names an independent check.

pub mod check;
pub mod inputs;
pub mod lua;
pub mod notes;
pub mod release;
pub mod schema;
pub mod tables;
pub mod tier;

use std::path::{Path, PathBuf};

use crate::tables::Source;

pub struct Options {
	pub root: PathBuf,
	pub out: PathBuf,
	/// The KB's sqlite; build-only mode when it does not exist.
	pub kb: PathBuf,
	/// A public data build with QuestieDB (entities, quest links, spawns); None: built into a
	/// temp folder.
	pub public_data: Option<PathBuf>,
	/// A public data build without QuestieDB (drops); None: built into a temp folder.
	pub public_drops: Option<PathBuf>,
	pub provenance: PathBuf,
	pub previous: Option<PathBuf>,
	pub version: Option<String>,
	/// Also write forever-db-<version>.zip beside `out`.
	pub zip: bool,
	/// Also write the tables as one sqlite file here.
	pub sqlite: Option<PathBuf>,
	pub factoruide: Option<PathBuf>,
	pub cmangos: Option<PathBuf>,
	/// The source cache (CMaNGOS quest_facts.json is read, or extracted and cached, there).
	pub sources: PathBuf,
	pub tdb: Option<PathBuf>,
	/// The corrections: forever-db/corrections (section files and notes.json) or the old single file.
	pub corrections: PathBuf,
	/// The note-fix records (default: notes.json beside the corrections' section files).
	pub note_fixes: Option<PathBuf>,
	/// The rewritten quest notes (quest-notes.json); None: the KB's steps, no notes.
	pub notes: Option<PathBuf>,
	pub producer_commit: Option<String>,
	/// The release date (YYYY-MM-DD; default: today, or SOURCE_DATE_EPOCH).
	pub date: Option<String>,
	/// The local evidence quotes (data/local/mechanics/evidence): steps running 8 words of page
	/// text are held.
	pub evidence: Option<PathBuf>,
}

impl Options {
	pub fn new(root: &Path, out: &Path) -> Options {
		let local = root.join("data").join("local");
		Options {
			root: root.to_path_buf(),
			out: out.to_path_buf(),
			kb: local.join("kb").join("forever-kb.sqlite"),
			public_data: None,
			public_drops: None,
			provenance: local.join("publish").join("provenance.sqlite"),
			previous: None,
			version: None,
			zip: false,
			sqlite: None,
			factoruide: Some(local.join("factcheck").join("sources").join("factoruide-forever.sqlite")),
			cmangos: Some(local.join("mechanics").join("cm.db")),
			sources: root.join("data").join("sources"),
			tdb: Some(local.join("forever-tdb").join("world.sqlite")),
			corrections: crate::corrections::locate(root),
			note_fixes: None,
			notes: None,
			producer_commit: None,
			date: None,
			evidence: Some(local.join("mechanics").join("evidence")),
		}
	}
}

pub struct Summary {
	pub version: String,
	pub client_build: String,
	pub counts: Vec<(&'static str, usize)>,
	pub coverage: Vec<(String, usize, usize)>,
	pub cuts: Vec<(String, usize)>,
	pub held: Vec<(String, usize)>,
	pub zip: Option<(PathBuf, u64)>,
	pub sqlite: Option<(PathBuf, u64)>,
	/// The note-fix records per ledger status (applied, stale, conflicting).
	pub ledger: std::collections::BTreeMap<&'static str, usize>,
	pub notes: Vec<String>,
}

/// Civil date of a Unix day number.
fn ymd(days: i64) -> (i64, u32, u32) {
	let z = days + 719468;
	let era = z.div_euclid(146097);
	let doe = z.rem_euclid(146097);
	let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
	let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
	let mp = (5 * doy + 2) / 153;
	let d = (doy - (153 * mp + 2) / 5 + 1) as u32;
	let m = if mp < 10 { mp + 3 } else { mp - 9 } as u32;
	(yoe + era * 400 + i64::from(m <= 2), m, d)
}

fn today() -> String {
	let secs = std::env::var("SOURCE_DATE_EPOCH")
		.ok()
		.and_then(|s| s.parse::<i64>().ok())
		.unwrap_or_else(|| std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map(|d| d.as_secs() as i64).unwrap_or(0));
	let (y, m, d) = ymd(secs.div_euclid(86400));
	format!("{y:04}-{m:02}-{d:02}")
}

/// CalVer YYYY.MM.N: N one above the previous release's when it is of the same month.
fn next_version(date: &str, previous: Option<&Path>) -> String {
	let ym = format!("{}.{}", &date[0..4], date[5..7].trim_start_matches('0'));
	let prev = previous.and_then(release_version);
	let n = match prev {
		Some(v) => match v.rsplit_once('.') {
			Some((head, n)) if head == ym => n.parse::<u32>().unwrap_or(0) + 1,
			_ => 1,
		},
		None => 1,
	};
	format!("{ym}.{n}")
}

/// A release folder's version (index.json).
pub fn release_version(dir: &Path) -> Option<String> {
	let b = std::fs::read(dir.join("index.json")).ok()?;
	serde_json::from_slice::<serde_json::Value>(&b).ok()?.get("version")?.as_str().map(String::from)
}

/// --producer-commit, else $PRODUCER_COMMIT, else this forge's git HEAD.
fn producer_commit() -> String {
	if let Some(c) = std::env::var("PRODUCER_COMMIT").ok().filter(|c| !c.trim().is_empty()) {
		return c.trim().to_string();
	}
	std::process::Command::new("git")
		.args(["rev-parse", "HEAD"])
		.current_dir(env!("CARGO_MANIFEST_DIR"))
		.output()
		.ok()
		.filter(|o| o.status.success())
		.map(|o| String::from_utf8_lossy(&o.stdout).trim().to_string())
		.unwrap_or_else(|| "unknown".into())
}

/// The data build options of a public build: no site or web sources, no corrections (the tier
/// decides which corrections count), QuestieDB only when asked.
pub fn public_build_options(root: &Path, sources: &Path, questie: bool, empty_corrections: &Path) -> crate::Options {
	let mut o = crate::Options::new(root);
	o.sources = sources.to_path_buf();
	o.web_xp = false;
	o.web_zones = false;
	o.corrections = empty_corrections.to_path_buf();
	o.questie = if questie { crate::questie::detect_questie() } else { None };
	let defs = o.sources.join("wowdbdefs");
	o.forever_source = match forge_gamedata::find_install() {
		Some(w) if defs.join("definitions").is_dir() => Source::Client { wow: w, product: "wow_classic_beta".into(), defs },
		_ => Source::Wago,
	};
	o
}

fn inside(path: &Path, dir: &Path) -> bool {
	let abs = |p: &Path| -> PathBuf {
		let p = if p.is_absolute() { p.to_path_buf() } else { std::env::current_dir().unwrap_or_default().join(p) };
		let mut out = PathBuf::new();
		for c in p.components() {
			match c {
				std::path::Component::ParentDir => {
					out.pop();
				}
				std::path::Component::CurDir => {}
				c => out.push(c),
			}
		}
		out
	};
	abs(path).starts_with(abs(dir))
}

fn existing(p: &Option<PathBuf>) -> Option<&Path> {
	p.as_deref().filter(|p| p.is_file())
}

pub fn run(o: &Options, log: &dyn Fn(&str)) -> Result<Summary, String> {
	if inside(&o.provenance, &o.out) {
		return Err(format!("--provenance {} is inside the release folder {}; the sidecar stays outside", o.provenance.display(), o.out.display()));
	}
	let mut notes = Vec::new();
	// The public builds.
	let tmp = std::env::temp_dir().join(format!("polestar-publish-{}", std::process::id()));
	let mut built = |questie: bool| -> Result<PathBuf, String> {
		let dir = tmp.join(if questie { "with-questie" } else { "without-questie" });
		std::fs::create_dir_all(&dir).map_err(|e| format!("{}: {e}", dir.display()))?;
		let empty = tmp.join("corrections.json");
		std::fs::write(&empty, "{}\n").map_err(|e| format!("{}: {e}", empty.display()))?;
		let mut bo = public_build_options(&o.root, &o.sources, questie, &empty);
		bo.corrections_private = None;
		if questie && bo.questie.is_none() {
			notes.push("QuestieDB not found: the entity build runs without it".to_string());
		}
		log(&format!("public data build ({} QuestieDB) into {}", if questie { "with" } else { "without" }, dir.display()));
		let out = crate::run(&bo, log)?;
		crate::write(&dir, &out)?;
		Ok(dir)
	};
	let data_dir = match &o.public_data {
		Some(d) => d.clone(),
		None => built(true)?,
	};
	let drops_dir = match &o.public_drops {
		Some(d) => d.clone(),
		None => built(false)?,
	};
	let data = inputs::load_build(&data_dir)?;
	let drops = if drops_dir == data_dir { None } else { Some(inputs::load_build(&drops_dir)?) };
	let kb = if o.kb.is_file() {
		log(&format!("KB: {}", o.kb.display()));
		Some(inputs::load_kb(&o.kb)?)
	} else {
		notes.push(format!("no KB at {}: build-only release from the public data builds", o.kb.display()));
		None
	};
	let factoruide = match (kb.as_ref().is_some_and(|k| k.factoruide_split), existing(&o.factoruide)) {
		(true, _) => None,
		(false, Some(p)) => {
			log(&format!("Factoruide row sources: {}", p.display()));
			Some(inputs::load_factoruide(p)?)
		}
		(false, None) => {
			if kb.is_some() {
				notes.push("Factoruide: no factoruide.web split in the KB and no Factoruide sqlite; its values back nothing".into());
			}
			None
		}
	};
	let mut cmv = inputs::Cm::default();
	let mut have_cm = false;
	match inputs::load_cm_facts(&o.sources, &mut cmv) {
		Ok(()) => have_cm = true,
		Err(e) => notes.push(format!("CMaNGOS quest facts unavailable ({e}): no CMaNGOS rewards, money, types, zones or factions")),
	}
	match existing(&o.cmangos) {
		Some(p) => {
			log(&format!("CMaNGOS classic-db sqlite: {}", p.display()));
			inputs::load_cm_db(p, &mut cmv)?;
			have_cm = true;
		}
		None => notes.push("no CMaNGOS classic-db sqlite: no loot chances, object or item names from it".into()),
	}
	let cm = have_cm.then_some(cmv);
	let tdb = match existing(&o.tdb) {
		Some(p) => {
			log(&format!("ForeverTDB: {}", p.display()));
			Some(inputs::load_tdb(p)?)
		}
		None => {
			notes.push("no ForeverTDB sqlite: no disabled-quest filter, no sniffed rewards or factions".into());
			None
		}
	};
	if kb.as_ref().is_some_and(|k| k.steps.is_none()) {
		notes.push("steps held: the KB's steps carry no source/evidence columns yet".into());
	}
	let corrections = if o.corrections.exists() {
		Some(serde_json::from_str::<serde_json::Value>(&crate::corrections::read_text(&o.corrections)?).map_err(|e| format!("{}: {e}", o.corrections.display()))?)
	} else {
		None
	};
	let read_json =
		|p: &Path| -> Result<serde_json::Value, String> { serde_json::from_slice(&std::fs::read(p).map_err(|e| format!("{}: {e}", p.display()))?).map_err(|e| format!("{}: {e}", p.display())) };
	let quest_notes = match &o.notes {
		Some(p) => {
			log(&format!("quest notes: {}", p.display()));
			Some(read_json(p)?)
		}
		None => None,
	};
	let fixes_path = o.note_fixes.clone().or_else(|| o.corrections.is_dir().then(|| o.corrections.join("notes.json")));
	let fixes = match fixes_path.as_deref().filter(|p| p.is_file()) {
		Some(p) => read_json(p)?,
		None => serde_json::json!({}),
	};
	let evidence = match o.evidence.as_deref().filter(|d| d.is_dir()) {
		Some(d) => {
			log(&format!("page-text evidence quotes: {}", d.display()));
			Some(check::evidence_shingles(d)?)
		}
		None => {
			if kb.as_ref().is_some_and(|k| k.steps.is_some()) {
				notes.push("no evidence folder: steps are not screened for 8-word runs of page text (publish --check still is, with --evidence)".into());
			}
			None
		}
	};
	let inp = tables::Inputs {
		kb: kb.as_ref(),
		factoruide: factoruide.as_ref(),
		cm: cm.as_ref(),
		tdb: tdb.as_ref(),
		data: &data,
		drops: drops.as_ref().unwrap_or(&data),
		corrections: if kb.is_none() { corrections.as_ref() } else { None },
		notes: quest_notes.as_ref(),
		evidence: evidence.as_ref(),
	};
	let mut t = tables::assemble(&inp)?;
	let published: std::collections::BTreeSet<i64> = t.by.get("quest").into_iter().flatten().filter_map(|r| r.row.get("id").and_then(serde_json::Value::as_i64)).collect();
	let ledger = notes::apply(&mut t, &fixes, &published);
	for r in ledger.iter().filter(|r| r.status != "applied") {
		notes.push(format!("note fix {}: {} ({})", r.record, r.status, r.detail));
	}
	let date = o.date.clone().unwrap_or_else(today);
	// The version: given; else the next after --previous; else the one already in --out (a re-run
	// writes the same release); else the month's first.
	let version = o.version.clone().or_else(|| o.previous.is_none().then(|| release_version(&o.out)).flatten()).unwrap_or_else(|| next_version(&date, o.previous.as_deref()));
	if !regex::Regex::new(r"^\d{4}\.\d{1,2}\.\d+$").unwrap().is_match(&version) {
		return Err(format!("--version {version}: YYYY.MM.N"));
	}
	let client_build = data.client_build().unwrap_or_else(|| "unknown".into());
	let meta = release::Meta {
		client_build: client_build.clone(),
		version: version.clone(),
		date,
		producer_commit: o.producer_commit.clone().unwrap_or_else(producer_commit),
		pfquest_notice: data.pfquest_notice(),
	};
	release::write(&o.out, &t, &meta, o.previous.as_deref(), &notes::ledger_md(&ledger))?;
	if corrections.is_some() {
		release::copy_corrections(&o.corrections, &o.out)?;
	}
	if let Some(p) = fixes_path.as_deref().filter(|p| p.is_file()) {
		let dst = o.out.join("corrections").join("notes.json");
		if p.canonicalize().ok() != dst.canonicalize().ok() {
			std::fs::copy(p, &dst).map_err(|e| format!("{}: {e}", dst.display()))?;
		}
	}
	release::write_sidecar(&o.provenance, &t, &meta)?;
	let ex = export(&o.out, o.zip, o.sqlite.as_deref())?;
	if o.public_data.is_none() || o.public_drops.is_none() {
		let _ = std::fs::remove_dir_all(&tmp);
	}
	let mut cuts: std::collections::BTreeMap<String, usize> = Default::default();
	for c in &t.cuts {
		*cuts.entry(format!("{}.{}", c.table, c.field)).or_default() += 1;
	}
	Ok(Summary {
		version,
		client_build,
		counts: schema::TABLES.iter().map(|d| (d.name, t.by.get(d.name).map_or(0, Vec::len))).collect(),
		coverage: t.coverage.clone(),
		cuts: cuts.into_iter().collect(),
		held: t.held.clone().into_iter().collect(),
		zip: ex.zip,
		sqlite: ex.sqlite,
		ledger: ledger.iter().fold(std::collections::BTreeMap::new(), |mut m, r| {
			*m.entry(r.status).or_insert(0usize) += 1;
			m
		}),
		notes,
	})
}

/// What [`export`] wrote.
#[derive(Default)]
pub struct Exported {
	pub zip: Option<(PathBuf, u64)>,
	pub sqlite: Option<(PathBuf, u64)>,
}

/// From a release folder: forever-db-<version>.zip beside it (the folder under `forever-db/`), and
/// the tables as one sqlite file.
pub fn export(dir: &Path, zip: bool, sqlite: Option<&Path>) -> Result<Exported, String> {
	let version = release_version(dir).ok_or_else(|| format!("{}: no index.json version (not a release folder)", dir.display()))?;
	let mut ex = Exported::default();
	if zip {
		let name = format!("forever-db-{version}.zip");
		let abs = std::path::absolute(dir).unwrap_or_else(|_| dir.to_path_buf());
		let p = abs.parent().map(|d| d.join(&name)).unwrap_or_else(|| PathBuf::from(&name));
		let n = release::zip(dir, &p, "forever-db")?;
		ex.zip = Some((p, n));
	}
	if let Some(p) = sqlite {
		let n = release::sqlite(dir, p)?;
		ex.sqlite = Some((p.to_path_buf(), n));
	}
	Ok(ex)
}
