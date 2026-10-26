//! Quality: engine replay, honest playtest, passed-by, avoidable returns, guide-text metrics, cases, must-pass.
//!
//! - [`engine`]: a headless copy of addon/Polestar/Core/Engine.lua's step selection and done rules.
//! - [`honest`]: `playtest --honest` (tools/lib/playtest-honest.js) R1-R5, and R6-R10.
//! - [`walk`]: a chain's goals in route order (judge walk.js); levels and time come from a [`walk::LevelModel`]
//!   (the sim crate's evaluator replay; not in this crate).
//! - [`passedby`], [`returns`]: judge passedby.js and returns.js.
//! - [`guidetext`]: the gate's guide-text scorer (gate metric names kept).
//! - [`report`]: the judge report and the dashboard's route status; [`feedback`]: player reports into route overrides.
//! - [`cases`]: the sim cases (tests/fixtures/sim/cases/reported.json) property evaluator.

pub mod cases;
pub mod engine;
pub mod feedback;
pub mod guidetext;
pub mod honest;
pub mod levels;
pub mod passedby;
pub mod report;
pub mod returns;
#[cfg(feature = "native")]
pub mod seed;
pub mod walk;
