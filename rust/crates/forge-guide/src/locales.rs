//! Port of tools/lib/i18n/locales.js.
//!
//! The languages of Polestar's interface (docs/TRANSLATING.md): the client
//! locales WoW: Forever ships besides English. Each has one file,
//! addon/Polestar/Locales/<locale>.lua, loaded by Core/Core.xml once it
//! exists. `status`: "reviewed" when a native speaker wrote or checked it
//! (tooling never fills or rewrites its translations; `i18n sync` only adds
//! the new keys commented out), "ai" when a machine made it (Options' About
//! says so on that client: ns.AI_LOCALES in Core/Init.lua, kept equal to this
//! list by tests/i18n.test.js). enUS and enGB read the English keys. Adapted
//! from Ding! by Yendi (@moust4ki), GPL-3.0:
//! https://github.com/moust4ki/DingGuideWoWForever

pub struct Locale {
	pub code: &'static str,
	pub language: &'static str,
	pub status: &'static str,
	pub translators: &'static [&'static str],
}

/// LOCALES, in its key order.
pub static LOCALES: [Locale; 9] = [
	Locale { code: "deDE", language: "German", status: "reviewed", translators: &["thecodingcortex"] },
	Locale { code: "esES", language: "Spanish (Spain)", status: "reviewed", translators: &["julen92"] },
	Locale { code: "esMX", language: "Spanish (Latin America)", status: "reviewed", translators: &["CDVolvik"] },
	Locale { code: "frFR", language: "French", status: "reviewed", translators: &["Yendi"] },
	Locale { code: "koKR", language: "Korean", status: "ai", translators: &[] },
	Locale { code: "ptBR", language: "Portuguese (Brazil)", status: "ai", translators: &[] },
	Locale { code: "ruRU", language: "Russian", status: "ai", translators: &[] },
	Locale { code: "zhCN", language: "Chinese (simplified)", status: "ai", translators: &[] },
	Locale { code: "zhTW", language: "Chinese (traditional)", status: "ai", translators: &[] },
];

pub const LOCALE_CODES: [&str; 9] = ["deDE", "esES", "esMX", "frFR", "koKR", "ptBR", "ruRU", "zhCN", "zhTW"];

/// `LOCALES[code]`.
pub fn locale(code: &str) -> Option<&'static Locale> {
	LOCALES.iter().find(|l| l.code == code)
}

pub fn check_locale(locale_code: &str) -> Result<&str, String> {
	if locale(locale_code).is_none() {
		return Err(format!("unknown locale \"{locale_code}\": one of {}", LOCALE_CODES.join(", ")));
	}
	Ok(locale_code)
}

/// `LOCALES[code].language` (panics on an unknown code, where the JS would throw).
pub fn language(code: &str) -> String {
	locale(code).unwrap_or_else(|| panic!("unknown locale \"{code}\"")).language.to_string()
}
