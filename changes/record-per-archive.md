---
section: forge
---
- `forge record pull` and `resession` normalise one archive at a time per
  worker (`--jobs`, at most 12), so a large pull no longer holds every touched
  archive in memory at once, and the session files are read once per run
  instead of once per archive. Each archive's `install.json` is stamped with
  what its sessions were made from (the recording code's hash, the chunk
  count, a digest of its inputs); `resession` leaves archives whose stamp
  still matches as they are, and `--all` does every archive. The session
  files are the same, byte for byte.
