//! A radius the pack would write as `r = 0` (2 decimals) is refused: the addon rejects the guide with
//! "bad radius". Repro from forge-judge's fuzzer (tests/fuzz/ok-radius-rounds-to-zero.guide there).

use forge_guide::data::Data;
use forge_guide::project::{lint_sources, Source};

fn errors(goal: &str) -> Vec<String> {
	let text = format!("guide forever/fuzz/p\ntitle P\nlevels 1-10\nzone Durotar\nstep A\n  {goal}\n");
	let src = Source { source: "p.guide".into(), file: "p.guide".into(), text };
	lint_sources(&[src], &Data::empty(), &forge_guide::js::V::obj()).into_iter().filter(|d| d.severity == "error").map(|d| d.message).collect()
}

#[test]
fn radius_rounding_to_zero_is_refused() {
	for r in ["0.004", "0.0049", "0.0001"] {
		let e = errors(&format!("goto 50,50 r {r}"));
		assert!(e.iter().any(|m| m.contains("rounds to 0")), "r {r}: {e:?}");
	}
	assert!(errors("goto 50,50 r 0").iter().any(|m| m.contains("malformed radius")));
	for r in ["0.005", "0.01", "12"] {
		assert!(!errors(&format!("goto 50,50 r {r}")).iter().any(|m| m.contains("radius")), "r {r}");
	}
}
