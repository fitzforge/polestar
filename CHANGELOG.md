# Changelog

## Unreleased

### For players

- Gear advice no longer marks a weapon you haven't trained as an upgrade,
  picks it as your quest reward or equips it: it went by the weapons your
  class can learn, so a level 4 rogue was shown a green arrow on a sword and
  a mace. The tooltip says the weapon skill isn't trained, and the advice
  changes as soon as you learn it (thanks Pynte).
- Teldrassil takes Conservator Ilthalaine's The Balance of Nature before
  Melithar's quest: he stands right beside where you start, and the guide
  sent you past him first (thanks Pynte).
- Teldrassil shows the Gnarlpine Totems with the Nightsabers, boars and Fel
  Moss instead of after them, and the arrow knows every totem in the woods:
  the guide named only one of the two totem objects (thanks Pynte).
- Teldrassil still hands you your class sigil after The Balance of Nature,
  but has you hand it to your trainer on the next visit to Aldrassil, when
  you train, rather than a trip up the tree at level 2 with nothing to learn
  (thanks Pynte).
- Thousand Needles offers the Bronze Tube from Herble Baubbletump before you
  turn in Look to the Stars in Darkshire, for when you arrive without one;
  the tip names Neal Allen in Menethil Harbor if Herble is sold out (thanks
  Yendi).
- Zephras Isle: The Great Outdoors says to /sit by Raan's campfire until you
  get Boosted Rest, not "Click Basic Campfire" (thanks Sato).
- Zephras Isle: The Gift of Skysight says to cast Skysight near the
  Elemental Convergence, and the Alliance's Reading the Ley Lines to cast
  Read Ley Line at the Ley Line, not to click them (thanks Sato).
- Zephras Isle (Horde) takes Welcome to Shen'dar Village at your first stop
  with Constable Aonda and follows the quest's own progress, so talking to
  Illaya Amberwind earlier counts and the step no longer waits on her
  (thanks Sato).
- Zephras Isle: the Scrawny Ursera step sends you to the slopes west of
  Thendal Village, where they spawn, not into the village: our spawn data
  had bears inside it that Wowhead Forever's map has none of (thanks Sato).
- A quest whose earlier part you haven't done reads "Requires <quest>
  first" right away, and the guide no longer walks you to its giver: in the
  19-24 Barrens it sent you to Sergra Darkthorn for Jorn Skyseer without The
  Angry Scytheclaws, and only marked it after her window opened. It comes
  back as soon as you finish the earlier part. Quests whose earlier part the
  guide still brings you to are unchanged, and the giver's window stays the
  final word (thanks Fitz).
- Polestar's interface is in French, translated by Yendi (thanks Yendi).
- Reputation standings, item qualities, the Alliance and the Horde, the gear
  slots on the upgrade line, the Dungeon Journal and the race names on guides
  and the welcome read exactly as the game writes them, in every language
  ("Main Hand", "Shoulders" and "Dungeon Journal" in English).
- Options > About says so on a client whose translation was made with AI, with
  the Discord invite.
- On a client in another language, the guide window names quests, NPCs,
  objects and items in that language, and the game's own quest title comes
  before the guide's English one: the client's names where it has them, else
  Polestar's names for that language (from DingDB, by Yendi, thanks Yendi,
  and pfQuest). A name neither has stays English. The target button targets
  the translated name, quest objectives and object tooltips are matched by
  it, the quest database's names and tooltips use it, and Lookup finds a
  quest, NPC, item or zone by its translated name as well as by its English
  one. Each language's names are their own small addon,
  `Polestar_Names_<locale>`, in the release zip; the game loads only the one
  of its language, and an English client none.
- On a French, German, Spanish or any other non-English client, setting your
  home, discovering a flight path, hearthing and flying complete their steps:
  the guide named the place in English and the game answered in your language
  ("Darkshire" against "Sombre-Comté"), so these steps never checked off and
  had to be skipped. Polestar now knows each inn, flight path and place by
  the game's own ID: binding at the innkeeper the step names, or being bound
  there already, completes the step, and the guide window names the place as
  your game does (thanks Yendi, #83).
- Alliance Priests run Cenarion Aid, Of Coursers We Know and The Ichor of
  Undeath (8254-8256) on the leveling route: High Priest Rohan gives the first
  at the Ironforge stop before Azshara, and Ogtinc's two errands fit the
  Azshara visit, the Ichor of Undeath from the Ruins of Eldarath the route
  already clears. About half an hour faster to 60 for every Alliance Priest
  start, with about 45 minutes less grinding. Blood of Morphaz stays in the
  Class guide: its item drops inside the Sunken Temple (thanks XrayAlpha,
  #119).

### For guide authors

- `compile` gives `sethome`, `hearth`, `fly` and `getfp` and a labelled `goto`
  the game's area ID of the place they name (`area`), and `getfp` its flight
  point's taxi node (`node`), so they complete on every client language; it
  prints how many got one. The guide sources do not change, and a pack
  without the keys keeps matching by English name (GUIDE_FORMAT.md, "Places
  by ID"; PACK_FORMAT.md).

### For contributors

- The Discord bot tells no #bugs thread about a pre-release: a test build
  published on GitHub as a pre-release is not "the fix is out", and the next
  full release still tells every fix closed since the last full one
  (`tools/discord-bot/lib/notify.js`).
- `node tools/polestar.js i18n` keeps the interface translations, adapted
  from Ding! by Yendi (@moust4ki): `status` lists the nine languages with
  their counts, status (reviewed or AI-made) and translators; `check` (run in
  CI) fails on a file Lua cannot load, a stale key or a broken format and
  warns where a translation leaves out its glossary's word; `sync` adds the
  texts the code gained to each file, commented out under their file, and
  moves translations of texts it lost to a block at the end, never touching a
  translation; `import` merges translations written apart.
  docs/TRANSLATING.md.
- The boat, zeppelin, tram and lift captions ("Next boat in 1:20") can be
  translated: they were looked up through a variable, so no translator saw
  them.
- Tests fake an Italian client (`fakeLocale('itIT', ...)`): Forever has none,
  so no shipped language file replaces the fake strings.
- `node tools/polestar.js i18n names` builds the names addons
  `addon/Polestar_Names_<locale>` (committed) from DingDB, cloned into
  `data/sources/ding` and pinned to Ding v1.8.1's commit and each file's
  sha256 (a file that differs stops the build), then pfQuest's locale files
  for the names DingDB lacks, keeping only the quests, NPCs, objects and items
  the guides, the quest database and the Codex name. `--no-questie` leaves
  DingDB out. Each folder's `LICENSE-DATA.txt` records the sources, versions,
  licences and counts, with Ding's `CREDITS.md` beside it. `Polestar.Names`
  (`Core/Names.lua`) reads them; docs/ARCHITECTURE.md, "Names", and
  docs/TRANSLATING.md, "Game names".
- `travel build` gives every inn in `Nav/TravelData.lua` its AreaTable area,
  from the AreaTable `data build` caches (`tools/lib/data/areas.js`, also read
  by `compile`); `Compat.GetAreaName` reads `C_Map.GetAreaInfo`; Nav exposes
  `Nav.FindInn` and `Nav.BoundInn`. `tests/engine-l10n.test.js` plays the
  steps on a fake French client.
- `tools/discord-bot`: `/close` and `/reopen` for server administrators in
  a #bugs thread. `/close` takes a reason (Fixed, Won't fix, No action
  needed, Can't reproduce, Not resolved, Duplicate) and an optional note,
  closes the issue with it, and the reporter hears it in those words with
  the note quoted (`tools/discord-bot/README.md`).
- `tools/discord-bot`: every player's message in a tracked #bugs thread
  becomes a comment on its issue, not only the reporter's: another player's
  confirmation or Wowhead link is context for whoever triages it. The
  reporter's comments say "(the reporter)".

## 0.2.4 (2026-10-16)

### For players

- Ticking a quest's accept off without taking the quest no longer sends you
  to farm for it: its objectives and turn-in leave the guide, as when you
  skip the step, and come back if you take the quest after all. A stray tick
  on Raptor Horns in Ratchet kept the Barrens guide on the horns.
- Walks between zones go through the real tunnels, passes, bridges and
  gates: from the Barrens to Astranaar the route flew to Sun Rock Retreat
  and walked straight over the ridge into Ashenvale; it now walks through the
  Talondeep Path. The zone crossings are Carbonite's (GPL-3.0), shipped with
  Polestar; until now only a local file had them, so released builds walked
  between zones in straight lines.
- The quest item button offers only an item from the step's own quests: it
  took the first usable quest item in your bags, so Bethor's Potion from
  Silverpine sat on it through the Barrens. From the bags it now offers only
  an item one of the step's open quests handed you when you took it.
- The instance counter ("1/5 this hour") no longer appears on screen unless
  you turn it on: Options, Quality of Life, Trackers, Instances, "Compact
  display". Instances are still counted, and /pole instances still lists
  your runs and the hourly cap.
- The Barrens (19-24) takes Her Name Is Olgra after Lost in Battle is handed
  in, the only time Mankrik offers it, and collects Olgra's Adornments on the
  way back down to Camp Taurajo: the guide asked for it at the first
  Crossroads visit, Mankrik's window then marked it not offered, and the
  quest dropped off the route (reported by Fitz on Discord).
- A rare alert's "Set waypoint" goes to the rare, not to a spawn point across
  the zone: a rare in sight (nameplate, target or mouseover) sets it where you
  saw it, and a minimap rare is asked for its position again on the click and
  on the zone's map when a subzone or cave map lacks it. Only when the game
  gives no position does it fall back to the nearest known spawn, and the
  alert now says so ("known spawn 120 yd"); a spawn whose distance cannot be
  measured is no longer picked (thanks petllama and Miguel Antunes).
- Vendors, trainers and inns the guide picks for you put towns in zones far
  above your level last: a level 18 in Darkshore was sent to sell and repair
  at Chagrak Hammerstrike in Mount Hyjal (56-60), nearer by straight line
  than Auberdine. Such a town still comes up when you click through the
  alternatives (thanks Sevenleafclover).
- The Target button and the Step action key never put a name with a line
  break (or any other control character) into their macro. A guide pack,
  which anyone can write, could have hidden a second line such as
  `/run SendMail(...)` in a mob's or NPC's name, and it would have run on the
  press; such a name is now passed over.
- Looking ahead at an accept, taking the quest moves on to its objectives
  again: in the moment after the accept, before the game fills in the quest's
  objectives, the guide read it as ready to hand in and jumped past the kill
  or collect step to the turn-in (Kolkar Leaders in the Barrens went straight
  from Regthar to his turn-in, past Barak Kodobane).
- Handing in a quest the guide does not list, then taking the follow-up the
  game offers at once, no longer passes the same NPC's guide quests as "not
  offered" when the reward took more than half a minute to read (Jorn
  Skyseer at Sergra Darkthorn in the Crossroads).
- In Eastern Kingdoms and Kalimdor the arrow's walks run on Polestar's own,
  finer walking maps (made from the game's terrain, water and buildings, in
  Shortest Path Forever's map format, with Cillian Berragan's permission): out
  of an inn by its door rather than through the wall, down into the Undercity
  by its lifts, never swimming across open sea (water the game tires you in),
  and along the coast where that is the way, and never straight up a slope
  too steep to climb (the Raptor Horns hillside in the Barrens; thanks
  Fitz). The maps take about 26 MB once
  loaded (Walk real paths on) and up to about 54 MB more while a walk is
  being searched; the zip grows by about 11 MB.
- A class guide opened before your level says so: the guide window shows
  "Available from level 20" with who starts it (or the quest to finish
  first), instead of sending you to a trainer who has nothing for you, then
  skipping its quests one by one until it called itself complete. The guide
  starts by itself on the level-up, and the guide menu's row reads "From
  level 20".
- The published leveling times count only what a guide requires: about
  130-132 h to 60 for the Horde and 132-134 h for the Alliance, not 123-124
  and 128-129. They used to count the guides' optional extras (rare-drop
  quest starters, the Green Hills pages, profession quests) as done; doing
  them as they come can still save up to about 8 h (thanks joelwurtz).
- A guide's "Train at" goal for your class ticks itself off when there is
  nothing new to learn: you visited your class trainer at this level, or at
  the even level below an odd one (class trainers teach on even levels only).
  A level 5 Paladin who trained at 4 walks on to Goldshire instead of
  looking for a trainer (thanks SavageHands).
- "Skip grey quests" (Options, Guide, Automation) leaves out grey quests now:
  it kept every quest the guide also turns in, which is nearly all of them,
  so a character ahead of the route still saw them. A grey quest goes with
  its turn-in; one that opens a quest still worth doing stays, as Buzzbox 827
  does in Darkshore at 20 (thanks Wogi).
- "Warn about missable quests" (Options, Guide, Automation; off by default):
  before you take a quest that closes another for good, a breadcrumb's
  follow-up or one quest of a choice, chat names what you would lose
  ("Taking Sven's Revenge closes Deliveries to Sven for good.") and quest
  automation leaves that accept to you. Quests your race or class never gets
  and other versions of the same quest are left out, and so are guides for
  the other faction (thanks CDVolvik and Roxton).
- The Undead Tirisfal Glades guide sends only Paladins to Bandarion Keep for
  As Above, So Below and The One That Got Away: Hilda the Breaker and Ephram
  Barbaro offer them to Paladins only. Other classes still collect the
  Shadowvale elixir bottles (thanks Mike_).
- Quests done by an event or an escort wait until the quest log counts them,
  instead of moving on as soon as you reach the place: Discipline (motivate
  five Deathguards), A Light in the Darkness and Seeking Refuge in Tirisfal
  Glades, Lost in the Shadows in Durotar and Escaping Ban'ethil in
  Teldrassil. The guide used to send you to turn in Discipline with no
  Deathguard motivated (thanks CDVolvik).
- The Dungeons journal lists the dungeon quests it missed and drops ones that
  were not: each quest's chain now holds every prerequisite and breadcrumb
  (Nathanos Blightcaller's errands before Ramstein, Speak with Shoni before
  Underground Assault, Alba Fairmoon's Toxic Soil chain before Destruction in
  Deadmines, Rethiel's Wetlands chain before Horrors in the Highland, Magus
  Voidglare's quests before Blood in the Streets); the instance Wowhead
  Forever files a quest under counts (An Ancient Grudge in the Hall of Thanes,
  now for both sides); a quest whose start item drops or lies inside is on
  that dungeon's page too (An Unholy Alliance on Razorfen Kraul's, the
  Treaty of Understanding on the Hall of Thanes'); the report back that ends
  a dungeon quest's story is on its page (Hidden Enemies, The Lord of
  Blackrock, The Platinum Discs); Shards of the Felvine is on Dire Maul's.
  Quests whose items are sold, crafted or found outside (Murloc Poachers,
  Craftsman's Writs, Desert Survival Kits) left the pages. (thanks Shockp)
- Dungeon quest rewards: the reputation a quest gives (pages showed the
  standing some quests ask for, such as +3000), the money, the rewards of
  108 quests that showed none, how many of an item ("5 x"), and Deviate
  Hides gives both of its items now (thanks Shockp)
- A "Complete" goal shows the quest's progress: its count after it (8/14)
  and, for a quest with several objectives, the open ones under it in the
  game's words ("Plainstrider Meat: 3/7"), as kill and collect goals do. The
  Hunt Begins in Mulgore read only "Complete The Hunt Begins" with no x of y
  (thanks CDVolvik and c0nsy).
- A dungeon's pick-up guide no longer sends you to the Darkmoon Faire: the
  Deadmines guide started with Copper Modulator, Rinling's Faire ticket
  turn-in, because the modulator drops there. Darkmoon Faire, holiday and
  war effort quests are on a dungeon's page only where the game files them,
  and an item a boss drops only rarely by Wowhead's count no longer ties a
  quest to it: The Ectoplasmic Distiller left Naxxramas and Zul'Gurub, The
  Dread Citadel left Blackwing Lair (thanks kp)
- The Barrens guide takes Walton and Vrang's quests in the order the game
  offers them: Vrang's two first, The Hermit Tanner up to Walton, then
  Trouble in the Valley and Unwelcome Guests, which now waits until Terry
  Longdrink is dead. Walton offered neither at the first visit (thanks
  CDVolvik and Hotline).
- A dungeon quest several NPCs give goes to the nearest one of your side:
  Tabetha's Task for Zul'Farrak sent Alliance mages to Anastasia Hartwell in
  the Undercity; now the pick-up guide, the quest's card and Lookup send
  them to an Alliance mage trainer, and Lookup marks a quest only the other
  side's NPCs give as that side's.
- The Ruins of Lordaeron pick-up guide no longer starts with Unending
  Torment: Master Apothecary Faranell gives it only after you bring her the
  Abominable Head The Baron drops inside, so it now comes after the run, in
  the hand-in guide. The same for the Excavation Site's Titan Relics: Earthen
  Echo and Prehistoric Prism follow the relic you bring out (thanks Arachnit)
- Party sync: in a party, the guide shows the counts of party members who run
  Polestar under each shared quest goal (Ana 5/8, Ben done), and on a quest
  you took, who in the party lacks it, even without Polestar. Quest IDs and
  counts only, through hidden party messages when a count changes, so it
  works across guides and client languages; nothing goes to chat. Two
  switches in Questing > Quests > Party, both off until you turn them on
  (thanks CDVolvik).
- Quests Forever renamed carry their Forever names in the guides: Chastise
  (once A Lack of Fear), Dark Sacrifice (once Devouring Plague), Look to the
  Stars, Onu is Meditating and the others Wowhead Forever lists as renamed.
- The leveling guides follow the refreshed simulator route and take
  Forever's new quests on it. Alliance: Shipment to Stormwind and An Apple
  Treat in Elwynn Forest, Crown of the Earth and the Temple of the Moon in
  Darnassus, Fishin' Time in Stormwind, Expanding Horizons and Making Do
  between Darkshore and Stormwind, a Wetlands loop out of Menethil at 30
  (From the Ashes, Crocs of the Sky, Stopping the Cycle and the rest),
  Hillsbrad's Hoard, Seeking Caitlin, Shared Fury and the Gleaming Crescent
  Necklace in Ashenvale, Carved Centaur Totems in Desolace and My Little
  Friends across Arathi, Desolace and Stranglethorn. Horde: Beren's Peril and
  the Offering Stone in Silverpine, Va'xug Firefure in Stonetalon, Gloomrise
  north of Thunder Bluff, Stop the Screeching at Freewind Post, Traditions of
  the Bluff, The Kolkar of Desolace and Draenethyst Crystals; the Tauren
  start no longer walks to Durotar. Elite quests on the way (Aggor the Young,
  Riptear, Carnage, The Offering of Blood) are optional.
- A Class category in the guide menu, after Leveling, with 62 guides for the
  class quest chains of every class, one guide per goal and named after it:
  Druid forms and Cure Poison, Rhok'delar and Lok'delar and The Hunter's
  Charm, the Mage robes, orbs, wands and Polymorph: Pig, Verigan's Fist, the
  Holy Mightstone and the Paladin's Tyr's Watch and Lumina Windsinger
  chains, the Priest spell quests and Benediction and Anathema, Ravenholdt,
  Poisons and the Rogue's key and horn chains, the Shaman totems and
  Darkreaver, the Warlock's felhunter, incubus, Orb of Orahil (both
  acolytes' paths in one guide), Shard of the Green Flame and Tome of
  Sacrifice, and the Warrior's armour and weapon chains. The details in the
  guide menu lead with what each one gives (the item or spell with its icon
  and the game's tooltip on hover, a choice of items under "Choose one") and
  one line on why it is worth doing. A reward behaves like any item: Shift-
  click links it (a spell too), Ctrl-click tries it on, Alt-click guides you
  to it, and its tooltip fills in when the game has not loaded the item yet
  instead of staying at "Retrieving item information" (the Dungeons loot,
  the guide window's gear picks and rare drops too). The spells the chains
  teach (forms, demons, stances, the Priest racials) show their own icon and
  tooltip. The four class mounts (Paladin Warhorse and Charger, Warlock
  Felsteed and Dreadsteed) moved there from Collectibles, and the Charger
  and Dreadsteed guides now walk their whole chains (Emphasis on Sacrifice
  to Judgment and Redemption; Rage of Blood to Dreadsteed of Xoroth)
  instead of naming them in a tip.
- Class quests on the leveling route: every start takes its level 1 class
  letter to the trainer; Night Elf and Tauren Druids learn Cure Poison on
  the way (Darkshore, the Barrens), Mages do Mirror Lake (Alliance) and The
  Balnir Farmstead (Undead), Hunters' taming quests say they teach Tame
  Beast and Beast Training (Orc and Troll Hunters hand Training the Beast in
  before leaving Durotar), Undead Paladins take Coming to Terms, Call of Fire
  names the Totem of Charged Flames it gives Shamans, Rogues may do The
  Touch of Zanzil in Stormwind and Alliance Warlocks the incubus. The
  Warlock felhunter chain left the Horde 30-40 guides for its Class guide,
  and the leveling guides point at the Class guides for the long chains they
  leave out.
- The guide window says when a goal needs a group, under the goal in violet:
  "Elite: group advised" (also rare elite and boss), "Dungeon: Dire Maul",
  "Raid: Molten Core" or the guide's own "Group of 3 advised"; once per card
  when several goals share it. The guide menu tags guides with group content
  on their route "Group" in the list, on the Continue cards and in the
  details.
- The Deathcharger guide's arrow points at Stratholme's Service Entrance
  (41.5,17.7), not at the spot its Era map position falls on Forever's
  redrawn Eastern Plaguelands map.
- Without the Codex, Lookup and Dungeons say which case it is: not installed
  (get the Polestar zip from CurseForge or the GitHub Releases page, not
  GitHub's "Source code" download) or turned off in the AddOns list.
- At login, Polestar says in chat when its install is incomplete: the Codex
  or the guides missing, or a Polestar folder left from another version
  (copied over an old install, or unzipped one folder too deep), with how to
  reinstall cleanly.
- Durotar: Cutting Teeth goes back to Gornek as soon as the boars are
  done, with the class letter, so Sting of the Scorpid and Galgar's Cactus
  Apple Surprise come along to Sarkoth, whose slope is full of the Scorpid
  Workers and cactuses they need (thanks Tom).
- Three quests no longer go straight from their accept to the turn-in
  with the quest unfinished: Camping 101: Cooking in Mulgore and Dun Morogh
  waits until you have spoken with the cook, and the Alliance Un'Goro guide
  collects the compass, map and key for It's a Secret to Everybody, as the
  Horde one does (thanks CDVolvik).
- The arrow leads to a cave's mouth before anyone inside it: the Den (Kzan
  Thornslash, at the back of the cave behind Gornek), the Burning Blade
  Coven and Skull Rock in Durotar, the Coldridge troll cave in Dun Morogh,
  the Jasperlode Mine in Elwynn Forest, Shadowthread Cave and Fel Rock in
  Teldrassil and Night Web's Hollow in Tirisfal Glades, instead of straight
  through the mountain (thanks Tom).
- Dungeons: after the run, "Hand in the quests" on a dungeon's page builds a
  guide to where its quests in your log are turned in, on the shortest path
  from where you stand, and takes the follow-ups those turn-ins open from the
  same NPC or one close by; quests not finished yet are listed instead of
  routed. The button leads once a quest is finished, the pick-up guide's
  last step points to it and its end offers it, and the hand-in guide takes
  the finished pick-up guide's tab (thanks Feverish).
- Reputation the Codex knew nothing of: quest rewards say the standing their
  quest needs (the Bloodsail Admiral's Hat, the Cenarion Circle's Ahn'Qiraj
  gear) and Lookup marks the quest unavailable until you have it; the
  Winterspring Frostsaber, Stormpike Battle Charger and Frostwolf Howler
  ask for Exalted at their vendor; Aqual and Eternal Quintessence come from
  Duke Hydraxis.
- Lookup knows the standing about 180 reputation rewards ask at their
  vendor, which the game's data does not say: the Alterac Valley and Warsong
  Gulch supply officers' wares (each side's at its own faction: an Alliance
  player buying Alterac Manna Biscuits needs Honored with the Stormpike
  Guard, a Horde one with the Frostwolf Clan), the Argent Dawn's resistance
  mantles, Timbermaw Hold's Furbolg Medicine Pouch and Totem, Duke
  Hydraxis's Aqual and Eternal Quintessence, and the Zandalar Tribe's
  Essence Mangoes, Zanza potions and signets, now listed as rewards of
  Rin'wosho the Trader's quests. Such a source shows as unavailable, with
  the grind, until you have the standing, and a guide built from it reaches
  the standing first.
- 286 more NPCs show their level in Lookup (from Wowhead Forever's NPC list,
  where nothing else gave one).
- Dungeons list more than their encounters: the Ring of Law's fighters,
  event and rare bosses (Edge of Madness, Theldren, Mor Grayhoof) after the
  encounter bosses, and boss chests with their loot (Chest of The Seven,
  Gordok Tribute, Cache of the Firelord). Kirtonos the Herald shows his loot.
- A boss's loot lists its own drops first, so world drops no longer push
  them out, and a rare's or a treasure's list starts with what only it drops
  and shows up to 150 items.
- On the quest reward panel the coin always marks the reward that sells for
  most, beside any upgrade arrow, not only when no reward is an upgrade.
- An object a quest item drops from names the quest once on its tooltip,
  not once per object of that name: the Sapphire of Aku'Mai in Blackfathom
  Deeps listed its quest three times (thanks Mightie).
- Dun Morogh: Grik'nir the Cold's step says he is inside the troll cave, not
  on the hill above it; follow the tunnel from the mouth (thanks CDVolvik
  and Turesh).
- Elwynn Forest: Goldtooth is inside the Fargodeep Mine, at the back of the
  mine floor; the arrow now leads to the mine's mouth first instead of onto
  the hill above it (thanks Verium).
- Ashenvale (Horde): the Sapphires of Aku'Mai grow in the tunnels leading to
  the Blackfathom Deeps portal, underground, not on the strand; the arrow
  now leads to the ruins' pit first, and the step warns that the tunnels'
  satyrs and naga are elite (thanks Mightie).
- The arrow no longer vanishes on the Deeprun Tram, where the game gives no
  position: on the ride it keeps showing "Take the tram to Stormwind" (or
  Ironforge), anywhere else without a position it says "No position here"
  over the step, and it points again as soon as you step off (thanks
  Igotthis).
- The arrow takes the mouse on the arrow itself, not on the distance and
  label under it, so a large arrow no longer catches drags meant for the
  world, and the hover wash sits behind the arrow only. When there is no
  arrow to show (another continent, no position), the text takes the mouse
  (thanks CDVolvik).
- Teldrassil, Dun Morogh and Mulgore: the starting glens no longer send you
  off for one delivery quest and back. Dolanaar Delivery and Supplies to
  Tannok are taken on the way out of Shadowglen and Coldridge Valley, by the
  path where Porthannius and Hands Springsprocket stand, and A Task
  Unfinished starts the cougar hunt at Antur Fallow's end of Camp Narache.
- Quest items that vanish after a while reach their turn-in in time: Dun
  Morogh takes the Scalding Mornbrew (five minutes) from Nori just before
  Anvilmar instead of before the troll cave, the Blasted Lands go to
  Nethergarde Keep with the Crate of Power Stones (an hour) before the
  bloodmages' beasts, and Horde Warriors in the Barrens gather the Twitching
  Antennae (fifteen minutes) on the way back from Gann Stonespire and hearth
  to Ruga at once. Teldrassil says Iverron's Antidote lasts five minutes.
- Western Plaguelands (Alliance): the Arcane Quickeners vanish 30 minutes
  after you buy them, so the guide no longer buys all four at the first
  Chillwind Camp stop, where they ran out before the cauldrons: one is
  bought on the stop right before Felstone Field's cauldron and two on the
  one before the Writhing Haunt's and Dalson's Tears', and the steps say
  they last 30 minutes.
- Dungeons: an Attunement tab (Keys where each is a key) on the pages of
  Molten Core (Attunement to the Core, and Aqual Quintessence for the runes),
  Onyxia's Lair (the Drakefire Amulet, each side's chain), Blackwing Lair
  (Blackhand's Command), Naxxramas (the Dread Citadel quest your Argent Dawn
  standing allows), Scholomance (the Skeleton Key), Blackrock Depths (the
  Shadowforge and Prison Cell keys), Stratholme, Dire Maul, Gnomeregan,
  Scarlet Monastery and the City of Dalaran (the Horde's Dalaran Sewer Key).
  Each shows what it opens and who needs it, whether you hold the key, and
  every step with your progress: done, in your log, open now, waiting on an
  earlier step, too low or short of standing. "Guide me through it" opens a
  guide through what is left, from where you stand: every quest of the
  chain in turn, including the ones given, ended or done inside a dungeon
  (Marshal Windsor in Blackrock Depths, Blackhand's Command at Drakkisath's
  Brand, the Core Fragment by the Molten Core portal), which send you to
  that dungeon's entrance and say what is inside; a quest still above your
  level stays in the guide, its accept saying from which level. Forever took
  the Seal of Ascension out, so Upper Blackrock Spire has no key (thanks
  Shockp).
- A step that asks you to buy something can buy it for you at a merchant
  that sells it, after selling greys and repairing: Options, Quality of
  Life, Vendors, Buy for the guide (off by default; Shift skips). Only what
  your bags still lack, and only for money. Optional buys, like a second
  mount colour, are left to you, and so is anything over 50g: the chat says
  what it left (thanks CDVolvik).
- Dun Morogh: Grund and Gozwin is done from Anvilmar and handed in on the
  way to the troll cave, The Adventurer is taken from Thalos on the way out,
  the arrow leads to the troll cave's mouth where it is in game, and the Crag
  Boars on the road to Kharanos count toward Ragnar's ribs: the valley is
  never walked back to, about two minutes sooner to level 10 (thanks
  thmastin).
- One key for the step (Options, Keybindings, AddOns, Polestar, "Step
  action: NPC, quest item, mob or Hearthstone") does the step's next action,
  in guide order, the route's own goals before optional ones: targets the
  NPC to accept from, turn in to or talk to, uses a use goal's quest item or
  the Hearthstone, targets the step's mobs (each press the next name), else
  uses the quest's item. It needs no button on screen and, like the buttons,
  keeps its action in combat until combat ends (thanks CDVolvik and Turesh).
- Class trainers can teach you every new spell you can afford as you open
  them: Options, Quality of Life, Vendors, Learn new spells (off by default;
  Shift skips). Riding, weapon, pet and profession trainers are left alone
  (thanks CDVolvik).
- Darnassus hunters are sent to Jeen'ra Nightrunner, not Ariyell Skyshadow
  (a weapon merchant), and Polestar knows twenty more class trainers in the
  capitals and Mulgore (Ander Germaine, Grezz Ragefist, Sian'tsu, Hana
  Lighthoof...), so learning new spells works at every class trainer.
- Quest rewards that are upgrades can go on by themselves once they reach
  your bags, out of combat: Options, Questing, Rewards & gear, Wear reward
  upgrades (off by default; Shift at the turn-in skips). Chat says
  "Wearing [item] (+12%)" once it is on, and nothing when you cancel its
  bind confirmation (thanks CDVolvik).
- Grow upward (Options, Guide, Window, Position): the guide window keeps its
  bottom edge in place, so a longer step extends it up instead of down.
  Turning it on or off leaves the window where it stands (thanks thmastin).
- Step tips start in full: each step shows the author's tip whole instead of
  one line, as players asked. A click still folds it for that step; Expand
  step tips (Options, Guide, Window, What it shows) off keeps them on one
  line (thanks CDVolvik).
- `/polestar way 40 60` where the game gives no map position (an instance,
  another continent) says "No position here" instead of how to type the
  command (thanks meellm).
- `/polestar way` takes decimal commas in both coordinates
  (`/polestar way 45,5 30,2`) as well as decimal points, and `45,30` still
  reads as x and y. A decimal comma in only one (`45,5 30`, which could also
  be 45,5 with the label 30) and coordinates outside 0-100 show the usage
  line instead of setting a waypoint. So does `x,y` followed by a numeric
  label (`45,30 50`), which reads the same way; write `45 30 50` instead
  (thanks meellm).
- Quests only a profession's practitioners are offered stay out of sight
  for everyone else, the way another class's quests do: a Troll Warrior
  without Enchanting no longer sees A Pain in the Neck in Durotar, and
  learning the profession (or the rank the quest needs) brings it back. The
  Teldrassil guide takes Recipe of the Kaldorei after the cooking lesson,
  since Zarrin offers it to cooks only (thanks AndarKerran).
- Beer Basted Boar Ribs stays on the first visit to Ragnar Thunderbrew in
  Kharanos and in sight without Cooking: on Forever he offers it to
  characters who have not learned Cooking (thanks thmastin).
- A quest item's goal says where it comes from: "Kill Grellkin or Grell for
  Fel Moss" instead of "Collect Fel Moss", and "Collect Handful of Oats from
  Sack of Oats" for one you pick up, on the goal line and the arrow. Up to
  two creatures that drop it at 50% or more are named; cloth and other items
  that drop everywhere are not. Two tips that said "click" for picking up an
  item now say so (thanks Pynte).
- The guide window no longer fades out on every pull: "In combat" (Options,
  Guide, Window, Combat) is "Keep visible" by default. "Hide" stays if you
  chose it; to keep the fade, pick "Fade out" there (thanks Pynte).
- Every place the guide step's mobs and objects spawn is a region on the map
  now, not one point: the whole stretch they are found in, shaded with an
  outline, so the Grells carrying Fel Moss are one region over the woods they
  roam, not small circles hidden under the pins. The goal the arrow follows
  wears the arrow's colour on the world map and the minimap (cut at its rim);
  the step's other goals' regions are fainter, on the world map. If the first
  camp is crowded, the next one is in sight; the next-spot button, or a click
  on a camp's mark on the world map, moves the arrow there (thanks Pynte).
- Tirisfal Glades: Hides for the Forsaken counts the Vile Fin Murloc Skins
  (3) on the shore step and the Darkhound Hides (6) with the darkhounds; the
  two had swapped objectives, so the murloc step showed the hide count
  (thanks CDVolvik).
- Zephras Isle, Hunters: Taming the Beast tames the Ornery Galestrider with
  Quel'ana's second rod and the Vuldren Alpha with her third, as the quests
  ask; the guide had the two beasts the other way round.
- Quest objectives each read their own line of the quest log: Kobold Vermin
  no longer counts the Kobold Vermin Runt line, two objectives of the same
  name keep their own counts, and a line that gets its name late (" slain:
  0/8") is matched again. After a turn-in the quest counts as done until the
  log catches up (up to 10 seconds), so its follow-up opens at once instead
  of the quest flashing as available again (thanks meellm).
- `/polestar guide <id>` takes the id in any case: `/polestar guide
  Forever/Horde/02-The-Barrens` opens the Barrens guide (thanks meellm).
- Talent plans for Paladins (Questing, Talents; `/pole talents`): Holy,
  Protection and Retribution leveling plans as an ordered list of picks with
  short notes, and marks on the talent frame: a ring on the next pick when a
  point is waiting, pick numbers, a flag on points spent off the plan, and a
  line in each talent's tooltip. Unspent points come from the game, so
  Talented (Adventure) and other early points count. It never spends a point
  for you (thanks jnickles85-bit).
- Polestar in Spanish (Latin America): on an esMX client the whole interface
  is in Spanish, in the client's own terms (calabozo, banda, piedra de hogar,
  mercader, instructor) (thanks CDVolvik).
- Polestar in German: on a deDE client the interface is in German, in the
  client's own words (Verbreitet, Selten, Rar for the item qualities,
  Alchemie, NSC, Dungeonkompendium); the report texts and "Complete" stay in
  English for now (thanks thecodingcortex).
- The arrow walks real paths: round cliffs, water and walls, through the
  town gate and down into the mine instead of straight over the edge, thanks
  to Shortest Path Forever by Cillian Berragan
  (https://github.com/cjber/shortest-path-forever), whose router and walking
  map of Zephras Isle he kindly let Polestar use; the walking maps of Eastern
  Kingdoms and Kalimdor are Polestar's own, in his format. They come in the
  new `Polestar_Nav` folder of the zip (install it with the others). Options,
  Arrow & routes, "Walk real paths" turns it off.
- The route picks where to land by the real walk: the walks from the flight
  masters, docks, portals, inn and teleports near your target are measured on
  the ground, so a landing whose walk goes round a ridge loses to one whose
  walk does not (a marker near Astranaar no longer sends you from Sun Rock
  Retreat straight over the mountains, thanks Fitz). The walks later on the
  route follow their paths on the map lines and in the journey too, each with
  its own time, not only the one you are on; zone crossings, cave approaches
  and the walk on from a guide's "go to the mouth" step stay straight, as the
  zone data and the guide lay them out.
- Works with Shortest Path Forever: with it installed, Polestar hands it the
  route. Each goal goes to it as a stop with the game's own mark (a quest's
  "!" or "?", a trainer, a flight master, a dungeon, a boat), a kill or
  collect area as a held area that guides you there and then stays quiet
  while you work it, and its arrow, route and journey take you there.
  Polestar's own arrow, route lines, journey steps, travel button, transport
  alerts, map clicks and `/way` step aside, so the two never guide at once,
  and Polestar's walking maps are not loaded. Clearing or replacing the
  journey sticks until the guide moves on; nothing is sent in combat (it goes
  when the fight ends) or for a corpse run, which Shortest Path Forever
  guides itself. With its journeys switched off, Polestar guides as before.
  Options, Arrow & routes, "Guide with Shortest Path Forever when it's
  installed" (on by default; shown only with it installed). While it guides,
  Polestar's arrow, route and waypoint options are greyed out and say why,
  and `/polestar arrow show`, `route` and `skipleg` say in one line how to
  get Polestar's arrow back.
- A walk is told step by step at the places it passes: "Walk to The Great
  Lift, Bottom" then "Take The Great Lift", through a zone's gate or into a
  cave by the zone data's or the guide's own words, each with its own time,
  the arrow saying each as you reach it, and at the bridges, gates, tunnels,
  passes and cave and building mouths Polestar's walking maps of Eastern
  Kingdoms and Kalimdor name. A cave or chain the guide or the zone data
  already describes keeps its own words, and a goal right after a guide's
  "go to the mouth" step is still pointed at straight from the mouth, so the
  arrow never leads onto the hill above a mine. As a ghost the route only
  walks (no flights, boats or hearth) and the walk crosses water.
- Dungeons' "Show on map" opens the world map the way the game's own buttons
  do and never in combat: opening it from addon code left the map unable to
  open in a fight, without its quest markers, until a reload (Shortest Path
  Forever fixed the same in its 1.8.0).
- Route lines on the world map and the minimap, drawn the way Shortest Path
  Forever draws them: dots where you walk, following the real path, flights
  along the way the flight master actually flies, boats, zeppelins and the
  tram as solid lines, each in its kind's colour; the leg you are on is
  strong and the legs after it fainter, and the dots stop short of each stop.
  Every stop along the way is marked: a lift with its own glyph, zone
  crossings, approach chains and the guide's go-to points with a plain disc;
  gates, bridges, caves and passes have their own marks. Options, Arrow &
  routes, "Route lines" (on by default); the old
  trail dots stand in while it is off.
- When the route says to hearth or teleport, a button under the arrow casts
  it (bindable: "Use the route's Hearthstone or teleport"); it appears,
  moves and hides only out of combat. Right-click the arrow, or
  `/polestar skipleg`, to skip a leg: "Skip this leg" on a Hearthstone,
  teleport, flight, ride or portal plans the rest of the trip without it;
  "Mark this leg done" on a walk or a lift moves on to the next leg. As in
  Shortest Path Forever. Options, Arrow & routes, "Travel button".
- Transport alerts: 30 seconds before your boat, zeppelin or tram comes in
  while you wait at the dock, and 20 before the next stop on board, a small
  banner with a countdown, the transport's own sound (the ship's bell, the
  zeppelin's horn) on the Master channel and a flashing taskbar icon, each
  with its own switch under Arrow & routes, "Along the route". Never for
  lifts or in combat. After Shortest Path Forever's alerts.
- The flight map marks the route's flight by its node ID (no longer fooled by
  a similar name) and draws its hops to it in the accent, as Shortest Path
  Forever does.
- The journey in the guide window: under the step, every leg of the route
  numbered with its own time, counting down ("1. Walk to The Great Lift,
  Top 11:10", "2. Take The Great Lift, leaves in about 0:15 · ride 0:10"),
  the total time and distance in its header and the destination under it.
  The leg you are on is marked, finished legs drop off, and a click on the
  header folds it to the totals; click the current leg to skip it. Shown
  only when the route has more than one leg. After Shortest Path Forever's
  journey tracker. Options, Arrow & routes, "Show the journey".
- Go anywhere: Shift-click empty space on the world map or the minimap and
  the arrow takes you there, routed like any goal and named after the zone;
  Alt-click works over map icons too (a flight master, a dungeon entrance),
  named after the icon. Click the same spot again to let it go. With a chat
  box open, Shift-click still links into chat. Options, Arrow & routes,
  "Shift-click a map to go there". After Shortest Path Forever.
- Nearby services: `/polestar near repair` (or trainer, a profession such as
  `mining`, class, reagents, vendor, innkeeper, bank, auction, flight,
  stable) points the arrow at the quickest one to reach by the route, not
  just the nearest as the crow flies. The world map's and minimap's tracking
  menus list them under "Nearby services". After Shortest Path Forever.
- Without TomTom installed, "Let other addons set waypoints" (off by
  default) lets addons that set TomTom waypoints point Polestar's arrow, and
  `/way [zone] x y [title]` works (when no other addon has it); addons that
  expect TomTom's own settings may not work with it on. With TomTom
  installed, "Follow TomTom's arrow" (off by default) makes Polestar's arrow
  go wherever TomTom's points. Options, Arrow & routes, Other waypoints.
  After Shortest Path Forever.
- A point you picked before dying (a map click, `/way`, another addon's) comes
  back once you are alive, instead of the arrow returning to the guide.
- Boats, zeppelins, the Deeprun Tram and lifts run to their real timetables:
  each loop's period and stops from the transport model the servers use
  (accelerating, docking, the original servers' measured periods), so a
  route weighs the real wait and ride. Ride a boat, a zeppelin or the tram
  and Polestar times it from where you are along the way ("Timed the Booty
  Bay - Ratchet from your ride"); from then on, for six hours, the arrow says
  "Next boat in 1:20" or "Boat docked, leaves in 0:40", and the route takes
  the boat you can actually catch. Untimed, it says "Next boat in about
  2:55". If you opt in (Options, Arrow & routes, "Share boat times", off by
  default), the times you take go to your guild and group on your realm, and
  theirs come to you.
  After Shortest Path Forever by Cillian Berragan, whose timetables these
  are.
- Routes can start with a class teleport you know: a mage's Teleport to a
  city (with a Rune of Teleportation in the bags), a druid's Teleport:
  Moonglade, a shaman's Astral Recall to the bound inn, when off cooldown and
  faster. The Darnassus and Rut'theran Village portals are part of routes
  too. Options, Arrow & routes, "Class teleports".
- The walk to a guide's NPC or object ends on its floor: Andron Gant in the
  Undercity's Rogues' Quarter is reached down in the quarter, not on the
  street above it. Guide goals carry the height of the NPC or object they
  lead to; where that height finds no route, or the route ends far above or
  below it, the arrow walks as before. A point you set yourself is unchanged.
- A bug posted in the Discord #bugs forum is tracked on GitHub right away:
  the post gets "Tracked as #N", and you hear back in it when the bug is
  fixed, when we decide not to change it, and again when the fix is out in
  a release.

### For guide authors

- `category Class` files a guide under the new Class category (class quest
  chains, mounts and weapons; pair it with a `class` header), listed after
  Leveling in the guide menu with the trainer icon. Two header keys say what
  the guide's goal gives and why, shown first in the guide menu's details:
  `reward item <item> ...` (several on one line are a choice of one),
  `reward spell <id> "Name"` or `reward text <words>`, repeatable, and `why
  <one line>` (format 2; lint warns when a Class guide lacks either).
- `data build` applies Wowhead Forever's "Renamed from Y" notes too: a quest
  whose title is still Y takes Forever's name (its `source` gains
  `wowhead:title`). It also reads Wowhead Forever's class quest pages, so
  Forever's XP and level changes reach class quests that no zone list shows.
- Goals carry `group` (format 2 of the pack format; Polestar 0.2.4 reads it,
  older versions show such a pack as needing 0.2.4): the compiler derives it
  from elite kills and elite-only drops, from the solo filter's dungeon and
  raid quests and from instance maps, and the new `group [N]` modifier
  (`kill 1234 group 3`) says it outright. A guide with group content on its
  route carries `group = true`. `compile` now writes format 2 for every pack.
- Lint warns when a guide carries a quest item that vanishes after a while
  longer than it lasts: `item 10439 (Durnan's Scalding Mornbrew) lasts 5
  minutes, but the route takes about 11:29 from here to the turnin that
  spends it`. It times each goal that spends the item (a `turnin` that
  needs it, a `use`) from the latest goal that got it (an `accept` that hands
  it over, a `collect`, a `buy`; `buy x2` serves two turn-ins) with the
  simulator's travel and kill times over the guide's own goals and places.
  It flags the orders the Dun Morogh, Blasted Lands and Barrens fixes
  replaced and the Western Plaguelands Arcane Quickeners. `data build` now
  reads the Forever client's ItemSparse for it: items.json gives such items
  a `duration` in seconds (101 today).
- `travel chain --to <map,x,y>` drafts an approach chain (a cave, a climb)
  from recorded walks to that spot: where the walks leave the straight line
  to it, and the walked path from there as nodes with radii and captions,
  ready for the local crossings file once checked in game. `--session`
  drafts from chosen recordings, `--reverse` counts ways out as ways in
  (thanks CDVolvik).
- Every goal of a quest that needs a profession (quests.json `skill` and
  `skillLevel`) carries `profLine`, `profName` and `profRank`, and Polestar
  hides it from characters without that profession and rank (older
  versions ignore the fields). In a Leveling guide lint warns on such a goal
  unless it is `optional` or the guide trains the profession (and levels it
  to the quest's rank) first. `data build` takes `skill` from QuestieDB's
  Forever store only: a quest it lists without a required skill has none,
  whatever pfQuest's Classic data says, so Beer Basted Boar Ribs, Liquid
  Stone and five Stranglethorn Fishing Extravaganza quests need no
  profession (thanks thmastin).
- `record draft` writes a drafted flight as `fly "Sentinel Hill"`, the town
  the game reports on landing, not the flight point's full name ("Sentinel
  Hill, Westfall"), so the goal ticks off by itself and lint accepts it; the
  step's text and `getfp` keep the full name (thanks meellm).
- `quest Q.O` on a `collect`, `kill` or `interact` warns when objective O is
  another item, npc or object, and names the index that is this one's (or
  write `quest Q` and the index comes from the target). Legging It and Call
  of Fire list their objectives in Wowhead Forever's order in the reference
  data now, so their steps raise no false alarm (thanks CDVolvik).
- `node tools/polestar.js planner` opens the route planner in the browser:
  pick a guide and a character and the route plays on the game's own map
  (the minimap terrain of every continent, `planner art` fetches it once),
  step by step or as the whole 1-60 route, with each step's time split into
  travel, combat, talking and waiting, the level, XP, quest log and items, the
  spawn areas and the path walked, in Polestar's own look with the game's
  icons (class icons for class trainers, item icons for items, the quest
  markers). Edit mode drags waypoints, adds a `goto` with a click, bends a
  travel line into a new labelled waypoint ("Cross the bridge") and edits any
  goal or step in a form; each edit is written into the `.guide` file at once,
  with undo, a list of changes and a Compile button. It works on another pack
  given its folder. `planner mcp` serves the same commands to an AI assistant
  over MCP (and the page offers them to WebMCP), so an assistant can read a
  route's timings, change its steps and play them in the open page while you
  watch. With the navigation grid built (`nav build`) its walks follow the
  terrain for the character's class and level (around mountains, into caves
  and buildings, up lifts, swimming, mounted from 40), cached between runs; a
  walk the grid cannot route stays a marked straight line, and the map's
  Layers add Walkable and Arrow aids. The planner, and the navigation grid
  that grew out of it, are Nivek_Gaming's idea (@Nivek_Gaming on X): thank
  you, Nivek.
- The compiler gives every goal at an NPC or object (accept, turn in, talk,
  kill, interact, buy, train, vendor, set home, flight point, learn) the
  height of that NPC's or object's spawn as `z`, when one stands on the
  goal's map within 15 yards of its point (docs/GUIDE_FORMAT.md, "Heights");
  gotos, collect spots, exploration and smart targets get none. `compile`
  prints how many goals got one. The heights come from CMaNGOS classic-db
  (GPL-3.0, used as facts), which `data build` now writes as
  `data/forever/spawnz.json`; the pack's LICENSE-DATA.txt names it. Packs stay
  format 2: an older Polestar ignores `z`.

### For contributors

- `Compat.GetPlayerUnitPosition` returns no height when the client reports
  exactly 0, as Forever's does. Taken as real, it started walking paths on
  the nearest surface within 10 yd of 0 (from Ratchet's flight master: 20 yd
  down the slope towards the harbour, then back) and kept Transit from
  timing a ride on a raised track (a zeppelin at 120 yd). With no height,
  Walk starts from the ground under the player and Transit matches the ride
  on the ground plane.
- `node tools/polestar.js travel import --carbonite <ZoneConnections.lua>
  --source <text>` writes the shipped zone crossings,
  `tools/lib/travel/crossings.json`, from Carbonite's Classic Era zone
  connections (54 walks between zones, 30 yd arrival radius); `travel build`
  puts them into TravelData.lua as both continents' full crossing data
  (`--shipped none` leaves them out). Zones only Forever has are `wild`, and a
  zone's rectangle is Forever's where it redrew the map. The local crossings
  file still builds Polestar_Travel, which adds to them.
- A Feature request issue form beside Bug report and Wrong step, tagged
  `enhancement`, with a field for the Discord thread an idea came from
  (thanks CDVolvik).
- `talents build` writes `addon/Polestar/Talents/Builds.lua` from the plans
  in `talents/forever/`, and `talents check` replays every pick (rows,
  prerequisites, ranks) against the Forever trait tables from wago.tools
  (thanks jnickles85-bit).
- `node tools/polestar.js nav build` builds a navigation grid from the
  Forever client's own terrain, water and building, cave and doodad collision
  (fetched from wago.tools like the planner's map art; local only, about
  750 MB): where a character can walk, which slopes it can climb, which drops
  it survives, where it swims and which lifts it can ride. `nav path` prints
  the route between two map points.
- `node tools/polestar.js nav aids` generates the arrow's zone crossings,
  open borders and cave, building and climb approach chains from the
  navigation grid (`data/local/nav/aids.json`, the crossings file format;
  local only, never shipped) and, with `--report`, measures how many guide
  legs the arrow walks straight over ground the grid cannot walk, without
  and with them. `nav pack` names the walk's caves, building mouths, passes,
  bridges and tunnels from them (`Nav/Chokepoints.lua`), and the arrow's walks
  inside a zone follow the engine's paths. Some cities' gates are not yet found.
- `addon/Polestar_Nav`'s maps of Eastern Kingdoms and Kalimdor are
  Polestar's: `node tools/polestar.js nav pack` writes the
  navigation grid in his walking-map format (`tools/lib/nav/pack.js`, a port
  of his `gen_nav.py` and `pack_nav.py`: 128 cells a tile, a step between
  cells open only where one of our links crosses it, floors for stacked
  surfaces, his HPA* graph; climbs are no step, and a face, steep links and
  runs of terrain triangles over 50° that Forever's client slides off, only
  where it is the only way between two places, since his steps are two-way
  at flat cost; an intra-cluster edge is pruned only via two shorter hops,
  so pruning never cuts a region), with `Nav/Chokepoints.lua`
  (`tools/lib/nav/chokepoints.js`) and `PACK.json` (grid build, cells, date,
  sizes, sha256; `nav check` and `nav pack --check` hold the folder to it);
  `nav vendor` now takes only his router and the maps we do not pack
  (Zephras Isle), never removes Polestar's packed maps, and writes `Nav.xml`
  from both manifests. `API.lua` raises the engine's ceilings to
  `Path.cacheKB` 48 MB and `Path.graphKB` 6 MB for the finer maps. The grid
  no longer swims fatigue water (MH2O's deep quads; grid tile format 3:
  rebuild with `nav build`), stairs in WMOs walk as slopes or a jump, and a
  point inside a building snaps to its floor.
- `sim compare` and `sim bench` score the guides without their `optional`
  goals (an optional quest whole); `--with-optional` scores them as done, the
  old way. README, docs/SIMULATION.md and the charts are republished on world
  5eef72140b61. The world builder's quest log stays 20 with Forever's 40
  (`MAXIMUM_NUM_QUESTS_LOG_CAN_ACCEPT`) cited: 40 never binds the guides but
  merges one Alliance package, so it comes with the next world (thanks
  joelwurtz).
- The solo filter's dungeon and raid rule (`instanceQuest` in
  `tools/lib/sim/solo.js`) is shared with the compiler's group content
  (`tools/lib/dsl/group.js`), and `preview` renders the group line
  (`docs/preview/guide-group.svg`).
- The search speed test no longer pins one machine's speed (it failed under
  4 ms on slower Windows machines running the full suite): a keystroke over
  25,000 names must cost under 12 scans of the same names in the same run,
  and grow under 15x from 2,500 names, each the median of several batches,
  so a per-keystroke index rebuild or a quadratic search still fails it
  (thanks CDVolvik).
- `tests/recorder-perf.test.js` holds the Recorder to Polestar's CPU budgets
  while it records, without reference data so CI runs it: a walking frame
  under 1 ms, a burst of questing events with a full quest log and a burst
  of finds (20 rares, kills and loot windows in one frame) under 4 ms, each
  the median of 5 rounds. Each is also held against a reference timed in
  the same round (400 events to a plain handler doing a Recorder handler's
  work), which holds across machines and lua5.1 or LuaJIT; on Windows,
  where `os.clock()` is wall time, only that is held (thanks CDVolvik).
- `tools/lib/codex/repgates.json`: a curated, cited table of the reputation
  a vendor, giver or quest asks for an item (one row per item and faction,
  each with its warcraft.wiki.gg or Wowhead Classic page), which `codex
  build` applies after the client's own gates and before a guide's; a row
  whose item, vendor or quest the Codex lacks is a build warning. Parity
  "items: rep" goes from 505 to 682 of 689.
- `codex wowhead` reads Wowhead Forever's NPC, object and item lists first
  (1,000 rows a request, by id range, cached under
  `data/sources/wowhead/codex/lists/`) and fetches a cached page again only
  when its list row changed, an older parser read it, or it is older than
  `--max-age` (default 7 days) and an open parity gap or Forever's own (new
  or updated): an entity Forever left as in Classic keeps its page. A
  refresh with every page stale goes from 1,704 page requests to 210 plus
  103 list requests (151 the first time). `--dry-run` counts a run's
  requests. The Codex reads the lists for NPC levels only; parity is
  unchanged.
- `codex build` reads the newest Forever client build wago.tools lists
  (1.60.1.70374 today, was pinned to 1.60.1.70338), picked as `data build`
  picks its `--forever-build` (`pickBuild`, tools/lib/data/wago.js);
  `--build <version>` names one, and offline the newest cached build holding
  every table the Codex reads is used. `meta.json` records the build;
  `codex parity` and `codex wowhead` read the client tables of the build the
  Codex was made from.
- A route refresh keeps every fix a guide's header documents
  (docs/SIMULATION.md, "Keeping the guides' fixes"; CONTRIBUTING.md, "Fixing
  a guide"): `tests/guides-reported.test.js` pins each player-reported fix on
  the compiled guide by behaviour, one case per report (Durotar's Sting of
  the Scorpid taken to Sarkoth, the arrow through the Den's mouth to Kzan
  Thornslash and through the mouths of the Burning Blade Coven, Skull Rock,
  the Coldridge troll cave, the Jasperlode Mine, Shadowthread Cave, Fel Rock
  and Night Web's Hollow, Dolanaar Delivery and Supplies to Tannok on the way
  out of the starting glens, Antur Fallow starting the cougar hunt, Bandarion
  Keep's quests for Paladins only, Coldridge Valley without walking back),
  and `tests/lint-timed.test.js` checks the timed-item rule on the old and
  fixed orders and on every guide. A data mistake behind a guide fix belongs
  in `tools/lib/data/corrections.json` too, so the simulator sees it.
- `tools/lib/codex/attunements.json`: a cited table naming each attunement's
  goal (the quests that end it, or the key item) per instance;
  `tools/lib/codex/attunements.js` builds the steps from the Codex's quest
  chains and item sources into the journal pages (`attunement`), and
  `auditReport` compares them with the Attune addon's for the local
  `data/local/attunements-audit.md` (thanks Shockp).
- `preview` renders the Attunement tab (`docs/preview/dungeons-attune.svg`).
- Translations: `/polestar help` prints every line in the client's language,
  the show, hide, guides, options and debug commands' too: Init.lua, which
  loads before the locale file, registered them in English; they register
  in Core/Commands.lua now. `tests/helpers/locale.js` fakes a translation in
  the addon's tests.
- Translations: a word with two meanings has a key per meaning
  (`Polestar.LC`): the gear slots on the tooltip line are `"slot: Back"`,
  `"slot: Chest"` and so on, and a dungeon boss that is a chest is
  `"boss: Chest"`, so they no longer share "Back" with the welcome's button
  or "Chest" with each other.
- Translations: the options pages keep English keys whatever their titles
  read, so `/polestar options quests`, `gear`, `lookup` and the others and
  `/polestar packs` open the right page on a translated client instead of
  the first one. `Polestar.RegisterOptions` takes an optional `key` for a
  page's stable key.
- Translations: the travel route's boat, zeppelin and tram captions ("Take
  the tram to %s") are written as `L["..."]` keys in Nav/Travel.lua like the
  flight one, so a translator finds them.
- Translations: every label kept in a table is written as a literal
  `L["..."]` where it is defined, so a translator finds it by searching:
  the gear tooltip's reasons, the Dungeons journal's boss roles, attunement
  kinds, quest ties and Codex messages, Lookup's kinds, standings, factions
  and statuses, the guide menu's tabs, the group lines, source ranks, the
  welcome's feature columns, the step details ("from %s", "at %s"), the
  hand-in notes, the travel map's boat tooltips, the rare alert sounds and
  `/polestar gear`'s spec source. The item qualities in Lookup are
  `"quality: Rare"` and so on, apart from the rare mobs. Nothing changes in
  English.
- The docs say what the code does: ARCHITECTURE (startup, refused guides,
  waypoints, which code calls the client outside Compat), GUIDE_FORMAT (the
  guide id rule), README, SIMULATION, THIRD_PARTY and the tools README
  (thanks CDVolvik).
- `trainers build` reads the same guides as `compile`: Recorder drafts under
  `guides/drafts/` and build output under `dist/` no longer add class
  trainers to `trainers.json` (thanks meellm).
- `preview` writes the same `docs/preview/nav-areas.svg` on every run, so
  "Previews are up to date" no longer fails pull requests that don't touch
  it. The world map's pin pools released their pins in `pairs()` order over
  a table keyed by frame, an order of table addresses that changed from run
  to run (under lua5.1 and LuaJIT alike): a redraw could give a hull to a
  frame that had made more pieces for another, and the extra pieces
  renumbered the minimap's mask in the render. The pools release their
  frames newest first now, so a redraw hands every frame back the pin it
  showed (thanks CDVolvik).
- The guide parser records where each part of a goal line sits
  (`goal.spans`, non-enumerable, so compiled output is unchanged); the
  planner's edits (`tools/lib/planner/source.js`) rewrite only the tokens they
  change, and every goal line in `guides/` survives fields -> text -> parse
  (`tests/planner-source.test.js`).
- `tools/lib/planner/`: map coordinates (`geo.js`), the
  playback clock on the simulator's priors (`timeline.js`), and the map art
  pipeline (`art/`: a wago.tools CASC file cache, BLP2 and BC1 decoding, a BC1
  encoder, the minimap pyramid and the unfogged zone art), each with tests.
- `Nav/Handoff.lua` hands the target to Shortest Path Forever through its
  public `ShortestPathForever.API` (owner "Polestar"; `NavigateRoute` with one
  stop, `Cancel`, `Ended`, `CurrentStop`, `Subscribe` when its `minor` has
  it, else polled). `Nav.HandedOff()` is the one predicate the arrow, trail,
  travel planner (so route lines, journey steps, the travel button), alerts,
  `Nav/Walk.lua` (no `Polestar_Nav` load, no search), map clicks, the TomTom
  stand-in, `/way` and `Nav/Bridges.lua` check; `Nav.Reapply()` re-runs them
  when it flips. `Nav.SetTarget` takes an optional sixth `stop` kind
  (Dungeons, Nearby and the trainer banner pass it; `Nav.GetTravelData()`
  lists `portals`). Tested by `tests/nav-handoff.test.js` against a fake API
  written to its `docs/api.md`.
- `Nav/Prompts.lua` (the travel button, `Nav.prompts`; its own combat queue,
  as `QoL.Secure`), `Nav/Alerts.lua` (`Nav.alerts`, reads `ns.Transit`) and
  `QoL/Flight.lua`'s `Flight.RouteFlight`, `SlotOf` and `DrawRoute` adapt
  Shortest Path Forever's `UI/Arrow.lua` cast prompt, `Journey.lua`
  `SkipJourneyStep`, `UI/Alert.lua` and `Transport/Taxi.lua`; tested by
  `tests/nav-prompts.test.js` with secure frames enforced in combat.
- `Nav/Journey.lua` (map-click planning, `Polestar.Nav.API` for other
  addons: `Estimate`, `Navigate`, `Cancel`, `Active`; the TomTom stand-in,
  following TomTom's arrow and `/way`) and `Nav/Nearby.lua` (nearby
  services) adapt Shortest Path Forever's `Journey/JourneyInput.lua`,
  `Core/API.lua`, `Core/TomTom.lua`, `Core/Way.lua` and `UI/Nearby.lua`;
  docs/ARCHITECTURE.md, "Nav API". `Pins.MinimapCursor()` and
  `Pins.MinimapView()` read the minimap's view; `qol build` adds
  `reagentVendors` to `QoL/Data.lua`. `tests/syntax.test.js` lets only
  `Nav/Journey.lua` write the `TomTom` global. Tested by
  `tests/nav-journey.test.js` (NAV_QA rows 7, 8, 9, C11, C13, C14).
- `addon/Polestar_Nav` vendors Shortest Path Forever's router
  (`Routing/PathGrid.lua`, `Path.lua`, `PathJobs.lua`) and his walking map of
  Zephras Isle (`Nav/Nav2991*.lua`) at v1.16.0 (b1ad5bd), GPL-3.0-or-later
  with Cillian Berragan's copyright (`LICENSE`, `CREDITS.md`). The only
  changes are mechanical: the data global `ShortestPathForeverPathData`
  becomes `PolestarPathData`, each file names its upstream file and commit.
  `API.lua` hands the engine to Polestar as `Polestar_NavEngine` (upstream's
  `Find`, `FindCost`, `FindMany`, `Cancel`, `Busy`, plus `Available(map)`).
  It always reads its own `PolestarPathData`, never an installed Shortest
  Path Forever's tables: his engine evicts decoded entries from them while
  ours may be searching. With both installed each holds its maps.
- `node tools/polestar.js nav vendor <checkout>` redoes the copy from a newer
  upstream commit (only `Nav<name>.lua` map files; each header carries his
  copyright and the dated notice GPLv3 section 5a asks for) and writes
  `UPSTREAM.json` (repo, commit, version, vendored date, every file's
  sha256); `nav check` and `tests/nav-vendor.test.js` check the
  folder against it, and the test walks Goldshire to the Fargodeep Mine mouth
  with the real maps (decoded by `tests/lua/stub_encoding.lua`, a plain-Lua
  `C_EncodingUtil`), with checks from
  `docs/NAV_QA.md` (C2 cancelled searches,
  C6 Stormwind double-backs, C17 frame slicing, and a Shortest Path Forever
  copy trimmed mid-search leaving ours untouched).
- `Compat.OpenWorldMap(uiMapID)` and `Compat.CanOpenWorldMap()` open the
  world map through `C_Map.OpenWorldMap` (the global `OpenWorldMap` only on a
  client without it), never in combat; `Dungeons.ShowOnMap` uses them, and
  `tests/compat.test.js` rejects any other addon code that opens or moves the
  world map itself (NAV_QA C3).
- `pack` and `install` ship `Polestar_Nav` with Polestar and Polestar_Guides,
  and Polestar checks its version at login like the data packs'.
- `Nav/Walk.lua` follows `Polestar_NavEngine`'s paths: the walk the arrow is
  on is searched first (`Path.Find`, cancelled on a new goal, asked again
  25 yd off the path, never in combat), hand-made walks (crossings, chains,
  a goal after a guide `goto`) stay straight, and every failure falls back
  to the straight arrow; it splits that walk at the lifts `Nav/Transit.lua`
  knows (crossings, approach chains and guide gotos are legs already; gates,
  bridges, caves, passes and lift landings come from Polestar_Nav's
  `PolestarNavChokepoints`) (`Travel.SplitWalk`: pieces with `step`,
  `choke`, lift rides of kind `lift`) and publishes
  `Nav.GetRouteGeometry()`. `Travel.lua` plans
  timetabled waits (from when the player reaches the dock), class
  teleports, one-way portals and walk-only ghost routes, adds `yards`,
  `stops`, `item`/`spell`, `Travel.SkipLeg()` and `Travel.Progress()`; option
  `nav.navRouting`. Tested by `tests/nav-spf.test.js` (fake engine; NAV_QA
  C1, C2, K1-K8) and `tests/travel-transit.test.js` (2, 3, 11, C9, C11, C15).
- The planner's walks into the target are priced by the walking engine:
  `Travel.lua` hands each plan's places (the player, flight masters, docks,
  portal ends, the inn, teleport landings, crossing ends and chain mouths;
  `p.places`) to `Walk.Measure`, which runs one reversed `Path.FindMany` from
  the target to the nearest 16 within 3000 yd (after Shortest Path Forever's
  goal batch, `Journey/JourneySearch.lua`, v1.16.0); later plans price those
  walks by it (`p.walkCost` from `Walk.Measured`, legs `engine = "cost"`; a
  target inside a chain keeps its straight link). The batch goes from the
  target's height (once more without it when it finds nothing). A place with
  no walk found, or a target with none at all, keeps straight x1.25; the
  player's measure holds within 50 yd, and farther is measured again with
  the next plan, meanwhile never priced above the straight distance.
  Measures are fixed per target (the last 4 kept), so `Travel.Remeasured`
  replans once when one lands (after a flight or a boat ride) and keeps the
  route unless the way changes (its flights, rides, hearth, teleports,
  crossings or chain waypoints), the kept route taking the new walk prices.
  Every later walk leg that is not hand-made, not a piece of a split walk and
  not the walk on from a guide `goto` is searched once after the arrow's own
  search and the measure (`Path.Find`, one at a time, the last walk to the
  target's height, the last 32 kept by their ends and water mode):
  `Walk.LegPath`, drawn by `GetRouteGeometry`, priced by
  `Travel.PricePaths` (`engine = "path"`), which times the rides after it
  again by their timetables. Nothing is measured or searched in combat or
  while handed off. Tested by `tests/nav-spf.test.js` (fake engine: terrain,
  crossings, later walks, the review's ten points) and
  `tests/nav-e2e.test.js` (Ashenvale 40,70 and 35,75 on the real engine;
  NAV_QA H4).
- `Maps/RouteStrokes.lua` (route-line geometry) and `Maps/RouteLines.lua`
  (the world map pin and minimap painters) port Shortest Path Forever's
  `UI/Strokes.lua`, `UI/FlightLines.lua` and `UI/Route.lua`; they draw
  `Nav.GetRouteGeometry()` and are tested by `tests/nav-route-lines.test.js`
  (dot spacing across bends, stop gaps, receding legs, flight tracks, pool
  bounds, no allocation per draw). `travel build` also writes
  `Maps/FlightPaths.lua`, each flight's TaxiPathNode track simplified to
  10 yd (`--flight-lua`). `tests/lua/wow_stub.lua` gains Line regions.
- New glyphs `icon-gate`, `icon-bridge`, `icon-cave`, `icon-lift` and
  `icon-pass` (`tools/media/ui.js`) mark chokepoints on the route's stops
  (a Travel leg's `choke = { kind, name }`).
- `Nav/Transit.lua` (`Polestar.Transit`: `NextDeparture`, `NextArrival`,
  `Caption`, `Riding`, `Lifts`, `LiftNear`, `Teleports`; `NAV_TRANSIT`)
  ports Shortest Path Forever's `Transport/Model.lua`, `Timetable.lua`,
  `Observer.lua`, `Sync.lua` and `Teleports.lua`; docs/ARCHITECTURE.md,
  "Timetables, portals and teleports". `travel build` writes the timetables,
  portals and class teleports into TravelData.lua
  (`tools/lib/travel/timetable.js`, after his `gen_routes.py` and
  `gen_transit.py`: the CMaNGOS transport model over TaxiPathNode,
  TransportAnimation tracks, spell tables) from the Forever client tables
  and CMaNGOS classic-db (`tools/lib/travel/cmangos.js`, cached in
  `data/sources/cmangos/`); transports' `ab`/`ba`/`waitA`/`waitB` now come
  from the timetable. `Compat.GetPlayerUnitPosition()` is the one reader of
  `UnitPosition`, `Compat.GetSpellCooldown()` reads spell cooldowns. Tested
  by `tests/nav-transit.test.js` (NAV_QA C5, C9, K3, 11).
- Goal heights: `tools/lib/travel/cmangos.js` also extracts every creature
  and gameobject spawn on maps 0 and 1 (`loadSpawnHeights`, cached as
  `data/sources/cmangos/<rev>/spawnz.json`; `<table>_spawn_entry` fills
  pooled spawns) and `data build` writes it as `data/forever/spawnz.json`
  (left out with one warning when `--offline` has no cached dump);
  `tools/lib/dsl/heights.js` gives goals `z` (emit.js `GOAL_KEYS`, after `y`);
  the Engine's waypoint carries it while it is the goal's own point,
  `Nav.GetTargetWorld()` returns it fourth, and `Nav/Walk.lua` passes it to
  `Path.Find`, asking once more without it when the search fails or the path
  ends more than 30 yd from it. Tested by `tests/data-spawnz.test.js`,
  `tests/dsl-heights.test.js`, `tests/engine-heights.test.js`,
  `tests/nav-spf.test.js` and `tests/nav-e2e.test.js` (NAV_QA Z1-Z3).
- `tools/discord-bot`: the bug bot. It files each Discord #bugs post as an
  issue (labels from the addon's report: version, guide, locale, Lua errors,
  the forum tags; screenshots kept on the `bug-media` branch), carries the
  reporter's follow-ups and edits over, and with the workflows
  `discord-issue-sync.yml` and `discord-release-notify.yml` answers the
  thread when the issue closes, reopens or ships. Setup in
  `tools/discord-bot/README.md`.

## 0.2.3 (2026-10-14)

### For players

- Clearing the guide menu's search takes its Codex matches away: they no
  longer stay drawn over the guide list (they did after searching for an
  item or mount, then clearing the search or changing tabs).

## 0.2.2 (2026-10-14)

### For players

- The release now includes the Codex (the `Polestar_Codex` folder, part of
  Polestar), so Lookup, Dungeons and Rares work: search items, mounts, pets,
  recipes, NPCs and quests and see where to get them; every dungeon and raid
  with its levels, entrance, bosses and their loot, and its quests; rares and
  treasures with their spawns and drops. It is built from the game's own data
  tables, the quest and creature databases Polestar already uses, and our
  recordings. If it is missing or disabled, Lookup, Dungeons and Rares say
  so: reinstall Polestar or enable it in the AddOns list, then /reload.
- The Codex knows more: the battleground war mounts and tabards show their
  PvP rank and reputation, the Orange Murloc Egg and Green Helper Box are
  companions, Molten Core and the other raids list their bosses' loot, more
  rares are known, and every dungeon and raid points at its real entrance
  (the Deadmines at Moonbrook), not the spot where a ghost returns.
- Distances can read in metres: Options, Arrow & routes, Distances.
- The starting zones follow Forever's new quest chains: a follow-up is taken
  once the quest before it is handed in, where the guides offered several
  links of a chain at once (Northshire's book chain and Jason Mathers'
  murloc quests in Elwynn Forest, Dun Morogh, Teldrassil, Durotar and
  Mulgore). The Big Picture and what follows it stay optional extras, as
  Shinyfinder Narf is elite.
- Profession quests are optional and say who they are for: Rough Wolf Pelts
  (skinners), A Pain in the Neck (enchanters) and The Quarry's Smith
  (blacksmiths). Other characters could not take or finish them.
- The Skyborne start points at the Ley Line, the Elemental Convergence and
  Raan's campfire again: their ids changed in Forever's data.
- The world map's zone level ranges are rebuilt from Questie 12.1.0's
  Forever creatures (Mulgore reads 3-11, no longer 3-27).
- Reading ahead with Next no longer stops quest automation for the step you
  are on: its quests are still accepted and handed in while the window shows
  a later step.
- The optional Recorder also notes what the Codex learns only in play, while
  it is on: rares you see (on nameplates, as target or mouseover, or on the
  minimap), treasures, what each corpse or chest drops and how often, the
  dungeons you enter and where, and boss encounters, plus the rewards quest
  windows offer. To share a recording, send the `Polestar_Recorder.lua` file
  from your SavedVariables folder (CONTRIBUTING.md says where); it is imported
  without your character's name or realm.

### For guide authors

- `codex build` uses only inputs Polestar may redistribute: the dungeons and
  raids (levels, entrances, bosses) come from the Forever client's tables
  (`Map`, `DungeonEncounter`, `LFGDungeons`, `MapDifficulty`,
  `ContentTuning`), boss loot from the drops in `items.json`, mounts and
  companions from `Mount` and `BattlePetSpecies`, rares from npc ranks.
  `--local-extras` adds AtlasLoot, RareScanner and DungeonJournal for a
  local-only comparison build. `pack` ships the Codex with its
  `LICENSE-DATA.txt` and refuses to run without a release-safe one.
- A release `codex build` measures itself against the last `--local-extras`
  build, entity by entity (`data/local/codex-parity.md`, `codex parity`), and
  lists what only play can fill with the Recorder event that fills it.
- `codex wowhead` fetches, one page at a time, Wowhead Forever's facts for
  what the parity report lists as missing (NPC level, rank, positions and
  drops with counts; object contents; item tooltip requirements) into
  `data/sources/wowhead/codex/`, which a release `codex build` reads. The
  parity report now checks every internal-only fact against Forever (the
  client, Wowhead) and says whether it is a gap of ours, not in Forever, or
  unverified.
- `data build` keeps the droppers of pfQuest's reference loot tables (raid
  and boss loot) at an unknown rate instead of dropping them: Molten Core's
  tier pieces now name their bosses.
- A skill for coding agents, `skills/polestar-guide-pack/`: the workflow from
  `new` to `pack` (look up every id with `find`, then lint and playtest until
  both pass) and the guide format on one page. `new` copies it into the pack's
  `.agents/skills/` and `.claude/skills/`, and the pack's AGENTS.md points to
  it.
- `data build` reads Wowhead's Forever zone quest lists (cached a day in
  `data/sources/wowhead/`) and applies Forever's change notes: "Experience X
  instead of Y", "Level X instead of Y" and "Requires level X instead of Y"
  set X where the data still holds the old value (Scaring Shaky now gives
  3300 XP, not 820). Quests still without XP take Wowhead's. `--no-wowhead`
  skips it; guide pack workflows and Codespaces build with it.
- The Recorder records finds (`rare`, `treasure`, `slain`, `drop`, `enter`,
  `encounter` events; docs/ARCHITECTURE.md, "Recordings") and the quest
  frames' `items`, `choices` and `rewardMoney`. `record import` and `data
  build` turn them into npc ranks, levels, the `rare` role and spawns; drop
  chances from loot windows over kills, merged across sessions, with their
  counts in items' `seen` (10 kills or more replace the existing chance);
  `chest`/`herb`/`mine` objects with their spawns; quest `rewards`; and the
  new `instances.json` (entrances, encounters and their bosses).
- npcs and objects inside dungeons and raids carry `instances` (instance map
  ids), from QuestieDB's areas and the Forever `AreaTable` and `Map` tables
  (`Map` is now read with the Forever tables) plus recordings.

### For contributors

- `record import --anonymize` for a file a player sent in: character names and
  realms are dropped, a short hash keys the character (its sessions still
  group together) and no raw copy is archived.
- `npm test` passes on Windows: AtlasLoot's missing-file warnings and the
  install test's file names use `/` there too (thanks @CDVolvik).

## 0.2.1 (2026-10-14)

### For players

- Quests with several objectives check off the right one: a goal counted the
  objective at its place in the quest's text instead of its place in the quest
  log, so in The Guns of Northwatch "Kill Cannoneer Smythe" showed the 10/10
  medals and Captain Fairmount never ticked. 135 goals in 46 quests of the
  leveling guides now count the objective they name.
- A new character's welcome survives the intro cinematic: the cinematic
  closed it as it started and it never came back. It now waits for the
  cinematic to end, or comes back on the page it was on.
- The welcome is redesigned: three pages under a starlit hero (two for a
  later character), with step dots. It shows the guide window, the arrow and
  every guide at a glance; setup shows each choice's description and the
  colour schemes as cards that apply as you click; the last page shows your
  first guide on its zone painting, the beta note, the Discord invite as a
  link that opens it ready to copy, and what guide packs are.
- The guide menu lists only the guides your character can follow on your own
  faction: an Undead no longer sees the Orc and Troll Durotar and Barrens
  guides there. The other faction's button and All still list every guide.
- Guide packs page: the problem report box grows to fit long problem
  messages.
- Options > Guide packs says plainly what a guide pack is: someone else's
  guides in a separate addon, supported by its author. Its link opens
  docs/GUIDE_PACKS.md, a new page on packs for players and for authors.
- Search ranks an item first as covered by a guide only when a guide Lookup
  would open for it collects it: one of Polestar's own, or one from the pack
  chosen under Suggest guides from.
- Polestar is open source: the code, the guides and the tools that build
  them are on GitHub under the GPL-3.0.
- Report a problem from the game: the bug in the guide window, beside Skip,
  opens a report on the step on screen. Say what went wrong and Polestar
  writes the rest (the step and each goal's state and position, where you
  stand, your race, class and level, the versions and any errors it caught),
  sized to fit one Discord message, for you to copy and paste on the Polestar
  Discord (the game can't open links: "Get the invite" gives the invite once
  if you haven't joined yet). The guide window's menu and `/polestar report`
  open it too.
- The Polestar Discord is one click away: Discord's mark at the foot of the
  hub's and the settings' sidebars, and `/polestar discord`, give its invite
  to copy.

### For guide authors

- A pack reads as a pack in the game's AddOns list: its TOC title is
  "Polestar Pack: <title>", it sits under Polestar's entry next to
  Polestar's own addons, and without `notes` in `pack.json` its line is
  "Guide pack for Polestar by <author>". Polestar's menus show the title
  as written.
- docs/GUIDE_PACKS.md: what a pack is, the steps from `new` to publishing,
  what the tools require and what we ask of authors.
- `playtest` plays a step for a class none of the guide's races can be, and a
  guide with a `class` header, as the first race on the guide's side that can
  be that class: an `only Druid` step in a Horde guide is played as a Tauren.
- `play` and `dev --play` stop the Lua session and exit when it cannot start,
  instead of waiting on it; the page redraws on its own after a rebuild.
- `new` keeps the port of an http origin (`http://host:3000/...`) in the
  pack's workflow and dev container.
- `lint` reports a `|` in a second or later `pro` or `con` at that entry's own
  line, once for each entry that has one.
- `compile` no longer reads `data/forever/dungeons.json`: a quest only
  DungeonJournal knows gives its title and `lvl` in the guide, so nothing from
  DungeonJournal reaches a guide pack.
- `find` and `lint` number a quest's objectives as the game lists them in the
  quest log: creatures, objects, items, kill credits, then exploration, with
  QuestieDB's exceptions. `quest Q.O` in a guide written before 0.2.1 may
  point at another objective: check each against `find <quest>`.

### For contributors

- THIRD_PARTY.md, docs/RELEASING.md and the README say what a release holds
  from each data source: QuestieDB facts in the guides and the quest markers,
  credited; never the Codex or the zone crossings pack.
- Two more independent route searches (the fourth on the data 0.2.0 ships
  with) back the README's numbers and docs/SIMULATION.md; the charts compare
  the guides with those of 0.1.0.
- The README charts display again: an SVG's generated header no longer holds
  `--`, which XML comments forbid, and a test checks every committed SVG for
  it.
- docs/curseforge holds the CurseForge listing: the description to paste,
  the summary, the project settings and what to upload where. `readme
  brand` draws the project avatar and, with `rsvg-convert` installed, writes
  the listing's PNGs (avatar, banner, route charts) beside it.
- `preview` draws a multi-line edit box's text wrapped from the top, and the
  report window and the Discord invite are scenes of their own, held to the
  text-fit audit. THIRD_PARTY.md credits Discord's mark, the one piece of
  art Polestar ships that it did not draw.

## 0.2.0 (2026-10-14)

### For players

- Guide packs: guides written by other players load beside Polestar's own.
  A Guide packs page in Options (`/polestar packs`) shows each pack, turns it
  on or off and reports its problems.
- A centred welcome greets each new character by name, with the guide
  Polestar suggests; its Set up page appears only on the account's first
  character.
- The leveling guides of both factions are reworked: quests that block a solo
  player are dropped or made optional, rare drops are optional, flight paths
  and training come at the right levels, and Forever's own additions, fixed
  points and level tips are in.
- Class quests are in the leveling guides of both factions, at the start and
  level where each class gets them: Shaman totems, Warlock demons, Hunter
  pets and Beast Training, Paladin and Priest spells, Warrior stances, Druid
  forms and Rogue poisons.
- Each training stop in the leveling guides is for the classes whose trainer
  stands there, with stops of their own for Horde Druids (Thunder Bluff),
  Undead Paladins (Brill, the Undercity, Thunder Bluff), Alliance Shamans
  (Ironforge) and Alliance Druids (Stormwind, Darnassus), no Horde gap of more
  than about five levels, and riding at 40 from each race's own riding
  trainer. Alliance guides add training in Ironforge on the way out of Dun
  Morogh, and in Stormwind after Duskwood and on the way to Stranglethorn,
  drop it in Auberdine, which has no class trainer, and take every race to the
  Sentinel Hill flight path.
- Alliance 40-50 grinds less: Keeping Pace on the ride through the Shimmering
  Flats into Tanaris, and The Curse of the Tides, Pearl Diving and Return to
  Corporal Kaleb on one loop through northern Stranglethorn.
- Stranglethorn Vale and Un'Goro Crater, which were split into parts, are now
  one guide per stay in the zone. Inn names are the ones the game reports, so
  binding and hearthing check off; Northwatch Hold's step names its levels;
  and no travel step comes before goals that lead there themselves.
- Collectible, Legacy and reputation guides have clearer notes (warlock mount
  hand-offs, Merchant's Favor camps, Timbermaw and Cenarion Circle standings)
  and mark optional extras as such. Gathering loops in Mulgore and Redridge
  point at the nodes, and an exploration area the game names twice is listed
  once.
- The guide arrow knows every place a target spawns: the map marks the other
  places, fainter ("It also spawns here"), and a click on the arrow, the arrow
  button or a mark moves on to the next one.
- Quest markers cover every place a quest's mobs and objects spawn (before: at
  most 8 areas per mob per map), and a kill no longer redraws them all. Quest
  nameplate icons sit beside the health bar you see, on replacement
  nameplates as well as the game's own.
- Guide window: each tab shows its guide's level range; a narrow tab cuts the
  title, not the range.
- Windows fit their text in any font: a page's subtitle wraps to two lines
  inside the header, no text runs past a window's edge in the game font or in
  Inter, and the hub's search placeholder picks the first of its wordings
  that fits the box.
- Beta wording everywhere, and British spelling in the interface.
- The Recorder's command is `/psrec`, replacing `/lsrec`; `/polestarrec`
  still works.
- The README starts with a quick start for players, a download button and
  screenshots from the game.

### For guide authors

- Guide packs: write your own guides in a pack of your own, with `new` to
  start one from a template, `lint`, `playtest`, `dev` (rebuilds into the game
  on every save), `play` (the real addon in the browser), `compile`,
  `install` and `pack` (the release zip). See docs/PACKS.md.
- Lint checks the places of `sethome`, `hearth`, `fly` and `getfp`, and warns
  on a `goto` whose next goal is within 200 yards; route drafts no longer
  write one.
- `lint`, `compile`, `dev`, `play`, `install` and `pack` stop with one clear
  message when the reference data is missing.
- `dev` reports a deleted `pack.json`, keeps the last good build and builds
  again once it is back.
- `find` lists inns and flight points as guide lines.
- `sim compare` takes the pack folder as its argument, like the other pack
  commands.
- Docs: the guide format on one page (docs/GUIDE_CHEATSHEET.md), and what the
  `fly` check accepts.

### For contributors

- A second, independent route search checks the first; the README's numbers
  and charts show both.
- `version` sets `guides/pack.json` too, so the guides addon's TOC carries
  the release version after compile; docs/RELEASING.md separates private test
  builds from public releases.
- The UI renders in docs/preview show this release's windows and come out
  byte for byte the same from any checkout: textures go through a zlib
  encoder of the preview's own (Node's zlib gives different bytes from one
  Node to the next), quest markers are built in quest ID order (LuaJIT walked
  the quest log in another order and stacked overlapping markers
  differently), the test client's `date()` is UTC, `preview` refuses local
  inputs unless they render outside the repository, and the guide menu scenes
  load frozen copies of six compiled guides, so they change only with the UI,
  never with a guide recompile.
- CI runs `npm test` on pushes and pull requests, and fails when the committed
  textures differ from a fresh `media` build or the committed UI renders
  differ from fresh ones.
- `--help` prints a command's usage and never runs it; test helpers live in
  tests/helpers; one copy of each client helper in Core/Compat; every AddOns
  and WTF folder lookup goes through tools/lib/addons.js
  (`$WOW_FOREVER_ADDONS` first, then the detected clients); `.gitattributes`
  and `.editorconfig`.
- A docs map (docs/README.md), READMEs in the main folders, CONTRIBUTING.md
  and issue forms for wrong steps and bugs.
- The design system is docs/DESIGN.md, which now also says who the windows
  are for and what they must do (formerly PRODUCT.md and docs/UI_BRIEF.md).
- The tools share one copy of each foundation: the repository's folders
  (tools/lib/paths.js), the argument parser (tools/lib/cli.js), the XP rules
  (tools/lib/game/xp.js) and the races and classes with their mask bits
  (tools/lib/game/races.js).
- Fields the addon sets on game frames share one prefix, `ps`, explained in
  addon/README.md.

## 0.1.0 (2026-10-13)

The first public beta. One addon for the whole of WoW: Forever, with 164
guides: 63 leveling guides that take both factions from 1 to 60 from every
race's starting zone (Zephras Isle for the Skyborne included), the twelve
professions from 1 to 300, 17 reputations, 7 exploration guides, the Legacy
challenges and 64 collectible guides, one per mount and per pet. Around them:
a 3D waypoint arrow with a travel planner, quest markers on the map, an
upgrade indicator on item tooltips, a search for where any item, mount or pet
comes from, a dungeon quest journal, rare alerts and quality-of-life helpers.
The leveling routes come from a simulator that plays millions of complete
1-60 routes for each start and keeps the one that reaches 60 soonest under
its model.
