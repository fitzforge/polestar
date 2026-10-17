![Polestar: leveling guides for World of Warcraft: Forever](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/images/banner.png)

**A free, open-source guide addon for World of Warcraft: Forever: leveling routes for every start, found by simulation and written step by step.**

---

## What it is

Polestar is one addon for the whole of WoW: Forever. It carries 220 guides: 57 leveling guides that take both factions from 1 to 60 from every race's starting zone (Zephras Isle for the Skyborne included), 62 class guides for every class's quest chains, the twelve professions from 1 to 300, 17 reputations, 7 exploration guides, the Legacy challenges and 64 collectible guides, one per mount and per pet.

Around the guides it adds a 3D waypoint arrow that walks real paths and a travel planner, quest markers on the map, an upgrade indicator on item tooltips, a dungeon quest journal, rare alerts and the quality-of-life helpers a long leveling session needs. Its interface is in English, German and Latin American Spanish. It is free, open source under the GPL-3.0, and made in the open on GitHub.

---

## A guide that keeps up with you

![The guide window on step 5 of 60 of The Barrens: Northwatch Hold, with goal counters, the next person, XP per hour and the time to level](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/assets/screenshots/guide-window.png)

**The guide window.** The step's goals with their counters, who comes next, XP per hour and the time to level.

- **One person at a time.** In a quest hub the window shows only who to talk to now and their quests, then who comes next ("Person 2 of 8"), and the arrow points at that person.
- **Goals check themselves off** as you play: quests accepted and turned in, kills, loot, places reached, trainers visited, skills and reputation. Your place is worked out from your quest log, so it survives lost saved variables.
- **A guide for where you are.** The window opens with a guide for your race, class, level and zone, and each guide hands over to the next one in its chain when you finish it.
- **Solo by design.** The leveling routes use only quests one player can do alone; a quest that needs an elite appears as an extra marked "optional". Class quests come at the level each class gets them.
- **Tabs.** Up to six guides open at once: a leveling route and a profession, say.

## Finding the way

![The 3D waypoint arrow over the sea: 34 yd, Collect Theramore Medal](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/assets/screenshots/arrow.png)

**The arrow.** Distance and the goal it leads to.

- **A 3D waypoint arrow** points at the current goal, with distance and ETA, and knows every place a target spawns: a click moves it on to the next one.
- **Real paths:** the arrow walks you round cliffs, walls and water, through town gates, into caves and down the Undercity's lifts, on Polestar's walking maps with a router that started from the routing engine of Cillian Berragan's [Shortest Path Forever](https://github.com/cjber/shortest-path-forever), used with his kind permission. With Shortest Path Forever itself installed, Polestar still guides; **Hand guiding to Shortest Path Forever** (Options, Integrations) hands it the guiding instead, so the two never guide at once.
- **The travel planner** uses known flight paths, boats, zeppelins, the tram, lifts, portals, class teleports and your Hearthstone when they are faster, with boats and zeppelins on their real timetables, each leg with its own caption and time ("Fly to Crossroads", "Take The Great Lift, leaves in about 0:15").
- **Quest markers** for givers, objectives and turn-ins on the world map and the minimap, with tooltip lines on the mobs and items a quest needs and nameplate icons on the mobs you still need.
- **Upgrade advice** on item tooltips and on the quest reward panel: by how much an item is an upgrade for your spec at your level, and which reward to take.
- **Class training reminders** every two levels, with the nearest trainer of your class.

## Every guide in one place

![The Polestar hub on its Guides section, with the Horde leveling guides by level band and The Barrens (19-24) selected](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/assets/screenshots/hub-guides.png)

**The hub.** Guides, Lookup, Dungeons and Rares on one rail, Options at its foot. Here the Horde leveling guides by level band, and the selected guide's zone, progress, quests and the guide after it.

- **Leveling, professions, reputations, exploration, Legacy challenges, mounts and pets**, each guide with its levels, steps and the guide that follows it.
- **Professions** send you to the nearest trainer, vendor or inn of your own faction from where you stand.
- **Community guides**, other people's guides for Polestar, appear here too under their own heading, each credited to its author.

## Lookup, Dungeons and Rares

![The Wailing Caverns page: its quests with who starts and ends them, their chains, and a Pick up the quests button](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/assets/screenshots/dungeon-quests.png)

**A dungeon's page.** Who starts and ends each quest and its chain; one button guides you round to pick them all up.

- **Lookup** searches guides, items, mounts, pets, NPCs, quests, zones, dungeons and rares, and answers "how do I get that?" with the sources ranked for your character.
- **Dungeons**: a page per dungeon with every quest, its objective, chain and rewards, the bosses and the entrance. "Pick up the quests" builds a guide that collects them on the way to the door.
- **Rares**: rares and treasures by zone with their spawns and signature drop, and an alert when one shows up.

*Dungeons, Rares and Lookup beyond the guides read a data pack that is not part of the download yet. Without it, Lookup still searches the guides and each section says what is missing.*

## Your look

![The guide window in transparent mode: no background, outlined text over the grass of the Barrens](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/assets/screenshots/guide-transparent.png)

**Transparent mode.** Outlined text straight on the world; the controls appear under the cursor.

- **Colour schemes**: Dusk (the default), Night and Graphite, with your own accent or your class colour, background colour, opacity and brightness on top. Text stays legible whatever you pick.
- **Windows**: the guide window standard, compact or transparent, its scale, width and opacity; the arrow's style, size and colours; reduced motion.
- **Fonts**: the game's own by default, or Inter. With EllesmereUI installed, Polestar follows its accent and font.

## Quality of life

![Options on the Appearance page: accent colour, class colour, colour scheme, background colour, brightness, background opacity, font and reduce motion](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/assets/screenshots/options-appearance.png)

**Options.** Every setting as one row, applied as you change it, with a search that finds any of them.

Quest item, target and Hearthstone buttons; XP per hour and time to level; selling greys and repairing; taking the best quest reward; instant quest text and faster auto-loot; flight map and death helpers. Requests from other players: accept summons, resurrections and party invitations from friends and guildmates; decline other party invitations, guild invitations and duels. Hold **Shift** to skip auto-accept, auto-turn-in, auto-sell or the flight helper once, or to answer a request yourself.

---

## How the routes are made

The leveling routes are not hand-picked. A simulator models every quest Forever offers a faction (solo quests only, with their levels, prerequisites, givers and the kills and drops their objectives take), plays millions of complete 1-60 routes for each start, and keeps the one that reaches 60 soonest under its model. From level 12 one shared route per faction is searched, so the guides join into one chain; the guides are written by hand from it and scored under the same model. Four independent searches land within five hours of each other, and under the model the guides reach 60 in about 130-132 hours played for the Horde and 132-134 for the Alliance, counting only what they require (their optional extras can save up to about 8 hours).

![Chart: hours to 60 and hours of grinding per start, for the guides, the best route found, the consensus route and Polestar 0.1.0](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/images/starts.png)

*These hours are the simulator's estimates, not measured play: nobody has played a route end to end on Forever yet. The method, the four searches and every number are in the [README](https://github.com/fitzforge/polestar/blob/main/README.md#how-the-routes-are-made) and [docs/SIMULATION.md](https://github.com/fitzforge/polestar/blob/main/docs/SIMULATION.md).*

---

## Install

**With the CurseForge app:** install Polestar, then restart the game completely.

**By hand:**

1. Download the zip from the Files tab.
2. Unzip it into the game's AddOns folder, so the Polestar folders (`Polestar`, `Polestar_Guides` and the data folders beside them) sit directly inside it: `World of Warcraft/_classic_beta_/Interface/AddOns/` on the beta client, `_forever_` instead of `_classic_beta_` from launch.
3. Restart the game completely (a `/reload` does not load new addons) and log in.

To update by hand, delete the old Polestar folders first, then unzip the new version the same way.

## Getting started

- **The welcome.** Each new character's first login opens a short welcome: a hello, the guide Polestar suggests for that character and the three things to know. `/polestar welcome` shows it again.
- **`/polestar guides`** opens the hub: every guide, Lookup, Dungeons and Rares. `/polestar` (or `/pole`) shows the guide window.
- **`/polestar options`** holds every setting. Quest markers on the map are off until you turn them on under **Map**.
- **`/polestar skip`** moves on from a step for good (the window offers Undo); `/polestar next` and `/polestar prev` only look ahead or back.
- **`/polestar help`** lists every command.

## Community guides

A community addon is someone else's guides for Polestar. It is a separate addon, made by its author, not by Polestar, and its guides are not Polestar's leveling routes.

Get a community addon from its author's own project page and install it like any addon. Its guides then appear in the guide menu under Community guides, credited to the author, and Options > Community guides (`/polestar packs`) turns each one on or off.

Each community addon is supported by its author: report its problems to them, not to Polestar. It is an addon like any other, so install community addons from authors you trust.

Write leveling guides of your own? Polestar's guide format, compiler, checks, playtests, arrow and markers are yours to use. Publish your guides as your own addon and they appear in Polestar's menus under Community guides. [Community guides explained](https://github.com/fitzforge/polestar/blob/main/docs/GUIDE_PACKS.md) covers both sides.

## Beta

Polestar is in beta. Every guide compiles, lints and plays to the end in a simulator for every race and class it serves, but nothing has been play-tested end to end on Forever yet. Forever's new 30-60 content (Riverglades, Shen'dralas, Mount Hyjal) is not in any data yet; the routes will take it in once it is.

A step in the wrong order, or a quest that is not where the guide says? Please tell us on the [Polestar Discord](https://discord.gg/vMbee6F2e9) or [open an issue on GitHub](https://github.com/fitzforge/polestar/issues), with the guide, the step and what you saw. `/console scriptErrors 1` shows Lua errors.

---

## Links

- **Discord:** [Polestar | Leveling Guides](https://discord.gg/vMbee6F2e9), for questions and reports
- **Source code:** [github.com/fitzforge/polestar](https://github.com/fitzforge/polestar)
- **Issues:** [report a wrong step or a bug](https://github.com/fitzforge/polestar/issues)
- **Changelog:** [CHANGELOG.md](https://github.com/fitzforge/polestar/blob/main/CHANGELOG.md)
- **Docs:** [README](https://github.com/fitzforge/polestar/blob/main/README.md), [the documentation index](https://github.com/fitzforge/polestar/blob/main/docs/README.md), [community guides explained](https://github.com/fitzforge/polestar/blob/main/docs/GUIDE_PACKS.md), [writing a community addon](https://github.com/fitzforge/polestar/blob/main/docs/PACKS.md)

## Licence and credits

Polestar is free and open source under the [GNU General Public License, version 3](https://github.com/fitzforge/polestar/blob/main/LICENSE). Its data comes from public sources, the game client's own tables and recordings, each used as its licence allows: [THIRD_PARTY.md](https://github.com/fitzforge/polestar/blob/main/THIRD_PARTY.md) credits every input with its licence. No game art ships with Polestar: every texture is drawn in code, and zone paintings are read from your own client. The Inter typeface (SIL Open Font License 1.1) ships with the addon. The screenshots show the game (© Blizzard Entertainment).

*World of Warcraft is a trademark of Blizzard Entertainment. Polestar is a community project, not affiliated with or endorsed by Blizzard.*
