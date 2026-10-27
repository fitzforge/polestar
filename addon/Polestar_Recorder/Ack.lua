-- The uploader's acknowledgement (docs/RECORDING.md, "Ack file"). The
-- Polestar Uploader rewrites this file with the highest chunk it has sent
-- for each install (one per WoW account; the accounts share this folder):
--   PolestarRecorderAck = { ["<install id>"] = <seq>, ... }
-- and at the next login Recorder.lua deletes those chunks. The release ships
-- it empty; a lost ack only means a chunk is uploaded twice.
PolestarRecorderAck = nil
