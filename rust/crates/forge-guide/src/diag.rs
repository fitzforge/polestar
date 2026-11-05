//! Diagnostics: errors fail compile/lint, warnings print. Port of tools/lib/dsl/diag.js and
//! tools/lib/cli.js printDiagnostics (text, json, github).

use crate::js::{json_quote, num_str};

#[derive(Clone, Debug, PartialEq)]
pub struct Diag {
	/// "error" or "warning".
	pub severity: &'static str,
	pub file: Option<String>,
	pub line: f64,
	pub message: String,
	pub hint: Option<String>,
}

#[derive(Default, Clone, Debug)]
pub struct Diagnostics {
	pub list: Vec<Diag>,
}

fn make(severity: &'static str, file: &str, line: f64, message: String, hint: Option<String>) -> Diag {
	Diag { severity, file: Some(file.to_string()), line: if line.is_nan() { 0.0 } else { line }, message, hint: hint.filter(|h| !h.is_empty()) }
}

impl Diagnostics {
	pub fn new() -> Self {
		Self::default()
	}
	pub fn error(&mut self, file: &str, line: f64, message: impl Into<String>, hint: Option<String>) {
		self.list.push(make("error", file, line, message.into(), hint));
	}
	pub fn warn(&mut self, file: &str, line: f64, message: impl Into<String>, hint: Option<String>) {
		self.list.push(make("warning", file, line, message.into(), hint));
	}
	pub fn errors(&self) -> Vec<&Diag> {
		self.list.iter().filter(|d| d.severity == "error").collect()
	}
	pub fn warnings(&self) -> Vec<&Diag> {
		self.list.iter().filter(|d| d.severity == "warning").collect()
	}
	pub fn has_errors(&self) -> bool {
		self.list.iter().any(|d| d.severity == "error")
	}
	/// Stable order: by file, line, then errors before warnings, then insertion.
	pub fn sorted(&self) -> Vec<Diag> {
		let mut v: Vec<(usize, &Diag)> = self.list.iter().enumerate().collect();
		v.sort_by(|(ia, a), (ib, b)| {
			let fa = a.file.as_deref().unwrap_or("");
			let fb = b.file.as_deref().unwrap_or("");
			crate::js::cmp_utf16(fa, fb).then(a.line.partial_cmp(&b.line).unwrap_or(std::cmp::Ordering::Equal)).then((a.severity != "error").cmp(&(b.severity != "error"))).then(ia.cmp(ib))
		});
		v.into_iter().map(|(_, d)| d.clone()).collect()
	}
}

/// One diagnostic as text: `file:line: severity: message`, then `  hint: <hint>`.
pub fn format(d: &Diag) -> String {
	let where_ = match &d.file {
		Some(f) if !f.is_empty() => {
			if d.line != 0.0 {
				format!("{}:{}: ", f, num_str(d.line))
			} else {
				format!("{f}: ")
			}
		}
		_ => String::new(),
	};
	let hint = d.hint.as_ref().map(|h| format!("\n  hint: {h}")).unwrap_or_default();
	format!("{where_}{}: {}{hint}", d.severity, d.message)
}

fn gh_data(s: &str) -> String {
	s.replace('%', "%25").replace('\r', "%0D").replace('\n', "%0A")
}

fn gh_prop(s: &str) -> String {
	gh_data(s).replace(':', "%3A").replace(',', "%2C")
}

fn github(d: &Diag) -> String {
	let mut props = Vec::new();
	let file = d.file.as_deref().filter(|f| !f.is_empty());
	if let Some(f) = file {
		props.push(format!("file={}", gh_prop(f)));
		if d.line != 0.0 {
			props.push(format!("line={}", num_str(d.line)));
		}
	}
	let text = format!("{}{}", d.message, d.hint.as_ref().map(|h| format!(" (hint: {h})")).unwrap_or_default());
	let props = if props.is_empty() { String::new() } else { format!(" {}", props.join(",")) };
	format!("::{}{}::{}", if d.severity == "error" { "error" } else { "warning" }, props, gh_data(&text))
}

/// items -> the output in `fmt` (text, json, github); json counts over `counted`.
pub fn format_diagnostics(items: &[Diag], fmt: &str, counted: &[Diag]) -> String {
	match fmt {
		"json" => {
			let errors = counted.iter().filter(|d| d.severity == "error").count();
			let mut o = String::new();
			o.push_str(&format!("{{\n\t\"ok\": {},\n\t\"errors\": {},\n\t\"warnings\": {},\n\t\"diagnostics\": ", errors == 0, errors, counted.len() - errors));
			if items.is_empty() {
				o.push_str("[]");
			} else {
				o.push('[');
				for (i, d) in items.iter().enumerate() {
					if i > 0 {
						o.push(',');
					}
					o.push_str("\n\t\t{\n\t\t\t\"file\": ");
					match d.file.as_deref().filter(|f| !f.is_empty()) {
						Some(f) => json_quote(&mut o, f),
						None => o.push_str("null"),
					}
					o.push_str(&format!(",\n\t\t\t\"line\": {},\n\t\t\t\"severity\": ", num_str(d.line)));
					json_quote(&mut o, d.severity);
					o.push_str(",\n\t\t\t\"message\": ");
					json_quote(&mut o, &d.message);
					if let Some(h) = &d.hint {
						o.push_str(",\n\t\t\t\"hint\": ");
						json_quote(&mut o, h);
					}
					o.push_str("\n\t\t}");
				}
				o.push_str("\n\t]");
			}
			o.push_str("\n}");
			o
		}
		"github" => items.iter().map(github).collect::<Vec<_>>().join("\n"),
		_ => items.iter().map(format).collect::<Vec<_>>().join("\n"),
	}
}
