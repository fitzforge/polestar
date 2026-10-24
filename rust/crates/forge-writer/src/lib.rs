//! Routes to guides in the shipped layout: `apply_route` writes a simulator route (forge-sim's
//! search output) into v1's guides, byte for byte what `polestar apply-route`
//! (tools/lib/improve/apply-route.js) writes. The library takes the guides' texts and parsed
//! data (it builds for wasm); the `forge-writer` binary reads and writes the files.

pub mod apply;
pub mod engine;
pub mod fixes;
pub mod guide;
pub mod input;
pub mod jsre;
#[cfg(feature = "native")]
pub mod native;
pub mod post;
pub mod run;
pub mod travel;

pub use apply::{apply_route, Inputs, Output};
pub use input::{Data, Route, World};
pub use run::{run, RunInputs, RunOpts, RunOutput};
