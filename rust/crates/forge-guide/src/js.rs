//! A JavaScript value model, so the compiler ports `tools/lib/dsl/*.js` line for line and keeps the JS
//! compiler's exact behaviour (byte parity): shared mutable objects and arrays (`Rc<RefCell<..>>`, like
//! JS references), JS property order (array-index keys ascending, then the rest in insertion order),
//! non-enumerable ("hidden") properties, `JSON.parse`/`JSON.stringify`, `String(number)` and
//! `Number.prototype.toFixed` (ties round up on the exact binary value, unlike Rust's `{:.N}`).
//!
//! The typed model the writer and judge use is [`crate::model`]; this module is the compiler's engine room.

use rustc_hash::FxHashMap;
use std::cell::RefCell;
use std::fmt::Write as _;
use std::rc::Rc;

pub type Str = Rc<str>;

#[derive(Clone, Default)]
pub enum V {
	#[default]
	Undef,
	Null,
	Bool(bool),
	Num(f64),
	Str(Str),
	Arr(Arr),
	Obj(Obj),
}

#[derive(Clone, Default)]
pub struct Arr(pub Rc<RefCell<Vec<V>>>);
#[derive(Clone, Default)]
pub struct Obj(pub Rc<RefCell<ObjData>>);

/// Properties in insertion order (deleted ones are tombstoned), with a hash index once the object grows.
#[derive(Default)]
pub struct ObjData {
	entries: Vec<(Str, Option<V>)>,
	index: Option<FxHashMap<Str, usize>>,
	live: usize,
	has_index_keys: bool,
	hidden: Vec<(Str, V)>,
}

const INDEX_AT: usize = 12;

/// Whether `k` is a canonical array index ("0", "17"; not "017", "-1", "4294967295").
pub fn is_index_key(k: &str) -> bool {
	let b = k.as_bytes();
	if b.is_empty() || b.len() > 10 || (b[0] == b'0' && b.len() > 1) || !b.iter().all(u8::is_ascii_digit) {
		return false;
	}
	k.parse::<u64>().map(|n| n < 4_294_967_295).unwrap_or(false)
}

impl ObjData {
	fn find(&self, k: &str) -> Option<usize> {
		if let Some(ix) = &self.index {
			return ix.get(k).copied();
		}
		self.entries.iter().position(|(key, v)| v.is_some() && &**key == k)
	}
	pub fn get(&self, k: &str) -> Option<&V> {
		self.find(k).and_then(|i| self.entries[i].1.as_ref()).or_else(|| self.hidden.iter().find(|(key, _)| &**key == k).map(|(_, v)| v))
	}
	pub fn set(&mut self, k: Str, v: V) {
		if let Some(i) = self.find(&k) {
			self.entries[i].1 = Some(v);
			return;
		}
		if let Some(h) = self.hidden.iter_mut().find(|(key, _)| *key == k) {
			h.1 = v;
			return;
		}
		if is_index_key(&k) {
			self.has_index_keys = true;
		}
		let at = self.entries.len();
		if let Some(ix) = &mut self.index {
			ix.insert(k.clone(), at);
		}
		self.entries.push((k, Some(v)));
		self.live += 1;
		if self.index.is_none() && self.entries.len() > INDEX_AT {
			let mut ix = FxHashMap::default();
			for (i, (key, v)) in self.entries.iter().enumerate() {
				if v.is_some() {
					ix.insert(key.clone(), i);
				}
			}
			self.index = Some(ix);
		}
	}
	pub fn delete(&mut self, k: &str) -> bool {
		if let Some(i) = self.find(k) {
			self.entries[i].1 = None;
			if let Some(ix) = &mut self.index {
				ix.remove(k);
			}
			self.live -= 1;
			return true;
		}
		false
	}
	pub fn set_hidden(&mut self, k: &str, v: V) {
		if let Some(h) = self.hidden.iter_mut().find(|(key, _)| &**key == k) {
			h.1 = v;
		} else {
			self.hidden.push((k.into(), v));
		}
	}
	pub fn get_hidden(&self, k: &str) -> V {
		self.hidden.iter().find(|(key, _)| &**key == k).map(|(_, v)| v.clone()).unwrap_or_default()
	}
	pub fn len(&self) -> usize {
		self.live
	}
	pub fn is_empty(&self) -> bool {
		self.live == 0
	}
	/// Own enumerable keys in JS order.
	pub fn keys(&self) -> Vec<Str> {
		let live = self.entries.iter().filter(|(_, v)| v.is_some());
		if !self.has_index_keys {
			return live.map(|(k, _)| k.clone()).collect();
		}
		let mut idx: Vec<(u64, Str)> = Vec::new();
		let mut rest = Vec::new();
		for (k, _) in live {
			if is_index_key(k) {
				idx.push((k.parse().unwrap(), k.clone()));
			} else {
				rest.push(k.clone());
			}
		}
		idx.sort_unstable_by_key(|(n, _)| *n);
		idx.into_iter().map(|(_, k)| k).chain(rest).collect()
	}
	pub fn entries(&self) -> Vec<(Str, V)> {
		self.keys()
			.into_iter()
			.map(|k| {
				let v = self.get(&k).cloned().unwrap_or_default();
				(k, v)
			})
			.collect()
	}
}

thread_local! {
	static INTERN: RefCell<FxHashMap<Box<str>, Str>> = RefCell::new(FxHashMap::default());
}

/// A shared string for a property name used over and over (data field names).
pub fn intern(s: &str) -> Str {
	INTERN.with(|m| {
		let mut m = m.borrow_mut();
		if let Some(r) = m.get(s) {
			return r.clone();
		}
		let r: Str = s.into();
		m.insert(s.into(), r.clone());
		r
	})
}

impl Obj {
	pub fn new() -> Obj {
		Obj::default()
	}
	pub fn get(&self, k: &str) -> V {
		self.0.borrow().get(k).cloned().unwrap_or_default()
	}
	pub fn has(&self, k: &str) -> bool {
		self.0.borrow().get(k).is_some()
	}
	pub fn set(&self, k: &str, v: impl Into<V>) {
		self.0.borrow_mut().set(intern(k), v.into());
	}
	pub fn set_str(&self, k: Str, v: impl Into<V>) {
		self.0.borrow_mut().set(k, v.into());
	}
	pub fn delete(&self, k: &str) -> bool {
		self.0.borrow_mut().delete(k)
	}
	pub fn keys(&self) -> Vec<Str> {
		self.0.borrow().keys()
	}
	pub fn entries(&self) -> Vec<(Str, V)> {
		self.0.borrow().entries()
	}
	pub fn values(&self) -> Vec<V> {
		self.entries().into_iter().map(|(_, v)| v).collect()
	}
	pub fn len(&self) -> usize {
		self.0.borrow().len()
	}
	pub fn is_empty(&self) -> bool {
		self.0.borrow().is_empty()
	}
	pub fn set_hidden(&self, k: &str, v: impl Into<V>) {
		self.0.borrow_mut().set_hidden(k, v.into());
	}
	pub fn hidden(&self, k: &str) -> V {
		self.0.borrow().get_hidden(k)
	}
	pub fn ptr_eq(&self, o: &Obj) -> bool {
		Rc::ptr_eq(&self.0, &o.0)
	}
	/// `{ ...this }`: a shallow copy of the enumerable properties.
	pub fn spread(&self) -> Obj {
		let o = Obj::new();
		for (k, v) in self.entries() {
			o.set_str(k, v);
		}
		o
	}
}

impl Arr {
	pub fn new() -> Arr {
		Arr::default()
	}
	pub fn from_vec(v: Vec<V>) -> Arr {
		Arr(Rc::new(RefCell::new(v)))
	}
	pub fn len(&self) -> usize {
		self.0.borrow().len()
	}
	pub fn is_empty(&self) -> bool {
		self.len() == 0
	}
	pub fn get(&self, i: usize) -> V {
		self.0.borrow().get(i).cloned().unwrap_or_default()
	}
	pub fn push(&self, v: impl Into<V>) {
		self.0.borrow_mut().push(v.into());
	}
	pub fn to_vec(&self) -> Vec<V> {
		self.0.borrow().clone()
	}
	pub fn ptr_eq(&self, o: &Arr) -> bool {
		Rc::ptr_eq(&self.0, &o.0)
	}
}

impl From<f64> for V {
	fn from(n: f64) -> V {
		V::Num(n)
	}
}
impl From<i64> for V {
	fn from(n: i64) -> V {
		V::Num(n as f64)
	}
}
impl From<i32> for V {
	fn from(n: i32) -> V {
		V::Num(n as f64)
	}
}
impl From<u32> for V {
	fn from(n: u32) -> V {
		V::Num(n as f64)
	}
}
impl From<usize> for V {
	fn from(n: usize) -> V {
		V::Num(n as f64)
	}
}
impl From<bool> for V {
	fn from(b: bool) -> V {
		V::Bool(b)
	}
}
impl From<&str> for V {
	fn from(s: &str) -> V {
		V::Str(s.into())
	}
}
impl From<String> for V {
	fn from(s: String) -> V {
		V::Str(s.into())
	}
}
impl From<Str> for V {
	fn from(s: Str) -> V {
		V::Str(s)
	}
}
impl From<&Str> for V {
	fn from(s: &Str) -> V {
		V::Str(s.clone())
	}
}
impl From<Obj> for V {
	fn from(o: Obj) -> V {
		V::Obj(o)
	}
}
impl From<Arr> for V {
	fn from(a: Arr) -> V {
		V::Arr(a)
	}
}
impl From<Vec<V>> for V {
	fn from(a: Vec<V>) -> V {
		V::Arr(Arr::from_vec(a))
	}
}
impl<T: Into<V>> From<Option<T>> for V {
	fn from(o: Option<T>) -> V {
		o.map(Into::into).unwrap_or_default()
	}
}

/// `{ k: v, ... }` (keys are literals; values anything `Into<V>`).
#[macro_export]
macro_rules! obj {
	() => { $crate::js::Obj::new() };
	($($k:expr => $v:expr),+ $(,)?) => {{
		let o = $crate::js::Obj::new();
		$( o.set($k, $v); )+
		o
	}};
}

/// `[a, b, ...]` as a JS array value.
#[macro_export]
macro_rules! arr {
	() => { $crate::js::V::Arr($crate::js::Arr::new()) };
	($($v:expr),+ $(,)?) => { $crate::js::V::Arr($crate::js::Arr::from_vec(vec![$($crate::js::V::from($v)),+])) };
}

impl V {
	pub fn obj() -> V {
		V::Obj(Obj::new())
	}
	pub fn arr() -> V {
		V::Arr(Arr::new())
	}
	pub fn str(s: &str) -> V {
		V::Str(s.into())
	}
	pub fn is_undef(&self) -> bool {
		matches!(self, V::Undef)
	}
	/// `x == null` (undefined or null).
	pub fn is_nullish(&self) -> bool {
		matches!(self, V::Undef | V::Null)
	}
	pub fn truthy(&self) -> bool {
		match self {
			V::Undef | V::Null => false,
			V::Bool(b) => *b,
			V::Num(n) => *n != 0.0 && !n.is_nan(),
			V::Str(s) => !s.is_empty(),
			_ => true,
		}
	}
	pub fn as_obj(&self) -> Option<&Obj> {
		if let V::Obj(o) = self {
			Some(o)
		} else {
			None
		}
	}
	pub fn as_arr(&self) -> Option<&Arr> {
		if let V::Arr(a) = self {
			Some(a)
		} else {
			None
		}
	}
	pub fn as_num(&self) -> Option<f64> {
		if let V::Num(n) = self {
			Some(*n)
		} else {
			None
		}
	}
	pub fn as_str(&self) -> Option<&str> {
		if let V::Str(s) = self {
			Some(s)
		} else {
			None
		}
	}
	pub fn as_rc_str(&self) -> Option<Str> {
		if let V::Str(s) = self {
			Some(s.clone())
		} else {
			None
		}
	}
	pub fn is_num(&self) -> bool {
		matches!(self, V::Num(_))
	}
	pub fn is_str(&self) -> bool {
		matches!(self, V::Str(_))
	}
	pub fn is_obj(&self) -> bool {
		matches!(self, V::Obj(_))
	}
	pub fn is_arr(&self) -> bool {
		matches!(self, V::Arr(_))
	}
	/// `typeof x === 'object' && x !== null` (objects and arrays).
	pub fn is_object(&self) -> bool {
		matches!(self, V::Obj(_) | V::Arr(_))
	}
	/// `Number(x)` for numbers, else NaN (strings parsed like JS `Number`).
	pub fn num(&self) -> f64 {
		match self {
			V::Num(n) => *n,
			V::Bool(b) => *b as i32 as f64,
			V::Null => 0.0,
			V::Str(s) => str_to_num(s),
			_ => f64::NAN,
		}
	}
	/// `x.k` (arrays: index keys and `length`; strings: `length` in UTF-16 units).
	pub fn get(&self, k: &str) -> V {
		match self {
			V::Obj(o) => o.get(k),
			V::Arr(a) => {
				if k == "length" {
					V::Num(a.len() as f64)
				} else if is_index_key(k) {
					a.get(k.parse().unwrap())
				} else {
					V::Undef
				}
			}
			V::Str(s) if k == "length" => V::Num(s.encode_utf16().count() as f64),
			_ => V::Undef,
		}
	}
	/// `Number(x[i])` for an array, without cloning the item.
	pub fn num_at(&self, i: usize) -> f64 {
		match self {
			V::Arr(a) => match a.0.borrow().get(i) {
				Some(V::Num(n)) => *n,
				Some(v) => v.num(),
				None => f64::NAN,
			},
			_ => f64::NAN,
		}
	}
	/// `x[i]` for an array.
	pub fn at(&self, i: usize) -> V {
		match self {
			V::Arr(a) => a.get(i),
			_ => V::Undef,
		}
	}
	pub fn set(&self, k: &str, v: impl Into<V>) {
		match self {
			V::Obj(o) => o.set(k, v),
			V::Arr(a) if is_index_key(k) => {
				let i: usize = k.parse().unwrap();
				let mut a = a.0.borrow_mut();
				if a.len() <= i {
					a.resize(i + 1, V::Undef);
				}
				a[i] = v.into();
			}
			_ => panic!("set {k} on a non-object"),
		}
	}
	/// `k in x` / hasOwnProperty for plain objects.
	pub fn has(&self, k: &str) -> bool {
		match self {
			V::Obj(o) => o.has(k),
			V::Arr(a) => is_index_key(k) && k.parse::<usize>().unwrap() < a.len(),
			_ => false,
		}
	}
	pub fn len(&self) -> usize {
		match self {
			V::Arr(a) => a.len(),
			V::Str(s) => s.encode_utf16().count(),
			V::Obj(o) => o.len(),
			_ => 0,
		}
	}
	pub fn is_empty(&self) -> bool {
		self.len() == 0
	}
	/// The array's items (a snapshot), or none.
	pub fn items(&self) -> Vec<V> {
		match self {
			V::Arr(a) => a.to_vec(),
			_ => Vec::new(),
		}
	}
	pub fn push(&self, v: impl Into<V>) {
		match self {
			V::Arr(a) => a.push(v),
			_ => panic!("push on a non-array"),
		}
	}
	pub fn keys(&self) -> Vec<Str> {
		match self {
			V::Obj(o) => o.keys(),
			V::Arr(a) => (0..a.len()).map(|i| Str::from(i.to_string())).collect(),
			_ => Vec::new(),
		}
	}
	pub fn entries(&self) -> Vec<(Str, V)> {
		match self {
			V::Obj(o) => o.entries(),
			V::Arr(a) => a.to_vec().into_iter().enumerate().map(|(i, v)| (Str::from(i.to_string()), v)).collect(),
			_ => Vec::new(),
		}
	}
	pub fn values(&self) -> Vec<V> {
		self.entries().into_iter().map(|(_, v)| v).collect()
	}
	pub fn hidden(&self, k: &str) -> V {
		match self {
			V::Obj(o) => o.hidden(k),
			_ => V::Undef,
		}
	}
	pub fn set_hidden(&self, k: &str, v: impl Into<V>) {
		match self {
			V::Obj(o) => o.set_hidden(k, v),
			_ => panic!("hidden on a non-object"),
		}
	}
	/// `a === b`.
	pub fn strict_eq(&self, o: &V) -> bool {
		match (self, o) {
			(V::Undef, V::Undef) | (V::Null, V::Null) => true,
			(V::Bool(a), V::Bool(b)) => a == b,
			(V::Num(a), V::Num(b)) => a == b,
			(V::Str(a), V::Str(b)) => a == b,
			(V::Arr(a), V::Arr(b)) => a.ptr_eq(b),
			(V::Obj(a), V::Obj(b)) => a.ptr_eq(b),
			_ => false,
		}
	}
	/// `String(x)` / template interpolation.
	pub fn to_js_string(&self) -> String {
		match self {
			V::Undef => "undefined".into(),
			V::Null => "null".into(),
			V::Bool(b) => b.to_string(),
			V::Num(n) if n.fract() == 0.0 && n.abs() < 1e15 && *n != 0.0 => (*n as i64).to_string(),
			V::Num(n) => num_str(*n),
			V::Str(s) => s.to_string(),
			V::Arr(a) => a.to_vec().iter().map(|v| if v.is_nullish() { String::new() } else { v.to_js_string() }).collect::<Vec<_>>().join(","),
			V::Obj(_) => "[object Object]".into(),
		}
	}
	/// A deep copy as `JSON.parse(JSON.stringify(x))` makes it (drops hidden and undefined properties).
	pub fn json_clone(&self) -> V {
		match self {
			V::Arr(a) => V::Arr(Arr::from_vec(a.to_vec().iter().map(|v| if v.is_undef() { V::Null } else { v.json_clone() }).collect())),
			V::Obj(o) => {
				let n = Obj::new();
				for (k, v) in o.entries() {
					if !v.is_undef() {
						n.set_str(k, v.json_clone());
					}
				}
				V::Obj(n)
			}
			V::Num(n) if !n.is_finite() => V::Null,
			v => v.clone(),
		}
	}
}

/// Deep structural equality (for tests and the typed model; JS `===` is [`V::strict_eq`]).
impl PartialEq for V {
	fn eq(&self, o: &V) -> bool {
		match (self, o) {
			(V::Arr(a), V::Arr(b)) => a.ptr_eq(b) || a.to_vec() == b.to_vec(),
			(V::Obj(a), V::Obj(b)) => a.ptr_eq(b) || a.entries() == b.entries(),
			_ => self.strict_eq(o),
		}
	}
}

impl std::fmt::Display for V {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		f.write_str(&self.to_js_string())
	}
}

impl std::fmt::Debug for V {
	fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
		f.write_str(&stringify(self, None))
	}
}

/// JS `Number(string)` (decimal, hex, Infinity, whitespace-trimmed; "" is 0).
pub fn str_to_num(s: &str) -> f64 {
	let t = s.trim_matches(|c: char| c.is_whitespace() || c == '\u{feff}');
	if t.is_empty() {
		return 0.0;
	}
	match t {
		"Infinity" | "+Infinity" => return f64::INFINITY,
		"-Infinity" => return f64::NEG_INFINITY,
		_ => {}
	}
	if let Some(h) = t.strip_prefix("0x").or_else(|| t.strip_prefix("0X")) {
		return u64::from_str_radix(h, 16).map(|n| n as f64).unwrap_or(f64::NAN);
	}
	if !t.bytes().all(|b| b.is_ascii_digit() || matches!(b, b'.' | b'e' | b'E' | b'+' | b'-')) || t.contains("inf") {
		return f64::NAN;
	}
	t.parse::<f64>().unwrap_or(f64::NAN)
}

/// JS `parseFloat(s)`: the longest decimal prefix after leading whitespace.
pub fn parse_float(s: &str) -> f64 {
	let t = s.trim_start();
	let b = t.as_bytes();
	let mut i = 0;
	if i < b.len() && (b[i] == b'+' || b[i] == b'-') {
		i += 1;
	}
	if t[i..].starts_with("Infinity") {
		return if b.first() == Some(&b'-') { f64::NEG_INFINITY } else { f64::INFINITY };
	}
	let ds = i;
	while i < b.len() && b[i].is_ascii_digit() {
		i += 1;
	}
	if i < b.len() && b[i] == b'.' {
		i += 1;
		while i < b.len() && b[i].is_ascii_digit() {
			i += 1;
		}
	}
	if i == ds || (i == ds + 1 && b[ds] == b'.') {
		return f64::NAN;
	}
	if i < b.len() && (b[i] == b'e' || b[i] == b'E') {
		let mut j = i + 1;
		if j < b.len() && (b[j] == b'+' || b[j] == b'-') {
			j += 1;
		}
		let es = j;
		while j < b.len() && b[j].is_ascii_digit() {
			j += 1;
		}
		if j > es {
			i = j;
		}
	}
	t[..i].parse().unwrap_or(f64::NAN)
}

/// JS `parseInt(s, 10)`.
pub fn parse_int(s: &str) -> f64 {
	let t = s.trim_start();
	let (neg, rest) = match t.as_bytes().first() {
		Some(b'-') => (true, &t[1..]),
		Some(b'+') => (false, &t[1..]),
		_ => (false, t),
	};
	let end = rest.bytes().position(|b| !b.is_ascii_digit()).unwrap_or(rest.len());
	if end == 0 {
		return f64::NAN;
	}
	let n: f64 = rest[..end].parse().unwrap_or(f64::NAN);
	if neg {
		-n
	} else {
		n
	}
}

// Number formatting and rounding come from forge-core (V8-exact), re-exported under the names the
// ports use: `num_str` = `String(x)`, `to_fixed` = `x.toFixed(d)`, `math_round` = `Math.round`.
pub use forge_core::jsnum::{js_hypot as hypot, js_round as math_round, js_to_fixed as to_fixed, js_to_string as num_str};

/// `Number.isInteger`.
pub fn is_integer(x: f64) -> bool {
	x.is_finite() && x.fract() == 0.0
}

/// JS default `Array.prototype.sort` order for strings (UTF-16 code units).
pub fn cmp_utf16(a: &str, b: &str) -> std::cmp::Ordering {
	if a.is_ascii() && b.is_ascii() {
		return a.cmp(b);
	}
	a.encode_utf16().cmp(b.encode_utf16())
}

// ---------------------------------------------------------------- JSON

/// `JSON.parse` into shared JS values.
pub fn parse_json(text: &str) -> Result<V, String> {
	let mut p = Parser { b: text.as_bytes(), i: 0, key_cache: FxHashMap::default() };
	p.ws();
	let v = p.value()?;
	p.ws();
	if p.i != p.b.len() {
		return Err(format!("unexpected trailing input at {}", p.i));
	}
	Ok(v)
}

struct Parser<'a> {
	b: &'a [u8],
	i: usize,
	key_cache: FxHashMap<&'a [u8], Str>,
}

impl<'a> Parser<'a> {
	fn ws(&mut self) {
		while self.i < self.b.len() && matches!(self.b[self.i], b' ' | b'\t' | b'\n' | b'\r') {
			self.i += 1;
		}
	}
	fn err<T>(&self, what: &str) -> Result<T, String> {
		Err(format!("JSON: {what} at byte {}", self.i))
	}
	fn value(&mut self) -> Result<V, String> {
		match self.b.get(self.i) {
			Some(b'{') => {
				self.i += 1;
				let o = Obj::new();
				self.ws();
				if self.b.get(self.i) == Some(&b'}') {
					self.i += 1;
					return Ok(V::Obj(o));
				}
				loop {
					self.ws();
					let k = self.key()?;
					self.ws();
					if self.b.get(self.i) != Some(&b':') {
						return self.err("expected ':'");
					}
					self.i += 1;
					self.ws();
					let v = self.value()?;
					o.0.borrow_mut().set(k, v);
					self.ws();
					match self.b.get(self.i) {
						Some(b',') => self.i += 1,
						Some(b'}') => {
							self.i += 1;
							return Ok(V::Obj(o));
						}
						_ => return self.err("expected ',' or '}'"),
					}
				}
			}
			Some(b'[') => {
				self.i += 1;
				let mut a = Vec::new();
				self.ws();
				if self.b.get(self.i) == Some(&b']') {
					self.i += 1;
					return Ok(V::Arr(Arr::from_vec(a)));
				}
				loop {
					self.ws();
					a.push(self.value()?);
					self.ws();
					match self.b.get(self.i) {
						Some(b',') => self.i += 1,
						Some(b']') => {
							self.i += 1;
							return Ok(V::Arr(Arr::from_vec(a)));
						}
						_ => return self.err("expected ',' or ']'"),
					}
				}
			}
			Some(b'"') => Ok(V::Str(self.string()?.into())),
			Some(b't') if self.b[self.i..].starts_with(b"true") => {
				self.i += 4;
				Ok(V::Bool(true))
			}
			Some(b'f') if self.b[self.i..].starts_with(b"false") => {
				self.i += 5;
				Ok(V::Bool(false))
			}
			Some(b'n') if self.b[self.i..].starts_with(b"null") => {
				self.i += 4;
				Ok(V::Null)
			}
			Some(c) if *c == b'-' || c.is_ascii_digit() => {
				let s = self.i;
				self.i += 1;
				while self.i < self.b.len() && matches!(self.b[self.i], b'0'..=b'9' | b'.' | b'e' | b'E' | b'+' | b'-') {
					self.i += 1;
				}
				let t = std::str::from_utf8(&self.b[s..self.i]).unwrap();
				t.parse::<f64>().map(V::Num).map_err(|_| format!("JSON: bad number {t}"))
			}
			_ => self.err("unexpected token"),
		}
	}
	fn key(&mut self) -> Result<Str, String> {
		if self.b.get(self.i) != Some(&b'"') {
			return self.err("expected a key");
		}
		let s = self.i + 1;
		let mut j = s;
		while j < self.b.len() && self.b[j] != b'"' && self.b[j] != b'\\' {
			j += 1;
		}
		if j < self.b.len() && self.b[j] == b'"' {
			let raw = &self.b[s..j];
			self.i = j + 1;
			if let Some(k) = self.key_cache.get(raw) {
				return Ok(k.clone());
			}
			let k = intern(std::str::from_utf8(raw).map_err(|e| e.to_string())?);
			if self.key_cache.len() < 4096 {
				self.key_cache.insert(raw, k.clone());
			}
			return Ok(k);
		}
		Ok(intern(&self.string()?))
	}
	fn string(&mut self) -> Result<String, String> {
		self.i += 1;
		let mut out = Vec::new();
		loop {
			let s = self.i;
			while self.i < self.b.len() && self.b[self.i] != b'"' && self.b[self.i] != b'\\' {
				self.i += 1;
			}
			out.extend_from_slice(&self.b[s..self.i]);
			match self.b.get(self.i) {
				Some(b'"') => {
					self.i += 1;
					return String::from_utf8(out).map_err(|e| e.to_string());
				}
				Some(b'\\') => {
					self.i += 1;
					let c = *self.b.get(self.i).ok_or("JSON: bad escape")?;
					self.i += 1;
					match c {
						b'"' => out.push(b'"'),
						b'\\' => out.push(b'\\'),
						b'/' => out.push(b'/'),
						b'b' => out.push(8),
						b'f' => out.push(12),
						b'n' => out.push(b'\n'),
						b'r' => out.push(b'\r'),
						b't' => out.push(b'\t'),
						b'u' => {
							let mut cp = self.hex4()?;
							if (0xD800..0xDC00).contains(&cp) && self.b[self.i..].starts_with(b"\\u") {
								self.i += 2;
								let lo = self.hex4()?;
								cp = 0x10000 + ((cp - 0xD800) << 10) + (lo - 0xDC00);
							}
							let ch = char::from_u32(cp).unwrap_or('\u{fffd}');
							let mut buf = [0u8; 4];
							out.extend_from_slice(ch.encode_utf8(&mut buf).as_bytes());
						}
						_ => return self.err("bad escape"),
					}
				}
				_ => return self.err("unterminated string"),
			}
		}
	}
	fn hex4(&mut self) -> Result<u32, String> {
		let h = std::str::from_utf8(self.b.get(self.i..self.i + 4).ok_or("JSON: short \\u")?).map_err(|e| e.to_string())?;
		self.i += 4;
		u32::from_str_radix(h, 16).map_err(|e| e.to_string())
	}
}

/// `JSON.stringify(v, null, indent)`; `None` for compact output. Undefined at top level gives "undefined".
pub fn stringify(v: &V, indent: Option<&str>) -> String {
	let mut out = String::new();
	if !write_json(&mut out, v, indent, 0) {
		return "undefined".into();
	}
	out
}

pub fn json_quote(out: &mut String, s: &str) {
	out.push('"');
	for c in s.chars() {
		match c {
			'"' => out.push_str("\\\""),
			'\\' => out.push_str("\\\\"),
			'\n' => out.push_str("\\n"),
			'\r' => out.push_str("\\r"),
			'\t' => out.push_str("\\t"),
			'\u{8}' => out.push_str("\\b"),
			'\u{c}' => out.push_str("\\f"),
			c if (c as u32) < 0x20 => {
				let _ = write!(out, "\\u{:04x}", c as u32);
			}
			c => out.push(c),
		}
	}
	out.push('"');
}

fn newline(out: &mut String, indent: Option<&str>, depth: usize) {
	if let Some(ind) = indent {
		out.push('\n');
		for _ in 0..depth {
			out.push_str(ind);
		}
	}
}

fn write_json(out: &mut String, v: &V, indent: Option<&str>, depth: usize) -> bool {
	match v {
		V::Undef => return false,
		V::Null => out.push_str("null"),
		V::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
		V::Num(n) => out.push_str(&if n.is_finite() { num_str(*n) } else { "null".into() }),
		V::Str(s) => json_quote(out, s),
		V::Arr(a) => {
			let items = a.to_vec();
			if items.is_empty() {
				out.push_str("[]");
				return true;
			}
			out.push('[');
			for (i, x) in items.iter().enumerate() {
				if i > 0 {
					out.push(',');
				}
				newline(out, indent, depth + 1);
				if !write_json(out, x, indent, depth + 1) {
					out.push_str("null");
				}
			}
			newline(out, indent, depth);
			out.push(']');
		}
		V::Obj(o) => {
			let mut any = false;
			out.push('{');
			for (k, x) in o.entries() {
				if x.is_undef() {
					continue;
				}
				if any {
					out.push(',');
				}
				any = true;
				newline(out, indent, depth + 1);
				json_quote(out, &k);
				out.push(':');
				if indent.is_some() {
					out.push(' ');
				}
				write_json(out, &x, indent, depth + 1);
			}
			if any {
				newline(out, indent, depth);
			}
			out.push('}');
		}
	}
	true
}

#[cfg(test)]
mod tests {
	use super::*;

	#[test]
	fn numbers_like_js() {
		assert_eq!(num_str(0.1 + 0.2), "0.30000000000000004");
		assert_eq!(num_str(1e21), "1e+21");
		assert_eq!(num_str(1.5e-7), "1.5e-7");
		assert_eq!(num_str(123456.0), "123456");
		assert_eq!(num_str(-0.0), "0");
		assert_eq!(num_str(0.000001), "0.000001");
		assert_eq!(to_fixed(0.125, 2), "0.13");
		assert_eq!(to_fixed(1.005, 2), "1.00");
		assert_eq!(to_fixed(2.5, 0), "3");
		assert_eq!(to_fixed(-0.125, 2), "-0.13");
		assert_eq!(to_fixed(9.995, 2), "9.99");
		assert_eq!(to_fixed(0.5, 0), "1");
		assert_eq!(to_fixed(99.995, 2), "100.00");
		assert_eq!(to_fixed(-0.001, 2), "-0.00");
	}

	#[test]
	fn property_order_like_js() {
		let v = parse_json(r#"{"b":1,"10":2,"a":3,"2":4}"#).unwrap();
		assert_eq!(stringify(&v, None), r#"{"2":4,"10":2,"b":1,"a":3}"#);
		assert_eq!(stringify(&parse_json(r#"{"a":[1,{"x":"é\n"}]}"#).unwrap(), Some("\t")), "{\n\t\"a\": [\n\t\t1,\n\t\t{\n\t\t\t\"x\": \"é\\n\"\n\t\t}\n\t]\n}");
	}
}
