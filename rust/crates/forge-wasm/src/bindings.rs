//! wasm-bindgen face of [`crate::Planner`]: JSON strings and bytes in, JSON strings out.

use wasm_bindgen::prelude::*;

use crate::{diag_json, to_json_hidden, Character, Pack, Planner};
use forge_guide::project::FileContent;

fn err(e: String) -> JsValue {
	JsValue::from_str(&e)
}

fn diags(list: &[forge_guide::diag::Diag]) -> serde_json::Value {
	serde_json::Value::Array(list.iter().map(diag_json).collect())
}

#[wasm_bindgen(js_name = Planner)]
pub struct JsPlanner(Planner);

#[wasm_bindgen(js_class = Planner)]
impl JsPlanner {
	/// `data`: JSON `{ "<file>": "<its JSON text>", ... }` of the reference data; `instances`, `areas`: JSON texts.
	#[wasm_bindgen(constructor)]
	pub fn new(data: &str, instances: &str, areas: &str) -> Result<JsPlanner, JsValue> {
		let texts: rustc_hash::FxHashMap<String, String> = serde_json::from_str(data).map_err(|e| err(format!("data: {e}")))?;
		Planner::new(&texts, instances, areas).map(JsPlanner).map_err(err)
	}

	/// The client's spell names (the bundle's spell-names.json): JSON [[name, id], ...].
	#[wasm_bindgen(js_name = setSpellNames)]
	pub fn set_spell_names(&mut self, json: &str) -> Result<(), JsValue> {
		self.0.set_spell_names(json).map_err(err)
	}

	/// The pack's files: JSON `{ manifest, legs, retired, license, translations, iface }` (texts; null: absent).
	#[wasm_bindgen(js_name = setPack)]
	pub fn set_pack(&mut self, pack: &str) -> Result<(), JsValue> {
		let v: serde_json::Value = serde_json::from_str(pack).map_err(|e| err(format!("pack: {e}")))?;
		let s = |k: &str| v[k].as_str().map(str::to_string);
		self.0
			.set_pack(Pack {
				manifest: s("manifest").unwrap_or_else(|| "{}".into()),
				legs: s("legs"),
				retired: s("retired"),
				license: s("license"),
				translations: s("translations"),
				iface: s("iface").unwrap_or_default(),
			})
			.map_err(err)
	}

	/// Compile one guide file and keep it. -> JSON `{ guide (hidden properties as "\u0000<name>" keys) | null, diagnostics }`.
	#[wasm_bindgen(js_name = compileGuide)]
	pub fn compile_guide(&mut self, source: &str, file: &str, text: &str) -> String {
		let (g, d) = self.0.compile_guide(source, file, text);
		let guide = g.map_or_else(|| "null".to_string(), |g| to_json_hidden(&g));
		format!("{{\"guide\":{guide},\"diagnostics\":{}}}", diags(&d))
	}

	#[wasm_bindgen(js_name = removeGuide)]
	pub fn remove_guide(&mut self, source: &str) {
		self.0.remove_guide(source);
	}

	/// The pack's lint as a JSON list of diagnostics.
	pub fn lint(&self) -> String {
		diags(&self.0.lint()).to_string()
	}

	/// The addon folder: `{ diagnostics, files: [[name, text]] | null }`, bytes as `{ b64 }`.
	#[wasm_bindgen(js_name = packFiles)]
	pub fn pack_files(&self) -> String {
		let (files, d) = self.0.pack_files();
		let files = files.map(|f| {
			serde_json::Value::Array(
				f.into_iter()
					.map(|(name, c)| match c {
						FileContent::Text(t) => serde_json::json!([name, t]),
						FileContent::Bytes(b) => serde_json::json!([name, { "b64": b64(&b) }]),
					})
					.collect(),
			)
		});
		serde_json::json!({ "diagnostics": diags(&d), "files": files }).to_string()
	}

	#[wasm_bindgen(js_name = setWorld)]
	pub fn set_world(&mut self, faction: &str, world: &[u8], params: Option<String>) -> Result<(), JsValue> {
		self.0.set_world(faction, world, params.as_deref()).map_err(err)
	}

	#[wasm_bindgen(js_name = hasWorld)]
	pub fn has_world(&self, faction: &str) -> bool {
		self.0.has_world(faction)
	}

	/// The simulator's hours as JSON. `cls`: a class file name or empty; `chain`: a JSON list of guide ids
	/// or empty (the pack's default route).
	pub fn hours(&self, faction: &str, race: &str, cls: &str, chain: &str) -> Result<String, JsValue> {
		let chain = if chain.trim().is_empty() { None } else { Some(serde_json::from_str::<Vec<String>>(chain).map_err(|e| err(format!("chain: {e}")))?) };
		let ch = Character { faction: faction.into(), race: race.into(), cls: if cls.is_empty() { None } else { Some(cls.into()) } };
		let h = self.0.hours(&ch, chain).map_err(err)?;
		serde_json::to_string(&h).map_err(|e| err(e.to_string()))
	}
}

fn b64(b: &[u8]) -> String {
	const T: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	let mut s = String::with_capacity(b.len().div_ceil(3) * 4);
	for c in b.chunks(3) {
		let n = (c[0] as u32) << 16 | (*c.get(1).unwrap_or(&0) as u32) << 8 | *c.get(2).unwrap_or(&0) as u32;
		for i in 0..4 {
			s.push(if i <= c.len() { T[(n >> (18 - 6 * i) & 63) as usize] as char } else { '=' });
		}
	}
	s
}
