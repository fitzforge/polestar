//! The `.guide` toolchain: parse, `when`, tokens, compile (resolve), lint, pack emit.
//!
//! A line-for-line port of the JS compiler (tools/lib/dsl, tools/lib/pack, tools/lib/i18n; each module names its
//! source), byte-identical to it: `tests/parity.rs` compiles our guides, the shipped guides and the v2 slice and
//! compares every file and diagnostic with `tests/js-ref.js`'s JS output.
//!
//! - [`js`]: the JS value model the port runs on (shared objects, JS property order, `toFixed`, `JSON`).
//! - [`data::Data`]: reference data from file texts ([`data::Data::from_texts`]) or a folder (native).
//! - [`parse::parse_guide`] → [`resolve::resolve_guide`] → [`validate::validate_guides`] →
//!   [`project::localise`] (tokens) → [`emit`]; [`project::compile_sources`] runs them on in-memory sources,
//!   [`project::lint_sources`] adds the solo policy, [`project::build_pack_files`] lays out the addon folders
//!   (main pack, race parts, texts addons). Folder reading ([`project::build_pack`]) and the CLI are native only
//!   (feature `native`, default); without it the crate builds for wasm32.
//! - [`model`]: the typed Guide/Step/Goal the writer produces ([`model::Guide::to_source`] renders `.guide`
//!   text the compiler then checks) and the judge consumes ([`model::Guide::from_compiled`] reads a compiled
//!   guide with the compiler's fill-ins in [`model::Filled`]).
pub mod areas;
pub mod bake;
pub mod candidates;
pub mod cluster;
pub mod conditions;
pub mod data;
pub mod diag;
pub mod emit;
pub mod escort;
pub mod farmspots;
pub mod format;
pub mod gathering;
pub mod group;
pub mod guidecheck;
#[cfg(feature = "native")]
pub mod guidecheck_repair;
pub mod heights;
pub mod i18n_files;
pub mod i18n_guides;
pub mod images;
pub mod importstring;
pub mod js;
pub mod lexer;
pub mod locales;
pub mod manifest;
pub mod model;
pub mod money;
pub mod params;
pub mod parse;
pub mod places;
pub mod prereqs;
pub mod project;
pub mod races;
pub mod resolve;
pub mod solo;
pub mod timed;
pub mod toc;
pub mod tokens;
pub mod trainers;
pub mod validate;
pub mod when;
pub mod xp;
