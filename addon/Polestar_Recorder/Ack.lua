-- The uploader's acknowledgement (docs/RECORDING.md, "Ack file"). Polestar
-- Client rewrites this file with the highest chunk it has sent for each
-- install (one per WoW account; the accounts share this folder):
--   PolestarRecorderAck = { ["<install id>"] = <seq>, ... }
-- and at the next login Recorder.lua deletes those chunks. It also writes
--   PolestarRecorderShare = true|false
-- (sharing on in the client and not paused): true turns recording on at
-- login unless the player typed /psrec off, false turns it off. The release
-- ships it empty; a lost ack only means a chunk is uploaded twice.
PolestarRecorderAck = nil
