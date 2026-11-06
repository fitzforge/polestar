# The CurseForge listing

Everything the Polestar project on CurseForge needs, in one folder:

| File | What it is |
|---|---|
| [description.html](description.html) | The project description for CurseForge's WYSIWYG editor: paste it whole into its HTML source view. Every image has its width and height, so each shows near its natural size |
| [description.md](description.md) | The same text for the Markdown editor, if the HTML one is ever unusable (images then run at the column's full width) |
| [preview.html](preview.html) | A local preview: description.html at CurseForge's description width (836 px) with CurseForge's own description styles; open it in a browser |
| `media/*.gif` | The description's animations, recorded from the real addon (below); `.mp4` and `.webm` copies of each for anywhere that takes video |
| `media/journey.png`, `media/questlog.png`, `media/lookup.jpg` | The description's still pictures |
| `gallery/*.jpg` | The gallery: ten 1920x1080 pictures, uploaded by hand (titles below) |
| `images/logo-1024.png`, `images/logo-400.png` | The project avatar: the gold emblem on a night tile, no text |
| `images/banner.png` | The banner at the top of the description (the README's dark banner at 2x) |
| `images/starts.png` | The route chart at 2x |

The description's images and links point at `main` on GitHub
(`https://raw.githubusercontent.com/fitzforge/polestar/main/...` and
`https://github.com/fitzforge/polestar/blob/main/...`): CurseForge does not
show SVG reliably and cannot follow relative links. Its sanitizer keeps
headings, paragraphs, lists, links, `code`, `hr` and `img` with `width` and
`height`; it drops classes and most styles, and gives tables striped row
backgrounds, so two pictures side by side are two `img` in one paragraph, not
a table. The images load only while the repository is public. CurseForge does
not allow links to downloads hosted elsewhere, so the description links to
the source and the docs on GitHub, never to the releases page.

Display sizes: the column is 836 px wide, and each picture is shown at the
size of the addon's own windows (the guide window at about 390 px), never
wider. The files hold 1.5x to 2x those pixels, so they stay sharp on
high-density screens.

| File | Pixels | Shown at | Size |
|---|---|---|---|
| `images/banner.png` | 2560x640 | 836x209 | 293 KB |
| `media/arrow-walk.gif` | 1254x982, 7.5 s | 600x470 | 748 KB |
| `media/guide-fold.gif` | 792x890, 7.8 s | 396x445 | 359 KB |
| `media/journey.png` | 776x1122 | 388x561 | 334 KB |
| `media/nearby.gif` | 978x789, 7.9 s | 652x526 | 379 KB |
| `media/picker.gif` | 1256x970, 7.2 s | 836x646 | 424 KB |
| `media/lookup.jpg` | 1824x1472 | 836x675 | 293 KB |
| `media/questlog.png` | 856x944 | 428x472 | 331 KB |

The banner and avatar are drawn in code: `node tools/polestar.js readme
brand` writes `docs/assets/avatar.svg` and, with `rsvg-convert` (librsvg)
installed, those PNGs; `readme charts` re-exports the chart (tools/README.md,
"Generated files").

The animations, stills and the gallery's windows are the real addon, run in
`polestar play` (the playground: the addon's Lua against the simulated world)
with client map art, a Level 14-18 Human Warrior on the Darkshore and
Elwynn Forest guides. Each frame is the playground's own render, cropped and
scaled with `rsvg-convert`, set on a blurred game scene from polestar.guide's
press art, and joined with ffmpeg (a palette per GIF, MP4 and WebM beside
it). Walking in `arrow-walk` is sped up; the route is the one the addon
walks. The gallery adds a title and one line in polestar.guide's type over
press art (© Blizzard Entertainment, credited in each picture).

## Summary

For the project's summary field (plain text, at most 150 characters; this one
is 146):

```text
Free, open-source guides for World of Warcraft: Forever: leveling routes for every start, built from game data, plus professions, mounts and pets.
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
image; the first one was still the 0.2.0 guide menu.

| File | Title | Description |
|---|---|---|
| `01-hero.jpg` | Routes that make sense | Free leveling guides for World of Warcraft: Forever, with an arrow that walks real paths |
| `02-person.jpg` | One person at a time | Who to talk to now, in full; everyone after them waits on one line |
| `03-fold.jpg` | Done goals fold away | Finished people collapse to one line, so the next person is always on top |
| `04-arrow.jpg` | The arrow walks real paths | Around cliffs, through gates, into caves and onto boats, with the distance and time to go |
| `05-journey.jpg` | Boats, flights and your hearth | Each leg of the trip timed, waits included |
| `06-nearby.jpg` | Nearby services | The nearest vendor, repair, inn, flight master or trainer, one click from the guide window |
| `07-hub.jpg` | Every guide in one place | Leveling for every start, class quests, professions, reputations, mounts and pets |
| `08-lookup.jpg` | Lookup | Items, mounts, recipes, quests, NPCs and rares, and the way to each |
| `09-dungeons.jpg` | Dungeons | Every dungeon's quests with who starts and ends them, their chains and rewards |
| `10-questlog.jpg` | A tidy quest log | Quests the route no longer needs, and grey ones, in one list |

## For a new release

1. Upload the new zip as above, with its changelog.
2. Read [description.html](description.html) against the release: "What's
   new" lists the release's main player changes (CHANGELOG.md, "For
   players"), and every feature section still says what the addon does.
   Make the same change in [description.md](description.md), and paste the
   new description.html between the markers in [preview.html](preview.html)
   with the `https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/`
   prefix taken off.
3. If the chart was redrawn (`readme charts`) or the brand art changed
   (`readme brand`), commit the new PNGs too. A picture that no longer shows
   the addon as it is gets recorded again the same way (above).
4. Push to `main` first: the description's images load from there.
5. On CurseForge, open the description in the WYSIWYG editor, switch it to
   its HTML source view, replace everything with description.html, save, and
   check that each picture shows at its size (the GIFs move, two pictures
   sit side by side under "A guide window that stays calm").
