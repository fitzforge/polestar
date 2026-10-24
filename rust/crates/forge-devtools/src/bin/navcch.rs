//! navcch build <graph/<c>.bin.gz> <gi> <out.cch>   preprocess one coarse graph (weight-free)
//! navcch check <graph/<c>.bin.gz> <gi> <out.cch> [pairs]   customize with straight-line yards and
//!   compare CCH distances and unpacked paths against Dijkstra on the coarse graph

use forge_nav::cch::graph::CoarseGraph;
use forge_nav::cch::metric::Metric;
use forge_nav::cch::query::{path, table, Search, Seed};
use forge_nav::cch::structure::{build, Structure};
use std::collections::BinaryHeap;
use std::path::Path;
use std::time::Instant;

fn rss_mb() -> f64 {
	let s = std::fs::read_to_string("/proc/self/status").unwrap_or_default();
	for l in s.lines() {
		if let Some(v) = l.strip_prefix("VmHWM:") {
			return v.trim().trim_end_matches(" kB").trim().parse::<f64>().unwrap_or(0.0) / 1024.0;
		}
	}
	0.0
}

#[derive(PartialEq)]
struct H(f64, u32);
impl Eq for H {}
impl PartialOrd for H {
	fn partial_cmp(&self, o: &Self) -> Option<std::cmp::Ordering> {
		Some(self.cmp(o))
	}
}
impl Ord for H {
	fn cmp(&self, o: &Self) -> std::cmp::Ordering {
		o.0.partial_cmp(&self.0).unwrap()
	}
}

fn main() {
	let a: Vec<String> = std::env::args().collect();
	let g = CoarseGraph::read(Path::new(&a[2])).expect("graph");
	let gi: usize = a[3].parse().unwrap();
	let out = Path::new(&a[4]);
	match a[1].as_str() {
		"build" => {
			let t = Instant::now();
			let st = build(&g, gi, out).expect("build");
			println!(
				"{{\"c\":{},\"gi\":{gi},\"nodes\":{},\"inputArcs\":{},\"arcs\":{},\"levels\":{},\"orderMs\":{:.0},\"buildMs\":{:.0},\"totalMs\":{:.0},\"peakMB\":{:.0},\"bytes\":{}}}",
				g.c,
				st.nodes,
				st.input_arcs,
				st.arcs,
				st.levels,
				st.order_ms,
				st.build_ms,
				t.elapsed().as_secs_f64() * 1e3,
				rss_mb(),
				std::fs::metadata(out).map(|m| m.len()).unwrap_or(0)
			);
		}
		"check" => {
			let pairs: usize = a.get(5).map(|s| s.parse().unwrap()).unwrap_or(200);
			let s = Structure::open(out).expect("open");
			let rg = &g.graphs[gi];
			let n = g.node_count;
			let mut w = vec![0.0; rg.to.len()];
			for u in 0..n {
				for x in rg.off[u] as usize..rg.off[u + 1] as usize {
					let v = rg.to[x] as usize;
					w[x] = (g.wx[u] - g.wx[v]).hypot(g.wy[u] - g.wy[v]) + 1.0 + (x % 7) as f64;
				}
			}
			let yd: Vec<f32> = w.iter().map(|v| (v * 0.5) as f32).collect();
			let t = Instant::now();
			let m = Metric::customize(&s, w.clone(), yd);
			println!("customize {:.0} ms", t.elapsed().as_secs_f64() * 1e3);
			let mut rng = 12345u64;
			let mut next = || {
				rng = rng.wrapping_mul(6364136223846793005).wrapping_add(1442695040888963407);
				(rng >> 33) as usize % n
			};
			let (mut fw, mut bw) = (Search::new(n), Search::new(n));
			let mut bad = 0;
			let mut dist = vec![f64::INFINITY; n];
			for _ in 0..pairs {
				let (src, dst) = (next(), next());
				dist.iter_mut().for_each(|d| *d = f64::INFINITY);
				dist[src] = 0.0;
				let mut h = BinaryHeap::new();
				h.push(H(0.0, src as u32));
				while let Some(H(d, u)) = h.pop() {
					if d > dist[u as usize] {
						continue;
					}
					for x in rg.off[u as usize] as usize..rg.off[u as usize + 1] as usize {
						let v = rg.to[x] as usize;
						if d + w[x] < dist[v] {
							dist[v] = d + w[x];
							h.push(H(dist[v], v as u32));
						}
					}
				}
				let sd = [Seed { node: src as u32, cost: 0.0, yards: 0.0 }];
				let td = [Seed { node: dst as u32, cost: 0.0, yards: 0.0 }];
				let p = path(&s, &m, &mut fw, &mut bw, &sd, &td);
				let c = p.as_ref().map(|p| p.cost).unwrap_or(f64::INFINITY);
				let mut ok = (c - dist[dst]).abs() <= 1e-9 * dist[dst].max(1.0) || (c.is_infinite() && dist[dst].is_infinite());
				if let Some(p) = &p {
					// the unpacked path's own cost over cheapest parallel edges
					let mut sum = 0.0;
					for k in 1..p.nodes.len() {
						let (u, v) = (p.nodes[k - 1] as usize, p.nodes[k]);
						let mut best = f64::INFINITY;
						for x in rg.off[u] as usize..rg.off[u + 1] as usize {
							if rg.to[x] == v && w[x] < best {
								best = w[x];
							}
						}
						sum += best;
					}
					ok &= p.nodes[0] as usize == src && *p.nodes.last().unwrap() as usize == dst && (sum - c).abs() <= 1e-6 * c.max(1.0) && (p.yards - 0.5 * c).abs() <= 1e-5 * c.max(1.0);
				}
				if !ok {
					bad += 1;
					if bad < 5 {
						eprintln!("mismatch {src}->{dst}: cch {c} dijkstra {}", dist[dst]);
					}
				}
			}
			println!("check: {pairs} pairs, {bad} mismatches");
			let k = 300.min(n);
			let off: Vec<u32> = (0..=k as u32).collect();
			let seeds: Vec<Seed> = (0..k).map(|_| Seed { node: next() as u32, cost: 0.0, yards: 0.0 }).collect();
			let t = Instant::now();
			let (c, _) = forge_nav::cch::pool(0).install(|| table(&s, &m, &off, &seeds, &off, &seeds));
			println!("table {k}x{k}: {:.0} ms, {} reachable; peak {:.0} MB", t.elapsed().as_secs_f64() * 1e3, c.iter().filter(|v| **v >= 0.0).count(), rss_mb());
		}
		_ => panic!("navcch build|check"),
	}
}
