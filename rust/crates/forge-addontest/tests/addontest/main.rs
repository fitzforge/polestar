//! The forge-addontest integration tests, one binary: one module per test file (they used to be one
//! test binary each, which cost a link per file).
#![recursion_limit = "512"]
mod alts;
mod api;
mod automation;
#[path = "automation-accept-off.rs"]
mod automation_accept_off;
#[path = "automation-close-skipped.rs"]
mod automation_close_skipped;
#[path = "automation-profession-quests.rs"]
mod automation_profession_quests;
#[path = "automation-spoken.rs"]
mod automation_spoken;
#[path = "class-quests.rs"]
mod class_quests;
#[path = "class-skip.rs"]
mod class_skip;
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
#[path = "death-arrow.rs"]
mod death_arrow;
#[path = "docs-packs.rs"]
mod docs_packs;
#[path = "dsl-farm.rs"]
mod dsl_farm;
#[path = "dsl-gossip-wait.rs"]
mod dsl_gossip_wait;
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
#[path = "dungeons-sides.rs"]
mod dungeons_sides;
mod e2e;
mod engine;
#[path = "engine-abandon-destroy.rs"]
mod engine_abandon_destroy;
#[path = "engine-aim-accept-first.rs"]
mod engine_aim_accept_first;
#[path = "engine-along.rs"]
mod engine_along;
#[path = "engine-already-across.rs"]
mod engine_already_across;
#[path = "engine-alt-start.rs"]
mod engine_alt_start;
#[path = "engine-carried.rs"]
mod engine_carried;
#[path = "engine-cast.rs"]
mod engine_cast;
#[path = "engine-catchup.rs"]
mod engine_catchup;
#[path = "engine-die.rs"]
mod engine_die;
#[path = "engine-dungeon-route.rs"]
mod engine_dungeon_route;
#[path = "engine-dwell.rs"]
mod engine_dwell;
#[path = "engine-empty-stop.rs"]
mod engine_empty_stop;
#[path = "engine-enter.rs"]
mod engine_enter;
#[path = "engine-exact-points.rs"]
mod engine_exact_points;
#[path = "engine-failed-quest.rs"]
mod engine_failed_quest;
#[path = "engine-feeders.rs"]
mod engine_feeders;
#[path = "engine-field-route.rs"]
mod engine_field_route;
#[path = "engine-flights.rs"]
mod engine_flights;
#[path = "engine-focus.rs"]
mod engine_focus;
#[path = "engine-grind.rs"]
mod engine_grind;
#[path = "engine-group-default.rs"]
mod engine_group_default;
#[path = "engine-guide-end.rs"]
mod engine_guide_end;
#[path = "engine-heights.rs"]
mod engine_heights;
#[path = "engine-keep.rs"]
mod engine_keep;
#[path = "engine-l10n.rs"]
mod engine_l10n;
#[path = "engine-level.rs"]
mod engine_level;
#[path = "engine-level-pick.rs"]
mod engine_level_pick;
#[path = "engine-level-wait.rs"]
mod engine_level_wait;
#[path = "engine-lost-quest.rs"]
mod engine_lost_quest;
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
#[path = "engine-reset.rs"]
mod engine_reset;
#[path = "engine-review.rs"]
mod engine_review;
#[path = "engine-routes.rs"]
mod engine_routes;
#[path = "engine-sections.rs"]
mod engine_sections;
#[path = "engine-skip-ahead.rs"]
mod engine_skip_ahead;
#[path = "engine-skip-undo.rs"]
mod engine_skip_undo;
#[path = "engine-skipquest.rs"]
mod engine_skipquest;
#[path = "engine-skipto.rs"]
mod engine_skipto;
#[path = "engine-smart.rs"]
mod engine_smart;
#[path = "engine-tab-restore.rs"]
mod engine_tab_restore;
#[path = "engine-tabs.rs"]
mod engine_tabs;
#[path = "engine-talk.rs"]
mod engine_talk;
#[path = "engine-training.rs"]
mod engine_training;
#[path = "engine-unavailable.rs"]
mod engine_unavailable;
#[path = "engine-upgrade.rs"]
mod engine_upgrade;
#[path = "engine-upgrade-twice.rs"]
mod engine_upgrade_twice;
#[path = "engine-vendor.rs"]
mod engine_vendor;
#[path = "engine-wait.rs"]
mod engine_wait;
#[path = "engine-waypoint-keys.rs"]
mod engine_waypoint_keys;
#[path = "engine-when.rs"]
mod engine_when;
#[path = "engine-when-cooldown.rs"]
mod engine_when_cooldown;
#[path = "engine-when-dungeon.rs"]
mod engine_when_dungeon;
#[path = "engine-when-group.rs"]
mod engine_when_group;
#[path = "engine-when-knows.rs"]
mod engine_when_knows;
#[path = "engine-when-skill.rs"]
mod engine_when_skill;
#[path = "engine-when-upgrade.rs"]
mod engine_when_upgrade;
#[path = "engine-while-here.rs"]
mod engine_while_here;
#[path = "engine-zone-walk.rs"]
mod engine_zone_walk;
mod gamepad;
#[path = "gamepad-ui.rs"]
mod gamepad_ui;
mod gear;
#[path = "gear-adjust.rs"]
mod gear_adjust;
#[path = "gear-bags.rs"]
mod gear_bags;
#[path = "gear-forever.rs"]
mod gear_forever;
#[path = "gear-pawn.rs"]
mod gear_pawn;
#[path = "gear-upgrades.rs"]
mod gear_upgrades;
#[path = "guides-compiled.rs"]
mod guides_compiled;
#[path = "guides-end.rs"]
mod guides_end;
#[path = "guides-end-early.rs"]
mod guides_end_early;
#[path = "guides-end-places.rs"]
mod guides_end_places;
#[path = "guides-memory.rs"]
mod guides_memory;
mod harness;
#[path = "hide-all.rs"]
mod hide_all;
#[path = "hide-with-guide.rs"]
mod hide_with_guide;
mod import;
#[path = "import-safety.rs"]
mod import_safety;
mod install;
mod levels;
#[path = "locale-load.rs"]
mod locale_load;
mod lookup;
#[path = "lookup-codex.rs"]
mod lookup_codex;
#[path = "lookup-elites.rs"]
mod lookup_elites;
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
#[path = "names-shown.rs"]
mod names_shown;
mod nav;
#[path = "nav-arrow-look.rs"]
mod nav_arrow_look;
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
#[path = "nav-pins-look.rs"]
mod nav_pins_look;
#[path = "nav-prompts.rs"]
mod nav_prompts;
#[path = "nav-reported.rs"]
mod nav_reported;
#[path = "nav-route-lines.rs"]
mod nav_route_lines;
#[path = "nav-route-look.rs"]
mod nav_route_look;
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
#[path = "new-in-forever.rs"]
mod new_in_forever;
#[path = "options-memory.rs"]
mod options_memory;
#[path = "out-of-sight.rs"]
mod out_of_sight;
#[path = "pack-race-parts.rs"]
mod pack_race_parts;
#[path = "packs-ondemand.rs"]
mod packs_ondemand;
#[path = "packs-parity.rs"]
mod packs_parity;
#[path = "packs-registry.rs"]
mod packs_registry;
#[path = "packs-visibility.rs"]
mod packs_visibility;
mod party;
#[path = "party-chat.rs"]
mod party_chat;
#[path = "party-group.rs"]
mod party_group;
#[path = "party-pair.rs"]
mod party_pair;
#[path = "party-sync.rs"]
mod party_sync;
mod pause;
mod profiles;
mod qol;
#[path = "qol-bagglow.rs"]
mod qol_bagglow;
#[path = "qol-items.rs"]
mod qol_items;
#[path = "qol-loot-track.rs"]
mod qol_loot_track;
#[path = "qol-quickbind.rs"]
mod qol_quickbind;
#[path = "qol-spells.rs"]
mod qol_spells;
#[path = "quest-links.rs"]
mod quest_links;
#[path = "questdb-memory.rs"]
mod questdb_memory;
mod quests;
#[path = "quests-levels.rs"]
mod quests_levels;
#[path = "quests-log-link.rs"]
mod quests_log_link;
#[path = "quests-timed.rs"]
mod quests_timed;
#[path = "quoted-quest-names.rs"]
mod quoted_quest_names;
mod rares;
mod recorder;
#[path = "recorder-explore.rs"]
mod recorder_explore;
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
#[path = "route-experimental.rs"]
mod route_experimental;
#[path = "route-plan.rs"]
mod route_plan;
#[path = "settings-coverage.rs"]
mod settings_coverage;
#[path = "settings-effects.rs"]
mod settings_effects;
#[path = "settings-essentials.rs"]
mod settings_essentials;
#[path = "settings-game.rs"]
mod settings_game;
#[path = "settings-migration.rs"]
mod settings_migration;
#[path = "skins-bundled.rs"]
mod skins_bundled;
#[path = "skins-concepts.rs"]
mod skins_concepts;
#[path = "skins-hearth.rs"]
mod skins_hearth;
#[path = "skins-login.rs"]
mod skins_login;
#[path = "skins-sweep.rs"]
mod skins_sweep;
mod stranded;
mod syntax;
mod talents;
mod theme;
#[path = "theme-skin-api.rs"]
mod theme_skin_api;
mod travel;
#[path = "travel-build.rs"]
mod travel_build;
#[path = "travel-transit.rs"]
mod travel_transit;
mod ui;
#[path = "ui-along.rs"]
mod ui_along;
#[path = "ui-card.rs"]
mod ui_card;
#[path = "ui-dungeons.rs"]
mod ui_dungeons;
#[path = "ui-game-menu.rs"]
mod ui_game_menu;
#[path = "ui-guide-end.rs"]
mod ui_guide_end;
#[path = "ui-headsup-card.rs"]
mod ui_headsup_card;
#[path = "ui-import.rs"]
mod ui_import;
#[path = "ui-journey.rs"]
mod ui_journey;
#[path = "ui-look-buttons.rs"]
mod ui_look_buttons;
#[path = "ui-look-glow.rs"]
mod ui_look_glow;
#[path = "ui-look-guidewindow.rs"]
mod ui_look_guidewindow;
#[path = "ui-look-guidewindow-copy.rs"]
mod ui_look_guidewindow_copy;
#[path = "ui-look-theme.rs"]
mod ui_look_theme;
#[path = "ui-look-toasts.rs"]
mod ui_look_toasts;
#[path = "ui-lookup.rs"]
mod ui_lookup;
#[path = "ui-movers.rs"]
mod ui_movers;
#[path = "ui-options.rs"]
mod ui_options;
#[path = "ui-packs.rs"]
mod ui_packs;
#[path = "ui-picker.rs"]
mod ui_picker;
#[path = "ui-picker-folders.rs"]
mod ui_picker_folders;
#[path = "ui-picker-levels.rs"]
mod ui_picker_levels;
#[path = "ui-picker-packs.rs"]
mod ui_picker_packs;
#[path = "ui-picker-scroll.rs"]
mod ui_picker_scroll;
#[path = "ui-preview.rs"]
mod ui_preview;
#[path = "ui-quest-unlocks.rs"]
mod ui_quest_unlocks;
#[path = "ui-quick-settings.rs"]
mod ui_quick_settings;
#[path = "ui-report-settings.rs"]
mod ui_report_settings;
#[path = "ui-route.rs"]
mod ui_route;
#[path = "ui-scrub.rs"]
mod ui_scrub;
#[path = "ui-settings-ux.rs"]
mod ui_settings_ux;
#[path = "ui-steplist.rs"]
mod ui_steplist;
#[path = "ui-thanks.rs"]
mod ui_thanks;
#[path = "ui-transparent.rs"]
mod ui_transparent;
#[path = "ui-update.rs"]
mod ui_update;
#[path = "ui-welcome.rs"]
mod ui_welcome;
#[path = "ui-whatsnew.rs"]
mod ui_whatsnew;
#[path = "ui-while-here.rs"]
mod ui_while_here;
#[path = "ui-zoneart.rs"]
mod ui_zoneart;
#[path = "where.rs"]
mod where_;
