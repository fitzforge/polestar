//! The game's internal placeholder names (#2614). Forever's quest data names some invisible targets with
//! developer tags: a "[DNT] Kill Credit" (DNT: do not translate) a quest counts instead of the creature or deed,
//! a bare "Credit", the battlegrounds' "PvP Tower Credit Marker" and Alterac Valley's "Trigger Ichman", and it
//! keeps unused, test and unfinished quests ("<UNUSED>", "<TEST> HEY MISTER WILSON!", "<NYI> Flirting With
//! Darkness"). No player should read one: the data
//! build turns objectives on such targets into events with the quest log's own words (forge-data's
//! `credit.rs`) and fails on any it leaves; the compiler words a goal on one by its objective; lint fails on
//! any in a compiled guide; and Lookup's search leaves the unused quests and the placeholder NPCs out.

/// Tags anywhere in a text that mark it as a placeholder.
const TAGS: [&str; 8] = ["[DNT]", "(DNT)", "[PH]", "(DND)", "<UNUSED>", "<TEST>", "Credit Marker", "Kill Credit"];

/// Whether `text` is one of the game's placeholder names: a tag of [`TAGS`], "<NYI>" (not yet implemented,
/// in any case: "<nyi> <TXT> Course of Action"), a bare "Credit", or an Alterac Valley trigger ("Trigger
/// Ichman"; "Mulgore Trigger" and "EZ-Thro Tru-Trigger" are not).
pub fn marked(text: &str) -> bool {
	let t = text.trim();
	TAGS.iter().any(|tag| t.contains(tag)) || t.as_bytes().windows(5).any(|w| w.eq_ignore_ascii_case(b"<NYI>")) || t == "Credit" || t.starts_with("Trigger ") || t.starts_with("DND FLAG")
}

/// The real name a placeholder carries, when it carries one: "[DNT] Kill Credit: Twilight Thrall" and
/// "[DNT] Kill Credit Young Paletusk" -> the creature's name. None for one that names nothing ("[DNT] Kill
/// Credit", "Credit", "PvP Tower Credit Marker", "Trigger Ichman") and for a text that is no placeholder.
pub fn carried(text: &str) -> Option<String> {
	let t = text.trim();
	for tag in ["[DNT] Kill Credit", "(DNT) Kill Credit", "[DNT]", "(DNT)"] {
		if let Some(rest) = t.strip_prefix(tag) {
			let rest = rest.trim_start_matches([':', '-', ' ']).trim();
			if !rest.is_empty() && !marked(rest) && !rest.eq_ignore_ascii_case("Kill Credit") {
				return Some(rest.to_string());
			}
			return None;
		}
	}
	None
}

/// Texts that look like placeholders but ship on purpose, each with what the player reads instead. The data
/// build's and lint's checks pass them, and [`shown`] gives their replacement. None so far.
pub const ALLOWED: &[(&str, &str)] = &[];

/// What a player reads instead of `text` when [`ALLOWED`] lists it.
pub fn allowed(text: &str) -> Option<&'static str> {
	ALLOWED.iter().find(|(t, _)| *t == text.trim()).map(|(_, shown)| *shown)
}

/// Whether a player must never read `text`: a placeholder [`ALLOWED`] does not list.
pub fn banned(text: &str) -> bool {
	marked(text) && allowed(text).is_none()
}

/// What a player may read for `text`: the text itself when it is no placeholder, the replacement [`ALLOWED`]
/// gives, the name a placeholder carries ([`carried`]), else None.
pub fn shown(text: &str) -> Option<String> {
	if let Some(r) = allowed(text) {
		Some(r.to_string())
	} else if marked(text) {
		carried(text)
	} else {
		Some(text.to_string())
	}
}

/// Titles of quests that are not in the game: the client keeps them as unused ("<UNUSED>", "<UNUSED>Infused
/// Bandages"), test ("<TEST> HEY MISTER WILSON!", "Hunter test quest", "Test Kill Quest", "Lee's Ultimate Test
/// Quest... of Doom!"), unfinished ("<NYI> Flirting With Darkness"), flag ("DND FLAG The Dread Citadel -
/// Naxxramas") or free ("REUSE", "REUSE ME", "REUSEME") records. Lookup never offers them.
pub fn unused_quest(title: &str) -> bool {
	let t = title.trim();
	let lower = t.to_ascii_lowercase();
	marked(t) || matches!(lower.as_str(), "reuse" | "reuse me" | "reuseme") || lower.starts_with("hunter test quest") || lower == "test kill quest" || lower.contains("ultimate test quest")
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn the_issues_names_are_placeholders() {
		for t in [
			"[DNT] Kill Credit",
			"[DNT] Kill Credit: Twilight Thrall",
			"[DNT] Kill Credit Young Paletusk",
			"Credit",
			"PvP Graveyard Credit Marker",
			"PvP ALT-N Credit Marker",
			"Trigger Ichman",
			"Corrupted Moonwell Spell Focus (DND)",
			"<UNUSED>",
			"<TEST> HEY MISTER WILSON!",
			"[PH] Silithus PvP Dust [DEP]",
			"DND FLAG The Dread Citadel - Naxxramas",
			"<NYI> Flirting With Darkness",
			"<NYI> <TXT> Flirting With Darkness",
			"<nyi> <TXT> The Centaur Hoofprints",
		] {
			assert!(marked(t), "{t}");
		}
	}

	#[test]
	fn real_names_are_not() {
		for t in ["Credit Union", "Mulgore Trigger", "EZ-Thro Tru-Trigger", "Farholde Scouts rescued", "Graveyard Assaulted", "Reduce, Reuse, Reconcile", "Test of Faith", "Toxic Test"] {
			assert!(!marked(t), "{t}");
			assert!(!unused_quest(t), "{t}");
			assert_eq!(shown(t).as_deref(), Some(t));
		}
	}

	#[test]
	fn a_credit_shows_the_name_it_carries() {
		assert_eq!(shown("[DNT] Kill Credit: Twilight Thrall").as_deref(), Some("Twilight Thrall"));
		assert_eq!(shown("[DNT] Kill Credit Young Paletusk").as_deref(), Some("Young Paletusk"));
		assert_eq!(shown("[DNT] Kill Credit: Ogre Miner").as_deref(), Some("Ogre Miner"));
		for bare in ["[DNT] Kill Credit", "Credit", "PvP Tower Credit Marker", "Trigger Ichman", "<UNUSED>"] {
			assert_eq!(shown(bare), None, "{bare}");
		}
	}

	#[test]
	fn unused_and_test_quests() {
		for t in [
			"<UNUSED>",
			"<UNUSED>Infused Bandages",
			"<UNUSED> The Legacy of the Ashbringer",
			"<TEST> HEY MISTER WILSON!",
			"DND FLAG The Dread Citadel - Naxxramas",
			"Hunter test quest",
			"Hunter test quest2",
			"Test Kill Quest",
			"REUSE",
			"reuse",
			"REUSE ME",
			"Lee's Ultimate Test Quest... of Doom!",
			"REUSEME",
			"<NYI> Flirting With Darkness",
			"<nyi> <TXT> Course of Action",
		] {
			assert!(unused_quest(t), "{t}");
		}
	}
}
