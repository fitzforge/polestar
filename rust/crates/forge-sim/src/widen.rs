//! The shared part of a faction's route with an edit budget: every start keeps v1's own route to
//! its join point (the first step of a guide every start plays); from there one order, the
//! first start's v1 tail, improved by local edits (search::edits) that make no start slower.
//! Reports, per start, the hours to 60 with v1's own chain, with v1's prefix + the canonical
//! tail, and with the tail after the knee's edits and after all of them; per edit, each start's
//! hours.

use crate::chain::Goal;
use crate::order::{broken_pairs, Order};
use crate::profile::Profile;
use crate::route::{edits_json, prepare, Extras, Prepared};
use crate::search::edits::{descend, knee};
use crate::search::{evaluate, followers, runs, CtxSpec, Mapper, Problem};
use crate::seq::Event;
use crate::walks::Walks;
use crate::Params;
use forge_world::World;
use serde_json::{json, Value};

/// A start: its race and v1's chain.
pub struct WidenStart {
	pub race: String,
	pub events: Vec<Event>,
	pub goals: Vec<Goal>,
}

/// Plan the shared tail of `starts` (the first is the canonical one) with at most `max_edits`
/// edits; the result's order is the canonical tail at the knee (or after `budget` edits).
pub fn widen(
	world: &World,
	walks: &dyn Walks,
	base: &Params,
	starts: &[WidenStart],
	profile: &Profile,
	ex: &Extras,
	max_edits: usize,
	budget: Option<usize>,
	members: usize,
	join_after: Option<&str>,
) -> Result<Value, String> {
	let mut preps: Vec<Prepared> = starts.iter().map(|s| prepare(world, walks, base, &s.race, &s.events, &s.goals, profile, ex)).collect::<Result<_, _>>()?;
	let guard0 = preps[0].guard.take();
	// The join: after the start's own guides, or (join_after) after the last step from that
	// shared guide (each start keeps its own order of it).
	let joins = joins_of(&preps, starts, join_after);
	let c = &preps[0];
	let j0 = joins[0];
	let u0 = Order { steps: c.seed.steps[j0..].to_vec(), origin: c.seed.origin[j0..].to_vec() };
	let smodels: Vec<Option<crate::Model>> = preps
		.iter()
		.enumerate()
		.map(|(k, p)| if k == 0 { Ok(None) } else { shared_model(world, walks, base, profile, &starts[k].race, p, &p.seed.steps[..joins[k]], c, &u0.steps).map(|x| Some(x.0)) })
		.collect::<Result<_, String>>()?;
	let ctxs: Vec<CtxSpec> = preps
		.iter()
		.enumerate()
		.map(|(k, p)| CtxSpec {
			model: smodels[k].as_ref().unwrap_or(&p.model),
			prefix: p.seed.steps[..joins[k]].to_vec(),
			map: (k > 0).then(|| Mapper::new(&c.model.run, &p.model.run)),
			name: starts[k].race.clone(),
		})
		.collect();
	// The canonical start's constraints, on the tail: pairs and feasibility rules v1's tail keeps;
	// the guards on its whole route (prefix + tail), keeping only the tail's trainings.
	let mut pairs = c.pairs.clone();
	for k in broken_pairs(&u0.steps, &pairs).into_iter().rev() {
		pairs.remove(k);
	}
	let mut feas = c.feas.clone();
	let mut log = Vec::new();
	feas.keep_seed(&c.model.run, &u0.steps, &mut log);
	let guard = guard0.map(|mut g| {
		g.train_levels.retain(|(o, _)| u0.origin.contains(o));
		g
	});
	let p = Problem { model: &c.model, walks, pairs, pool: c.pool.clone(), ctxs, followers: followers(&c.model.run), guard, feas, log_bound: u32::MAX };
	let base_runs = runs(&p, &u0);
	let mut lg = |k: usize, h: f64, kind: &str| eprintln!("edit {k}: {kind} -> {h:.3} h (sum)");
	let d = descend(&p, &u0, max_edits, members, true, &mut lg);
	let kk = budget.unwrap_or_else(|| knee(&d)).min(d.edits.len());
	let per = |o: &Order| runs(&p, o).iter().map(|r| r.total / 3600.0).collect::<Vec<f64>>();
	let by_edit: Vec<Vec<f64>> = d.orders.iter().map(per).collect();
	let at = |k: usize| if k == 0 { base_runs.iter().map(|r| r.total / 3600.0).collect() } else { by_edit[k - 1].clone() };
	let mut doc = edits_json(world, &c.rules, &c.model, &d, kk);
	if let Some(list) = doc["list"].as_array_mut() {
		for (n, e) in list.iter_mut().enumerate() {
			let before = at(n);
			e["byStart"] = json!(starts
				.iter()
				.enumerate()
				.map(|(k, s)| (s.race.clone(), json!({ "hours": (by_edit[n][k] * 1000.0).round() / 1000.0, "savedMin": ((before[k] - by_edit[n][k]) * 600.0).round() / 10.0 })))
				.collect::<serde_json::Map<_, _>>());
		}
	}
	let (knee_h, end_h, v1c) = (at(kk), at(d.edits.len()), at(0));
	let rows: Vec<Value> = preps
        .iter()
        .enumerate()
        .map(|(k, p)| {
            let mut ev = p.model.evaluator(walks);
            let own = evaluate(&mut ev, &p.seed) / 3600.0;
            json!({ "start": starts[k].race, "joinStep": joins[k], "v1Own": own, "v1Shared": v1c[k], "knee": knee_h[k], "converged": end_h[k], "kneeGain": v1c[k] - knee_h[k], "slowerThanV1Own": knee_h[k] > own })
        })
        .collect();
	let best = if kk == 0 { u0.clone() } else { d.orders[kk - 1].clone() };
	Ok(json!({ "faction": world.faction.name(), "canonical": starts[0].race, "rows": rows, "edits": doc, "tailSteps": best.len(), "seconds": d.seconds, "notes": log }))
}

/// Where a shared tail costs a start: the start's own v1 order against its prefix + the
/// canonical tail, both played by the start's model and aligned by quest step; the gap
/// (seconds, shared minus own) at the first aligned step and at the end of each canonical
/// guide, with trainings and hearths of each.
pub fn diagnose(world: &World, walks: &dyn Walks, base: &Params, starts: &[WidenStart], profile: &Profile, ex: &Extras, join_after: Option<&str>) -> Result<Value, String> {
	let preps: Vec<Prepared> = starts.iter().map(|s| prepare(world, walks, base, &s.race, &s.events, &s.goals, profile, ex)).collect::<Result<_, _>>()?;
	let joins = joins_of(&preps, starts, join_after);
	let c = &preps[0];
	let tail = &c.seed.steps[joins[0]..];
	let tail_origin = &c.seed.origin[joins[0]..];
	let mut rows = Vec::new();
	for (k, p) in preps.iter().enumerate().skip(1) {
		let run = &p.model.run;
		let map = Mapper::new(&c.model.run, run);
		let mut shared: Vec<crate::eval::Step> = p.seed.steps[..joins[k]].to_vec();
		shared.extend(tail.iter().map(|&s| map.step(&c.model.run, run, s)));
		let play = |model: &crate::Model, steps: &[crate::eval::Step]| {
			let mut ev = model.evaluator(walks);
			ev.reset();
			let mut t = Vec::with_capacity(steps.len());
			let mut hk = Vec::new();
			for i in 0..steps.len() {
				let h0 = ev.s.hearths;
				if !ev.s.finished {
					ev.step_in(steps, i);
				}
				if ev.s.hearths > h0 {
					hk.push((run.q_id[steps[i].q as usize], steps[i].kind, (ev.level_now() * 10.0).round() / 10.0));
				}
				t.push((ev.s.time, ev.level_now(), ev.s.grind_sec, ev.s.travel_sec));
			}
			ev.finish();
			eprintln!(
				"  play: noops {} quest xp {:.0} kill xp {:.0} grind {:.0} min log skipped {} abandoned {}",
				ev.s.noops,
				ev.s.xp_quest,
				ev.s.xp_kill,
				ev.s.grind_sec / 60.0,
				ev.s.log_skipped,
				ev.s.log_abandoned
			);
			(t, ev.seconds(), ev.s.trains, hk, ev.s.zone_changes)
		};
		let sm = shared_model(world, walks, base, profile, &starts[k].race, p, &p.seed.steps[..joins[k]], c, tail)?.0;
		let (ts, tot_s, tr_s, h_s, z_s) = play(&sm, &shared);
		let (to, tot_o, tr_o, h_o, z_o) = play(&p.model, &p.seed.steps);
		let mut own_at: rustc_hash::FxHashMap<crate::run::StepKey, usize> = Default::default();
		for (j, s) in p.seed.steps.iter().enumerate() {
			if let Some(key) = run.step_key(s.kind, s.q, s.task) {
				own_at.entry(key).or_insert(j);
			}
		}
		let mut first = None;
		let mut prev_gap: Option<f64> = None;
		let mut jumps: Vec<(f64, usize, u32, u8)> = Vec::new();
		let mut by_guide: Vec<(String, Value)> = Vec::new();
		for (i, s) in shared.iter().enumerate().skip(joins[k]) {
			let Some(j) = run.step_key(s.kind, s.q, s.task).and_then(|key| own_at.get(&key).copied()) else { continue };
			let gap = (ts[i].0 - to[j].0) / 60.0;
			if first.is_none() {
				first = Some(gap);
			}
			if let Some(pg) = prev_gap {
				jumps.push((gap - pg, i, run.q_id[s.q as usize], s.kind));
			}
			prev_gap = Some(gap);
			let o = tail_origin[i - joins[k]];
			let g = if o >= 0 { starts[0].goals.get(o as usize).map_or(String::new(), |x| x.guide.clone()) } else { String::new() };
			if g.is_empty() {
				continue;
			}
			let detail = json!({ "gapMin": (gap * 10.0).round() / 10.0, "levelShared": (ts[i].1 * 100.0).round() / 100.0, "levelOwn": (to[j].1 * 100.0).round() / 100.0, "grindMin": [((to[j].2) / 6.0).round() / 10.0, (ts[i].2 / 6.0).round() / 10.0], "travelMin": [(to[j].3 / 6.0).round() / 10.0, (ts[i].3 / 6.0).round() / 10.0] });
			match by_guide.last_mut() {
				Some(l) if l.0 == g => l.1 = detail,
				_ => by_guide.push((g, detail)),
			}
		}
		let big: Vec<Value> = {
			let mut j = jumps.clone();
			j.sort_by(|a, b| b.0.abs().total_cmp(&a.0.abs()));
			j.truncate(12);
			j.iter().map(|x| json!({ "min": (x.0 * 10.0).round() / 10.0, "step": x.1, "q": x.2, "kind": x.3 })).collect()
		};
		rows.push(json!({
			"start": starts[k].race, "ownH": tot_o / 3600.0, "sharedH": tot_s / 3600.0, "costMin": (tot_s - tot_o) / 60.0,
			"gapAtFirstSharedStepMin": first,
			"atGuideEnd": by_guide.iter().map(|(g, x)| json!([g, x])).collect::<Vec<_>>(),
			"biggestJumps": big,
			"trains": [tr_o, tr_s], "hearths": [h_o.len(), h_s.len()], "zoneChanges": [z_o, z_s],
			"hearthsOwnOnly": h_o.iter().filter(|x| !h_s.iter().any(|y| y.0 == x.0 && y.1 == x.1)).map(|x| json!(x)).collect::<Vec<_>>(),
			"hearthsSharedOnly": h_s.iter().filter(|x| !h_o.iter().any(|y| y.0 == x.0 && y.1 == x.1)).map(|x| json!(x)).collect::<Vec<_>>(),
		}));
	}
	// The canonical start's own hearths (quest id, kind, level) and its bind trace.
	let mut ev = c.model.evaluator(walks);
	ev.trace = Some(Vec::new());
	ev.reset();
	let mut hk = Vec::new();
	for i in 0..c.seed.len() {
		let h0 = ev.s.hearths;
		if !ev.s.finished {
			ev.step_in(&c.seed.steps, i);
		}
		if ev.s.hearths > h0 {
			hk.push(json!([c.model.run.q_id[c.seed.steps[i].q as usize], c.seed.steps[i].kind, (ev.level_now() * 10.0).round() / 10.0]));
		}
	}
	Ok(json!({ "canonical": starts[0].race, "canonicalHearths": hk, "rows": rows }))
}

/// The travel plan of a start playing the shared order: its own (v1) hearths, binds and flight
/// paths for its own prefix's steps, the canonical start's for the tail's (the tail is the
/// canonical start's guide lines).
pub fn shared_plan(
	own: &crate::run::TravelPlan,
	own_run: &crate::run::Run,
	prefix: &[crate::eval::Step],
	canon: &crate::run::TravelPlan,
	canon_run: &crate::run::Run,
	tail: &[crate::eval::Step],
) -> crate::run::TravelPlan {
	let keys = |run: &crate::run::Run, steps: &[crate::eval::Step]| steps.iter().filter_map(|s| run.step_key(s.kind, s.q, s.task)).collect::<rustc_hash::FxHashSet<_>>();
	let (kp, kt) = (keys(own_run, prefix), keys(canon_run, tail));
	let mut p = crate::run::TravelPlan::default();
	for (src, ks) in [(own, &kp), (canon, &kt)] {
		p.hearth.extend(src.hearth.iter().filter(|k| ks.contains(*k)).copied());
		p.bind.extend(src.bind.iter().filter(|k| ks.contains(k.0)).map(|(k, v)| (*k, *v)));
		for (k, v) in src.fp.iter().filter(|k| ks.contains(k.0)) {
			p.fp.entry(*k).or_default().extend(v.iter().copied());
		}
	}
	p
}

/// A start's model for the shared order (shared_plan), same parameters, and its profile.
#[allow(clippy::too_many_arguments)]
pub fn shared_model(
	world: &World,
	walks: &dyn Walks,
	base: &Params,
	profile: &Profile,
	race: &str,
	own: &Prepared,
	prefix: &[crate::eval::Step],
	canon: &Prepared,
	tail: &[crate::eval::Step],
) -> Result<(crate::Model, Profile), String> {
	let (Some(op), Some(cp)) = (own.profile.plan.as_ref(), canon.profile.plan.as_ref()) else { return Ok((crate::route::model_for(world, race, profile, base, walks)?.0, profile.clone())) };
	let plan = shared_plan(op, &own.model.run, prefix, cp, &canon.model.run, tail);
	let pr = Profile { plan: Some(std::sync::Arc::new(plan)), ..own.profile.clone() };
	Ok((crate::route::model_for(world, race, &pr, base, walks)?.0, pr))
}

/// Each start's join: after its own guides, or (join_after) after its last step from that shared
/// guide (each start keeps its own order of it).
fn joins_of(preps: &[Prepared], starts: &[WidenStart], join_after: Option<&str>) -> Vec<usize> {
	preps.iter().zip(starts).map(|(p, s)| crate::shared::join_index(&p.seed, &s.goals, join_after)).collect()
}
