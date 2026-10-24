# Notices

Polestar Forge is part of Polestar and is GPL-3.0 (see `LICENSE`). This file credits the work it
builds on. It ships in every Forge release archive, together with `THIRD_PARTY.md` (every
third-party input of Polestar as a whole) and the licence list of the Rust crates Forge is built
from. The data pack's `manifest.json` names the source, licence and credit of each file in it.

## Shortest Path Forever

Parts of `forge-nav` (`src/f4/`: the reader and router for Leffe's navigation maps) and of
`forge-data` (`src/travel/timetable.rs`: the transport timetables) are adapted from Shortest Path
Forever (https://github.com/cjber/shortest-path-forever) by Cillian Berragan, used with his
permission. The walking routines `Path.lua` and `PathGrid.lua` that `f4/` ports started from
Shortest Path Forever v1.16.0. Those files keep his notice: Copyright (C) 2026 Cillian Berragan,
GPL-3.0-or-later.

`timetable.rs` also holds portions taken from the CMaNGOS project (https://github.com/cmangos;
see its AUTHORS file), GPL-2.0-or-later, used here under GPL-3.0.

## Leffe's navigation maps

Forge reads Leffe's navigation maps (format 4) to price walks, and the data pack carries them as
their own download, with Leffe's full permission. Thank you, Leffe.

## Factoruide

Parts of `forge-sim` (the route search and its edits), `forge-nav`, `forge-data` and `forge-guide`
are adapted from Factoruide (https://github.com/brouznouf/factoruide), Copyright (c) 2026 Factoruide
contributors, MIT License, used with its author's permission. Each adapted file names its source at
the top. Factoruide's databases are GPL-2.0-or-later and are not shipped with Forge or in the data
pack. The MIT License text:

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## EG Link

The knowledge base and the data pack use EG Link output by Efficient Games
(https://efficient.games; https://github.com/JIVESCORP/eg-link-output-wowf): players' game caches
of the server's quest answers. Licensed CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/);
the data pack carries these files unchanged, credited in its manifest.

## pfQuest

`forge-data` reads pfQuest's database (https://github.com/shagu/pfQuest) by Shagu, MIT License. The
data pack carries the database files it reads, with pfQuest's `LICENSE`.

## Questie and QuestieDB

Questie and QuestieDB (https://github.com/Questie): no data licence stated; used with credit, with
the Questie maintainers' agreement. Questie's code is moving to GPL-3.0. `forge-data` reads
QuestieDB's Forever store from the user's own installed addon.

## WoWDBDefs

`forge-gamedata` reads the client's table layouts from WoWDBDefs (https://github.com/wowdev/WoWDBDefs,
`definitions/*.dbd` and `manifest.json`) by the wowdev community. Its definitions are licensed
CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) and its code BSD-3-Clause. No
WoWDBDefs file is in this workspace; the data pack includes the definitions and `manifest.json`
unchanged, with WoWDBDefs' `LICENSE.md` and this credit, under CC BY-SA 4.0. The CASC, BLTE and DB2
readers are written from the format documentation on wowdev.wiki (CASC, TACT, DB2 pages); no code is
copied.

## Blizzard game data

The tables are Blizzard Entertainment's and are read from the user's own installed client,
read-only. No Blizzard file or raw table is committed. The data pack holds cached copies of the
client tables the build reads, used as facts for interoperability; game data © Blizzard
Entertainment.

## Lua 5.1

`forge-data` runs pfQuest's database and QuestieDB's schema and support files through Lua 5.1,
built into the binary by the `mlua` crate (MIT) from the Lua 5.1 sources (`lua-src`, MIT;
Copyright (C) 1994-2012 Lua.org, PUC-Rio).
