//! Order of a package's steps (port of tools/lib/sim/tour.js planOrder): nearest neighbour
//! under precedence, then 2-opt moves that keep it.

use rustc_hash::FxHashMap;

const FAR: f64 = 1e6;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum StepKind {
	Accept,
	Task,
	Turnin,
}

/// A step and the quest facts precedence reads.
pub struct Step<'a> {
	pub kind: StepKind,
	pub q: u32,
	pub task: i64,
	pub pt: u32,
	pub pre: &'a [i64],
	pub in_log: Option<i64>,
	pub after: Option<&'a [u32]>,
}

/// -> the steps' indices in route order.
pub fn plan_order(steps: &[Step], dist: &dyn Fn(u32, u32) -> f64) -> Vec<usize> {
	let n = steps.len();
	if n <= 1 {
		return (0..n).collect();
	}
	let d = |a: usize, b: usize| {
		let x = dist(steps[a].pt, steps[b].pt);
		if x.is_finite() {
			x
		} else {
			FAR
		}
	};
	struct E {
		accept: i64,
		tasks: Vec<usize>,
		turnin: i64,
	}
	let mut by_quest: FxHashMap<i64, E> = FxHashMap::default();
	for (i, s) in steps.iter().enumerate() {
		let e = by_quest.entry(s.q as i64).or_insert(E { accept: -1, tasks: Vec::new(), turnin: -1 });
		match s.kind {
			StepKind::Accept => e.accept = i as i64,
			StepKind::Task => e.tasks.push(i),
			StepKind::Turnin => e.turnin = i as i64,
		}
	}
	let mut preds: Vec<Vec<usize>> = vec![Vec::new(); n];
	for (i, s) in steps.iter().enumerate() {
		let e = &by_quest[&(s.q as i64)];
		if s.kind == StepKind::Task && e.accept >= 0 {
			preds[i].push(e.accept as usize);
		}
		if s.kind == StepKind::Turnin {
			if e.accept >= 0 {
				preds[i].push(e.accept as usize);
			}
			preds[i].extend(e.tasks.iter().copied());
			for &c in s.after.unwrap_or(&[]) {
				if let Some(x) = by_quest.get(&(c as i64)) {
					if x.turnin >= 0 {
						preds[i].push(x.turnin as usize);
					}
				}
			}
		}
		if s.kind == StepKind::Accept {
			for p in s.pre {
				if let Some(x) = by_quest.get(p) {
					if x.turnin >= 0 {
						preds[i].push(x.turnin as usize);
					}
				}
			}
			if let Some(par) = s.in_log.and_then(|l| by_quest.get(&l)) {
				if par.accept >= 0 {
					preds[i].push(par.accept as usize);
				}
				if par.turnin >= 0 {
					let t = par.turnin as usize;
					preds[t].push(i);
				}
			}
		}
	}
	let mut placed = vec![false; n];
	let ready = |placed: &[bool], i: usize| !placed[i] && preds[i].iter().all(|&p| placed[p]);
	let mut cur: i64 = -1;
	let mut best_n: i64 = -1;
	for i in 0..n {
		if !ready(&placed, i) {
			continue;
		}
		let mut c = 0i64;
		for j in 0..n {
			if d(i, j) <= 150.0 {
				c += 1;
			}
		}
		if c > best_n || (c == best_n && steps[i].kind == StepKind::Accept && steps[cur as usize].kind != StepKind::Accept) {
			best_n = c;
			cur = i as i64;
		}
	}
	if cur < 0 {
		cur = 0;
	}
	let mut cur = cur as usize;
	let mut order = vec![cur];
	placed[cur] = true;
	while order.len() < n {
		let mut best: i64 = -1;
		let mut bd = f64::INFINITY;
		for i in 0..n {
			if !ready(&placed, i) {
				continue;
			}
			let tie = d(cur, i)
				- match steps[i].kind {
					StepKind::Turnin => 0.002,
					StepKind::Accept => 0.001,
					StepKind::Task => 0.0,
				};
			if tie < bd {
				bd = tie;
				best = i as i64;
			}
		}
		if best < 0 {
			best = placed.iter().position(|p| !p).map(|x| x as i64).unwrap_or(-1);
		}
		let b = best as usize;
		placed[b] = true;
		order.push(b);
		cur = b;
	}
	let mut pos = vec![0usize; n];
	let valid_rev = |order: &[usize], pos: &[usize], i: usize, j: usize| -> bool {
		for &s in &order[i..=j] {
			for &p in &preds[s] {
				if pos[p] >= i && pos[p] <= j {
					return false;
				}
			}
		}
		true
	};
	let mut improved = true;
	let mut passes = 0;
	while improved && {
		passes += 1;
		passes <= 50
	} {
		improved = false;
		for (k, &o) in order.iter().enumerate() {
			pos[o] = k;
		}
		for i in 1..n.saturating_sub(1) {
			for j in i + 1..n {
				let a = order[i - 1];
				let b = order[i];
				let c = order[j];
				let dd = if j + 1 < n { Some(order[j + 1]) } else { None };
				let before = d(a, b) + dd.map_or(0.0, |x| d(c, x));
				let after = d(a, c) + dd.map_or(0.0, |x| d(b, x));
				if after < before - 1e-6 && valid_rev(&order, &pos, i, j) {
					order[i..=j].reverse();
					for (k, &o) in order.iter().enumerate().take(j + 1).skip(i) {
						pos[o] = k;
					}
					improved = true;
				}
			}
		}
	}
	order
}
