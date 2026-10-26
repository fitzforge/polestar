//! Is the installed client complete? A launcher can leave an install where the root and encoding
//! files list a file the archives do not hold: never downloaded (a streaming install) or a stale
//! index slot that now holds another file. Reading the game's data then misses those files, and a
//! walking grid built from it is silently wrong where they are. [`check`] finds them and the maps
//! they belong to: each map's WDT, its tiles' root and object files (heights, water, placements),
//! the models and buildings placed on it, and the buildings' group and doodad files.

use rustc_hash::FxHashMap;

use crate::casc::{Key, Presence, Storage};
use crate::Client;

/// One map with files the archives lack.
#[derive(Clone, Debug)]
pub struct MapGap {
	pub map: u32,
	pub name: String,
	/// Tiles with a missing root or object file.
	pub tiles: usize,
	/// Missing files the map uses, by fileDataID, with how each is missing.
	pub missing: Vec<(u32, Presence)>,
}

#[derive(Clone, Debug, Default)]
pub struct Report {
	/// Maps checked and the files they use.
	pub maps_checked: usize,
	pub files_checked: usize,
	/// The maps with missing files (map id order).
	pub maps: Vec<MapGap>,
}

impl Report {
	/// Whether the maps checked can be read in full.
	pub fn complete(&self) -> bool {
		self.maps.is_empty()
	}

	/// One line per map with missing files, e.g. `Kalimdor (1): 120 files (34 tiles)`.
	pub fn lines(&self) -> Vec<String> {
		self.maps
			.iter()
			.map(|m| {
				let stale = m.missing.iter().filter(|(_, p)| *p == Presence::Stale).count();
				let absent = m.missing.len() - stale;
				let how = match (stale, absent) {
					(_, 0) => "stale archive slots".to_string(),
					(0, _) => "not downloaded".to_string(),
					_ => format!("{stale} in stale archive slots, {absent} not downloaded"),
				};
				format!("{} ({}): {} files missing ({how}), {} tiles affected", m.name, m.map, m.missing.len(), m.tiles)
			})
			.collect()
	}
}

/// What to tell the player when the install is incomplete.
pub const FIX: &str = "run Scan and Repair in the game launcher (Options > Scan and Repair), let it finish, then run this again";

fn chunks(b: &[u8]) -> impl Iterator<Item = ([u8; 4], &[u8])> {
	let mut o = 0usize;
	std::iter::from_fn(move || {
		if o + 8 > b.len() {
			return None;
		}
		let mut id: [u8; 4] = b[o..o + 4].try_into().unwrap();
		id.reverse();
		let n = u32::from_le_bytes(b[o + 4..o + 8].try_into().unwrap()) as usize;
		let body = b.get(o + 8..(o + 8 + n).min(b.len()))?;
		o += 8 + n;
		Some((id, body))
	})
}

fn u32s(b: &[u8]) -> impl Iterator<Item = u32> + '_ {
	b.chunks_exact(4).map(|c| u32::from_le_bytes(c.try_into().unwrap()))
}

struct Ctx<'a> {
	storage: &'a Storage,
	/// fileDataID -> content key (enUS, else the first entry).
	root: FxHashMap<u32, Key>,
	presence: FxHashMap<u32, Presence>,
	/// WMO roots already expanded, with their missing files.
	wmo_done: FxHashMap<u32, Vec<(u32, Presence)>>,
}

impl Ctx<'_> {
	fn presence(&mut self, fdid: u32) -> Presence {
		if let Some(&p) = self.presence.get(&fdid) {
			return p;
		}
		// A file this build does not list at all (a placement of a removed model) is no fault of the
		// install: counted as present, as every reader skips it.
		let p = match self.root.get(&fdid) {
			None => Presence::Present,
			Some(ck) => self.storage.presence(ck),
		};
		self.presence.insert(fdid, p);
		p
	}

	fn read(&mut self, fdid: u32) -> Option<Vec<u8>> {
		if self.presence(fdid) != Presence::Present || !self.root.contains_key(&fdid) {
			return None;
		}
		self.storage.read_ckey(self.root.get(&fdid)?).ok().map(|d| d.data)
	}

	/// A WMO root and its group and doodad files: the missing ones into `missing`.
	fn wmo(&mut self, fdid: u32, missing: &mut FxHashMap<u32, Presence>) {
		if !self.wmo_done.contains_key(&fdid) {
			let mut found = Vec::new();
			match self.read(fdid) {
				None => found.push((fdid, self.presence(fdid))),
				Some(b) => {
					let deps: Vec<u32> = chunks(&b).filter(|(id, _)| id == b"GFID" || id == b"MODI").flat_map(|(_, body)| u32s(body).filter(|&f| f != 0).collect::<Vec<_>>()).collect();
					for f in deps {
						let p = self.presence(f);
						if p != Presence::Present {
							found.push((f, p));
						}
					}
				}
			}
			self.wmo_done.insert(fdid, found);
		}
		missing.extend(self.wmo_done[&fdid].iter().copied());
	}
}

/// Checks the maps `maps` (Map table ids; None: every map with a WDT) of the client. (A storage
/// wide count would mislead: the indexes keep many entries for space reused since, of files no
/// build lists any more.)
pub fn check(client: &Client, maps: Option<&[u32]>) -> Result<Report, String> {
	let storage = &client.storage;
	let en = crate::casc::locale_flag("enUS").unwrap_or(2);
	let mut root: FxHashMap<u32, Key> = FxHashMap::default();
	storage.each_root_entry(|fdid, locales, ck| {
		let e = root.entry(fdid).or_insert(*ck);
		if locales & en != 0 {
			*e = *ck;
		}
	});

	let table = client.table("Map", "enUS")?;
	let (id_col, wdt_col, name_col) = (table.id_column.ok_or("Map: no ID column")?, table.column("WdtFileDataID").ok_or("Map: no WdtFileDataID column")?, table.column("MapName_lang"));
	let mut ctx = Ctx { storage, root, presence: FxHashMap::default(), wmo_done: FxHashMap::default() };
	let mut report = Report::default();
	let mut rows: Vec<(u32, u32, String)> = (0..table.rows())
		.filter_map(|i| {
			let r = table.row(i);
			let id = r[id_col].as_i64()? as u32;
			let wdt = r[wdt_col].as_i64().filter(|&w| w > 0)? as u32;
			let name = name_col.and_then(|c| table.str(&r[c])).map(|s| String::from_utf8_lossy(s).into_owned()).unwrap_or_default();
			Some((id, wdt, name))
		})
		.filter(|(id, _, _)| maps.is_none_or(|m| m.contains(id)))
		.collect();
	rows.sort_unstable_by_key(|r| r.0);
	for (map, wdt, name) in rows {
		report.maps_checked += 1;
		let before = ctx.presence.len();
		let mut missing: FxHashMap<u32, Presence> = FxHashMap::default();
		let mut tiles = 0usize;
		match ctx.read(wdt) {
			None => {
				missing.insert(wdt, ctx.presence(wdt));
			}
			Some(b) => {
				let mut placed: Vec<(u32, bool)> = Vec::new(); // (fdid, is WMO)
				for (id, body) in chunks(&b) {
					if &id == b"MAID" {
						for tile in body.chunks_exact(32) {
							let f: Vec<u32> = u32s(tile).collect();
							let (adt, obj0) = (f[0], f[1]);
							if adt == 0 {
								continue;
							}
							let mut bad = false;
							for x in [adt, obj0] {
								if x != 0 && ctx.presence(x) != Presence::Present {
									missing.insert(x, ctx.presence(x));
									bad = true;
								}
							}
							tiles += bad as usize;
							if let Some(ob) = (obj0 != 0).then(|| ctx.read(obj0)).flatten() {
								for (cid, cb) in chunks(&ob) {
									if &cid == b"MDDF" {
										for e in cb.chunks_exact(36) {
											let flags = u16::from_le_bytes([e[34], e[35]]);
											if flags & 0x40 != 0 {
												placed.push((u32::from_le_bytes(e[0..4].try_into().unwrap()), false));
											}
										}
									} else if &cid == b"MODF" {
										for e in cb.chunks_exact(64) {
											let flags = u16::from_le_bytes([e[56], e[57]]);
											if flags & 0x8 != 0 {
												placed.push((u32::from_le_bytes(e[0..4].try_into().unwrap()), true));
											}
										}
									}
								}
							}
						}
					} else if &id == b"MODF" {
						// A building-only map: its one WMO, by fileDataID.
						for e in body.chunks_exact(64) {
							placed.push((u32::from_le_bytes(e[0..4].try_into().unwrap()), true));
						}
					}
				}
				placed.sort_unstable();
				placed.dedup();
				for (f, is_wmo) in placed {
					if is_wmo {
						ctx.wmo(f, &mut missing);
					} else if ctx.presence(f) != Presence::Present {
						missing.insert(f, ctx.presence(f));
					}
				}
			}
		}
		report.files_checked += ctx.presence.len() - before;
		if !missing.is_empty() {
			let mut m: Vec<(u32, Presence)> = missing.into_iter().collect();
			m.sort_unstable_by_key(|x| x.0);
			report.maps.push(MapGap { map, name, tiles, missing: m });
		}
	}
	Ok(report)
}
