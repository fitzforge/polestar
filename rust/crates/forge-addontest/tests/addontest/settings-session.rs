//! The settings window over a session of real use stays quick and keeps nothing it does not need: the whole
//! addon on the stubbed world, a guide open and its window shown, ROUNDS rounds of what a player does in it
//! (settings-session.lua): open it, every page and tab (each scrolled down and up), a search typed and cleared
//! twice, on five tabs two of each kind of control (a switch flipped and back, a dropdown opened and a choice
//! picked and put back, a slider dragged and let go, a colour picked on the wheel and the picker closed), a key
//! binding captured and cancelled, Reset page and its Undo, a profile switched and back, the window closed, the
//! Install pages one after another, the route choice window opened and closed.
//!
//! Per action, rounds 2 and on (the first builds what each page needs once): addon ms (the action's calls with
//! every handler they run, and the handlers of the frame after it, less an idle frame's; scaled by the reference
//! as settings-perf.rs scales its budgets) and the addon's KiB (a run with tests/lua/stub_alloc.lua, apart, its
//! wrappers would slow every call). After each round, the heap after two full collects: the third round keeps no
//! more than the second (KEPT_SLACK: measured +21 KiB, +325 the second over the first), and makes no frame or
//! font string and at most 8 textures (measured 5; frames, pages and rows are all reused).
//!
//! Each budget is the figure of a run on 2026-11-15 (fix/settings-hover-040, the lua5.1 interpreter) and about
//! half again (ms) or a fifth (KiB): lower a budget when a change lowers the figure, never raise one to make a
//! change pass. Before that branch (release/040-data 36bb3028ac, the same session with every control of the
//! tabs): Reset page 3,945 ms and 19.7 MB (it wrote every setting of the page, each refreshing the window and
//! the look on its own), a search keystroke 18.2 ms, its worst 149 ms (each preset card's summary listed every
//! control of every page for each of its settings).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

const ROUNDS: u32 = 3;
const PER_KIND: u32 = 2;
const KEPT_SLACK: f64 = 64.0;
// The reference's fastest timing where the budgets were set (i7-10700K, Linux, the harness's Lua 5.1).
const REF_BASELINE: f64 = 6.95;
const CPU_CLOCK: bool = !cfg!(windows);

// (action, median ms, median KiB): the run's median and about half again (ms; 0.2 at least) or a fifth (KiB;
// 2 at least). Measured: open 10.2 ms / 92.6 KiB, a tab 4.9 / 48.7, a search keystroke 16.2 / 377, a switch
// 24.6 / 161, a dropdown's pick 23.2 / 150, a slider's step 2.3 / 1.2 and its release 31.7 / 166, the colour
// wheel 10.8 / 1.5 a move and 71 / 487 closed (put back), Reset page with three settings off 99.5 / 875 and
// its Undo 93 / 844, a profile switch 99.9 / 845, an Install page 4.0 / 72.6.
const BUDGETS: &[(&str, f64, f64)] = &[
	("open", 16.0, 112.0),
	("close", 0.2, 2.0),
	("select", 7.5, 59.0),
	("scroll", 0.2, 2.0),
	("search type", 24.0, 453.0),
	("search clear", 8.5, 102.0),
	("toggle", 37.0, 194.0),
	("dropdown open", 0.4, 3.2),
	("dropdown pick", 35.0, 180.0),
	("slider step", 3.5, 2.0),
	("slider release", 48.0, 200.0),
	("colour open", 0.2, 2.2),
	("colour drag", 16.0, 2.0),
	("colour close", 107.0, 585.0),
	("keybind capture", 0.2, 2.0),
	("keybind cancel", 0.2, 2.0),
	("reset page", 150.0, 1050.0),
	("undo", 140.0, 1013.0),
	("profile switch", 150.0, 1014.0),
	("install page", 6.0, 87.0),
	("install close", 0.2, 2.0),
	("path open", 1.0, 16.0),
	("path close", 0.2, 2.0),
];

const SCRIPT: &str = include_str!("settings-session.lua");

fn run(alloc: bool) -> Value {
	let mut stubs = vec!["stub_world.lua", "profile.lua"];
	if alloc {
		stubs.push("stub_alloc.lua");
	}
	emitted(&RunAddon {
		stubs,
		addons: vec![Addon::name("Polestar")],
		login: true,
		before: "stub.profile.start()".into(),
		script: SCRIPT.replace("ROUNDS", &ROUNDS.to_string()).replace("PER_KIND", &PER_KIND.to_string()),
		..Default::default()
	})
	.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

#[test]
fn a_session_in_the_settings_window_stays_within_each_action_s_budget_and_a_round_keeps_nothing_more() {
	let time = run(false);
	let scale = (num(&time["reference"]) / REF_BASELINE).max(1.0);
	let report = format!("measured {time}; reference scale {scale:.3}");
	// An empty Lua list reaches JSON as [] or {}.
	let errors = &time["errors"];
	let none = errors.as_array().is_some_and(|a| a.is_empty()) || errors.as_object().is_some_and(|o| o.is_empty());
	assert!(none, "every action ran: {errors}");
	if CPU_CLOCK {
		for (action, ms, _) in BUDGETS {
			let m = num(&time["actions"][action]["median"]);
			assert!(m <= ms * scale, "{action}: {m:.3} ms (budget {ms}): {report}");
		}
	}
	println!("{report}");

	let alloc = run(true);
	let report = format!("allocated {alloc}");
	for (action, _, kib) in BUDGETS {
		let k = num(&alloc["actions"][action]["median"]);
		assert!(k <= *kib, "{action}: {k:.1} KiB (budget {kib}): {report}");
	}
	let r = &alloc["rounds"];
	let n = ROUNDS as usize;
	let growth = num(&r[n - 1]["kept"]) - num(&r[n - 2]["kept"]);
	assert!(growth <= KEPT_SLACK, "round {n} kept {growth:.0} KiB over the one before (slack {KEPT_SLACK}): {report}");
	assert_eq!((r[n - 1]["frames"].as_u64(), r[n - 1]["strings"].as_u64()), (Some(0), Some(0)), "round {n} made frames or strings: {report}");
	assert!(num(&r[n - 1]["textures"]) <= 8.0, "round {n} made textures: {report}");
	println!("{report}");
}
