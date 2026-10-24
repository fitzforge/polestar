//! The stage cache key: the same inputs give the same key, any byte change a new one.

use forge::{key, Part};

#[test]
fn key_follows_input_bytes() {
	let dir = std::env::temp_dir().join(format!("forge-key-{}", std::process::id()));
	std::fs::create_dir_all(dir.join("sub")).unwrap();
	std::fs::write(dir.join("a.json"), b"{\"a\":1}").unwrap();
	std::fs::write(dir.join("sub/b.txt"), b"b").unwrap();
	let k1 = key("world", "v1", &[Part::Dir(&dir), Part::Text("x")]);
	assert_eq!(k1, key("world", "v1", &[Part::Dir(&dir), Part::Text("x")]), "same inputs, same key");
	assert_ne!(k1, key("world", "v2", &[Part::Dir(&dir), Part::Text("x")]), "a new stage version changes it");
	std::fs::write(dir.join("sub/b.txt"), b"c").unwrap();
	assert_ne!(k1, key("world", "v1", &[Part::Dir(&dir), Part::Text("x")]), "a changed byte changes it");
	std::fs::remove_dir_all(&dir).ok();
}
