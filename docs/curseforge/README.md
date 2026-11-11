# The CurseForge listing

Everything the Polestar project on CurseForge needs, in one folder:

| File | What it is |
|---|---|
| [description.html](description.html) | The project description for CurseForge's WYSIWYG editor: paste it whole into its HTML source view. An evergreen overview of the whole addon (no version numbers or "new in"; what changed lives in CHANGELOG.md and the Files tab). Every image has its width and height, so each shows at the column's width |
| [description.md](description.md) | The same text for the Markdown editor, if the HTML one is ever unusable (made from description.html) |
| [preview.html](preview.html) | A local preview: description.html at CurseForge's description width (836 px) on its dark page with its description styles; open it in a browser |
| `media/*.gif` | The description's animations, recorded from the real addon (below); `.mp4` and `.webm` copies of each for anywhere that takes video |
| `media/*.jpg`, `media/banner.png` | The description's still pictures and the banner at its top |
| `gallery/*.jpg` | The gallery: fifteen 1920x1080 pictures, uploaded by hand (titles below) |
| `images/logo-1024.png`, `images/logo-400.png` | The project avatar: the gold emblem on a night tile, no text |
| `images/banner.png`, `images/starts.png` | The README's banner at 2x and the route chart (not in the description) |

The description's images point at `next` on GitHub
(`https://raw.githubusercontent.com/fitzforge/polestar/next/docs/curseforge/...`),
so they load as soon as this folder is on `next`; its links point at `main`
(`https://github.com/fitzforge/polestar/blob/main/...`). CurseForge does not
show SVG reliably and cannot follow relative links. Its sanitizer keeps
headings, paragraphs, lists, links, `code`, `hr`, tables and `img` with
`width` and `height`; it drops classes and most styles, and gives tables
striped row backgrounds (the long feature list is one). An empty paragraph
(`<p>&nbsp;</p>`) spaces the sections. The images load only while the
repository is public. CurseForge does not allow links to downloads hosted
elsewhere, so the description links to the source and the docs on GitHub,
never to the releases page.

Every picture is the column's width (836 px): GIFs at 1x, the UI pixel for
pixel (each under 1.5 MB), stills at 2x so they stay sharp on high-density
screens. A window wider than the column (the guide menu) is shown whole, a
little smaller.

| File | Pixels | Shown at | Size |
|---|---|---|---|
| `media/banner.png` | 1672x520 | 836x260 | 269 KB |
| `media/arrow-walk.gif` | 836x470, 12.1 s | 836x470 | 370 KB |
| `media/guide-hub.gif` | 836x470, 9.3 s | 836x470 | 510 KB |
| `media/while-here.gif` | 836x470, 7.1 s | 836x470 | 153 KB |
| `media/level-up.gif` | 836x664, 11.3 s | 836x664 | 833 KB |
| `media/leveling.jpg` | 1672x960 | 836x480 | 197 KB |
| `media/journey.jpg` | 1672x940 | 836x470 | 158 KB |
| `media/nearby.gif` | 836x470, 6.7 s | 836x470 | 545 KB |
| `media/guide-menu.gif` | 836x480, 11.3 s | 836x480 | 1.4 MB |
| `media/lookup.jpg` | 1672x960 | 836x480 | 182 KB |
| `media/dungeons.jpg` | 1672x960 | 836x480 | 225 KB |
| `media/worldmap.jpg` | 1672x1172 | 836x586 | 593 KB |
| `media/questlog.jpg` | 1672x728 | 836x364 | 111 KB |

The animations, stills and the gallery's windows are the real addon: the
Feature Studio (`node tools/polestar.js studio`, the addon's Lua against the
simulated world with the client's art and fonts) on the 0.3.7 code, Polestar's
default look, with scripted scenes: a Tauren crossing Thunder Bluff to Elder
Rise on its baked walking path (walking sped up), a new Human in Northshire,
an Undead at Hillsbrad Fields, a Human in Goldshire and on the way to
Darkshore, the level-up card from the Barrens. Each frame is the Studio's own
render, set on a game scene from polestar.guide's press art in Polestar's night
tones (© Blizzard Entertainment), and joined with ffmpeg (a palette per GIF,
MP4 and WebM beside it). The XP line shows a believable pace, not the
simulator's; the guide menu's version line and its rotating supporter name are
blanked, so no picture dates itself. The gallery adds a title and one line in
Inter over the same scenes.

## Summary

For the project's summary field (plain text, at most 150 characters; this one
is 147):

```text
Free leveling guides for WoW: Forever, 1 to 60 for every race, with a guide window that ticks off as you play and an arrow that follows real paths.
```

## Project settings

- [ ] **Name:** Polestar Guides (live at https://www.curseforge.com/wow/addons/polestar)
- [ ] **Slug:** `polestar`
- [ ] **Summary:** the text above
- [ ] **Description:** [description.html](description.html), pasted whole into the WYSIWYG editor's HTML source view (see "For a new release")
- [ ] **Avatar:** `images/logo-400.png` (CurseForge asks for 400x400 pixels; `images/logo-1024.png` is the large copy)
- [ ] **Categories:** Quests & Leveling (primary); Map & Minimap, Professions, Tooltip
- [ ] **Game flavour and version:** Forever, 1.60.1
- [ ] **Licence:** GNU General Public License version 3 (GPL-3.0)
- [ ] **Source URL:** https://github.com/fitzforge/polestar
- [ ] **Issues URL:** https://github.com/fitzforge/polestar/issues
- [ ] **Wiki or docs URL** (if asked): https://github.com/fitzforge/polestar/blob/main/docs/README.md
- [ ] **Discord** (if the form has a field for it): https://discord.gg/polestar
- [ ] **Donation:** Ko-fi, `0xfitz` (https://ko-fi.com/0xfitz); the description's "Support Polestar" section links the same page
- [ ] **Experimental:** off, so the project syncs to the CurseForge app
- [ ] **Allow comments:** on
- [ ] **Relations:** none; Polestar needs no other addon

The categories are CurseForge's World of Warcraft addon categories as its
search page lists them (checked 2026-10-14): Quests & Leveling for the guides,
Map & Minimap for the arrow, the quest markers and the travel planner,
Professions for the twelve profession guides, Tooltip for the upgrade
indicator.

## Uploads

### The file

- **File:** `dist/Polestar-<version>.zip`, from `forge release pack`
  (docs/RELEASING.md). Its addon folders sit at the top level, as CurseForge
  and its app expect.
- **Display name:** `Polestar <version>`
- **Release type:** Release. CurseForge lists a project in its app only once
  it has a Release file, and offers Beta files only to players who opt in;
  the version number (0.x) says it is a beta. The GitHub release is a full
  release too, marked Latest.
- **Game version:** Forever 1.60.1
- **Changelog:** the version's "For players" section of CHANGELOG.md, in
  Markdown, each list item joined onto one line
- **Not uploaded:** `Polestar_Recorder-<version>.zip` and `SHA256SUMS` stay on
  the GitHub release.

### The gallery

The files in `gallery/`, 1920x1080, in this order, each with its title and
description (CurseForge's gallery shows them large, so each holds one idea
with the window at a readable size). They replace every earlier gallery
image; `01-featured.jpg` is the featured one (the project's thumbnail). Like
the description they show no version, so they stay true.

| File | Title | Description |
|---|---|---|
| `01-featured.jpg` | Polestar | Free leveling guides for WoW: Forever: the arrow and the guide window on the way to Elder Rise |
| `02-arrow.jpg` | The arrow walks real paths | Around cliffs, across bridges and up the lifts, with the distance and time to go |
| `03-person.jpg` | One person at a time | Who to talk to now, in full; done people fold away and the next one moves up |
| `04-while-here.jpg` | While you're here | Kills, items and hand-ins from other steps, offered when you are close to them |
| `05-journey.jpg` | Boats, flights and your Hearthstone | Each leg of the trip timed, waits included |
| `06-nearby.jpg` | Nearby services | The nearest vendor, repair, innkeeper, flight master or trainer, one click from the guide window |
| `07-guides.jpg` | Every guide in one place | Leveling for every start, class quests, professions, reputations, mounts and pets |
| `08-lookup.jpg` | How do I get that? | Lookup searches items, mounts, recipes, quests and NPCs, and guides you to the source |
| `09-dungeons.jpg` | Dungeons, quests included | Every dungeon's quests with who starts and ends them, their chains and rewards |
| `10-quest-log.jpg` | A tidy quest log | Quests the route no longer needs, in one list; Abandon asks first |
| `11-new-spells.jpg` | New spells when you level up | What your trainer has for you, what it costs and where to train; Upgrade puts the new ranks on your bars |
| `12-quest-loot.jpg` | Loot that starts a quest | It glows on the quest item button until you take the quest |
| `13-hide-all.jpg` | Hide it all in one click | The minimap button hides everything Polestar shows; click again and it all comes back |
| `14-keybinds.jpg` | Bind Polestar's buttons | In the game's Quick Keybind Mode: hover a button and press a key |
| `15-all-steps.jpg` | Every step of the guide | Click the step number to browse the whole guide |

## For a new release

1. Upload the new zip as above, with its changelog.
2. The description is evergreen: it says what Polestar is and does, never
   which version did what, so a release usually needs no change to it. Only
   when a release adds a whole feature or removes one, or a section no longer
   says what the addon does, edit [description.html](description.html), make
   the same change in [description.md](description.md), and paste the new
   description.html between the markers in [preview.html](preview.html) with
   the `https://raw.githubusercontent.com/fitzforge/polestar/next/docs/curseforge/`
   prefix taken off.
3. If the chart was redrawn (`readme charts`) or the brand art changed
   (`readme brand`), commit the new PNGs too. A picture that no longer shows
   the addon as it is gets recorded again the same way (above).
4. Get the change onto `next` first: the description's images load from there.
5. On CurseForge, open the description in the WYSIWYG editor, switch it to
   its HTML source view, replace everything with description.html, save, and
   check that each picture shows at the column's width and the GIFs move.
