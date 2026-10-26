//! sim-hash: a route's action hash, for the native == wasm check (tests/wasm/run.sh).
//!
//!   sim-hash <sim dir> <seed json> [walks on|off] [tries] [camps 0|1]
//!
//! Loads `<sim dir>/world-horde.json` (and walks-horde.bin), builds v1's Orc order from the seed,
//! prints the hash of its replay, then of the order after a short search (2 members, counted in
//! tries, so the same on one thread or many).

use forge_sim::chain::events_from;
use forge_sim::order::{action_hash, deliberate_pairs, seed_order};
use forge_sim::profile::Profile;
use forge_sim::route::model_for;
use forge_sim::search::{pool, search, Problem, SearchOpts};
use forge_sim::{NoWalks, Params, WalkTable, Walks};
use forge_world::World;

fn main() {
	let a: Vec<String> = std::env::args().skip(1).collect();
	let dir = std::path::PathBuf::from(&a[0]);
	let doc: serde_json::Value = serde_json::from_slice(&std::fs::read(&a[1]).expect("seed")).expect("seed json");
	let walks_on = a.get(2).map(String::as_str) == Some("on");
	let tries: u64 = a.get(3).and_then(|x| x.parse().ok()).unwrap_or(2000);
	let camps = a.get(4).map(String::as_str) == Some("1");
	let world = World::from_json(&std::fs::read(dir.join("world-horde.json")).expect("world")).expect("world json");
	let walks: Box<dyn Walks> =
		if walks_on { Box::new(WalkTable::from_bin(&std::fs::read(dir.join("walks-horde.bin")).expect("walks"), world.points.len()).expect("walks bin")) } else { Box::new(NoWalks) };
	let pdoc: Option<serde_json::Value> = std::fs::read(dir.join("params.json")).ok().and_then(|b| serde_json::from_slice(&b).ok());
	let over = if camps { vec![("camps".to_string(), 1.0), ("spots".to_string(), 1.0)] } else { vec![] };
	let base = Params::effective(pdoc.as_ref(), None, &over);
	let f = forge_core::Faction::Horde;
	let (m, rules) = model_for(&world, "Orc", &Profile::average(f), &base, &*walks).expect("model");
	let mut ev = m.evaluator(&*walks);
	let seed = seed_order(&mut ev, &events_from(&doc), true);
	let h0 = action_hash(&mut ev, &seed.steps);
	let secs0 = ev.seconds();
	let p = Problem::single(&m, &*walks, deliberate_pairs(&m.run), pool(&m.run, &rules, &seed, &m.tables));
	let out = search(&p, &seed, &SearchOpts { tries, members: 2, seed: 1, share_every: 250, ..Default::default() });
	let h1 = action_hash(&mut ev, &out.best.steps);
	println!("seed {h0:016x} {:.6} h; searched {h1:016x} {:.6} h ({} steps)", secs0 / 3600.0, ev.seconds() / 3600.0, out.best.len());
}
