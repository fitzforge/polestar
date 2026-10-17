# Translating Polestar

Polestar follows the game's language: a German client reads Polestar's
interface in German, and any text without a translation in English. The
translation tools are adapted from Ding! by Yendi (@moust4ki), GPL-3.0.

## Languages

`node tools/polestar.js i18n status` lists every language with how much of it
is translated (`--markdown` prints the table for the README and release
notes). The list, with each language's status and translators, is
`tools/lib/i18n/locales.js`.

- **reviewed**: written or checked by a native speaker. The tools never fill
  or rewrite its translations. German (`deDE`, thecodingcortex), Latin
  American Spanish (`esMX`, CDVolvik), French (`frFR`, Yendi).
- **ai**: made by a machine. On that client, Options > About says so and
  links to the Discord. Spanish of Spain (`esES`), Korean (`koKR`), Brazilian
  Portuguese (`ptBR`), Russian (`ruRU`), Chinese (`zhCN`, `zhTW`).

Spain's and Latin America's clients use different words for game terms
(mazmorra, calabozo), so `esES` and `esMX` are separate files. English clients
(`enUS`, `enGB`) read the English text.

## The file

Each language has one file, `addon/Polestar/Locales/<locale>.lua`, and one
for the optional Recorder's few chat lines,
`addon/Polestar_Recorder/Locales/<locale>.lua`, written the same way:

```lua
-- German (deDE). ...

local _, ns = ...
if not (GetLocale and GetLocale() == "deDE") then return end
local L = ns.L

-- Core/Commands.lua
L["Toggle guide window"] = "Guide-Fenster ein-/ausblenden"
-- L["Next step"] = ""
```

- The key, between `L[` and `]`, is the exact English text the code shows.
  Leave it byte for byte as it is; translate the right-hand side only.
- A line starting `-- L[` is not translated yet and shows in English. To
  translate it, remove the `-- ` and write the translation between the quotes.
- Lines are grouped under the file that first uses them (`-- Core/Commands.lua`),
  so you can see where a text appears. Your own comment lines and group
  headers stay as you wrote them.
- A key `"context: text"` (`"boss: Chest"`) is one meaning of a word: translate
  the text after the colon, in that meaning.
- The block at the end, `-- No longer in the code (its English changed or it
  went away): reuse or delete.`, keeps your translations of texts the code no
  longer has, commented out. When the English of a text changed, its new key
  is in the file as a `-- L[...] = ""` line: copy your old translation there,
  adapt it, and delete the old line.

## Formats

Keep every `%s`, `%d`, `%.1f` of the key, of the same kind, in the same order.
If the sentence needs another order, number them all: `"%2$s niveau %1$d"`.
Keep `|4singular:plural;` (translate both forms), `|cAARRGGBB…|r` colours and
`|T…|t` textures. In a text with a `%s` or `%d`, write a percent sign `%%`.

## Game terms and the glossary

Where the game names something itself, Polestar shows the game's word and
there is nothing to translate: reputation standings, item qualities, the
Alliance and the Horde, gear slots, the Dungeon Journal.

For the rest, use the game's vocabulary. `tools/lib/i18n/glossary/<locale>.json`
holds about forty terms (quest, step, flight master, hearthstone, dungeon…)
with the word chosen for that language: the game client's own word first,
then the reviewed translators' choice. `i18n check` warns where the
translation of a text holding one of those terms does not use the glossary's
word. A warning is a question, not an error: fix the line, or keep your
wording where it reads better.

```json
"flight master": { "term": "Flugmeister", "client": "MINIMAP_TRACKING_FLIGHTMASTER" }
```

`term` is the word; `match` (optional) lists the forms that count, compared
without case or accents anywhere in the translation (`["annehm", "angenommen"]`);
`client` names the game's string the word comes from; `note` is any remark.
The English terms are `TERMS` in `tools/lib/i18n/glossary.js`. The game's
strings (Blizzard's GlobalStrings) are not in the repository: download them
for your language from
`https://wago.tools/db2/GlobalStrings/csv?build=<build>&locale=<locale>` into
`data/sources/wago/` (ignored by git) when you need them.

## Commands

- `node tools/polestar.js i18n sync [<locale>...]` adds every text the code
  gained to the file, commented out at the end of its file's group, and moves
  translations of texts the code lost to the block at the end. It never
  changes a line that holds a translation. A language named that has no file
  gets one, loaded from `addon/Polestar/Core/Core.xml` (a new Recorder file
  goes in `Polestar_Recorder.toc` by hand). Without a locale it updates every
  existing file. It covers Polestar and the Recorder; `--addon
  Polestar_Recorder` (or `Polestar`) limits it, and `status`, `keys` and
  `import` to that one (Polestar's by default).
- `node tools/polestar.js i18n check [<locale>...]` lists each language's
  translated and missing counts and fails on a file Lua cannot load, a stale
  key (a translated text the code no longer has, outside the end block), a key
  set twice, or a translation whose formats differ from the English. Missing
  translations are fine. CI runs it (`npm run i18n:check`), and `npm test` runs
  the same checks (`tests/i18n.test.js`).
- `node tools/polestar.js i18n status` prints the table of languages.
- `node tools/polestar.js i18n keys` lists every key with the files and lines
  that use it.
- `node tools/polestar.js i18n import <locale> <file.lua>...` merges
  translations written elsewhere: a file that returns
  `{ ["English"] = "translation" }`, sets `L["English"] = "..."`, or calls
  `ns.AddTranslations` (Ding!'s layout). It fills only texts not translated
  yet, refuses a broken format, and puts texts the code lacks in the end block.
- `node tools/polestar.js i18n fit [<locale>[=<file>]...]` lays out every
  preview scene and every Options page in English and each language, and
  lists the translated text the window would cut with an ellipsis or let
  cross its edge (`deDE=my-deDE.lua` checks a file of your own). Write your
  translation as long as it needs to be: the layout makes room (labels and
  descriptions wrap, controls size to their text), and a text this still
  lists is a layout bug to report, not yours to shorten. `--slack 1.15`
  measures about as wide as the game's own font.
- `node tools/polestar.js i18n leaks [<locale>...]` runs the addon in each
  language and lists the English it leaves on screen, grouped by where it
  came from ("English left on screen" below). `--scene guide,options` runs
  only those scenes, `--guide <id>,...` puts other guides in the guide
  window, `--json` prints one document, `--update-baseline` rewrites the
  baseline (below).

## For developers

Write every player-facing text as a literal `L["..."]` (or
`ns.LC("context", "text")`) where it is used, so `i18n keys` finds it. After
adding, changing or removing texts, run `node tools/polestar.js i18n sync`
and commit the locale files with the change: a stale key fails `npm test`. A
text looked up through a variable (`L[category]`) must be listed in
`DATA_KEYS` in `tools/lib/i18n/keys.js` (the Dungeons attunement notes are
read from `tools/lib/codex/attunements.json` there); a generator writes its
prose as literal keys (`talents build`: the plan notes in `Talents/Builds.lua`).
Data that names a game thing carries its id, never its English name alone, so
the display can ask `Polestar.Names` for it. A game term the client names
(`ITEM_QUALITY3_DESC`, `FACTION_HORDE`…) is read from the client, not put in
`L`, and its English value goes in `tests/lua/wow_stub.lua`. Tests that need a
translated client fake a language Polestar does not ship:
`fakeLocale('itIT', { ... })` (`tests/helpers/locale.js`).

## English left on screen

`node tools/polestar.js i18n leaks` checks that nothing English reaches the
screen on a client in another language, so a new feature cannot add English
unnoticed. It runs the addon on the client stub (`tests/lua`) in each
language with the shipped translations, names addon and guide texts, and has
the client answer in "its language": every name the client itself gives
(quest titles, item, zone, map, area, spell, faction, class and race names,
the player's name) comes back as a placeholder holding no word. Scenes then
drive the windows: the guide window step by step with every tooltip, all
guides (both with every step shown, whatever class, race or faction it is
for), the welcome, the picker, Options, Lookup, Dungeons, Rares, talents,
the journey planner, Polestar's tooltip lines, every slash command, the world
map and alerts, and the Recorder. Every text the addons put up is recorded
(font strings and buttons, tooltips, chat, popups, menus) with its scene and
the line that set it.

A word of three or more Latin letters is English left on screen unless it is
the language's own or `tools/lib/i18n/leaks-allow.json` allows it:

- **The language's own words.** Russian, Korean and Chinese have none in
  Latin letters. German, Spanish, French and Portuguese learn the words of
  their real translations (interface strings and guide texts), after cutting
  what is the same in every language (products, slash commands and their
  arguments, tokens, formats): a translation that equals its English, or
  copies most of it, teaches nothing.
- **Names the client gave.** Every name `Polestar.Names` returned in the run
  is the client's, in whole and by its words.
- **The allow list**: product and people's names (Polestar, Discord, TomTom,
  the font credits...), terms every client shows in English (XP, PvP, Shift,
  Ctrl+C), patterns for links, files, versions, slash commands with their
  documented arguments (`slashArguments` and every registered command; the
  prose after one is checked), guide ids and format directives, and per
  language the names and words it writes as English does (Uldaman; German
  Navigation).

What a scene types (a search, a command's arguments) does not count where a
text repeats it. Each finding names its source:

- **interface string not translated**: a key the language's file leaves
  empty (`i18n sync`, then translate it);
- **guide text not translated**: a guide text its texts file leaves empty
  (`i18n guides sync`);
- **name missing from the names pack**: `Polestar.Names` was asked and had no
  name, so the guide's English showed (`i18n names`);
- **English name, Polestar.Names not asked**: the code shows a name from a
  guide or the data without asking `Polestar.Names` for it by its id;
- **English a translation keeps**: the words are ones a translation of the
  language writes as in English (a Forever-only place such as Hyjal Summit);
- **English in the code**: a literal or a data text that does not go through
  `L`.

`tools/lib/i18n/leaks-baseline.json` lists, per language, what cannot be
fixed in Polestar yet, each with a reason and the scenes it shows in: names
as `"kind:id"` (`no-source`: no source of `i18n names` has it, mostly
Forever's own NPCs, objects and items, which the client shows once the
player has seen them; `same-as-english`: every source names it as in
English, which `i18n names` records in `data/local/names-same-as-english.json`
for the baseline), and texts as `"text:<the text>"` whose English a
translation keeps (`kept-english`). A text whose only English is such is no
finding.

It fails (exit 1) on any finding, on a scene that stops with an error, and on
a baseline entry that no longer shows in English in scenes that all ran (so the file only shrinks: remove the
entry, or run with `--update-baseline`, which also adds the names and kept
texts a new guide leaves in English, and never takes English from the code
or an untranslated string or guide text). `npm test` runs a part of it
(`tests/i18n-leaks.test.js`: Russian and Simplified Chinese; the guide window
on three guides, Options, the picker, and Lookup, Dungeons and Rares where
the Codex and quest database are built), and plants English to show the
check finds it: an interface string "translated" as its English, English the
code writes out, dropped guide texts (a paladin's among them) and prose after
a slash command. Every scene needs the Codex and the quest database built
(`codex build`, `questdb build`): without them the addon is an incomplete
install with its own warnings, so the scenes skip, as on CI; run
`i18n leaks` before a pull request that changes what the addon shows. A text that is right
to show in Latin letters goes on the allow list with the reason in its group,
never to make a finding go away. Developer output stays English on purpose:
the guide lines `/polestar where` prints and the details block of a bug
report, both read by maintainers, are on the allow list.

## Game names

Names of quests, NPCs, objects, items, instances, dungeon encounters,
factions and flight points are not translated by hand: they are the game's
own. A client in another language reads them from the client where it has
them (quest titles, item names) and from Polestar's names addon of its
language, `Polestar_Names_<locale>`, loaded only on that client. A name no
source has stays English. The client is the truth: a name it shows in play
(an NPC targeted, moused over or talked to, a quest-giving object opened) is
kept, per language, and shown from then on. docs/ARCHITECTURE.md, "Names",
has the details.

- `node tools/polestar.js i18n names [<locale>...]` rebuilds the addons. Per
  id the first source with a name wins: the client's own tables in that
  language (wago.tools), Wowhead's Forever database in that language (what
  is cached under `data/sources/wowhead/names`), DingDB (cloned into
  `data/sources/ding` at the commit pinned in `tools/lib/i18n/names.js`,
  every file checked against its sha256) and pfQuest's `db/<locale>` (the
  clone `data build` uses). It keeps only the ids the compiled guides, the
  quest database (`questdb build`, or `--questdb <dir>`), the Codex's data
  (`codex build`, or `--codex <dir>`) and the travel data name. A name equal
  to the English one is not stored (a later source's translation wins), nor
  is one marking unused content (`[PH]`, `(DNT)`...). The client tables
  come from the newest build that has them all in English and every
  language; without one the build stops (`--no-tables` leaves them out on
  purpose). The Wowhead names are read from the cache in
  `data/sources/wowhead/names/`, and without it that source is empty.
  `--offline` reads only the caches, `--no-questie` leaves DingDB out. It
  prints, per language, how many ids of each kind have no name. Commit the
  folders it writes.
- A wrong name is fixed at its source: in the client (it changes there), in
  DingDB (tell Yendi, then move the pin to his new commit and rebuild) or,
  for one only pfQuest has, in pfQuest.
- To move the pin, read what changed in Ding's `Ding/DB/`, then set the
  commit, version and sha256s of `DING` in `tools/lib/i18n/names.js`; a file
  that differs from its pin stops the build.
- A new language needs its Wowhead path (`LOCALE_PATHS` in
  `tools/lib/codex/wowhead.js`, for the cache and the packs' credit), a
  DingDB file and `DING` pin if Ding
  has it, its AddOns-list text (`tools/lib/i18n/toc.js`) and the folder's
  entry in the release list (`tools/lib/dsl/project.js` takes every locale of
  `locales.js`).

## The AddOns list

The game's AddOns list shows each addon's title and notes in the client's
language from its TOC's `## Title-<locale>` and `## Notes-<locale>`. Every
Polestar addon's are written once in `tools/lib/i18n/toc.js` (Polestar and
Codex stay as they are); the generated TOCs take them from there, the
hand-written ones (Polestar, Polestar_Nav, Polestar_ItemDB,
Polestar_Recorder) carry the same lines, and `tests/i18n-toc.test.js` checks
that every TOC under `addon/` has all nine and that they match.

## Guide texts

A guide's own words (its title, why and route-choice lines, each step's title
and tip, each goal's note and label) are translated per guide pack, in the
pack's `locales/` folder: `guides/locales/<locale>/` for Polestar's own, one
file per guide at the guide's path (`forever/alliance/02-westfall.lua`), plus
`_pack.lua` for the pack's own texts (its title and notes, its guides' menu
folders). A file returns the English of each text with its translation:

```lua
return {
	-- Step 1: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin
	["{npc:234} and {npc:821} stand at the top of the stone tower."] = "{npc:234} und {npc:821} stehen oben auf dem Steinturm.",
	["Fill the vial at the well"] = "",
}
```

- **Names are not translated.** The compiler writes the game's names inside
  a text as tokens, `{npc:234}` (kinds: npc, object, item, quest, zone, area,
  spell, faction, skill), and the game shows each in the client's language.
  The comment above the line lists them with their English. Keep every token
  of the English, as many times, wherever the sentence needs it; add none.
  A text that is only names (a step titled after its NPC) has no line.
- A token marked `(no name in this language: may be words)` is an object no
  source names in your language (a district's sign, a tavern): the game would
  show it in English. Write its name in your words instead; `i18n guides
  check` accepts the translation without that token.
- A name the text uses in the English plural stays words ("Harvest
  Watchers"): the comment `-- plural, as words: Harvest Watchers = {npc:115}
  Harvest Watcher` gives its NPC. Translate the plural yourself from the
  game's singular name (Polestar_Names_<locale>, `i18n names`), or, where
  the game has no name for it in your language, write the singular's token
  in the translation: `"Bandidos ({npc:251918})"`, `"{npc:251918} ×8"`. A
  token of that line is allowed though the English has none.
- `""` is not translated yet: the English shows. Keep the key byte for byte.
- Keep the line breaks (`\n`) of the English.
- `-- No longer in the guide (its English changed or it went away)` heads
  the translations whose English the guide lost, commented out; `i18n guides
  check` names the new English of a changed one where it can tell. Copy the
  translation to the new line, adapt it, and delete the old one.
- The files are written whole by sync: comments you add are rewritten.

The compiler puts each language's translations into the pack's texts addon
for it, `<pack folder>_<locale>` (`Polestar_Guides_deDE`), which only that
client loads, on demand (docs/PACK_FORMAT.md, "Texts addons"). Commit the
locale files and the texts addons `compile` writes.

- `node tools/polestar.js i18n guides sync [<locale>...]` writes every
  guide's file and `_pack.lua` for each language named (without one: each the
  pack has a folder for): every text in reading order, the translations kept,
  the lost ones moved to the end. `--pack <dir>` names another guide pack.
- `node tools/polestar.js i18n guides check [<locale>...]` fails on a file
  Lua cannot load, a translation that leaves out or adds a token or a line
  break, a stale translation, or a file no guide has. `lint` and `compile`
  warn about the same, and leave a broken translation out (the English
  shows).
- `node tools/polestar.js i18n guides stats` sizes the work: the texts that
  need words, with their words and characters, in all and per guide folder,
  and how many names the compiler made tokens.

## Adding a language

Add it to `LOCALES` in `tools/lib/i18n/locales.js` with its status and
translators (and to `ns.AI_LOCALES` in `addon/Polestar/Core/Init.lua` when its
status is `ai`), then run `node tools/polestar.js i18n sync <locale>`.

## Reviewing an AI-made language

Play with it, correct what reads wrong, and open a pull request that also
sets its `status` to `"reviewed"` with your name in `translators`
(`tools/lib/i18n/locales.js`) and removes it from `ns.AI_LOCALES`
(`addon/Polestar/Core/Init.lua`).
