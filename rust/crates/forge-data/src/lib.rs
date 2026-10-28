//! The reference data build (`data build`: data/forever/*.json) ported from tools/lib/data, byte
//! for byte: pfQuest (Lua 5.1, built in), QuestieDB's baked Forever store, the client's map,
//! faction and race tables (the installed client through forge-gamedata, or cached wago.tools
//! CSVs), recordings, the cached web and CMaNGOS facts, corrections.json. The build reads the source
//! cache; [`sources`] fills it (`forge data sources`).
//!
//! Library: [`build::run`] (`Options` -> `Output`, the files' texts) and [`build::write`].

pub mod build;
pub mod client;
pub mod cmangos;
pub mod codex;
pub mod corrections;
pub mod dungeons;
pub mod extras;
pub mod factions;
pub mod gear;
pub mod itemdb;
pub mod jsv;
pub mod kb;
pub mod lua;
pub mod maps;
pub mod merge;
pub mod names;
pub mod names_sources;
pub mod normalize;
pub mod objectives;
pub mod pfquest;
pub mod players;
pub mod professions;
pub mod publish;
pub mod questdb;
pub mod questie;
pub mod recordings;
pub mod sim_inputs;
pub mod sources;
pub mod spawns;
pub mod stats;
pub mod tables;
pub mod talents;
pub mod tdb;
pub mod trainers;
pub mod travel;
pub mod worldmap;

pub use build::{quest_drop, run, write, Options, Output, MAX_QUEST_DROP, VERSION};
