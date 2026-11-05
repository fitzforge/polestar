//! Replacing the player's own character names in recorded text with `$N` (the addon already does
//! this for the current character; the Polestar Client and forge do it again for every character of the
//! account).

use crate::record::Kind;

/// `text` with every whole-word occurrence of a name (case-insensitive) replaced by `$N`. Names
/// shorter than two characters are ignored.
pub fn scrub_text(text: &str, names: &[String]) -> String {
	let mut out: Vec<char> = text.chars().collect();
	for name in names {
		let pat: Vec<char> = name.trim().chars().flat_map(char::to_lowercase).collect();
		if pat.len() < 2 {
			continue;
		}
		let mut res: Vec<char> = Vec::with_capacity(out.len());
		let mut i = 0;
		while i < out.len() {
			let boundary_before = i == 0 || !out[i - 1].is_alphanumeric();
			if boundary_before && matches_at(&out, i, &pat) {
				let end = i + pat.len();
				if end == out.len() || !out[end].is_alphanumeric() {
					res.extend(['$', 'N']);
					i = end;
					continue;
				}
			}
			res.push(out[i]);
			i += 1;
		}
		out = res;
	}
	out.into_iter().collect()
}

/// Whether the lowercase pattern matches `text` at `i` (character by character; a character whose
/// lowercase form is several characters never matches, which only affects rare scripts).
fn matches_at(text: &[char], i: usize, pat: &[char]) -> bool {
	if i + pat.len() > text.len() {
		return false;
	}
	pat.iter().enumerate().all(|(k, p)| {
		let mut l = text[i + k].to_lowercase();
		l.next() == Some(*p) && l.next().is_none()
	})
}

/// A chunk's text with [`scrub_text`] applied to the free text of every known record (titles,
/// objective and gossip text, notes, zone names, trainer service names, ...); ids, numbers and
/// tokens are left alone, and so are records of unknown kinds.
pub fn scrub_chunk(text: &str, names: &[String]) -> String {
	if names.iter().all(|n| n.trim().chars().count() < 2) {
		return text.to_string();
	}
	let lines: Vec<String> = text
		.split('\n')
		.map(|line| {
			let mut parts: Vec<String> = line.split('\t').map(str::to_string).collect();
			let Some(kind) = Kind::parse(&parts[0]).filter(|k| !matches!(k, Kind::Chunk | Kind::Session)) else { return line.to_string() };
			for (i, sub) in kind.text_slots() {
				let Some(f) = parts.get_mut(i + 2) else { continue };
				*f = match sub {
					None => scrub_text(f, names),
					Some(p) => f
						.split(';')
						.map(|item| item.split(':').enumerate().map(|(k, s)| if k == p { scrub_text(s, names) } else { s.to_string() }).collect::<Vec<_>>().join(":"))
						.collect::<Vec<_>>()
						.join(";"),
				};
			}
			parts.join("\t")
		})
		.collect();
	lines.join("\n")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn replaces_whole_names_only() {
		let names = vec!["Thrall".to_string(), "Zoë".to_string(), "x".to_string()];
		assert_eq!(scrub_text("Well met, Thrall. THRALL's axe; Thralldom, x marks.", &names), "Well met, $N. $N's axe; Thralldom, x marks.");
		assert_eq!(scrub_text("zoë und Zoë!", &names), "$N und $N!");
		assert_eq!(scrub_text("", &names), "");
	}

	#[test]
	fn scrubs_only_text_fields_of_a_chunk() {
		let names = vec!["Warrior".to_string()];
		let chunk = "chunk\t0\t1\t1700000000\tabcdefghij\nsession\t0\tabcdefghij\tHuman\tWARRIOR\tAlliance\nmark\t5\t\t\t\tmeet Warrior here\nobjectives\t6\t9\tmonster:8:Warrior slain\ntrainer\t7\t1\t\t\t\t0:10:4:a:Warrior Shout\nfuture\t8\tWarrior";
		assert_eq!(
			scrub_chunk(chunk, &names),
			"chunk\t0\t1\t1700000000\tabcdefghij\nsession\t0\tabcdefghij\tHuman\tWARRIOR\tAlliance\nmark\t5\t\t\t\tmeet $N here\nobjectives\t6\t9\tmonster:8:$N slain\ntrainer\t7\t1\t\t\t\t0:10:4:a:$N Shout\nfuture\t8\tWarrior"
		);
	}
}
