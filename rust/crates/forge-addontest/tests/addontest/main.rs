//! The forge-addontest integration tests, one binary: one module per test file (they used to be one
//! test binary each, which cost a link per file).
#![recursion_limit = "512"]
mod alts;
mod automation;
#[path = "automation-close-skipped.rs"]
mod automation_close_skipped;
#[path = "class-quests.rs"]
mod class_quests;
mod closes;
mod codex;
#[path = "codex-bosses.rs"]
mod codex_bosses;
#[path = "codex-repgates.rs"]
mod codex_repgates;
mod compat;
mod compile;
#[path = "compile-pack.rs"]
mod compile_pack;
mod core;
#[path = "data-addons.rs"]
mod data_addons;
#[path = "docs-packs.rs"]
mod docs_packs;
#[path = "dsl-farm.rs"]
mod dsl_farm;
#[path = "dsl-guide-reward.rs"]
mod dsl_guide_reward;
#[path = "dsl-loop.rs"]
mod dsl_loop;
#[path = "dsl-rewards.rs"]
mod dsl_rewards;
#[path = "dsl-shared-candidates.rs"]
mod dsl_shared_candidates;
#[path = "dsl-smart.rs"]
mod dsl_smart;
#[path = "dsl-verbs.rs"]
mod dsl_verbs;
#[path = "dungeons-attune.rs"]
mod dungeons_attune;
#[path = "dungeons-pickup.rs"]
mod dungeons_pickup;
#[path = "dungeons-runtime.rs"]
mod dungeons_runtime;
mod e2e;
mod engine;
#[path = "engine-abandon-destroy.rs"]
mod engine_abandon_destroy;
#[path = "engine-along.rs"]
mod engine_along;
#[path = "engine-cast.rs"]
mod engine_cast;
#[path = "engine-catchup.rs"]
mod engine_catchup;
#[path = "engine-die.rs"]
mod engine_die;
#[path = "engine-enter.rs"]
mod engine_enter;
#[path = "engine-focus.rs"]
mod engine_focus;
#[path = "engine-group-default.rs"]
mod engine_group_default;
#[path = "engine-heights.rs"]
mod engine_heights;
#[path = "engine-l10n.rs"]
mod engine_l10n;
#[path = "engine-level.rs"]
mod engine_level;
#[path = "engine-manual.rs"]
mod engine_manual;
#[path = "engine-money-task.rs"]
mod engine_money_task;
#[path = "engine-next-when.rs"]
mod engine_next_when;
#[path = "engine-notyet.rs"]
mod engine_notyet;
#[path = "engine-packs.rs"]
mod engine_packs;
#[path = "engine-pin.rs"]
mod engine_pin;
#[path = "engine-professions.rs"]
mod engine_professions;
#[path = "engine-review.rs"]
mod engine_review;
#[path = "engine-routes.rs"]
mod engine_routes;
#[path = "engine-skipquest.rs"]
mod engine_skipquest;
#[path = "engine-skipto.rs"]
mod engine_skipto;
#[path = "engine-smart.rs"]
mod engine_smart;
#[path = "engine-tabs.rs"]
mod engine_tabs;
#[path = "engine-training.rs"]
mod engine_training;
#[path = "engine-unavailable.rs"]
mod engine_unavailable;
#[path = "engine-when.rs"]
mod engine_when;
#[path = "engine-when-cooldown.rs"]
mod engine_when_cooldown;
#[path = "engine-when-dungeon.rs"]
mod engine_when_dungeon;
#[path = "engine-when-group.rs"]
mod engine_when_group;
#[path = "engine-when-skill.rs"]
mod engine_when_skill;
#[path = "engine-when-upgrade.rs"]
mod engine_when_upgrade;
mod gamepad;
#[path = "gamepad-ui.rs"]
mod gamepad_ui;
mod gear;
#[path = "gear-bags.rs"]
mod gear_bags;
#[path = "gear-pawn.rs"]
mod gear_pawn;
#[path = "gear-upgrades.rs"]
mod gear_upgrades;
#[path = "guides-compiled.rs"]
mod guides_compiled;
#[path = "guides-memory.rs"]
mod guides_memory;
mod harness;
mod import;
#[path = "import-safety.rs"]
mod import_safety;
mod levels;
mod lookup;
#[path = "lookup-codex.rs"]
mod lookup_codex;
#[path = "lookup-guides.rs"]
mod lookup_guides;
#[path = "lookup-tooltip-performance.rs"]
mod lookup_tooltip_performance;
#[path = "lua-helper-paths.rs"]
mod lua_helper_paths;
mod maps;
#[path = "maps-overlays.rs"]
mod maps_overlays;
#[path = "maps-reveal.rs"]
mod maps_reveal;
#[path = "maps-services.rs"]
mod maps_services;
mod names;
#[path = "names-memory.rs"]
mod names_memory;
mod nav;
#[path = "nav-crossings.rs"]
mod nav_crossings;
#[path = "nav-e2e.rs"]
mod nav_e2e;
#[path = "nav-handoff.rs"]
mod nav_handoff;
#[path = "nav-journey.rs"]
mod nav_journey;
#[path = "nav-load.rs"]
mod nav_load;
#[path = "nav-mapcanvas.rs"]
mod nav_mapcanvas;
#[path = "nav-maps.rs"]
mod nav_maps;
#[path = "nav-memory.rs"]
mod nav_memory;
#[path = "nav-pack.rs"]
mod nav_pack;
#[path = "nav-pins.rs"]
mod nav_pins;
#[path = "nav-prompts.rs"]
mod nav_prompts;
#[path = "nav-reported.rs"]
mod nav_reported;
#[path = "nav-route-lines.rs"]
mod nav_route_lines;
#[path = "nav-route-sparkle.rs"]
mod nav_route_sparkle;
#[path = "nav-router.rs"]
mod nav_router;
#[path = "nav-spf.rs"]
mod nav_spf;
#[path = "nav-trail.rs"]
mod nav_trail;
#[path = "nav-transit.rs"]
mod nav_transit;
#[path = "pack-race-parts.rs"]
mod pack_race_parts;
#[path = "packs-parity.rs"]
mod packs_parity;
#[path = "packs-registry.rs"]
mod packs_registry;
#[path = "packs-visibility.rs"]
mod packs_visibility;
mod party;
mod qol;
#[path = "qol-bagglow.rs"]
mod qol_bagglow;
#[path = "quest-links.rs"]
mod quest_links;
#[path = "questdb-memory.rs"]
mod questdb_memory;
mod quests;
#[path = "quests-levels.rs"]
mod quests_levels;
mod rares;
mod recorder;
#[path = "recorder-finds.rs"]
mod recorder_finds;
#[path = "recorder-perf.rs"]
mod recorder_perf;
#[path = "recorder-progress.rs"]
mod recorder_progress;
#[path = "recorder-route.rs"]
mod recorder_route;
mod release;
mod riding;
#[path = "route-plan.rs"]
mod route_plan;
mod syntax;
mod talents;
#[path = "talents-tree-ahead.rs"]
mod talents_tree_ahead;
#[path = "talents-tree-polish.rs"]
mod talents_tree_polish;
#[path = "talents-tree-stepper.rs"]
mod talents_tree_stepper;
mod theme;
mod travel;
#[path = "travel-build.rs"]
mod travel_build;
#[path = "travel-transit.rs"]
mod travel_transit;
mod ui;
#[path = "ui-along.rs"]
mod ui_along;
#[path = "ui-dungeons.rs"]
mod ui_dungeons;
#[path = "ui-import.rs"]
mod ui_import;
#[path = "ui-journey.rs"]
mod ui_journey;
#[path = "ui-lookup.rs"]
mod ui_lookup;
#[path = "ui-options.rs"]
mod ui_options;
#[path = "ui-packs.rs"]
mod ui_packs;
#[path = "ui-picker.rs"]
mod ui_picker;
#[path = "ui-picker-levels.rs"]
mod ui_picker_levels;
#[path = "ui-picker-packs.rs"]
mod ui_picker_packs;
#[path = "ui-route.rs"]
mod ui_route;
#[path = "ui-welcome.rs"]
mod ui_welcome;
#[path = "ui-zoneart.rs"]
mod ui_zoneart;
#[path = "where.rs"]
mod where_;
