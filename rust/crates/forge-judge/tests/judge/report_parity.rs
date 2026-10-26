//! Parity of `forge judge report` with the route loop's JS scripts (gmeasure.js, sdiff.js, honest-sum.js,
//! run on the same data, sim world and trees). One check per metric.
//!
//! Default: rust/tests/golden/report (its README and regen.sh): forge's Orc and Human routes on the slice,
//! written into the clean guide slice (v1 here), and the scripts' results on the v2-route judge tree.
//! Optional extra: the r8 Orc and Human routes written into the v1 guides checkout ($POLESTAR_V1), their
//! inputs in $POLESTAR_JSREF/report/{rep,simdir}; variables unset or inputs absent: skipped with a note.
//!
//! cargo test --release -p forge-judge --test report_parity -- --nocapture

use crate::common;
use forge_judge::report::{run, Inputs, StartInput};
use serde_json::Value;
use std::path::{Path, PathBuf};

#[test]
fn report_equals_the_js_scripts_on_the_slice() {
	let gold = common::golden().join("report");
	let tmp = Path::new(env!("CARGO_TARGET_TMPDIR")).join("report-slice");
	let _ = std::fs::remove_dir_all(&tmp);
	let sim = tmp.join("sim");
	std::fs::create_dir_all(&sim).unwrap();
	for f in ["horde", "alliance"] {
		std::fs::write(sim.join(format!("world-{f}.json")), common::gunzip(&common::golden().join(format!("world/expected/world-{f}.json.gz")))).unwrap();
	}
	std::fs::copy(common::golden().join("sim/params.json"), sim.join("params.json")).unwrap();
	let v1 = common::clean_slice("report-v1");
	let mut starts = Vec::new();
	for race in ["Orc", "Human"] {
		// the route doc (faction and start) and, beside it, its judge-improved goal stream
		std::fs::copy(gold.join(format!("route/{race}.json")), tmp.join(format!("{race}.json"))).unwrap();
		std::fs::write(tmp.join(format!("{race}.judge-improved.json")), common::gunzip(&gold.join(format!("route/{race}.judge-improved.json.gz")))).unwrap();
		// the written guides: the clean slice with the guides the writer rewrote
		let written = common::clean_slice(&format!("report-written-{race}"));
		fn overlay(from: &Path, to: &Path) {
			for e in std::fs::read_dir(from).unwrap() {
				let e = e.unwrap();
				if e.file_type().unwrap().is_dir() {
					overlay(&e.path(), &to.join(e.file_name()));
				} else {
					std::fs::copy(e.path(), to.join(e.file_name())).unwrap();
				}
			}
		}
		overlay(&gold.join(format!("written/{race}")), &written);
		starts.push(StartInput { route: tmp.join(format!("{race}.json")), stream: None, guides: written });
	}
	// the root: the data slice's mini repository, no knowledge base (the JS ran on an empty one)
	let inp = Inputs { starts, v1, root: common::root(), data_dir: common::data(), sim_dir: sim, along_walked: true, checks: false };
	let o = run(&inp).unwrap();
	let mut bad = Vec::new();
	for s in &o.starts {
		let js: Value = serde_json::from_slice(&std::fs::read(gold.join(format!("{}.ref.json", s.race))).unwrap()).unwrap();
		let mut chk = |what: String, rust: f64, js: &Value| {
			if js.as_f64() != Some(rust) {
				bad.push(format!("{} {what}: rust {rust} js {js}", s.race));
			}
		};
		// gmeasure.js: every column of every row.
		let rows = js["rows"].as_array().unwrap();
		assert_eq!(rows.len(), s.rows.len(), "{}: rows", s.race);
		for (w, (name, m)) in rows.iter().zip(&s.rows) {
			assert_eq!(w["chain"].as_str(), Some(name.as_str()), "{}: row order", s.race);
			let at = |k: &str| format!("{name} to {} {k}", m.to);
			chk(at("to"), m.to, &w["to"]);
			chk(at("hours"), m.hours, &w["hours"]);
			chk(at("endLevel"), (m.end_level * 100.0).round() / 100.0, &w["endLevel"]);
			for (k, v) in [
				("questsDone", m.quests_done),
				("zoneChanges", m.zone_changes),
				("passedBy", m.passed_by),
				("pbNever", m.pb_never),
				("pbLater", m.pb_later),
				("areaVisits", m.area_visits),
				("returns", m.returns),
				("wastedTrips", m.wasted_trips),
				("leftBehind", m.left_behind),
				("sameMob", m.same_mob),
				("deaths", m.deaths),
				("trains", m.trains),
				("trainTrips", m.train_trips),
			] {
				chk(at(k), v as f64, &w[k]);
			}
			chk(at("qPerVisit"), m.q_per_visit, &w["qPerVisit"]);
			chk(at("grindMin"), m.grind_min, &w["grindMin"]);
		}
		// honest-sum.js: the race's fail findings on the chain.
		chk("honest v1".into(), s.honest_v1.values().sum::<usize>() as f64, &js["honest"]["v1"]);
		chk("honest written".into(), s.honest_written.values().sum::<usize>() as f64, &js["honest"]["written"]);
		// sdiff.js: hours to 30 / 60 of the order stream and the written walk, and the quest events.
		let d = s.stream.as_ref().expect("the stream beside the route");
		let st = &js["stream"];
		chk("stream order h60".into(), d.order_h60, &st["order"]["h60"]);
		chk("stream order end".into(), d.order_end, &st["order"]["end"]);
		chk("stream written h60".into(), d.written_h60, &st["written"]["h60"]);
		chk("stream written end".into(), d.written_end, &st["written"]["end"]);
		for (k, v) in [
			("orderEvents", d.order_events),
			("writtenEvents", d.written_events),
			("inBoth", d.in_both),
			("outOfOrder", d.out_of_order.len()),
			("onlyInOrder", d.only_in_order.len()),
			("onlyWritten", d.only_written.len()),
		] {
			chk(format!("stream {k}"), v as f64, &st[k]);
		}
		let opt = |v: Option<f64>| v.map_or(Value::Null, |x| serde_json::json!(x));
		for (k, rust, js) in [("order h30", opt(d.order_h30), &st["order"]["h30"]), ("written h30", opt(d.written_h30), &st["written"]["h30"])] {
			if js.as_f64() != rust.as_f64() {
				bad.push(format!("{} stream {k}: rust {rust} js {js}", s.race));
			}
		}
		eprintln!("report parity slice {}: {} rows, honest {}/{}, stream events {}/{}", s.race, s.rows.len(), js["honest"]["v1"], js["honest"]["written"], d.order_events, d.written_events);
	}
	assert!(bad.is_empty(), "{} differences:\n  {}", bad.len(), bad.join("\n  "));
}

fn dirs() -> Option<(PathBuf, PathBuf)> {
	Some((PathBuf::from(std::env::var_os("POLESTAR_JSREF")?).join("report"), PathBuf::from(std::env::var_os("POLESTAR_V1")?)))
}

/// gmeasure.js rows: (chain, to, hours, end level, quests, zone changes, passed by, never, later, returns,
/// wasted, left behind, same mob, area visits, deaths, trains, training trips, grind minutes).
type Row = (&'static str, u32, f64, f64, usize, usize, usize, usize, usize, usize, usize, usize, usize, usize, usize, usize, usize, f64);

const ORC: [Row; 4] = [
	("v1", 30, 24.8, 30.07, 230, 16, 67, 38, 29, 25, 4, 25, 3, 236, 0, 5, 0, 87.0),
	("v1", 61, 128.3, 60.0, 717, 99, 144, 87, 57, 64, 14, 61, 18, 737, 0, 6, 0, 638.0),
	("written", 30, 24.9, 30.08, 231, 14, 68, 36, 32, 26, 7, 23, 2, 238, 0, 9, 0, 94.0),
	("written", 61, 127.1, 60.0, 717, 102, 148, 83, 65, 74, 21, 58, 7, 754, 0, 14, 0, 688.0),
];
const HUMAN: [Row; 4] = [
	("v1", 30, 24.3, 30.0, 269, 16, 74, 44, 30, 35, 11, 33, 4, 223, 0, 11, 0, 54.0),
	("v1", 61, 126.9, 60.0, 834, 111, 149, 83, 66, 78, 22, 62, 41, 784, 0, 23, 0, 1284.0),
	("written", 30, 24.8, 30.14, 270, 18, 77, 42, 35, 39, 13, 30, 4, 233, 0, 11, 0, 59.0),
	("written", 61, 128.1, 60.0, 836, 128, 158, 82, 76, 90, 30, 59, 43, 820, 0, 26, 1, 1233.0),
];

#[test]
#[ignore = "needs POLESTAR_JSREF (rep/) and POLESTAR_V1 (data/forever)"]
fn report_equals_the_js_scripts_on_r8() {
	let (scratch, seed) = dirs().expect("report parity needs POLESTAR_JSREF and POLESTAR_V1");
	let rep = scratch.join("rep");
	assert!(rep.join("Orc.json").exists() && seed.join("data/forever").is_dir(), "report parity needs {} and POLESTAR_V1's data/forever", rep.display());
	let start = |s: &str| StartInput { route: rep.join(format!("{s}.json")), stream: None, guides: rep.join("guides").join(s) };
	let inp = Inputs {
		starts: vec![start("Orc"), start("Human")],
		v1: seed.join("guides"),
		root: seed.clone(),
		data_dir: seed.join("data/forever"),
		sim_dir: scratch.join("simdir"),
		along_walked: true,
		checks: false,
	};
	let o = run(&inp).unwrap();
	for (s, want, honest, stream) in
		[(&o.starts[0], &ORC, (1103, 641), (24.34, 126.00, 24.91, 127.11, 1905, 1895, 1879, 46, 26, 16)), (&o.starts[1], &HUMAN, (25, 9), (23.54, 125.50, 24.81, 128.01, 2126, 2149, 2112, 48, 14, 37))]
	{
		// gmeasure.js: every column of every row.
		for (w, (name, m)) in want.iter().zip(&s.rows) {
			let got = format!(
				"{:?}",
				(
					name.as_str(),
					m.to as u32,
					m.hours,
					(m.end_level * 100.0).round() / 100.0,
					m.quests_done,
					m.zone_changes,
					(m.passed_by, m.pb_never, m.pb_later),
					(m.returns, m.wasted_trips, m.left_behind, m.same_mob, m.area_visits),
					(m.deaths, m.trains, m.train_trips, m.grind_min)
				)
			);
			let want = format!("{:?}", (w.0, w.1, w.2, w.3, w.4, w.5, (w.6, w.7, w.8), (w.9, w.10, w.11, w.12, w.13), (w.14, w.15, w.16, w.17)));
			assert_eq!(got, want, "{} {name} to {}", s.race, m.to);
		}
		// honest-sum.js: the race's fail findings on the chain.
		assert_eq!((s.honest_v1.values().sum::<usize>(), s.honest_written.values().sum::<usize>()), honest, "{} honest", s.race);
		// sdiff.js: hours to 30 / 60 of the order stream and the written walk, and the quest events.
		let d = s.stream.as_ref().unwrap();
		let r2 = |x: f64| (x * 100.0).round() / 100.0;
		assert_eq!((r2(d.order_h30.unwrap()), r2(d.order_h60), r2(d.written_h30.unwrap()), r2(d.written_h60)), (stream.0, stream.1, stream.2, stream.3), "{} stream hours", s.race);
		assert_eq!(
			(d.order_events, d.written_events, d.in_both, d.out_of_order.len(), d.only_in_order.len(), d.only_written.len()),
			(stream.4, stream.5, stream.6, stream.7, stream.8, stream.9),
			"{} stream events",
			s.race
		);
	}
}
