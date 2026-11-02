//! Replacing the player's own character names in recorded text with `$N` (the addon already does
//! this for the current character; the Polestar Client and forge do it again for every character of the
//! account).

use crate::record::Kind;

/// `text` with every whole-word occurrence of a name (case-insensitive) replaced by `$N`. Names
/// shorter than two characters are ignored. Chinese, Japanese and Korean write no spaces between
/// words (Korean puts its particles right after a name: "철수가"), so where the name's first or
/// last character, or the character beside it, is one of those scripts ([`is_cjk`]), that side
/// needs no word boundary; Latin, Cyrillic and other alphabets keep it ("Thralldom" is not Thrall).
pub fn scrub_text(text: &str, names: &[String]) -> String {
	let mut out: Vec<char> = text.chars().collect();
	for name in names {
		let pat: Vec<char> = name.trim().chars().flat_map(char::to_lowercase).collect();
		if pat.len() < 2 {
			continue;
		}
		let (first, last) = (pat[0], pat[pat.len() - 1]);
		let mut res: Vec<char> = Vec::with_capacity(out.len());
		let mut i = 0;
		while i < out.len() {
			let boundary_before = i == 0 || separates(out[i - 1], first);
			if boundary_before && matches_at(&out, i, &pat) {
				let end = i + pat.len();
				if end == out.len() || separates(out[end], last) {
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

/// Whether `neighbour`, right beside a name whose character on that side is `edge`, lets the name
/// match: it is not a letter or digit, or either of them is CJK or Hangul.
fn separates(neighbour: char, edge: char) -> bool {
	!neighbour.is_alphanumeric() || is_cjk(neighbour) || is_cjk(edge)
}

/// Whether `c` belongs to a script written without spaces between words: Han ideographs, Hangul,
/// Japanese kana and Bopomofo (their Unicode blocks).
pub fn is_cjk(c: char) -> bool {
	matches!(c as u32,
		0x1100..=0x11FF // Hangul Jamo
		| 0x2E80..=0x2FDF // CJK and Kangxi radicals
		| 0x3005..=0x3007 // 々 〆 〇
		| 0x3040..=0x30FF // Hiragana, Katakana
		| 0x3100..=0x312F // Bopomofo
		| 0x3130..=0x318F // Hangul Compatibility Jamo
		| 0x31A0..=0x31BF // Bopomofo Extended
		| 0x31F0..=0x31FF // Katakana Phonetic Extensions
		| 0x3400..=0x4DBF // CJK Extension A
		| 0x4E00..=0x9FFF // CJK Unified Ideographs
		| 0xA960..=0xA97F // Hangul Jamo Extended-A
		| 0xAC00..=0xD7FF // Hangul Syllables, Jamo Extended-B
		| 0xF900..=0xFAFF // CJK Compatibility Ideographs
		| 0xFF66..=0xFF9F // Halfwidth Katakana
		| 0xFFA0..=0xFFDC // Halfwidth Hangul
		| 0x20000..=0x323AF // CJK Extensions B to H, Compatibility Supplement
	)
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
	fn replaces_names_inside_cjk_and_hangul_text() {
		let names = vec!["철수".to_string(), "张三".to_string(), "Thrall".to_string(), "さくら".to_string()];
		// Korean particles follow the name directly.
		assert_eq!(scrub_text("철수가 왔다. 철수에게 말하세요", &names), "$N가 왔다. $N에게 말하세요");
		// Chinese has no spaces at all.
		assert_eq!(scrub_text("和张三勇士谈谈", &names), "和$N勇士谈谈");
		assert_eq!(scrub_text("さくらさんに話す", &names), "$Nさんに話す");
		// A Latin name written into CJK text.
		assert_eq!(scrub_text("Thrall에게 말하세요, 与Thrall交谈", &names), "$N에게 말하세요, 与$N交谈");
	}

	#[test]
	fn keeps_word_boundaries_in_latin_and_cyrillic_text() {
		let names = vec!["Thrall".to_string(), "Иван".to_string()];
		assert_eq!(scrub_text("Thralldom, Thrall", &names), "Thralldom, $N");
		assert_eq!(scrub_text("Иванов и Иван, ИВАНу", &names), "Иванов и $N, ИВАНу");
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
