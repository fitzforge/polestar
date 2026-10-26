//! Seeded defects: how many of each defect class the judge's checks catch.
//!
//! Each class of tests/seeded/ops.rs (the 122 labelled review rows' kinds, the ten classes an earlier judge
//! review found no check caught, and R1-R10's) is seeded into the shipped Orc Warrior (8 guides, 1-30) and Human Warrior
//! (7 guides) chains at 10 sites (5 a chain when both have them; seeded splitmix64, one site per mutant).
//! Every check runs on each mutant (tests/seeded/harness.rs): honest default (R1-R10), honest legacy
//! (R1-R5), the judge walk's passed-by and avoidable returns, the guide-text gate metrics, the engine replay
//! (stuck, missing location) and the compiler's diagnostics (lint). A check catches a mutant when it has a
//! finding the unmutated chain has not (same rule and text at the same baseline line) that lands in a step
//! the mutation touched, or names one of its quests; for the guide-text scorer, when a gate metric gets
//! worse (it reports totals, so the single-site mutant is the attribution).
//!
//! Levels: $POLESTAR_JSREF/{orc30,human30}.json (the JS walk) and gt/shipped-*.json (the guide-text replay) fit
//! only the unmutated goal lists, so every run aligns its goals to the baseline's by goal key and
//! interpolates the dump's levels by goal index (harness::Aligned; exact on the baseline). A mutation that
//! adds a grind or moves work therefore cannot change levels or hours: the sim evaluator is not in Rust.
//!
//! Then the same checks run on the real defects: the 122 rows of the v2 slice's player review
//! (rows in tests/seeded/review-rows.tsv) on the repaired guides, and
//! the shipped review's rows (levels 1-30) on the shipped guides at the commit it read
//! (eb7b47840): a row is caught by a check with a finding in a step the row cites.
//!
//! cargo test --release -p forge-judge --test seeded -- --nocapture
//! (POLESTAR_SEEDED_N=<sites per class>, POLESTAR_SEEDED_ONLY=<class id,...>; the report is also written
//! to rust/target/seeded.md)

#[path = "../seeded/harness.rs"]
mod harness;
#[path = "../seeded/ops.rs"]
mod ops;

use forge_core::Faction;
use harness::*;
use ops::{cands, Cx, Ed, Line, Model, Rng, CLASSES};
use rustc_hash::FxHashSet;
use std::fmt::Write as _;
use std::path::{Path, PathBuf};
use std::sync::atomic::{AtomicUsize, Ordering};
use std::sync::Barrier;
use std::time::Instant;

const NCHK: usize = CHECKS.len();
const SHIPPED_REV: &str = "eb7b47840";

fn shipped(name: &str) -> ChainDef {
	let (faction, race, files, walk, gt): (Faction, &str, &[&str], &str, &str) = match name {
		"orc" => (
			Faction::Horde,
			"Orc",
			&[
				"forever/horde/orc-troll/01-durotar",
				"forever/horde/orc-troll/02-the-barrens",
				"forever/horde/02-the-barrens",
				"forever/horde/03-silverpine-forest",
				"forever/horde/04-the-barrens",
				"forever/horde/05-stonetalon-mountains",
				"forever/horde/06-hillsbrad-foothills",
				"forever/horde/07-ashenvale",
			],
			"orc30.json",
			"gt/shipped-orc.json",
		),
		_ => (
			Faction::Alliance,
			"Human",
			&[
				"forever/alliance/human/01-elwynn-forest",
				"forever/alliance/02-westfall",
				"forever/alliance/03-darkshore",
				"forever/alliance/04-redridge-mountains",
				"forever/alliance/05-duskwood",
				"forever/alliance/06-ashenvale",
				"forever/alliance/07-thousand-needles",
			],
			"human30.json",
			"gt/shipped-human.json",
		),
	};
	let ids: Vec<String> = files.iter().map(|s| s.to_string()).collect();
	ChainDef {
		name: format!("shipped-{name}"),
		faction,
		race: race.into(),
		dir: main_dir().join("guides"),
		files: ids.iter().map(|i| format!("{i}.guide")).collect(),
		start: ids[0].clone(),
		walk_ids: ids.clone(),
		gt_ids: ids,
		walk_dump: rsj().join(walk),
		gt_dump: rsj().join(gt),
	}
}

/// The v2 slice (repaired writer output): every guide of the pack; chains as the JS walks took them.
fn v2(name: &str) -> Option<ChainDef> {
	let (faction, race, pack, sub, walk, gt) = match name {
		"orc" => (Faction::Horde, "Orc", "horde-orc-troll-warrior", "forever/horde/orc-troll-warrior", "v2orc61.json", "gt/v2-orc.json"),
		_ => (Faction::Alliance, "Human", "alliance-human-warrior", "forever/alliance/human-warrior", "v2human61.json", "gt/v2-human.json"),
	};
	let dir = v2_dir().join(pack);
	let mut files: Vec<String> =
		std::fs::read_dir(dir.join(sub)).ok()?.filter_map(|e| e.ok()).map(|e| e.file_name().to_string_lossy().into_owned()).filter(|f| f.ends_with(".guide")).map(|f| format!("{sub}/{f}")).collect();
	files.sort();
	let ids = |p: &Path, ptr: &str| -> Option<Vec<String>> {
		let v: serde_json::Value = serde_json::from_slice(&std::fs::read(p).ok()?).ok()?;
		Some(v.pointer(ptr)?.as_array()?.iter().filter_map(|x| x.as_str().map(str::to_string)).collect())
	};
	let (wd, gd) = (rsj().join(walk), rsj().join(gt));
	Some(ChainDef {
		name: format!("v2-{name}"),
		faction,
		race: race.into(),
		start: files.iter().find(|f| f.contains("/01-") && !f.contains("catchup"))?.trim_end_matches(".guide").to_string(),
		files,
		dir,
		walk_ids: ids(&wd, "/chain")?,
		gt_ids: ids(&gd, "/res/chain")?,
		walk_dump: wd,
		gt_dump: gd,
	})
}

/// A mutant's result.
struct Res {
	class: usize,
	chain: String,
	desc: String,
	caught: [bool; NCHK],
	offsite: [bool; NCHK],
	rules: Vec<String>,
	worse: Vec<String>,
	/// What each catching check said (check: finding), deduplicated.
	how: Vec<String>,
}

/// A labelled review row and which checks land on it.
struct RowRes {
	set: String,
	id: String,
	kind: String,
	severity: String,
	review: String,
	feasible: bool,
	caught: [bool; NCHK],
	how: Vec<String>,
	/// The chance a check (and, last, any check) lands on the row's steps at random: 1 - (1 - d)^k for the
	/// share d of steps the check has a finding in (files the set's rows cite) and k the steps the row cites.
	chance: [f64; NCHK + 1],
	/// The same on the cited lines only (no widening to steps); chance from the share of lines with a finding.
	caught_line: [bool; NCHK],
	chance_line: [f64; NCHK + 1],
}

fn step_ranges(lines: &[Line], spill: usize) -> Vec<(u32, u32)> {
	let starts: Vec<usize> = lines.iter().enumerate().filter(|(_, l)| l.text.starts_with("step")).map(|(i, _)| i).collect();
	let mut out = Vec::new();
	for (i, l) in lines.iter().enumerate() {
		if !l.mark {
			continue;
		}
		let k = starts.iter().rposition(|&s| s <= i);
		let s = k.map_or(0, |k| starts[k]);
		let e = k.map_or(0, |k| k + 1 + spill).min(starts.len());
		let end = starts.get(e).map_or(lines.len(), |&n| n);
		out.push((s as u32 + 1, end as u32));
	}
	out
}

fn evaluate(sh: &Shared, prep: &Prepared, base: &Out, base_set: &FxHashSet<(usize, String, u32, String)>, class: usize, files: Vec<(usize, Vec<Line>)>, info: ops::Info) -> Res {
	let mut texts = prep.texts.clone();
	let mut origin: Vec<Option<Vec<Option<u32>>>> = vec![None; texts.len()];
	let mut sites: Vec<(String, Vec<(u32, u32)>)> = Vec::new();
	for (fi, lines) in &files {
		texts[*fi] = lines.iter().map(|l| l.text.as_str()).collect::<Vec<_>>().join("\n");
		origin[*fi] = Some(lines.iter().map(|l| l.origin).collect());
		sites.push((prep.def.files[*fi].clone(), step_ranges(lines, info.spill)));
	}
	let titles: Vec<String> = info.quests.iter().filter_map(|q| sh.d.quests.get(q).and_then(|r| r.title.clone())).filter(|t| t.len() >= 4).collect();
	let out = run(sh, prep, &texts);
	let mut caught = [false; NCHK];
	let mut offsite = [false; NCHK];
	let mut rules = Vec::new();
	let mut how: Vec<String> = Vec::new();
	for h in &out.hits {
		let fi = prep.def.files.iter().position(|f| *f == h.file);
		let base_line = match fi.and_then(|i| origin[i].as_ref()) {
			Some(o) => o.get(h.line as usize - 1).copied().flatten(),
			None => Some(h.line),
		};
		if base_line.is_some_and(|l| base_set.contains(&(h.check, h.file.clone(), l, h.key.clone()))) {
			continue;
		}
		let at = sites.iter().any(|(f, rs)| *f == h.file && rs.iter().any(|(a, b)| (*a..=*b).contains(&h.line)))
			|| h.quests.iter().any(|q| info.quests.contains(q))
			|| titles.iter().any(|t| h.text.contains(t.as_str()));
		if at {
			caught[h.check] = true;
			let k: String = format!("{}: {}", CHECKS[h.check], h.key).chars().take(110).collect();
			if !how.contains(&k) {
				how.push(k);
			}
			if h.check == HONEST || h.check == LEGACY {
				let r = h.key.split(' ').next().unwrap_or("").to_string();
				if !rules.contains(&r) {
					rules.push(r);
				}
			}
		} else {
			offsite[h.check] = true;
		}
	}
	let worse: Vec<String> = gate_worse(&base.gt, &out.gt).into_iter().map(|(p, a, b)| format!("{} {a}->{b}", p.rsplit('/').next().unwrap())).collect();
	if !worse.is_empty() {
		caught[GUIDETEXT] = true;
	}
	rules.sort();
	Res { class, chain: prep.def.name.clone(), desc: info.desc, caught, offsite, rules, worse, how }
}

/// `oNN`/`hNN` (shipped Orc), `NN` (v2 Orc), `NN-name`, `human/NN-name` -> the file it names.
fn resolve_file(p: &str, files: &[String], set: &str) -> Option<String> {
	let p = p.trim().trim_start_matches('`');
	let base = |f: &str| f.rsplit('/').next().unwrap().trim_end_matches(".guide").to_string();
	let digits = |s: &str| s.len() == 2 && s.bytes().all(|b| b.is_ascii_digit());
	if set == "shipped-orc" && p.len() == 3 && digits(&p[1..]) {
		let pat = match p.strip_prefix('o') {
			Some(n) => format!("orc-troll/{n}-"),
			None => format!("horde/{}-", &p[1..]),
		};
		return files.iter().find(|f| f.contains(&pat)).cloned();
	}
	if digits(p) {
		return files.iter().find(|f| base(f).starts_with(&format!("{p}-")) && !f.contains("catchup")).cloned();
	}
	files.iter().find(|f| f.trim_end_matches(".guide").ends_with(p)).or_else(|| files.iter().find(|f| base(f).starts_with(p))).cloned()
}

/// A row's `file:line` cell -> (file, first, last) line ranges.
fn row_refs(cell: &str, files: &[String], set: &str) -> Vec<(String, u32, u32)> {
	let cleaned = cell.replace(['→', ';', '(', ')', '+'], ",");
	let mut cur: Option<String> = None;
	let mut out = Vec::new();
	for part in cleaned.split(',') {
		let part = part.trim();
		let (file, range) = match part.rsplit_once(':') {
			Some((f, r)) => {
				let f = f.split_whitespace().last().unwrap_or("");
				cur = resolve_file(f, files, set);
				(cur.clone(), r.trim())
			}
			None => (cur.clone(), part),
		};
		let Some(file) = file else { continue };
		let r = range.split_whitespace().next().unwrap_or("");
		let (a, b) = r.split_once('-').unwrap_or((r, r));
		if let (Ok(a), Ok(b)) = (a.parse::<u32>(), b.parse::<u32>()) {
			out.push((file, a, b.max(a)));
		}
	}
	out
}

/// Widen a line range to the steps it touches.
fn widen(text: &str, a: u32, b: u32) -> (u32, u32) {
	let lines: Vec<&str> = text.split('\n').collect();
	let starts: Vec<u32> = lines.iter().enumerate().filter(|(_, l)| l.starts_with("step")).map(|(i, _)| i as u32 + 1).collect();
	let s = starts.iter().rev().find(|&&s| s <= a).copied().unwrap_or(a);
	let e = starts.iter().find(|&&s| s > b).map_or(lines.len() as u32, |&n| n - 1);
	(s, e.max(b))
}

fn step_starts(text: &str) -> Vec<u32> {
	text.split('\n').enumerate().filter(|(_, l)| l.starts_with("step")).map(|(i, _)| i as u32 + 1).collect()
}

fn real_rows(set: &str, files: &[String], texts: &[String], out: &Out) -> Vec<RowRes> {
	let tsv = std::fs::read_to_string(concat!(env!("CARGO_MANIFEST_DIR"), "/tests/seeded/review-rows.tsv")).unwrap();
	let starts: Vec<Vec<u32>> = texts.iter().map(|t| step_starts(t)).collect();
	// Steps with a finding, per check (index NCHK: any check): (file, step start).
	let mut hit_steps: Vec<FxHashSet<(usize, u32)>> = vec![FxHashSet::default(); NCHK + 1];
	let mut hit_lines: Vec<FxHashSet<(usize, u32)>> = vec![FxHashSet::default(); NCHK + 1];
	for h in &out.hits {
		let Some(fi) = files.iter().position(|f| *f == h.file) else { continue };
		for k in [h.check, NCHK] {
			hit_lines[k].insert((fi, h.line));
		}
		if let Some(&s) = starts[fi].iter().rev().find(|&&s| s <= h.line) {
			hit_steps[h.check].insert((fi, s));
			hit_steps[NCHK].insert((fi, s));
		}
	}
	let rows: Vec<Vec<&str>> = tsv.lines().filter(|l| !l.starts_with('#')).map(|l| l.split('\t').collect::<Vec<_>>()).filter(|c| c[0] == set).collect();
	let cited: FxHashSet<usize> = rows.iter().flat_map(|c| row_refs(c[2], files, set)).filter_map(|(f, _, _)| files.iter().position(|x| *x == f)).collect();
	let total: usize = cited.iter().map(|&fi| starts[fi].len()).sum();
	let total_lines: usize = cited.iter().map(|&fi| texts[fi].split('\n').count()).sum();
	let density: Vec<f64> = hit_steps.iter().map(|s| s.iter().filter(|(fi, _)| cited.contains(fi)).count() as f64 / total.max(1) as f64).collect();
	let density_line: Vec<f64> = hit_lines.iter().map(|s| s.iter().filter(|(fi, _)| cited.contains(fi)).count() as f64 / total_lines.max(1) as f64).collect();
	let mut res = Vec::new();
	for c in rows {
		let exact = row_refs(c[2], files, set);
		let refs: Vec<(String, u32, u32)> = exact
			.iter()
			.map(|(f, a, b)| {
				let i = files.iter().position(|x| x == f).unwrap();
				let (a, b) = widen(&texts[i], *a, *b);
				(f.clone(), a, b)
			})
			.collect();
		let mut caught_line = [false; NCHK];
		for h in &out.hits {
			if exact.iter().any(|(f, a, b)| *f == h.file && (*a..=*b).contains(&h.line)) {
				caught_line[h.check] = true;
			}
		}
		let kl: u32 = exact.iter().map(|(_, a, b)| b - a + 1).sum();
		let mut chance_line = [0.0; NCHK + 1];
		for (i, d) in density_line.iter().enumerate() {
			chance_line[i] = if exact.is_empty() { 0.0 } else { 1.0 - (1.0 - d).powi(kl as i32) };
		}
		let mut caught = [false; NCHK];
		let mut how = Vec::new();
		for h in &out.hits {
			if refs.iter().any(|(f, a, b)| *f == h.file && (*a..=*b).contains(&h.line)) {
				caught[h.check] = true;
				let k = format!("{} {}", CHECKS[h.check], h.key.split(' ').take(2).collect::<Vec<_>>().join(" "));
				if !how.contains(&k) {
					how.push(k);
				}
			}
		}
		let k: usize = refs.iter().map(|(f, a, b)| starts[files.iter().position(|x| x == f).unwrap()].iter().filter(|&&s| s >= *a && s <= *b).count().max(1)).sum();
		let mut chance = [0.0; NCHK + 1];
		for (i, d) in density.iter().enumerate() {
			chance[i] = if refs.is_empty() { 0.0 } else { 1.0 - (1.0 - d).powi(k as i32) };
		}
		res.push(RowRes {
			set: set.into(),
			id: c[1].into(),
			kind: c[4].into(),
			severity: c[5].into(),
			review: c.get(6).copied().unwrap_or("").into(),
			feasible: !refs.is_empty(),
			caught,
			how,
			chance,
			caught_line,
			chance_line,
		});
	}
	res
}

fn git_show(rev: &str, path: &str) -> Option<String> {
	let o = std::process::Command::new("git").arg("-C").arg(main_dir()).args(["show", &format!("{rev}:{path}")]).output().ok()?;
	o.status.success().then(|| String::from_utf8_lossy(&o.stdout).into_owned())
}

fn pct(n: usize, d: usize) -> String {
	if d == 0 {
		"-".into()
	} else {
		format!("{n}/{d}")
	}
}

#[test]
#[ignore = "needs POLESTAR_CHECKOUT, POLESTAR_JSREF (level dumps) and this checkout's data/forever"]
fn seeded() {
	assert!(std::env::var_os("POLESTAR_CHECKOUT").is_some() && std::env::var_os("POLESTAR_JSREF").is_some(), "seeded needs POLESTAR_CHECKOUT and POLESTAR_JSREF");
	let data = Path::new(env!("CARGO_MANIFEST_DIR")).join("../../../data/forever/quests.json");
	assert!(main_dir().exists() && rsj().join("orc30.json").exists() && data.exists(), "seeded needs POLESTAR_CHECKOUT, the level dumps in POLESTAR_JSREF and this checkout's data/forever");
	let per_class: usize = std::env::var("POLESTAR_SEEDED_N").ok().and_then(|n| n.parse().ok()).unwrap_or(10);
	let only: Option<Vec<String>> = std::env::var("POLESTAR_SEEDED_ONLY").ok().map(|s| s.split(',').map(str::to_string).collect());
	let t0 = Instant::now();
	// Candidate counts per chain and class, exchanged once between the two chain threads.
	let counts: Vec<Vec<AtomicUsize>> = (0..2).map(|_| (0..CLASSES.len()).map(|_| AtomicUsize::new(0)).collect()).collect();
	let barrier = Barrier::new(2);
	let chains = ["orc", "human"];
	let results: Vec<(Vec<Res>, Vec<RowRes>, String)> = std::thread::scope(|s| {
		let hs: Vec<_> = chains
			.iter()
			.enumerate()
			.map(|(ci, &name)| {
				let (counts, barrier, only) = (&counts, &barrier, only.clone());
				std::thread::Builder::new()
					.stack_size(64 << 20)
					.spawn_scoped(s, move || {
						let mut log = String::new();
						let sh = Shared::load();
						let prep = prepare(&sh, shipped(name));
						let base = run(&sh, &prep, &prep.texts);
						let base_set = hit_set(&base.hits);
						let _ = writeln!(
							log,
							"{}: baseline {} hits; walk goals {} (dump {}, {} differ from it), guide-text goals {} ({} differ); ms {:?}",
							prep.def.name,
							base.hits.len(),
							base.walk_goals.len(),
							prep.walk_base.lv.len(),
							prep.walk_base.mismatched,
							base.gt_goals.len(),
							prep.gt_base.mismatched,
							base.ms.map(|x| x.round())
						);
						let model = Model::new(&prep.def.files, &prep.texts, base.gt_goals.clone(), &prep.def.race, prep.def.faction.name());
						let cx = Cx { m: &model, sh: &sh, prep: &prep };
						let all: Vec<Vec<ops::Cand>> = (0..CLASSES.len()).map(|c| if only.as_ref().is_none_or(|o| o.iter().any(|x| x == CLASSES[c].0)) { cands(&cx, c) } else { Vec::new() }).collect();
						for (c, l) in all.iter().enumerate() {
							counts[ci][c].store(l.len(), Ordering::SeqCst);
						}
						barrier.wait();
						let cn: Vec<Vec<usize>> = counts.iter().map(|v| v.iter().map(|a| a.load(Ordering::SeqCst)).collect()).collect();
						let mut res = Vec::new();
						for (c, mut list) in all.into_iter().enumerate() {
							// Half the sites each, the rest from the chain with more (Orc first).
							let half = per_class / 2;
							let (m0, m1) = (cn[0][c], cn[1][c]);
							let (a0, a1) = (m0.min(half), m1.min(per_class - half));
							let t0 = a0 + (m0 - a0).min(per_class - a0 - a1);
							let take = if ci == 0 { t0 } else { a1 + (m1 - a1).min(per_class - t0 - a1) };
							let mut rng = Rng(ops::seed(CLASSES[c].0, name));
							rng.shuffle(&mut list);
							list.sort_by_key(|x| x.pri);
							let mut done = 0;
							for cand in &list {
								if done >= take {
									break;
								}
								let mut ed = Ed::new(&model);
								let Some(info) = (cand.apply)(&mut ed) else { continue };
								let files = ed.into_files();
								if files.is_empty() {
									continue;
								}
								let r = evaluate(&sh, &prep, &base, &base_set, c, files, info);
								res.push(r);
								done += 1;
							}
						}
						let _ = writeln!(log, "{}: {} mutants in {:.0} s", prep.def.name, res.len(), t0.elapsed().as_secs_f64());

						// The real defects.
						let mut rows = Vec::new();
						if let Some(def) = v2(name) {
							let vp = prepare(&sh, def);
							let vo = run(&sh, &vp, &vp.texts);
							let _ = writeln!(
								log,
								"{}: {} hits; walk goals {} ({} differ from the dump); ms {:?}",
								vp.def.name,
								vo.hits.len(),
								vo.walk_goals.len(),
								vp.walk_base.mismatched,
								vo.ms.map(|x| x.round())
							);
							rows.extend(real_rows(&vp.def.name, &vp.def.files, &vp.texts, &vo));
						}
						let old: Option<Vec<String>> = prep.def.files.iter().map(|f| git_show(SHIPPED_REV, &format!("guides/{f}"))).collect();
						if let Some(old) = old {
							let so = run(&sh, &prep, &old);
							let _ = writeln!(log, "shipped-{name} at {SHIPPED_REV}: {} hits (levels aligned to today's dump)", so.hits.len());
							rows.extend(real_rows(&prep.def.name, &prep.def.files, &old, &so));
						}
						(res, rows, log)
					})
					.unwrap()
			})
			.collect();
		hs.into_iter().map(|h| h.join().unwrap()).collect()
	});
	let mut rep = String::new();
	for (_, _, log) in &results {
		rep.push_str(log);
	}
	let res: Vec<&Res> = results.iter().flat_map(|r| &r.0).collect();
	let rows: Vec<&RowRes> = results.iter().flat_map(|r| &r.1).collect();

	// Catch rate per class and check.
	let _ = writeln!(rep, "\n## Seeded defects: catch rate per class and check\n");
	let _ = writeln!(rep, "| class | defect seeded | from | N | {} | any | honest rules | meant for | caught by it |", CHECKS.join(" | "));
	let _ = writeln!(rep, "|---|---|---|---|{}---|---|---|---|", "---|".repeat(NCHK));
	let mut tot = [0usize; NCHK];
	let (mut tn, mut tany) = (0, 0);
	let mut nobody = Vec::new();
	let mut partly = Vec::new();
	for (c, (id, what, from, meant)) in CLASSES.iter().enumerate() {
		let rs: Vec<&&Res> = res.iter().filter(|r| r.class == c).collect();
		if rs.is_empty() {
			let _ = writeln!(rep, "| {id} | {what} | {from} | 0 | {} | - | | {meant} | - |", ["-"; NCHK].join(" | "));
			continue;
		}
		let mut cols = Vec::new();
		for k in 0..NCHK {
			let n = rs.iter().filter(|r| r.caught[k]).count();
			tot[k] += n;
			cols.push(pct(n, rs.len()));
		}
		let any = rs.iter().filter(|r| r.caught.iter().any(|x| *x)).count();
		let mut rules: Vec<String> = rs.iter().flat_map(|r| r.rules.clone()).collect();
		rules.sort();
		rules.dedup();
		tn += rs.len();
		tany += any;
		if any == 0 {
			nobody.push(*id);
		} else if any < rs.len() {
			partly.push(format!("{id} {any}/{}", rs.len()));
		}
		// The check (or honest rule) the class is meant for: did that one catch it?
		let by_meant = |r: &Res| -> bool {
			if meant.starts_with('R') {
				r.rules.iter().any(|x| x == meant)
			} else {
				CHECKS.iter().position(|c| c == meant).is_some_and(|k| r.caught[k])
			}
		};
		let meant_n = if *meant == "-" { "-".to_string() } else { pct(rs.iter().filter(|r| by_meant(r)).count(), rs.len()) };
		let _ = writeln!(rep, "| {id} | {what} | {from} | {} | {} | {} | {} | {meant} | {meant_n} |", rs.len(), cols.join(" | "), pct(any, rs.len()), rules.join(" "));
	}
	let _ = writeln!(rep, "| **all** | | | {tn} | {} | {} | | | |", tot.iter().map(|n| pct(*n, tn)).collect::<Vec<_>>().join(" | "), pct(tany, tn));
	let _ = writeln!(rep, "\nClasses no check catches (0 of N): {}", if nobody.is_empty() { "none".into() } else { nobody.join(", ") });
	let _ = writeln!(rep, "Classes caught only sometimes: {}", partly.join(", "));
	let off: Vec<String> = (0..NCHK).map(|k| format!("{} {}", CHECKS[k], res.iter().filter(|r| r.offsite[k]).count())).collect();
	let _ = writeln!(rep, "Mutants with new findings away from the site (noise or cascade), per check: {}", off.join(", "));

	let _ = writeln!(rep, "\n### Mutants\n");
	for r in &res {
		let by: Vec<&str> = (0..NCHK).filter(|k| r.caught[*k]).map(|k| CHECKS[k]).collect();
		let _ = writeln!(
			rep,
			"- {} {}: {} -> {}{}{}",
			CLASSES[r.class].0,
			r.chain,
			r.desc,
			if by.is_empty() { "none".into() } else { by.join(",") },
			if r.rules.is_empty() { String::new() } else { format!(" [{}]", r.rules.join(" ")) },
			if r.worse.is_empty() { String::new() } else { format!(" (guidetext {})", r.worse.join(", ")) }
		);
		for h in &r.how {
			let _ = writeln!(rep, "  - {h}");
		}
	}

	// The real rows.
	let _ = writeln!(rep, "\n## Real review rows: a finding in a step the row cites\n");
	let _ = writeln!(rep, "| set | rows | with line refs | {} | any | the review's own column: caught by a check |", CHECKS.join(" | "));
	let _ = writeln!(rep, "|---|---|---|{}---|---|", "---|".repeat(NCHK));
	for set in ["v2-orc", "v2-human", "shipped-orc", "shipped-human"] {
		let rs: Vec<&&RowRes> = rows.iter().filter(|r| r.set == set).collect();
		if rs.is_empty() {
			continue;
		}
		let fe: Vec<&&&RowRes> = rs.iter().filter(|r| r.feasible).collect();
		let cols: Vec<String> = (0..NCHK).map(|k| pct(fe.iter().filter(|r| r.caught[k]).count(), fe.len())).collect();
		let any = fe.iter().filter(|r| r.caught.iter().any(|x| *x)).count();
		let old = rs.iter().filter(|r| !r.review.is_empty() && !r.review.starts_with("none")).count();
		let _ = writeln!(rep, "| {set} | {} | {} | {} | {} | {} |", rs.len(), fe.len(), cols.join(" | "), pct(any, fe.len()), if set.starts_with("v2") { pct(old, rs.len()) } else { "-".into() });
		let exp: Vec<String> = (0..=NCHK).map(|k| format!("{:.1}", fe.iter().map(|r| r.chance[k]).sum::<f64>())).collect();
		let _ = writeln!(rep, "| {set}: expected by chance | | | {} | {} | |", exp[..NCHK].join(" | "), exp[NCHK]);
	}
	let _ = writeln!(rep, "\nOn the cited lines only (no widening to the step):\n");
	let _ = writeln!(rep, "| set | rows with line refs | {} | any |", CHECKS.join(" | "));
	let _ = writeln!(rep, "|---|---|{}---|", "---|".repeat(NCHK));
	for set in ["v2-orc", "v2-human", "shipped-orc", "shipped-human"] {
		let fe: Vec<&&RowRes> = rows.iter().filter(|r| r.set == set && r.feasible).collect();
		if fe.is_empty() {
			continue;
		}
		let cols: Vec<String> = (0..NCHK).map(|k| pct(fe.iter().filter(|r| r.caught_line[k]).count(), fe.len())).collect();
		let any = fe.iter().filter(|r| r.caught_line.iter().any(|x| *x)).count();
		let _ = writeln!(rep, "| {set} | {} | {} | {} |", fe.len(), cols.join(" | "), pct(any, fe.len()));
		let exp: Vec<String> = (0..=NCHK).map(|k| format!("{:.1}", fe.iter().map(|r| r.chance_line[k]).sum::<f64>())).collect();
		let _ = writeln!(rep, "| {set}: expected by chance | | {} | {} |", exp[..NCHK].join(" | "), exp[NCHK]);
	}
	let _ = writeln!(rep, "\nPer kind (all sets, rows with refs): caught by any check / rows");
	let mut kinds: Vec<String> = rows.iter().filter(|r| r.feasible).map(|r| r.kind.clone()).collect();
	kinds.sort();
	kinds.dedup();
	for k in kinds {
		let rs: Vec<&&RowRes> = rows.iter().filter(|r| r.feasible && r.kind == k).collect();
		let any = rs.iter().filter(|r| r.caught.iter().any(|x| *x)).count();
		let by: Vec<String> = (0..NCHK)
			.filter_map(|c| {
				let n = rs.iter().filter(|r| r.caught[c]).count();
				(n > 0).then(|| format!("{} {n}", CHECKS[c]))
			})
			.collect();
		let _ = writeln!(rep, "- {k}: {}{}", pct(any, rs.len()), if by.is_empty() { String::new() } else { format!(" ({})", by.join(", ")) });
	}
	let _ = writeln!(rep, "\n### Rows caught\n");
	for r in rows.iter().filter(|r| r.caught.iter().any(|x| *x)) {
		let _ = writeln!(rep, "- {} #{} ({}, {}): {}", r.set, r.id, r.kind, r.severity, r.how.join("; "));
	}
	let _ = writeln!(rep, "\n{} s", t0.elapsed().as_secs());
	println!("{rep}");
	let out = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("../../target/seeded.md");
	let _ = std::fs::write(&out, &rep);
	assert!(!res.is_empty(), "no mutant was played");
}
