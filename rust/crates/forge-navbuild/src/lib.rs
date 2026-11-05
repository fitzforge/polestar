//! Builds the navigation grid from the installed WoW client's geometry: a port of the JS
//! `nav build` (tools/lib/nav/grid, tools/lib/nav/geom) with byte-identical output.
//!
//! Pipeline per continent (build.rs): `geom` (client ADT/WMO/M2/MH2O -> triangles) ->
//! `rasterise` -> `surfaces` (tile surfaces and walls) -> `links` (+ `regions`: local components)
//! -> `graph` (the tile's part of the abstract graph) -> the continent's graph and regions.

pub mod areas;
pub mod build;
pub mod fmath;
pub mod format;
pub mod geom;
pub mod graph;
pub mod links;
pub mod moves;
pub mod rasterise;
pub mod regions;
pub mod roads;
pub mod search;
pub mod surfaces;
