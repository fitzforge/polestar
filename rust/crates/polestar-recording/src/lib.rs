//! Polestar's recording library (docs/RECORDING.md): shared by the Polestar Client desktop app,
//! the ingest server and forge.
//!
//! - [`sv`]: reads the Recorder's SavedVariables file (`PolestarRecorderDB`).
//! - [`record`]: decodes and validates chunks and records.
//! - [`summary`]: what a set of chunks holds, for people to read.
//! - [`scrub`]: replaces character names in text.
//! - [`install`]: finds WoW: Forever installs and checks a picked folder.
//! - [`ack`]: the ack file the addon reads.
//! - [`api`]: the upload API's bodies.
//! - [`normalize`]: chunks -> forge's per-session JSON (data/recordings/<session>.json).
//! - [`plausible`]: whether a decoded chunk's values could come from a real session.
//! - [`maps_table`]: canonical uiMap sizes, for [`plausible`]'s speed check.

pub mod ack;
pub mod api;
pub mod install;
pub mod lua;
pub mod maps_table;
pub mod normalize;
pub mod plausible;
pub mod record;
pub mod scrub;
pub mod summary;
pub mod sv;
