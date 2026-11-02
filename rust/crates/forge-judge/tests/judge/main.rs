//! The forge-judge integration tests, one binary: one module per test file (they used to be one
//! test binary each, which cost a link per file).
mod along;
mod cases_parity;
mod common;
mod engine_parity;
mod engine_rilua;
mod frame_default;
mod fuzz_guide;
mod guidetext_parity;
mod honest_parity;
mod judge_parity;
mod judge_simlevels;
mod levels_route;
mod mutants_cases;
mod mutants_honest;
mod mutants_walk;
mod report_parity;
mod seed_parity;
mod seeded;
