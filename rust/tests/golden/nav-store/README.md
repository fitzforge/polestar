# nav-store: walks files and walklookup.js samples on the synthetic world

Read by `forge-nav/tests/store_parity.rs`. `walks-{horde,alliance}.bin`: walktables.js routerWalks
(js backend, bands 0, 10, 20) over ../nav-walks' worlds, written by walks.js writeWalks;
`lookup-{horde,alliance}.bin`: parity/lookup-sample.js's logic (walklookup.js buildLookup, 4000 pairs,
seed 1). Synthetic inputs only. Made by ../nav-walks/regen.js (its README's JS).
