//! `luac -p` and the globals `luac -l` shows written, in-process: a file compiled by Lua 5.1 and the names its
//! bytecode (every nested function) stores with SETGLOBAL.

use std::path::Path;

/// Compiles `file` under Lua 5.1 -> the global names it writes (SETGLOBAL), in bytecode order, or the
/// compile error ("file:line: message").
pub fn globals_written(file: &Path) -> Result<Vec<String>, String> {
	let src = std::fs::read(file).map_err(|e| format!("{}: {e}", file.display()))?;
	let lua = mlua::Lua::new();
	let f = lua.load(&src[..]).set_name(format!("@{}", file.display())).into_function().map_err(|e| e.to_string())?;
	let dump = f.dump(false);
	let mut r = Reader { b: &dump, at: 0 };
	r.header()?;
	let mut out = Vec::new();
	r.function(&mut out)?;
	Ok(out)
}

struct Reader<'a> {
	b: &'a [u8],
	at: usize,
}

const SETGLOBAL: u32 = 7;

impl Reader<'_> {
	fn take(&mut self, n: usize) -> Result<&[u8], String> {
		let s = self.b.get(self.at..self.at + n).ok_or("truncated bytecode")?;
		self.at += n;
		Ok(s)
	}
	fn byte(&mut self) -> Result<u8, String> {
		Ok(self.take(1)?[0])
	}
	fn int(&mut self) -> Result<usize, String> {
		Ok(u32::from_le_bytes(self.take(4)?.try_into().unwrap()) as usize)
	}
	fn size(&mut self) -> Result<usize, String> {
		Ok(u64::from_le_bytes(self.take(8)?.try_into().unwrap()) as usize)
	}
	fn string(&mut self) -> Result<Option<String>, String> {
		let n = self.size()?;
		if n == 0 {
			return Ok(None);
		}
		let s = self.take(n)?;
		Ok(Some(String::from_utf8_lossy(&s[..n - 1]).into_owned()))
	}
	// ESC "Lua" 0x51, format 0, little endian, int 4, size_t 8, Instruction 4, lua_Number 8, not integral.
	fn header(&mut self) -> Result<(), String> {
		let h = self.take(12)?;
		if h != b"\x1bLua\x51\x00\x01\x04\x08\x04\x08\x00" {
			return Err(format!("unexpected Lua 5.1 bytecode header {h:?}"));
		}
		Ok(())
	}
	fn function(&mut self, out: &mut Vec<String>) -> Result<(), String> {
		self.string()?;
		self.take(4 + 4 + 4)?; // linedefined, lastlinedefined, nups/numparams/is_vararg/maxstacksize
		let n = self.int()?;
		let mut code = Vec::with_capacity(n);
		for _ in 0..n {
			code.push(u32::from_le_bytes(self.take(4)?.try_into().unwrap()));
		}
		let mut consts: Vec<Option<String>> = Vec::new();
		for _ in 0..self.int()? {
			match self.byte()? {
				0 => consts.push(None),
				1 => {
					self.byte()?;
					consts.push(None);
				}
				3 => {
					self.take(8)?;
					consts.push(None);
				}
				4 => consts.push(self.string()?),
				t => return Err(format!("unknown constant type {t}")),
			}
		}
		for i in code {
			if i & 0x3f == SETGLOBAL {
				if let Some(Some(name)) = consts.get((i >> 14) as usize) {
					out.push(name.clone());
				}
			}
		}
		for _ in 0..self.int()? {
			self.function(out)?;
		}
		let lines = self.int()?;
		self.take(lines * 4)?;
		for _ in 0..self.int()? {
			self.string()?;
			self.take(8)?;
		}
		for _ in 0..self.int()? {
			self.string()?;
		}
		Ok(())
	}
}
