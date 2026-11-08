---
section: contributors
---
- The Codex build tests no longer fail now and then with "cannot open
  /tmp/polestar-codex-pack-<pid>/…": measuring a pack's memory used one scratch
  folder per process, and `cargo test` runs tests as threads of one process,
  so two tests building a pack at once deleted each other's files. Each
  measurement now gets a folder (and script) of its own (thanks soulrocha).
