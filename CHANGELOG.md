# Changelog

## 0.2.6 (2026-10-19)

### For players

- On a quest's "Complete" line with no place of its own, the arrow no longer
  goes blank: it stays on the spot the step sent you to, or on the quest's
  giver, until the quest is done (#256).
- The arrow no longer jerks left and right at every little bend of a road: it
  looks up to 30 yards ahead along the path and only turns for corners that
  leave a 10 yard corridor, still turning at real corners and never past a
  floor change or a lift (thanks AURUM and Hotline from the Polestar Discord)
- Ashenvale: Alonso's Dragonslayer quests at Mystral Lake no longer hold a
  character he does not offer them to. Both guides lead everyone to him; take
  the quests if he offers them, else carry on (thanks Zerkness and Ioney;
  first fix by c0njure).
- Ashenvale (Alliance): Elemental Bracers counts the five Intact Elemental
  Bracers before the Divined Scroll, so the target button finds the Befouled
  Water Elementals (thanks Tazul, #391).
- Items in your bags that are an upgrade for your spec now carry the same
  green arrow as quest rewards, in the game's bags and in Baganator (Options,
  Questing, Rewards & gear: Upgrade arrows in bags). The tooltip already said
  so; now the bag shows it at a glance (thanks Leducia).
- Guide window: a new "Bar at the bottom" option puts the tabs and the step
  bar at the bottom edge when the window grows upward, next to where it is
  pinned, so they stay in one place as steps get longer. Off by default
  (thanks thmastin, and the player on Discord who asked for it, #386).
- The Barrens: the Savannah Lion Hide arrow stays in the Dry Hills, where the
  Sprung Traps of the same step are, instead of wandering off to the
  Matriarchs by Ratchet (thanks Fitz; fix by thmastin).
- With "Skip grey quests" on (Options), a guide opened on a character who
  already did part of the route catches up: the guide window goes over every
  step already done, faster and faster, while the arrow turns an hourglass
  over, and stops where you are. Green quests behind your progress that you
  have not taken are left out too, unless a later quest needs them. With no
  guide open, or from Start guide, a guide you are past hands over to the
  next one; the first time, the guides go by from your race's first one. A
  guide you open yourself stays open where you are. Item, mount, reputation,
  profession and class guides do every step.
- Chinese and Russian clients now translate missing transport-wait and option
  labels and the Library Books guide title (thanks HershelW).
- A dungeon's pick-up and hand-in guides route to a quest giver standing in
  a capital without walking you out of the city and back in. Argent Guard
  Manados, Mathiel and Varimathras are each recorded both in their city and
  on the zone map around it, and the page named the zone, so the journey
  planned its way out and back for an NPC a few yards away (thanks Visur,
  Rawbowke and Annie, #382, #368, #350).
- Names in Chinese or Korean (yours on the welcome page, other players') show
  in the game's font for that script instead of empty boxes when the game is
  set to another language (thanks Alx)
- After Polestar accepts or turns in a quest, the quest window the game opens
  next at that NPC (the next quest in the chain, or the NPC's other quests)
  closes by itself when the guide skips those quests, so it no longer looks as
  if something went wrong. A window you open yourself, or one with a quest the
  guide wants, stays open; hold Shift to keep it, or turn it off in Options,
  Guide, Automation ("Close offers the guide skips") (thanks AurumTitanos).
- Darkshore: The Blackwood Corrupted fills the Empty Cleansing Bowl at the
  Auberdine Moonwell, then gathers the Blackwood Nut, Fruit and Grain Samples
  at the northern Blackwood camp and uses the bowl by the bonfire to summon
  Xabraxxis, so the Talisman of Corruption can be had; the guide used to send
  you to the Demon Bag with nothing to summon him (#302, thanks XooVe).
- When your ghost starts at a graveyard in another zone, the arrow now leads
  to your corpse in the zone it lies in, instead of routing you through the
  graveyard's zone (thanks Gets, #270).
- Dun Morogh from Coldridge Valley to Brewnall Village follows recorded runs
  on Forever: Sten's, Balir's and the class letter before going into Anvilmar
  once, Bring Back the Mug before Felix, Kharanos done outside first with
  class training last in the distillery, Camping 101: Cooking and its lesson
  on the return with the ribs, when the copper is there for it, Rumbleshot's
  Ammo beside Beldin and looted by Gretchen's camp before the walk back,
  Gretchen first and one trip through the Grizzled Den, Frosthowl from Gretta
  on the dock first, Brewnall's quests before Frostmane Hold so the bears,
  boars and leopards on the way count for Rejold, and the arrow at the mouths
  of the Grizzled Den and Frostmane Hold before the caves.
- Dun Morogh from Brewnall Village to the tram follows a recorded run on
  Forever: The Reports taken from Senir and handed to Senator Barin Redstone
  on the way to the tram, Evershine's and Rime's Wrath's kills counted on the
  way, with Rime's Wrath finished at the small lake west of the refuge,
  Rejold's New Brew dropped as Shimmer Stout closes it, Farsen's and Mehr's
  quests taken on the walk east to the South Gate, a tip for slipping past
  Old Icebeard, and for Paladins the stairs to Tiza and Muiredon and a flight
  back to Ironforge from Thelsamar with Honor Students.
- Dungeons: a chip beside a dungeon's name says how far its quests take you,
  or the level recommended for its quests; hovering it shows the XP, a bar of the
  levels it spans and which quests were counted (thanks mcclaskiem).
- 18 dungeon quests count the XP Forever gives, not the old Classic amount:
  Wailing Caverns (Deviate Hides 3,100, Trouble at the Docks, Smart Drinks,
  Deviate Eradication and three more), Shadowfang Keep, The Stockade and
  Gnomeregan, each checked against the game after the 1 October change to
  dungeon quest XP (thanks MgM and mcclaskiem, #394).
- Dungeons: "Pick up the quests" no longer sends you to a lead-in quest
  (Klockmort's Essentials, Castpipe's Task and the other breadcrumbs on the
  dungeon pages) once you have turned in the quest it leads to or have it in
  your log, since the giver no longer offers it. The Hillsbrad Foothills guide
  likewise skips An Alarming Request once Heart of Disruption is taken (thanks
  Rawbowke).
- Durotar: at Tiragarde Keep, a player who already took The Admiral's Orders
  is no longer sent to kill Lieutenant Benedict again for his key; the step
  lets go once the quest is in the log (thanks defect).
- Durotar: Encroachment (the Razormane quilboar) is now taken after Tiragarde
  Keep and the Sen'jin and Echo Isles loop and done on the way to Fizzle
  Darkstorm, at about level 11 instead of 7 (thanks tor).
- Durotar: the arrow for the Raider's Bow (For Honor) leads to where the bow
  lies at Tiragarde Keep, not 120 yards south-west of it (thanks Lyngtoft).
- Durotar: Rezlak and Thunder Ridge, Securing the Lines among them, come
  after Sen'jin, the Echo Isles and Kolkar Crag, on the way to Fizzle
  Darkstorm on the same ridge, so a level 11 quest is no longer handed out at
  8 while the south's level 8 quests wait until 11 (thanks tor, #352).
- Guide window: with Match EllesmereUI font on, the step's name, its place and
  the Then: line are no longer blank after logging in; a reload was needed to
  show them (thanks thmastin, #448).
- Elwynn Forest: An Enticing Offer counts the Duskweed Petals and the Vials of
  Animal Blood on their own lines, no longer each other's (thanks Bashidian
  Twotao).
- Escort quests say so in the guide window: under the quest's accept, and then
  under the goal to complete it, a line reads "Escort: if the NPC is not
  there, wait for it to respawn", so an empty spot means someone else is on
  the escort, not a wrong place. It covers the 39 escorts the guides route
  (thanks Gray).
- A flight or hearth you landed stays done when you walk out of the town you
  landed in, or through Rut'theran Village's portal into Darnassus, and across
  a reload, so the arrow no longer sends you back to the flight master while
  the rest of the step is open (thanks AurumTitanos).
- Flight map: the destination the guide flies to is easier to spot. A bobbing
  arrow points at the node with its name above it, and a ring on the node
  sends out a slow ripple, each with a dark rim so the gold reads on the
  parchment. With Reduce motion on, the mark stands still.
- A follow-up is taken from the giver you just handed its quest to, before the
  guide sends you to someone else and back: Skirmish at Echo Ridge, Report to
  Goldshire and The Adventurer from Marshal McBride in Northshire (#310),
  Coldridge Valley Mail Delivery from Sten Stoutarm and Bring Back the Mug
  from Durnan Furcutter in Coldridge Valley, The Red Messenger from Executor
  Arren in Deathknell, At War With The Scarlet Crusade from Executor Zygand in
  Brill, Reagents for Reclaimers Inc. at Nijel's Point and Further Mysteries
  from Prospector Stormpike in Ironforge. Paladins hand Continue Your Training
  to Shari Stilwell when they train in Brill (thanks Zepheriel).
- WoW Forever skin: the guide window's active tab is lit like the selected row
  in the game's Settings, instead of a lone line where the tab's outline ran
  into the window's edge (thanks Smuve and imp)
- WoW Forever skin: guide window bronze border no longer has an inner glow
  over the content; progress bar fill now visible; hover art no longer blanks
  button icons (thanks imp and Fitz's testing)
- The WoW Forever skin is hidden for now while we fix its border and progress
  bar; players who chose it see the default skin until it returns.
- German: the newest strings and the Recorder read in natural German, reviewed
  by a German player, with the German client's names for the Paladin talents
  and the Blackrock dungeons (thanks thecodingcortex).
- Getting a flight path now points the arrow at the flight master: "get the
  flight path" steps that named only their town, such as Ratchet in the Orc
  and Troll Barrens guide, Sentinel Hill, Auberdine or Lakeshire, now lead to
  the flight master of your faction there (thanks defect). One Moonglade step
  in the druids' Bear Form guide, with a flight master per faction, still has
  no arrow.
- Lookup: Nat's Measuring Tape (Zul'Gurub) starts at the Battered Tackle Box,
  not from the tape itself, and Dokimi and Marcy Baker both give A Sealed
  Crate (91901), as they already did the other crate quests.
- Guide menu: a leveling guide's details say how far it takes you from your
  level, counting its quests and an estimate of the kills it asks for; below
  the guide's level the chip shows its recommended level. Hovering the
  chip shows the XP, a bar of the levels it spans and what was counted, in
  your chosen font, skin and colours (thanks mcclaskiem).
- With Shortest Path Forever guiding, Polestar no longer draws its own line to
  a target on the same continent on the map and minimap, so only one route
  shows (thanks Rawbowke, #398).
- The guide window can hide in dungeons and raids and come back when you leave
  (Options, Guide, Window, In dungeons; off by default). /polestar, the key
  binding or the minimap button still opens it there until you leave (thanks
  InfinityYoel).
- Import strings: hardened against fill blow-up, route-planner blow-up, direct
  turn-in abuse, control characters, bad frames and coordinates; added
  /polestar import clear and /polestar import delete.
- Import strings: a small guide someone shares as one line of text (a quest
  chain, an item, a mount, an errand) now goes in without installing anything.
  Paste it on the new Import page, at the foot of the hub's left rail above
  Options (/polestar import): Polestar shows what the guide is before saving
  it, says why when it refuses a string, offers Update for a newer version and
  keeps your progress, and lists your imported guides with Delete. They appear
  in the guide menu under Community guides, Imported, credited to their
  author, and are never suggested on their own. Strings are read as data only.
  (#261, thanks Yendi)
- New option, Quality of Life > Travel > Hearthstone: "Set your home at the
  guide's inn". When the step sets your home and you talk to the innkeeper it
  names, Polestar picks the bind option and confirms it; never at another inn.
  Off by default; hold Shift to skip it once (thanks CDVolvik)
- A quest that starts from an item no longer holds its step once you have
  taken it: accepting uses the item up, so a player who met Ursangous
  (Ashenvale, Horde) before the guide got there was told to kill him again for
  a paw already used (thanks Bill, #309).
- Hillsbrad Foothills (Alliance) and Azshara (Horde): Greater Friend of the
  Library and The Apothecary's Metaphysical Primer are optional, as the
  librarian offers them only for library books, which the leveling route does
  not collect (thanks b7216309-jpg, #307).
- Lock arrow and buttons (Options, Guide, Window; off by default): a stray
  drag no longer moves the arrow, the quest item, target and Hearthstone
  buttons or the flight and instance timers. Shift-drag still moves them
  (thanks Severd8 and fur).
- Guides played before level 40 no longer tell you to ride somewhere before
  you can have a mount: their tips say head, walk or fly instead (riding a
  boat, zeppelin, tram or lift is unchanged) (thanks Pynte).
- An option under Questing > Buttons, Mark what they target, off by default:
  the target button and the step key put a raid icon on the mob and the NPC
  they target, a skull and a star unless you pick others, and leave an icon
  alone that is already there. Either can be "A new one each press", so the
  last few NPCs keep theirs. Out of combat, a press that finds neither clears
  your target, so nothing else gets the icon. Your party sees the icons; in a raid only the
  leader and assistants can set them (thanks Turesh and Petllama).
- New Miscellaneous category in the guide menu, for side chains that fit
  nowhere else. Its first guide is the Cozy Sleeping Bag: the six hidden notes
  from Westfall or the Barrens through Stonetalon, Loch Modan and Thoradin's
  Wall, with the 12-slot Old Toolbox on the way (level 14 and up, both
  factions).
- Miscellaneous: a Library Books guide. It visits every lost book your faction
  can find (27 for the Alliance, 25 for the Horde), from Elwynn and Westfall
  to Tanaris and the Blasted Lands, then hands them in one by one to Garion
  Wendell in Stormwind or Owen Thadd in the Undercity, with the Friend of the
  Library rewards when they are offered. The Mo'grosh ogres guarding Runes of
  the Sorcerer-Kings are marked as elite (thanks b7216309-jpg, #307).
- Nameplate icons show your progress beside the quest icon: "3/10" over a
  Kobold Vermin you still have to kill, "3/10 · 1/8" when the mob counts for
  two quests (killed for one, dropping an item for the other). The count
  moves as you kill or loot, a finished objective drops out, and the icon
  and its count go once the mob is no longer needed. A one-kill or one-item
  objective keeps the icon alone. It comes with the Nameplate icons option
  (Questing → Quests, off by default).
- Walking routes now go into Brill's town hall through its side door to
  Magistrate Sevren, instead of stopping outside the wall, and a walk from
  inside the hall no longer leads you out first (thanks Onrevax).
- The guide window's header has a Nearby services button, between Skip and
  the menu: it lists the vendor, repair, innkeeper, flight master, class
  trainer, a trainer for each of your professions, a weapon master (pick
  the weapon to learn: the ones your class can use, those you already have
  and polearms before level 20 said and off), reagents, bank, auction
  house and stable master, and a click points the arrow at the nearest one,
  as `/polestar near` does. Once you get there, the arrow is back on the
  guide's step; on the way, a banner in the guide window and the top of the
  button's list offer Back to the guide. Off in combat; Options, Guide,
  Arrow & routes hides it.
- About 80 kill and collect steps that did not say how many you need now do
  ("Collect 10 ..."), and their farming time counts that many.
- A kill or collect goal counts and ticks the objective it names, even when
  the game lists the quest's objectives in another order than the guide: in
  Slimy Menace, killing Murlocs no longer counts up the Murloc Streamrunner
  line, and An Enticing Offer's Duskweed Petals no longer show the Vials of
  Animal Blood's count (#223, #279, #335, #410, thanks Syfin, Bashidian Twotao,
  poundofhash and zeike). Party members' counts follow too.
- On OpenMap's seamless world map, the trail dots carry on across zone borders
  and show on the whole-world view, and OpenMap's menu has a Polestar trail
  dots switch.
- Options > Questing > Buttons has a Target name position setting: the target
  button's name can sit to the right of the button (as before), to the left,
  above or below (thanks @inversedad, #330).
- The Wailing Caverns pick-up page sends you to Nalpak for Deviate Hides
  instead of a mailbox in Orgrimmar, and Poor Old Blanchy no longer lists a
  Stormwind mailbox as a giver. 124 quests now start and end where Forever's
  quest data says, without the extra or wrong givers our data had (thanks MgM,
  and mcclaskiem for spotting Questie shows the same mailbox).
- The target button and the step key work on a step where an NPC hands you the
  item: the three Patience reports in Tirisfal Glades target Deathguard
  Dillinger, Deathguard Kristof and Gordo, and the Warsong updates in
  Ashenvale the scout, runner and outrider who give them (thanks Onrevax;
  fix by XrayAlpha, #337).
- Portuguese (Brazil): the Spirit Healer, your corpse, Release Spirit,
  summons, raid lockouts, World drop and Shift-click read as the Brazilian
  client writes them (Anjo da Cura, cadáver, Libertar, evocação, vínculos,
  Espólio do Mundo, Shift+clique).
- Portuguese (Brazil): a setting that is on or off reads ativado or
  desativado, as in the client's own options, in Polestar and the Recorder.
- Alchemy, Enchanting, Engineering, Leatherworking and Tailoring: a recipe a
  vendor sells in limited stock no longer sends you to the Auction House when
  it binds when picked up on Forever, as Recipe: Holy Protection Potion does
  (thanks Conjure).
- Quest objective markers: mobs to kill or loot now show the game's skull
  icon; items picked up from objects or the ground show the gear icon.
  Nameplate quest icons also use the skull and no longer show a duplicate
  progress count beside the icon (thanks Fitz).
- Questie captions: a planned turn-in caption that Questie's tracker skipped
  because it had just redrawn is drawn again a moment later, once, and still
  waits for the end of combat (thanks AurumTitanos)
- A Rare button comes up under the Target button when Polestar spots a rare
  nearby, and targets it by name (several rares: each click moves to the
  next). It goes when the rare dies or is out of sight. Options > Questing >
  Buttons > Rare button turns it off, and it is bindable under Key Bindings >
  AddOns (thanks Tazul, #333).
- Redridge Mountains: the Battleworn Axes are collected in the Blackrock
  camps at the south end of Galardell Valley, east of Stonewatch Keep, about
  forty orcs with no elites among them, instead of the handful east of
  Alther's Mill (thanks Tazul | Robin).
- Redridge Mountains: the arrow for the Battleworn Axes (Blackrock Menace)
  leads to the Blackrock orcs on the east side of Alther's Mill, not into the
  tarantulas 70 yards west of them (thanks Tazul). The same slip is fixed for
  the Spool of Light Chartreuse Silk Thread in Stormwind (Duskwood guide) and
  Broodmother Valraxx's Bloody Parchment at Gloomrise (Horde Ashenvale guide).
- Redridge Mountains: Iron Pike and Iron Rivet lead to the Redridge Brutes and
  the other gnolls in the northern hills that drop them, not to the Mongrels'
  camp where the rare Ribchaser stands, and the Dire Condor and Great Goretusk
  goals after them follow from there (thanks Avtom).
- Redridge Mountains: Making Do is optional at the Stormwind stop. Baros
  Alexston offers it only to players who brought him Expanding Horizons from
  Darkshore, so nobody else is held there or at its Auberdine turn-in
  (thanks Nittepitte).
- The report window shows how to report in the Polestar Discord: "Copy
  report", then post it in #bugs, where a bot files it for the developers
  and tells you in your thread when it's fixed. "Get the invite" is there if
  you're not in the Discord yet. The report now lists your other addons too,
  and waits until you say what went wrong.
  Have a GitHub account? "Open on GitHub" gives a link that opens a new
  issue with your report, its title, your Polestar version and your other
  addons already filled in.
- "Mark the right spot" in the report window: walk to where the step should
  have sent you and press Mark here, and the spot goes in your report, at
  the top where it is seen first, and in the GitHub issue's "The right spot"
  field. Your report is kept while you walk, and "Clear mark" takes the
  spot back out.
- Death helper: resurrection sickness is the ten minutes Forever gives from
  level 11, or the length the game last gave you at your level, so it no
  longer sends you to the Spirit Healer when running back is quicker (thanks
  Gee)
- On a Russian client the separators between fields no longer show as empty
  boxes: Polestar uses Fira Sans there instead of the game font, which has no
  middle dot. If you pick "the game's" font in Options, you still get it.
  Thanks to XooVe (#296).
- Spanish (Spain): Skip, Reload UI, Hardcore and Companion read as the Spanish
  client writes them (Saltar, Reiniciar IU, Hardcore, Mascota).
- Spanish (Spain): guide tips that tell you to skip a step say Sáltate, the
  same verb as the Skip button.
- Route lines can sparkle: the gear beside Route lines (Options, Guide, Arrow
  & routes) picks dots or loot-gold sparkles that drift toward the goal on the
  minimap and world map, OpenMap's too, with intensity, density, subtlety,
  size, flow, colour and presets.
- With Shortest Path Forever installed and TomTom not, the arrow and pins no
  longer flicker and the game no longer slows down: Polestar stopped putting
  its waypoint into Shortest Path Forever's TomTom stand-in, which started a
  journey Polestar then stepped aside for, over and over (#306, thanks imp).
- Stonetalon Mountains & Ashenvale (Horde): the Kadrak step waits until a
  Warsong Report is in your bags, so you open the Bundle of Reports before
  setting off: the Warsong Scout, Runner and Outrider each give their update
  for one (thanks Hotline, and PRDesrochers for the idea).
- Talent plans keep only your own class's plans once loaded, so the other
  classes' plans take up no memory while you play (thanks jnickles85-bit).
- Talent plans for Druids: Balance, Feral Combat and Restoration, from level
  10 to 60, following ForeverDB's leveling builds to level 30 and checked
  against Forever's tree (thanks jnickles85-bit).
- Talent plans for Hunters: Beast Mastery, Marksmanship and Survival, from
  level 10 to 60. Beast Mastery and Marksmanship follow ForeverDB's builds to
  level 20; after that, and for Survival throughout, they are written for
  Polestar on Forever's tree, built around its new talents (Careful Aim,
  Sniper Shot, Lacerating Strikes) and checked against it. Every class now has
  talent plans (thanks jnickles85-bit).
- Talent plans for Mages: Arcane, Fire and Frost, from level 10 to 60.
  ForeverDB has no Mage builds yet, so these are written for Polestar on
  Forever's tree, built around its changed talents and checked against it
  (thanks jnickles85-bit).
- Talent plans for Priests: Discipline, Holy and Shadow, from level 10 to 60.
  ForeverDB has no Priest builds yet, so these are written for Polestar on
  Forever's tree, built around its new talents (Penance, Mind Flay's upgrade,
  Prayer of Mending) and checked against it (thanks jnickles85-bit).
- Talent plans for Rogues: Assassination, Combat and Subtlety, each an ordered
  list of picks from level 10 to 60 with short notes, the same marks on the
  talent frame as the Paladin plans, and nothing spent for you. Picks are
  adapted from ForeverDB's leveling builds to level 30 and checked against
  Forever's own talent trees (thanks jnickles85-bit).
- Talent plans for Shamans: Elemental, Enhancement and Restoration, from level
  10 to 60. ForeverDB has no Shaman builds yet, so these are written for
  Polestar on Forever's tree, built around its new talents (Mental Dexterity,
  Maelstrom Weapon, Lava Burst) and checked against it (thanks
  jnickles85-bit).
- Talent plans for Warlocks: Affliction, Demonology and Destruction, from
  level 10 to 60, following ForeverDB's leveling builds to level 30 and
  checked against Forever's tree (thanks jnickles85-bit).
- Talent plans for Warriors: Arms, Fury and Protection, each an ordered list
  of picks from level 10 to 60 with short notes, the same marks on the talent
  frame as the Paladin plans, and nothing spent for you. Picks are adapted
  from ForeverDB's leveling builds to level 30 and checked against Forever's
  own talent trees (thanks jnickles85-bit).
- The target button and the step key pass over corpses: a dead mob nearer
  than a living one no longer stays selected, and the next name is tried
  instead. Out of combat a press starts from nothing, so whatever you had
  selected -- a quest giver, a mob you clicked -- no longer stops it; in a
  fight your target is left alone, so your swings are not cut
  (thanks AurumTitanos, #355).
- The target button names the creatures the arrow leads to for a `collect`
  goal, rather than the item's best droppers anywhere in the world:
  collecting Small Spider Leg in Teldrassil offered Mother Fang, two Loch
  Modan lurkers and two Silverpine spiders, and never the Webwood Lurkers
  the guide sends you to (thanks AurumTitanos, #356).
- Teldrassil: the arrow now leads to the real mouths of Fel Rock and the
  Shadowthread Cave, not into the hillside beside them (thanks Pynte).
- Teldrassil: Escaping Ban'ethil is taken once the relics and The Sleeping
  Druid's chain are done, so Lynessa no longer sets off before the rest of
  Ban'ethil Barrow Den (thanks Pynte, #334).
- Teldrassil: Flight to Auberdine now takes Vesprystus' free flight to
  Auberdine instead of the boat, learns the Auberdine flight path on landing,
  and adds Return to Nessa (1050 XP) on a short flight back to Rut'theran
  (Druids hand it in on their Bear Form trip) (thanks Pynte).
- Fixed a lift detour when walking to the nearby Thunder Bluff flight master
  (thanks risco).
- Timberling Seeds leads to the Timberlings round Denalan, not the Elder
  Timberlings across Teldrassil: a collect no longer follows mobs 3 or more
  levels above its quest that drop the item more often when mobs near the
  quest's level drop it too. The same moves Bloodpetal Poison's Gorishi Stings
  off the Hive Queen onto the Gorishi round the hive, adds the rest of
  Hillsbrad's townsfolk to Souvenirs of Death, and keeps three Green Hills
  pages at the Venture Co. camp you are already in instead of sending you
  after Lord Sakrasis and Garr Salthoof. Pirate Hats Ahoy! counts every
  Southsea pirate instead of the Southsea Kidnapper, who does not drop the
  hats (thanks Pynte, #327; diagnosis and tests by XrayAlpha).
- The Argent Emissary now points to Deathguard Terrence's correct location
  (thanks Pledge-Resupply).
- Tirisfal Glades: every class takes its class letter from Sarvis together
  with Rattling the Rattlecages, so Warlocks no longer miss Tainted Scroll and
  Piercing the Veil. A Warlock's Rattlecage Skulls now show in the Rattlecage
  step. A Light in the Darkness is taken from Aramis once The Damned is handed
  in, and no longer holds the guide at him before then (thanks an3vilmonk3y
  and Onrevax).
- Tirisfal Glades: back in Brill for The Chill of Death, the guide sends you
  to Abigail Shiel for the Coarse Thread first if you have none, instead of
  straight to Gretchen Dedmar (thanks Onrevax).
- Tirisfal Glades: Paladins take As Above, So Below and The One That Got
  Away after handing A Righteous Cause to Leonid, when they are level 10 and
  Hilda and Ephram offer them, instead of on an earlier visit where they
  don't (thanks MadReign_Ltd).
- Tirisfal Glades (Paladins): Rediscovering the Light now has a step to heal
  five Injured Deathguard around the church with Holy Light, instead of going
  straight to the turn-in (thanks Hotline, #408).
- Tirisfal Glades: That Shadowvale Green Elixir, and the Paladins' bones and
  crystal, lead to the way down into the basement under Shadowvale's ruined
  house first, and the tips say the bottles, Lurchers and Mystics are down
  there, not on the ground above (thanks Onrevax).
- Showing item source tooltips no longer causes a hitch (#346, #354, thanks
  Stout and poundofhash).
- Translations: German, Latin American Spanish, Spanish, French, Korean,
  Brazilian Portuguese, Russian, Simplified Chinese and Traditional Chinese
  now have the Along the way label, the hearthstone bind and quest-window
  close options, talent plan descriptions for all classes, and the updated
  Elwynn Forest and Westfall guide tips. AI-generated; a review by native
  speakers is welcome.
- Boats, zeppelins, the tram and lifts nobody has timed yet show their average
  wait ("Boat: average wait 2:14", "average wait 2:14 · ride 1:08" in the
  journey) instead of a "Next boat in about 2:14" that looked like a countdown
  stuck in place; "Next boat in" and "leaves in" now only count down a
  departure Polestar has timed (#364, thanks AurumTitanos)
- "Up next" on a finished guide names where Polestar would go on: the route
  you chose or the only one that fits you, instead of always the guide's first
  option.
- Walks between Duskwood and Westfall or Elwynn Forest no longer go round by a
  far road crossing: from Sven's camp the route swims the river to Sentinel
  Hill instead of using your Hearthstone, and walks from Eastvale to Darkshire
  cross straight into Duskwood instead of going round through Redridge
  Mountains (#371, #421, thanks Ioney).
- The walk to the Deeprun Tram ends at the tram's entrance instead of on the
  roof above it, and the walks to the zeppelin towers at Orgrimmar and
  Grom'gol end on top of the tower instead of at its foot (thanks Tazul).
- Walks inside the Undercity reach the Royal Quarter (Varimathras, Sylvanas,
  Sharlindra) through the city instead of climbing out to the ruins and ending
  in a straight line (thanks Annie).
- Horde Warlock incubus: Hearts of the Lovers tracks Avelina's Heart and
  Isaac's Heart on their own lines, so the guide no longer skips the Ratchet
  step once you have the Silverpine heart (thanks Phyz).
- Westfall: the Gnoll Paws arrow now leads to the level 11-13 gnolls in the
  northern hills instead of searching every gnoll camp down to the level
  16-19 ones in the south. Quest drops elsewhere that also come from
  higher-level mobs now point at the low ones the step means: Westfall's
  north coast murlocs, Darkshore's crawlers and threshers below Auberdine,
  the Barrens' plainstriders by the Crossroads, Silverpine's worgs and
  murlocs by the Yoricks' house, and Hillsbrad's bears and lions west of
  Tarren Mill (thanks Bashidian Twotao).
- Westfall: the Molsen Farm step no longer waits for a Precessive
  Autocognition Assembly. It drops about once in 900 kills, so Harvesting the
  Harvesters is optional: take it if one drops, and hand it in to Ozwin at
  Saldean's Farm (thanks Smuve).
- Westfall: you now take the Furlbrows' and Saldeans' quests and Report to
  Gryan Stoutmantle on the walk in from Elwynn, then reach Sentinel Hill with
  them, instead of going to the hill first and back north. Elwynn ends at
  Deputy Rainer on the Westfall road (thanks Pynte).
- The game's XP bar now marks the level the guide wants you to reach before it
  moves on: a small tick at the end of the bar with "Guide: 12", or "Guide: 14
  (4 levels)" when it is further away (Options, Quality of Life, Trackers:
  Guide level on the XP bar) (thanks CDVolvik).
- The XP tracker tooltip no longer shows a quests-to-level count: the figure
  divided remaining XP by the average of the last ten quests this session, so
  one or two quests in it was rarely meaningful (thanks MgM).
- Zephras Isle (Horde): The Broken Construct now sends you for the Enchanted
  Gyrozephyr, south-west of Windsong Lake, before you hand it in to Riaani
  (thanks 𝔄𝔫𝔫𝔦𝔢).
- Zephras Isle: at the start you climb the watchtower first for The Anchors of
  Zephras and Falling With Style, then glide down with Walk on Air and hand
  Harmony in Balance and Falling With Style to Rorian on one visit (thanks
  Alx-Ryan).
- Zephras Isle (Alliance): The Wounds of Betrayal now has an arrow into the
  Nightfang Den, to the injured druids and Jorel Windsinger, and Standing Our
  Ground points at Aamelia and Ferauu the Bludgeon (thanks Phear).
- On Zephras Isle, "Train" steps and the class training reminder send you to
  the nearest trainer of your class, in Shen'dar or Valanaar too, not always
  back to the starting village: the isle's other trainers, and its other
  vendors and innkeepers for "nearest" steps, were left out (#299, #281, #367,
  thanks MrBackus, Phear and Feverish). On the isle, the Galestrider mount
  guides and the other maps Forever added, the shaded spawn areas and quest
  markers now cover the whole camp: they were measured as if the map were half
  its size, so they were drawn too small and far-apart camps ran together.

### For guide authors

- `category Miscellaneous` is a documented guide category.
- `collect <item> npc <id>` names the NPC who hands an item over, for an item
  nothing drops and no data links to anyone, so the target button has someone
  to target (docs/GUIDE_FORMAT.md, `collect`; thanks XrayAlpha, #337).
- On the maps Forever added (Zephras Isle, Riverglades, Mount Hyjal,
  Shen'dralas), route drafts measure distances in the map's own yards instead
  of a 1000-yard square, and `collect <item> xN nearest` finds farm spots on
  Riverglades, Mount Hyjal and Shen'dralas as contested zones, clustered in
  their own yards (#422).
- Guides: a `loop` line in a step makes its `goto` points the places to
  search, in order, for the step's kill, collect and interact goals, instead
  of a path to walk (docs/GUIDE_FORMAT.md, "Spawn areas"). (thanks petllama,
  #455; after #46)
- polestar export <file.guide> prints one guide of your pack as an import
  string, after linting it: one guide of at most 60 steps, with your pack's
  licence; the guide's version decides Import or Update in game. The
  playground's Copy import string gives the same. docs/GUIDE_PACKS.md, "Import
  strings", and docs/PACK_FORMAT.md describe it; LICENSE-EXCEPTION.md now
  covers strings too. (#261, thanks Yendi)
- A `level` goal can stop inside a level: `level 12.5` is halfway through
  level 12 and `level 12+2500` is 2500 XP into it (to whole percent). The
  guide window reads "Reach level 12 (50%)" and the goal is done once the XP
  bar gets there. `when level` takes the same form (`when level<12.5`). A pack
  using either needs Polestar 0.2.6 (pack format 4) (thanks petllama, #455;
  after #45).
- Lint warns on a turn-in whose quest needs an item (a drop, an object, a
  vendor buy) that no earlier goal gets, and on a `complete` with no place of
  its own on a quest whose objectives have places, where the arrow has nowhere
  to point (#424).
- A guide can hand over depending on the character: `next <id> when
  <predicate>` offers that guide only while the predicate (any of a step's
  `when` predicates) holds when the guide ends, and `next` lines now add up.
  An option whose condition fails is left out of "Choose your path", the guide
  menu's "Next" line and `/polestar path`; with one option left Polestar goes
  on to it without asking, with none the guide ends there. A pack using it is
  written in pack format 4 (GUIDE_FORMAT.md, "Conditional hand-offs") (thanks
  petllama, #455; after #44).
- A step can be done along the way: `along` lets the route go straight on, and
  its goals ("kill 8 boars", "collect 5 candles") stay listed under the
  current step, "Along the way" in the guide window, until they are done, or
  with `along until <label>` until the route reaches the step carrying `label
  <label>`. Clicking one points the arrow at it. A pack using `along` or
  `label` is written in pack format 4, which needs Polestar 0.2.6
  (GUIDE_FORMAT.md, "Along the way"; thanks petllama, #455, after #42).
- A step can show a picture under its tip with the new `image <path>
  [<w>x<h>]` line, for a spot that is hard to find such as a cave mouth: a
  .tga or .blp file in the pack folder, copied into the addon by `compile`
  (thanks CDVolvik).
- A step can depend on the character's state when the route reaches it: `when
  level<6`, `when onquest 788`, `when !has 159 x5`, `when zone "Durotar"` and
  more (GUIDE_FORMAT.md, "Conditions checked during play"). Once the route has
  passed the step the outcome stays; a step passed because its condition
  failed counts as skipped, so the player can unskip it. A `when onquest`
  step can hand in a quest picked up elsewhere. A pack using `when` is written
  in pack format 4, which needs Polestar 0.2.6 (thanks jfuglas, #376; the
  login and hand-in guards after petllama's #47).

### For contributors

- The pull request template now asks AI-assisted contributors to name the
  exact model and version and the tool they used; the review rubric notes
  that work from smaller or unnamed models is re-verified before merge.
- Closing a Discord report as a duplicate now tells the reporter where the
  earlier issue stands (fixed, released, not planned, or still open, with any
  fix in progress) and quotes the maintainer's explanation, also when it was
  closed as not planned with a "Duplicate of #M" comment. When a release ships
  the earlier issue's fix, the duplicate's thread hears it too, once. The
  triage skill closes duplicates with gh issue close --duplicate-of and labels
  not-planned closes with their resolution.
- The Discord bug bot reads Chinese reports: their full-width colons and
  brackets no longer lose the guide, step, client build and place from the
  issue, or leave the bold lead-in in the title.
- The bug bot copies every player's message in a tracked #bugs thread to its
  issue, not only the reporter's: another player's confirmation, fix or
  screenshot is context for whoever triages it. The reporter's comments say
  "(the reporter)", and the bot's "Tracked as" reply says that replies in the
  thread go to the issue.
- English-on-screen checks recognize exact author-credit names while
  continuing to check their label and surrounding prose, recognize the
  Baganator product name, and retire a stale Chinese NPC baseline entry
  (thanks HershelW).
- CI no longer cancels a run on next, main or a hotfix branch when another
  merge lands, so every merge commit gets a test result; a pull request's
  newer push still replaces its older run.
- Small changes are small: edit the source, run its tests, open a PR; the
  maintainers regenerate compiled files.
- `data build` no longer hangs when a quest XP site stops answering: each
  lookup gives up after 30 seconds and is listed as a warning, and the next
  build retries it.
- The guide pack's memory test loads the pack by its TOC, like the other pack
  tests, so a file added to the pack is measured; chainNeeds names a goal's
  pre and preAll instead of walking a table literal per accept of every guide
  down the chain.
- Contributing is lighter: run the tests for what you changed; CI runs the
  rest.
- On Windows, whole numbers above 2^31 (step hashes, for one) come through
  intact from Lua 5.1 in the tools, the test client and the playtest driver:
  Lua 5.1 there formats `%d` through a 32-bit long. A pack update test and the
  Ashenvale walk test failed on Windows because of it, and a playtest after a
  guide recompile could lose its check-offs.
- `data build` works with LuaJIT, the Lua the setup steps suggest on Windows
  and macOS: LuaJIT allows one function 65536 constants, fewer than pfQuest's
  `db/units.lua` holds, and the loader now splits such a file so it loads.
  When a file still cannot load, the error says to set `LUA` to a Lua 5.1
  interpreter, as it does for a file the split would cut inside a long
  string (thanks b7216309-jpg for that guard).
- Buying for buy goals reads the merchant's goods through
  `C_MerchantFrame.GetItemInfo` where the client has it, with
  `GetMerchantItemInfo` as the fallback. Forever has both today, but the old
  call is missing from the client's API lists and was the one client call
  Polestar made without a check (thanks RamosJoaquim, who found it while
  testing Polestar on another client, #153).
- Every pull request now goes to next, guide fixes included. A fix players
  need in the coming patch gets the backport label after it merges, and its
  patch pull request opens on its own; the Base branch check turns away other
  pull requests into a hotfix branch.
- `data build` fills the quest objective counts QuestieDB and pfQuest lack
  from CMaNGOS classic-db quest_template (cached as quest_counts.json beside
  the dump), so about 1,100 more quests have every count known.
- Performance checks account for the Lua clock's measured resolution, capped at one millisecond, and use a longer calibration sample so whole-millisecond Windows clocks do not falsely reject sub-millisecond frames.
- Every issue now shows which pull requests are fixing it: one comment, kept
  up to date, and the label has-pr (fix-merged once a fix is merged and waits
  for its release). A pull request whose issue already has another open one
  gets the label overlap and a comment naming it. A Discord reporter is told
  in their thread when the first fix for their report opens, and is asked the
  maintainer's question there when the issue is labelled needs-info.
  CONTRIBUTING.md has a new section, "Before you start", and the agent skills
  check for open pull requests before starting a fix.
- The quest-giver sweep from Forever's quest data keeps the NPCs that data
  leaves out on shared or multi-trainer quests: Veyric Thunderhame ends Storm,
  Earth, and Fire next to Rau Cliffrunner, Lago Blackwrench gives Seeking
  Strahad and Torm Ragetotem gives A Troubled Spirit.
- The simulator scores a guide at the quest giver and turn-in it names when a
  quest has several (`sim compare`, `sim bench`): the world kept only the
  first one the data lists, so Horde guides were charged a walk to the
  Steamwheedle Port poster for the two Tanaris wanted quests they take in
  Gadgetzan, and class guides a trip to another city's trainer. About 0.1 h
  to 60 for most starts, up to 0.9 h for Horde Warriors; the route search is
  unchanged.
- Simulator: `--param key=value` (repeatable) sets any model parameter for sim
  run/robust/compare/consensus after the objective's preset, and `--tag
  <name>` gives such a variant its own result files
  (horde-orc-any-smooth-g6.json).
- Simulator: `sim run/robust/compare/consensus --objective smooth` searches
  for smoother routes (fewer zone switches, returns into zones left earlier
  and returns to spots already worked; results in their own `-smooth` files)
  while reported times stay real; kills now count for every active quest on
  the same mob camp, the quest log holds 40 as in Forever's client across
  the whole route (a full log waits for a turn-in or gives up a quest 6+
  levels below the character), and results report zone changes, zone and
  spot returns, shared kills, the quest log peak and the quests accepted but
  never turned in.
- `sim walks` routes the simulator's walks with the walking router the arrow
  uses, into `data/sim/walks-<faction>.json` (about 10 minutes per faction),
  and `sim run`, `robust`, `compare`, `bench` and `consensus` then walk round
  cliffs, mountains and water instead of the straight line × detour, which
  priced Silithus to Feralas at 1,785 yd for a 13,807 yd walk. Guides score
  0.4-1.0 h slower to 60, and the search finds routes 0.9-2.8 h faster on
  real walking (Orc, Human; give it `--paths 3000000`). Without the file, or
  with `--no-walks`, nothing changes.
- Talent plans are now checked against Forever's client build 1.60.1.70450
  (was 1.60.1.70374). Forever changed the Mage, Priest, Shaman and Warlock
  trees in that build; plans for those classes need to be checked against it.
- Addon tests can load temporary fixture files on another Windows drive
  (thanks HershelW).

## 0.2.5 (2026-10-17)

### For players

- Options > About says so on a client whose translation was made with AI, with
  the Discord invite.
- Alliance Priests run Cenarion Aid, Of Coursers We Know and The Ichor of
  Undeath (8254-8256) on the leveling route: High Priest Rohan gives the first
  at the Ironforge stop before Azshara, and Ogtinc's two errands fit the
  Azshara visit, the Ichor of Undeath from the Ruins of Eldarath the route
  already clears. About half an hour faster to 60 for every Alliance Priest
  start, with about 45 minutes less grinding. Blood of Morphaz stays in the
  Class guide: its item drops inside the Sunken Temple (thanks XrayAlpha,
  #119).
- Desolace (Alliance, from the Badlands guide): Book of the Ancients is taken
  from Azore Aldamort on the way to Karnitol's Chest, instead of on a walk
  back to his tower after it (the same pattern as #89).
- Blood in the Streets (Dalaran, Horde) waits until Magus Wordeen Voidglare's
  Dalaran Patrols and Key to the City are handed in: its prerequisite
  correction listed them in a form the guides ignored, so the guide could
  offer it too early.
- The arrow to a boat now leads onto the pier beside the ship, not to the
  ship's stop in the water off its end: the boats from Stormwind Harbor,
  Auberdine (to Stormwind), Rut'theran Village and Menethil Harbor (to
  Southshore and Theramore). The route's walk to every boat now ends on the
  wharf at its boarding point instead of jumping off the pier and swimming
  the last few yards (Auberdine, Menethil Harbor, Theramore, Southshore,
  Stormwind Harbor, Rut'theran Village, Feathermoon), and Auberdine's walks
  keep to the pier instead of swimming across the bay. Darkshore's last step
  leads to the Stormwind boat in Auberdine instead of a spot in Moonglade,
  and the Barrens Warlocks' summoning circle for Dogran's Pendant is in
  Orgrimmar's Cleft of Shadow, not in Thunder Bluff (thanks Fitz).
- More quests are no longer asked for before the game offers them. In
  Silverpine Forest, Quinn Yorick gives Wild Eyes when you bring him Return
  to Quinn at the Ivar Patch, the murloc eyes come on the shore walk to
  Fenris Isle and Apothecary Renferrel takes them at the Sepulcher; Return to
  Quinn (Again) is left out. From level 30, Bloom of the Heavens (Menethil
  Harbor and Auberdine), Sentiments of the Lost (the Wetlands), Shared Fury
  (Forest Song) and Friend of the Kirin Tor (by Dalaran) are left out: each
  comes after a quest the guide cannot lead you to yet.
- Darkshore: the Grizzled Scalps for Buzzbox 525 are collected at the Grove of
  the Ancients, where the bears live, instead of at the Tower of Althalaxx.
  The cloth donations in Stormwind and Ironforge and Grimand's Runecloth for
  the Paladin charger lead to the Auction House, as their tips say, instead of
  to guards or to mobs in another zone.
- In German the guide's goal verb read "Abgeschlossen" (finished) instead of
  "Abschließen", and in French, Spanish, Portuguese and Russian a finished
  guide's card in the picker read as an order ("Terminer") instead of a
  status. The goal verb and the picker's status are now translated apart.
- On a road where a zone crossing's two ends are far apart, such as the Gold
  Road north out of the Barrens into Ashenvale, the arrow no longer sends you
  back to the crossing's near end once you have walked past it, and skipping
  that end moves on instead of bringing it back (thanks Mark Gould and fur).
- Darkshore: the Beached Sea Creature by Bashal'Aran is picked up on the first
  loop, on the walk from Asterion to Buzzbox 411 that passes it, and handed in
  at the first hearth instead of on a detour from Cliffspring Falls. The
  southern beaches step says why the three remains past Remtravel's
  Excavation wait for the last loop: level 18-20 Greymist murlocs guard them
  (thanks XooVe).
- On a client in another language, the Dungeons objective lines, dungeon, zone
  and faction names, attunement notes, talent plan notes, flight points,
  docks, inns, boats and lifts, class teleports, and the journey's cave,
  bridge, gate and lift steps read in that language, from the game's own names
- Durotar: Vile Familiars is handed in and Burning Blade Medallion taken
  before the Burning Blade Coven, so Thazz'ril's Pick and Yarrog Baneshadow
  are done on one trip into the cave instead of two (thanks Gruko).
- Collecting an item that both normal mobs and elites drop, the arrow now
  leads to the normal mobs instead of into the elites' camp: the Battleworn
  Axes in Redridge, the Hillsbrad Human Skulls, the Indurium Flakes in the
  Badlands, the Troll Tribal Necklaces in the Hinterlands, the Zhevra Hooves
  in the Barrens, the Green Hills of Stranglethorn pages and more. A normal
  mob standing among the elites is still marked on the map, but the arrow no
  longer picks it on its own (thanks Smuve, #126).
- Elwynn Forest: Croaky's Head is now an optional extra. Croaky, an elite,
  roams the murloc shore south of the Eastvale bridge where the guide sends
  you for the Torn Murloc Fins. If you loot its head, the guide then takes
  you to Merell Ross at Ridgepoint Tower, just east, before heading back to
  the bridge; without it, the guide goes straight on (thanks Syfin).
- Every guide's titles, tips and notes now read in your game's language on German, Spanish (Spain and Latin America), French, Korean, Brazilian Portuguese, Russian and Chinese (Simplified and Traditional) clients, with every NPC, place, item and quest named exactly as your game names it. Each language is its own small addon in the release zip; only your game's language loads.
- Every interface text now shows in your language on all nine clients: the
  strings added lately are translated, and nothing is left in English. Spanish
  (Spain) is now reviewed by julen92.
- Redridge Mountains: the Battleworn Axes lead to the Blackrock Renegades at
  Alther's Mill, not the elite orcs of Stonewatch Keep. Hillsbrad Foothills
  (Horde): the skulls lead to the Peasants in Hillsbrad Fields (thanks Smuve).
- Darkshore: Holy Diver is taken once all nine beached remains are handed
  in, its rod on the naga trip. Silverpine Forest: Ivar the Foul comes after
  Return to Quinn (Again), both on the road north out of the forest at the
  end. Westfall no longer takes the second Harvesting the Harvesters, and
  Silverpine no longer takes the Forever Arugal's Folly: the game offers
  them only after quests the route does not do.
- Quests that open only after another one are no longer asked for before the
  game offers them: in Mulgore, Baine's chain (Longwalker Malah, then Grim
  Tidings, Our Ancient Enemy, Drive Them Out and The High Chieftain, each
  once the one before is handed in) and Thunderhorn's Report after Wildmane
  Cleansing; in Tirisfal, Bandarion Keep when The Cult of the Damned and
  Remnants of War are handed in; in Redridge, Alther's Mill after The
  Everstill Bridge; in Westfall, The State of the Mines after Testing the
  Wells, with the mines and the quarry on the way to the western farms; in
  Hillsbrad, Scout Support after Battle of Hillsbrad part II, with the
  peasants now done before the Durnholde trip. Tirisfal no longer takes the
  second Rear Guard Patrol (Riptear): Linnea offers it only after the east
  loop (thanks Kori, whiteswag, Smuve, SouthernStyleSims and Taako).
- Polestar's interface is in French, translated by Yendi (thanks Yendi).
- Reputation standings, item qualities, the Alliance and the Horde, the gear
  slots on the upgrade line, the Dungeon Journal and the race names on guides
  and the welcome read exactly as the game writes them, in every language
  ("Main Hand", "Shoulders" and "Dungeon Journal" in English).
- Polestar's windows work with a gamepad. The options have a new Gamepad
  page: it names the buttons (Xbox letters or PlayStation shapes) and binds
  any Polestar action to a key, a button or two buttons held together;
  nothing is bound until you choose. "Browse the guide with the gamepad"
  lets the D-pad pick a line in the guide window: A points the arrow there,
  X shows the details, LB / RB change steps, Y minimizes the window and B
  gives the gamepad back. Every Polestar window you open answers the D-pad,
  A, B, Y and LB / RB, with a bar of button hints, and gives every button
  back when it closes or a fight starts. A window that opens by itself, like
  the choice of where to level next, waits until you press the Browse the
  guide button. With the game's gamepad interface on, LB and RB stay the
  game's targeting buttons (ported from Ding! by Yendi, @moust4ki).
- With the gamepad interface on (Options, Gamepad, Enable Gamepad UI),
  opening and closing the world map, or closing windows with B, no longer
  brings up the game's warning that Polestar was blocked from an action only
  available to the Blizzard UI, again and again, with the game's own gamepad
  controls failing behind it. Everything Polestar shows on the world map
  (the arrow's target, the step's goals and their regions, the route lines
  and the trail, rares, dungeon entrances, flight masters, zone levels, the
  coordinates bar) and the unexplored areas on the world and battlefield
  maps are now drawn over the map without touching it, the same with the
  gamepad and with the keyboard and mouse.
- With the gamepad, the world map's cursor works on Polestar's pins as on
  the game's own: near one, its tooltip shows, and A does what a click does
  (aims the arrow at a goal or a camp, opens a dungeon's page, and so on).
- With the gamepad interface on, taking a quest reward no longer brings up
  the same warning, with the game's gamepad controls failing in every window
  after it; nor does opening the talents or the world map. Polestar's marks
  on the reward choices and on the talents, and its drawings on the map and
  the minimap, are now added in a way that leaves the gamepad interface's
  own code alone.
- With the gamepad interface on (Options, Gamepad, Enable Gamepad UI),
  Polestar now keeps to its own windows, so the game's warning that Polestar
  was blocked from an action no longer comes back again and again until the
  game freezes. Polestar's slash commands (`/polestar`, `/way`, `/psrec`)
  are off, because the game blocks gamepad actions after any addon command
  typed in chat. Open Polestar from its minimap button, which is now on by
  default with the gamepad, or bind a key in Key Bindings. With the gamepad
  interface, Polestar also leaves out its entries in the map's tracking
  menu, quest levels in the game's quest windows, its line on talent
  tooltips, the route drawn on the flight map, the "Show on map" button on
  dungeon pages and the setting that hides combat error messages. Escape
  (B) no longer closes Polestar's windows; use their close button. With the
  keyboard and mouse, nothing changes.
- With the keyboard and mouse, Polestar no longer shows gamepad hints (the A,
  B, X, Y bar under its windows) or keeps its slash commands away when the
  game's saved interface setting still reads Gamepad from an earlier session:
  the game's own answer for the interface in use decides.
- With the keyboard and mouse, Polestar's windows no longer show the gamepad's
  focus outline, button hints (Move, Adjust, Choose…) or B chip, and no longer
  take the gamepad's buttons, even with a gamepad plugged in: Polestar uses
  the gamepad with the game's gamepad interface (Options, Gamepad, Enable
  Gamepad UI). To use a gamepad with the keyboard and mouse interface too,
  turn on Use with the keyboard and mouse on Polestar's Gamepad page.
- Gear advice no longer marks a weapon you haven't trained as an upgrade,
  picks it as your quest reward or equips it: it went by the weapons your
  class can learn, so a level 4 rogue was shown a green arrow on a sword and
  a mace. The tooltip says the weapon skill isn't trained, and the advice
  changes as soon as you learn it (thanks Pynte).
- Where two zone maps overlap, the arrow now leads to people and things on the
  map of the zone they really stand in, so the route no longer sends you
  through a zone crossing past them and back: Kadrak at the Mor'shan Rampart,
  Tirion Fordring's hut, Argent Officer Garush at the Bulwark, Erion
  Shadewhisper in Darnassus, Tal and Cairne in Thunder Bluff, the Great Lift's
  top, Henchman Valik, Lieutenant Haggerdin and the Syndicate camps in
  Alterac, and the Uldaman dig in the Badlands. The Western Plaguelands
  (Alliance) and Felwood (Horde) guides also take Tirion's first three quests
  at his hut instead of in Hearthglen (thanks fur and CDVolvik).
- A "Go to" at a cave's mouth, a dock or another way in now ticks off once the
  work it leads to is already done, so the guide no longer sends you back to
  the Burning Blade Coven with the Medallion already in your bags. The same
  holds for Skull Rock, Fel Rock, Shadowthread Cave, the Jasperlode and
  Fargodeep Mines, the Coldridge troll cave, the Blackfathom Deeps ruins and
  the boats and zeppelins between zones (thanks Gruko).
- A "Go to" at a cave's or mine's mouth now ticks off once you walk into the
  cave past it, in every client language: the Burning Blade Coven, the Den and
  Skull Rock in Durotar, Shadowthread Cave and Fel Rock in Teldrassil, the
  Fargodeep and Jasperlode Mines in Elwynn Forest, and every other cave a step
  names. Before, it waited for you to stand within 8 yards of the point
  outside (thanks Hulari).
- With Skip grey quests on, a grey quest Polestar keeps because it opens a
  later quest still worth doing now says so under it, naming that quest
  (thanks XooVe).
- On a client in another language, the names inside a guide's tips, notes and
  step titles (quest givers, mobs, items, quests, zones and places,
  professions) are the game's own names in that language; English ones showed
  until now. A note that only repeated the quest giver's name is gone: it put
  the English name beside the translated one (#133). The guides' own words
  come in your language as each one is translated.
- Guide packs are now Community guides: the options page and the guide menu's
  heading read Community guides, and each one you install is a community
  addon. Built ones read "Polestar Community: <title>" in the AddOns list;
  those built before still read "Polestar Pack:" and show as before.
- Registering the guides at login makes about 3 MiB less short-lived garbage
  for the collector to clear up: the checks that walk every step and goal now
  share one table of key names instead of building a new one per goal (#60).
- A guide that hearths you back to an inn now has you bind there first, at
  the start or the first time it passes the inn, instead of relying on the
  guide before it. This is for anyone who skipped that bind or started the
  guide from the picker. Horde: Hillsbrad Foothills (Tarren Mill),
  Dustwallow Marsh (Ratchet) and Winterspring (Everlook). Alliance: The
  Hinterlands (Aerie Peak), Searing Gorge and Un'Goro Crater (Thelsamar), the
  Burning Steppes (Ironforge), Winterspring (Everlook), the Western
  Plaguelands (Light's Hope Chapel) and Silithus (Ratchet). If you are
  already bound there, the step ticks at once (thanks psykzz).
- Options, Integrations also holds the settings for Shortest Path Forever
  (hand guiding to it), TomTom (let other addons set waypoints,
  follow TomTom's arrow) and EllesmereUI (match its accent and font), so every
  setting that depends on another addon is in one place.
- Dun Morogh: Distracting Jarven is now part of Bitter Rivals: buy a Thunder
  Ale, click the guarded barrel and hand the ale to Jarven before the
  unguarded barrel. The city reputation guides' Additional Runecloth goals
  check off when you hand the cloth in, not when you talk to the
  quartermaster, and stay done after a /reload; auto turn-in hands in once per
  goal, never again on a later visit. (thanks thmastin)
- Translated guides: an NPC a tip names by first name, and places such as the
  Crossroads written without their "The", now show in your language;
  profession ranks, Legacy, Skyborne, skyboat and reputation guide titles read
  the same everywhere in each language, with the client's own words
- On a client in another language the guide window names flight paths,
  explored places, farm-spot mobs and the items that start quests in your
  language where the game or the names addon has them.
- A minimap button (Options, Map, Guide & quests; off by default): click shows
  or hides the guide window, right-click opens the settings, and you can drag
  it around the minimap's edge (thanks Tedddogg).
- On a client in another language, Polestar now names Forever's own quests,
  NPCs, objects and items in that language too, and instances, dungeon bosses,
  factions and flight points as the game does: the names packs take the game's
  own tables first, then Forever's quest data in that language. The
  source a collect goal names ("Kill Grell for Fel Moss") is in your language,
  and the AddOns list shows Polestar's addons in it.
- Walks keep out of zones far above your level: the arrow and the route lines
  go round a zone whose lowest level is 4 or more above yours (and far round
  one more than 10 above), unless your walk starts or ends there or there is
  no other way, and they are searched again when you level up. Journeys
  weigh their straight walks the same way, so a route prefers a flight or
  boat to a walk across such a zone. So a level 20 Horde character walking
  from Tirisfal to Hillsbrad no longer crosses the Western Plaguelands
  (#195). The idea and its 4-level threshold come from Ding! by Yendi.
- On a non-English client, `/polestar near`, Lookup's sources and search
  results and the Dungeons list no longer keep English names after the names
  pack loads late (after combat).
- Dun Morogh's Call of Fire (Dwarf Shamans) and Durotar's Legging It count the
  Fire Tar and Reagent Pouch, and the Creepers and Lurkers, on the right lines
  again; a guide that names another objective's index no longer builds.
- The arrow now leads to the objective itself, not to the quest's turn-in,
  in steps that only had the turn-in placed: Rumbleshot's Ammo (the Ammo
  Crate by Mountaineer Gretchen, which the tip wrongly put on Shimmer Ridge),
  Operation Recombobulation, Treacherous Cold, A Pilot's Revenge and Tundra
  MacGrann's Stolen Stash in Dun Morogh, and steps in Darkshore, Stranglethorn
  Vale, Arathi Highlands, Alterac Mountains, Silverpine Forest, Azshara and
  Mulgore.
- Dun Morogh (Shaman, Call of Fire) and Durotar (Legging It) count each
  item or kill toward the right objective: their objective numbers were
  swapped.
- Legacy Challenges: Return to Bodley is now turned in before Back to the
  Beginning, which needs it.
- Accepting a quest no longer shows "Not offered by" its giver for it, or
  skips its later steps if you abandon it (thanks Tate Mastin)
- A quest giver who did not offer a quest no longer pulls you back to them
  after a level-up, a turn-in or logging in at a new level: the guide stays
  where it is and takes you back only when that giver offers the quest, for
  example when the route meets them again. A quest you passed because you
  were too low or lacked its prerequisite still brings you back once you
  reach its level or finish that quest (thanks Wyatt and stroexd).
- On a client in another language, the Dungeons journal, Rares, Lookup (entity
  pages, where things come from, item tooltips), the gear advice, the class
  trainer reminder, Nearby's professions, the talent plan's specs and guide
  skill, spell and reputation goals show the game's names in that language
  instead of English. NPC and object names the game shows you (target,
  mouseover, talking to them) are remembered and used from then on, since the
  game is always right. The optional Recorder's chat lines can be translated
  too.
- The turn-in and objectives of an optional quest you never took no longer
  show in the guide window, and no longer hold the guide: they come back if
  you take the quest.
- Options, Guide, Arrow & routes, Route style: Fastest takes the shortest walk
  over hills and across fields, Balanced (the default) keeps to roads that
  aren't much longer and goes round hills, and Roads stays on roads even when
  they're longer.
- The arrow's walks now keep to roads where they are not much longer, go round
  steep slopes rather than over them, and stay out of the other faction's
  towns. When a walk must enter one (a quest inside Southshore for a Horde
  character), the arrow says "Hostile town: Southshore" once as the walk
  starts, even when the walk is the whole way, and the walk's journey step
  reads the same. Walk times come from the path's real length.
- Teldrassil: the Dolanaar steps say that Moon Priestess Amara patrols the
  road west of the village, so if she isn't at the arrow you know to follow
  the road and meet her (thanks sesgoe). Stranglethorn Vale's first Rebel
  Camp step now says the same of Private Thorsen, who patrols the road north
  of the camp.
- On a French, German, Spanish or any other non-English client, setting your
  home, discovering a flight path, hearthing and flying complete their steps:
  the guide named the place in English and the game answered in your language
  ("Darkshire" against "Sombre-Comté"), so these steps never checked off and
  had to be skipped. Polestar now knows each inn, flight path and place by
  the game's own ID: binding at the innkeeper the step names, or being bound
  there already, completes the step, and the guide window names the place as
  your game does (thanks Yendi, #83).
- The crafting profession guides (Alchemy, Blacksmithing, Enchanting,
  Engineering, Leatherworking, Tailoring) now follow Forever's own recipes:
  its skill colours, reagents and names, not Classic's, so no step asks you to
  keep crafting a recipe that has already turned grey. Forever's recipes past
  295 in Tailoring all need a station or a recipe Polestar can't route yet, so
  the guide stops there and names them (thanks Hotline, #109).
- Questie's tracker can show where Polestar plans to hand in each completed
  quest, including the step in a later guide; earlier, skipped or missing
  hand-ins are flagged, and an unchosen route or unloaded guide is shown as
  unknown. Turn it on in Options > Integrations, a new page for the addons
  Polestar works with that lists each one only while it is installed (thanks
  AurumTitanos).
- The report from the bug button (and /polestar report) now lists the actions
  the game blocked from Polestar this session, such as a gamepad binding or a
  button press refused for taint, with how often and when. These are no Lua
  errors, so such reports used to say "Errors: none".
- The bug report (and /polestar report) says how the arrow routes: the route
  style (Fastest, Balanced or Roads) and any routing setting turned off or
  handed to Shortest Path Forever, so a pathing report shows which way the
  walk was planned. The bug bot puts it in the issue.
- After the reported fixes, every guide was searched for the same
  mistakes, and these were fixed wherever they turned up:
  - The quest giver standing beside you comes first. The Human start sent
    you 86 yards to Eagan Peltskinner past Deputy Willem; the same happened
    in about 40 towns from Northshire to Silithus (Teldrassil's Aldrassil and
    Dolanaar, Brill, Bloodhoof, Razor Hill, Auberdine, Lakeshire, Ratchet,
    Southshore, Gadgetzan, Feathermoon and more).
  - Class letters are handed in on the visit where you train: Elwynn's and
    the Horde Zephras Isle letters sent you to the trainer at level 2 with
    nothing to learn.
  - Items a quest needs that only a vendor sells are bought on the way: the
    Rhapsody Malt in Kharanos, the Empty Vial in Dolanaar, Fine Thread for
    Bartolo in Southshore, the Nutritious Slime Sludge, the Enriched Manna
    Biscuits and the Xorothian Stardust.
  - Goals say what you actually do: /sit at Kaga's campfire in Mulgore,
    spread the Prepared Incense off Hunter Rise, heal the druids in the
    Nightfang Den, mark the Andorhal towers with the Beacon Torch, free the
    Darrowshire spirits, wake the Lazy Peons.
  - Objects you click for a quest (the Gaea mounds in Stonetalon, the
    Witherbark cages, the Shadow Hold braziers) show together with the mobs
    around them instead of one after the other.
  - Talking to a quest NPC before the guide asks for it counts, on Zephras
    Isle (Horde) and for William Pickman in Brill.
  - Kill arrows no longer point at quest givers in town: the Balnir
    Farmstead cultists in Tirisfal, and the Windsong Crawlers and Al'Aketh
    Healers on Zephras Isle, whose spawn data had them inside Valanaar.
  - Orc mages are offered the Spellfire Robes chain, and Skyborne
    characters the mage robe, Aquatic Form and Cure Poison quests.
- A quest whose earlier part you haven't done reads "Requires <quest>
  first" right away, and the guide no longer walks you to its giver: in the
  19-24 Barrens it sent you to Sergra Darkthorn for Jorn Skyseer without The
  Angry Scytheclaws, and only marked it after her window opened. It comes
  back as soon as you finish the earlier part. Quests whose earlier part the
  guide still brings you to are unchanged, and the giver's window stays the
  final word (thanks Fitz).
- Setting your hearthstone now points the arrow at the innkeeper: every "set
  your home" step that named only its inn, such as Sentinel Hill, Auberdine,
  Lakeshire or Astranaar, now leads to the innkeeper of your faction there.
- Settings help lines wrap instead of being cut, and labels make room for
  longer languages: setting names, button descriptions, slider values,
  dropdown choices, the hub's section rail and sidebar, a guide's facts and a
  dungeon's facts take a second line or the room they need, so no
  translation ends in "..." (thanks thecodingcortex).
- Silverpine Forest no longer sends you to Dalar Dawnweaver for Stop the
  Spread, which he did not offer on the guide's route, or on to the refugees
  for it (thanks Rupert and Wyatt R).
- New skins, under Options > Appearance > Windows > Skin. Polestar's own look
  stays the default.
  - Halo: no frame, a dark veil with soft edges under the text, the game's
    gold, Fira Sans.
  - Hearth: Polestar in warm game colours, with the game's red buttons, check
    boxes and font.
  - WoW Forever, Blizzard and Classic: Polestar drawn in the game's own art.
    WoW Forever wears Forever's bronze frames, header rods and plates;
    Blizzard the retail art (the metal window frame, the damage meter's
    header, the minimal check boxes and sliders); Classic the original
    dialog box, tooltip borders, panel buttons and tabs.

  Every window takes the skin, and Style, compact mode and the colours you pick
  work in each. The arrow follows the skin too (Arrow style, "The skin's
  arrow"): a dart that turns green within 40 m, then a ring and a check on
  arrival; the 3D and flat arrows can still be picked. The font follows the
  skin unless you pick one (Font, "The skin's font"; Fira Sans joins the list).
- Spanish (Spain): clearer quest and trainer instructions, party progress, XP and kill counters, instance lockouts and gear advice; correct the Restoration spec and untrained-weapon warning, with consistent player vocabulary (thanks Forever Hispano).
- With Shortest Path Forever installed, Polestar's own arrow now guides by
  default; "Hand guiding to Shortest Path Forever" (Options, Integrations)
  hands it the route. This switches everyone to Polestar's
  arrow, players who used the hand-off before included: turn the option on
  again to keep it. With it on, a goal Shortest Path Forever finds no way to
  is guided by Polestar's arrow instead of by neither (#235, thanks Lofka).
  While a journey you started in Shortest Path Forever runs, Polestar steps
  aside so the two never guide at once, and guides again when it ends.
- The arrow now leads to every objective step that had nowhere to point: the
  Grizzled Den and seven more Dun Morogh steps, eight in Mulgore, and steps in
  Darkshore, Ashenvale, Stranglethorn Vale, Un'Goro Crater, the Burning
  Steppes, Winterspring, the Western Plaguelands and the Hydraxian Waterlords
  guide (thanks rikette).
- Stranglethorn Vale: the arrow leads to the hunters' camp for Investigate the
  Camp, for the Alliance and the Horde, as it now does in Darkshore for The
  Red Crystal (thanks Twerkjob).
- A kill or collect step whose mobs mostly live in one camp leads to that
  camp, not to a lone one or two hundreds of yards away from it: Frostmane
  Headhunters at Frostmane Hold, Grizzled Scalps in Darkshore, Jadefire
  Hellcallers at Jadefire Run, Stonetalon Sap, the Bloodpetals of Un'Goro's
  east side and the Marsh Flesheaters by the Misty Reed huts among them. The
  strays stay on the map as other places to look (thanks Phear).
- Teldrassil: Shanda's note says she is in at Aldrassil's front entrance and
  up the ramp, not just "inside the tree", so you don't run past the ramp
  deeper into the tree (thanks Pynte).
- Teldrassil shows the Gnarlpine Totems with the Nightsabers, boars and Fel
  Moss instead of after them, and the arrow knows every totem in the woods:
  the guide named only one of the two totem objects (thanks Pynte).
- Teldrassil still hands you your class sigil after The Balance of Nature,
  but has you hand it to your trainer on the next visit to Aldrassil, when
  you train, rather than a trip up the tree at level 2 with nothing to learn
  (thanks Pynte).
- Teldrassil takes Conservator Ilthalaine's The Balance of Nature before
  Melithar's quest: he stands right beside where you start, and the guide
  sent you past him first (thanks Pynte).
- Teldrassil: Zenn's Bidding is taken from Zenn Foulhoof on the road down from
  Shadowglen, which passes him, instead of on a walk back east once Dolanaar
  is done (#89, thanks Pynte for the report and CDVolvik for the fix).
- The Community guides page lays each row out top to bottom: the title with
  its author, version and licence under it, then the website and the author's
  note at the row's full width, so a long note no longer wraps in a narrow
  column.
- Thousand Needles offers the Bronze Tube from Herble Baubbletump before you
  turn in Look to the Stars in Darkshire, for when you arrive without one;
  the tip names Neal Allen in Menethil Harbor if Herble is sold out (thanks
  Yendi).
- The arrow's walk to a trainer, vendor or innkeeper the guide picks for you
  (train class, a profession trainer, buy nearest, vendor nearest, sethome
  nearest), to the class trainer of the training reminder and Nearby, and to
  the other places a quest's creature or object spawns now ends on that NPC's
  floor: the walk to the warrior trainer in Northshire Abbey led outside the
  building (thanks halexh, #180).
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
- The arrow's walk starts from the ground you are standing on, not a roof,
  rock top or upper floor above you: Polestar follows the floor under you as
  you walk (the game gives addons no height), so at the Den's camp in the
  Valley of Trials the way to Hana'zua no longer climbs the rock over the Den
  and crosses the hill. Off a lift, inside the Undercity, the city's floor is
  picked up from whether you are indoors (thanks MrPersonage, #234).
- Quests are taken where the route already stands instead of on a walk back
  later: Fields of Grief from Deathguard Simmer at Calvin's duel (Tirisfal
  Glades), WANTED: Caliph Scorpidsting from the same poster as Andre
  Firebeard's bounty (Tanaris, Alliance), and Panther Mastery with The Green
  Hills of Stranglethorn when the panthers are handed in at Nesingwary's camp,
  which saves a ride up from Grom'gol (Stranglethorn Vale, Horde).
- The welcome has a route style page on your account's first character: pick
  Fastest, Balanced or Roads, with a line on what each one does.
- Westfall: Alba Fairmoon's quests (Testing the Wells, Murloc Gills, The
  State of the Mines, Moonbrook Espionage, Explosive Consultation) are for
  Dwarves, Gnomes, Night Elves and Skyborne only on Forever. Humans are no
  longer sent to her, to the wells or to the mines for them.
- Wetlands: Captain Stoutfist's quests come in the order the game offers
  them. War Banners is followed by From the Ashes, the Dragonmaw attack plans
  in the Angerfang Encampment. Nek'rosh's Gambit comes after that: you take it
  when you hand From the Ashes in after the hearth to Menethil, and light the
  catapult on the Wetlands loop at the start of the next guide (thanks
  Lou-Saydus).
- Wetlands (Alliance): the guide no longer asks for Stopping the Cycle. Howin
  Kindfeather offers it only after Death to the Dragonmaw, whose orcs in the
  Dragonmaw Retreat are elite.
- Zephras Isle (Horde) takes Welcome to Shen'dar Village at your first stop
  with Constable Aonda and follows the quest's own progress, so talking to
  Illaya Amberwind earlier counts and the step no longer waits on her
  (thanks Sato).
- Zephras Isle: The Gift of Skysight says to cast Skysight near the
  Elemental Convergence, and the Alliance's Reading the Ley Lines to cast
  Read Ley Line at the Ley Line, not to click them (thanks Sato).
- Zephras Isle: The Great Outdoors says to /sit by Raan's campfire until you
  get Boosted Rest, not "Click Basic Campfire" (thanks Sato).
- Zephras Isle: the Scrawny Ursera step sends you to the slopes west of
  Thendal Village, where they spawn, not into the village: our spawn data
  had bears inside it that Forever's map data has none of (thanks Sato).

### For guide authors

- `compile` gives `sethome`, `hearth`, `fly` and `getfp` and a labelled `goto`
  the game's area ID of the place they name (`area`), and `getfp` its flight
  point's taxi node (`node`), so they complete on every client language; it
  prints how many got one. The guide sources do not change, and a pack
  without the keys keeps matching by English name (GUIDE_FORMAT.md, "Places
  by ID"; PACK_FORMAT.md).
- Compiled collect goals carry the ids of the sources they name (fromId,
  fromAlsoId), so Polestar names them in the player's language; older Polestar
  ignores them.
- docs/GUIDE_PACKS.md, the page Options > Community guides links to, is easier
  to follow on GitHub: a short path for players and one for authors, renders
  of the guide menu and the Community guides page, the publish steps as a list
  and a checklist before you publish. docs/PACKS.md and docs/PACK_FORMAT.md
  open with their contents.
- A goto at a cave's or mine's mouth labelled with the cave's subzone name as
  the game spells it ("Fargodeep Mine", not "Fargodeep Mine's mouth") gets its
  area and also counts as arrived once the player is inside
  (docs/GUIDE_FORMAT.md, goto).
- Guide packs are now called community addons. `polestar compile`, `pack`,
  `install` and `dev` title the addon "Polestar Community: <title>" in the
  AddOns list; Polestar still reads the old "Polestar Pack:" titles, so addons
  already published keep working. `pack.json`, the commands and the
  `PolestarPack_` folder names are unchanged.
- Guide texts can be translated (docs/TRANSLATING.md, "Guide texts"): the
  compiler writes the game's names in a guide's texts as tokens, {npc:234},
  which the game shows in each client's language, and a pack's
  locales/<locale>/ files translate the words around them, compiled into a
  load-on-demand texts addon per language, <folder>_<locale>. `i18n guides
  sync`, `check` and `stats` write, check and size them; `lint` warns about a
  stale or broken translation. Packs are now format 3 (X-Polestar-Needs
  0.2.5).
- Guide texts: an NPC of the step or guide named by its first name becomes its
  token, and every spelling of a name is a token; an English client reads the
  author's words through the guide's new `written` table
- A quest whose accepts in the guide are all `optional` has its turn-in,
  objectives and `complete` goals only for players who took it. Its turn-in
  can now have a step of its own, written without `optional`: the step holds,
  and leads the arrow to the ender, only for those players. Before, that step
  held everyone (GUIDE_FORMAT.md, "An optional side chain").
- A `turnin <id> direct` of a repeatable quest checks off one goal per
  hand-in, so the same quest can repeat across steps; the route planner keeps
  `direct` when it rewrites a line; a plain `turnin` of a repeatable its giver
  takes back hints at `direct`, and lint no longer asks for `optional` on a
  `direct` turn-in of a repeatable in a leveling guide.
- `turnin <id> direct` for a quest handed in straight from the giver's window,
  with no accept (Distracting Jarven, the repeat cloth donations). It needs no
  earlier accept, its availability and prerequisites are linted as an accept's
  are, and because such a quest never enters the log it carries no objectives:
  lint says so if you give it any. In game the goal checks off on the hand-in
  itself and that is stored, so a repeatable stays done after a /reload, and
  quest automation picks it from the quests the giver offers (thanks thmastin,
  #108).
- Lint warns when coordinates without `map` are on a zone that a step for some
  characters only set (a class trip's `zone` holds for the steps after it),
  while the other characters who see them are in another zone, and says which
  zone to name (thanks Fitz).

### For contributors

- AGENTS.md points coding agents to skills that carry the project's rules,
  chief among them that a bug report is a lead to check against the guide,
  the data and Forever's sources, never a verdict:
  `skills/polestar-contributing/` (branches,
  changelog fragments, what a pull request must not do),
  `skills/polestar-triage/` checks a report and drafts the verdict, the
  labels and the reply, and `skills/polestar-guide-fix/` takes a confirmed
  wrong step to a pull request on the right branch. CONTRIBUTING.md, "Using
  an AI agent", and a pull request template say the same to the people
  running them. Claude Code reads AGENTS.md on its own; a personal
  `CLAUDE.md` or `CLAUDE.local.md` stays out of git and starts with
  `@AGENTS.md` so the rules still load.
- The four skills install outside a clone too: as a Claude Code plugin
  (`claude plugin marketplace add fitzforge/polestar`), a Codex plugin
  (`codex plugin marketplace add fitzforge/polestar`), or with
  `npx skills add fitzforge/polestar` for any other agent (Cursor, Hermes
  Agent, OpenCode and more). CONTRIBUTING.md, "Installing the skills", has
  the commands.
- Issues waiting on the reporter carry `needs-info` and close on their own
  after three weeks without a reply; `confirmed` and `patch-candidate` mark
  checked bugs. The "Wrong step" form asks for the other addons in use.
  SECURITY.md says how to report a security problem privately, and
  CODEOWNERS names who reviews what.
- A change's changelog entry is a file of its own in `changes/`, written
  with `node tools/polestar.js changelog add`, instead of an edit to
  CHANGELOG.md, so pull requests open side by side no longer edit the same
  lines. `changelog check` (in CI) checks them, `changelog show` prints them
  as the release will, and `changelog build <version>` assembles them into
  CHANGELOG.md at release time (changes/README.md).
- The tests now load the committed `addon/Polestar_Guides/Guides.lua` the
  way the game does and fail when it differs from what `compile` writes: a
  goal outside its step's `goals`, a goal of no known kind, or a guide whose
  steps, goal kinds and quests do not match its `.guide` file. A hand-spliced
  Guides.lua could break that and still load without an error, and the game
  never showed those goals. Needs no reference data, so CI runs it.
- On Windows, data build names its quest XP and zone quest list caches with
  forward slashes in meta.json, so compiling there no longer writes
  backslashes into those two lines of addon/Polestar_Guides/LICENSE-DATA.txt.
- `tools/discord-bot`: `/close` and `/reopen` for server administrators in
  a #bugs thread. `/close` takes a reason (Fixed, Won't fix, No action
  needed, Can't reproduce, Not resolved, Duplicate) and an optional note,
  closes the issue with it, and the reporter hears it in those words with
  the note quoted (`tools/discord-bot/README.md`).
- `tools/discord-bot`: a prerelease (`v0.3.0-rc.1`) tells no #bugs thread
  its fix is out; it pings the tester role once in the testers channel,
  with its player entries, when `DISCORD_TESTERS_CHANNEL_ID` and
  `DISCORD_TESTER_ROLE_ID` are set. A full release tells an issue closed by
  a commit only when its tag holds that commit, so a patch no longer
  claims fixes merged into `next`; one closed by hand still counts from the
  full release before, never from a prerelease. The release workflow runs
  `next`'s bot, so a patch tag cut from an older release gets the current
  one (`tools/discord-bot/README.md`).
- Tests fake an Italian client (`fakeLocale('itIT', ...)`): Forever has none,
  so no shipped language file replaces the fake strings.
- Polestar draws on Blizzard's map frames through `Polestar.MapCanvas`
  (`Nav/MapCanvas.lua`, ARCHITECTURE "MapCanvas"): its own frames on the
  map's canvas, the map only read. No module adds a data provider or a pin
  pool, acquires a pin or calls a map method that writes: a value written
  into the map's tables taints the gamepad interface's secure code. No frame
  there has a click script either (the gamepad's navigation reads it back as
  it scans the map): pins take clicks from `GLOBAL_MOUSE_DOWN` and
  `GLOBAL_MOUSE_UP`. The route lines (`Maps/RouteLines.lua`) are one such
  frame; `Nav/Journey.lua` tells Polestar's pins under the mouse with
  `Pins.WorldPinOf` and lets the target go on a Shift-click of its pin
  through `Pins.OnWorldClick`. `tests/lua/wow_stub.lua` fakes the map
  frames' shape (`stub.newMapCanvas`) and `stub.guardMap` fails any write of
  addon code into them; `tests/nav-mapcanvas.test.js` draws everything with
  the maps guarded, with either interface, and pins what Polestar reads
  there.
- A frame of Polestar's whose parent is a game frame, or is under one (the
  map canvases, the minimap, quest reward and talent buttons), is made with
  `Polestar.CreateFrameUnder` (`Core/Init.lua`, ARCHITECTURE "Frames under
  the game's UI"): no parent, then `SetParent`. The gamepad interface hooks
  `CreateFrame` and, for a parent inside one of its open panels, rebuilds
  the panel's buttons in the caller's code, tainted. `tests/lua/wow_stub.lua`'s
  `CreateFrame` fails such a call from addon code and lists it in
  `stub.underGameFrames`.
- CONTRIBUTING.md and the guide-fix skill say Guides.lua is only ever what
  compile writes, never a hand edit or a spliced hunk, and give a recipe for
  keeping only your change when your reference data differs from the branch's:
  compile the guides before and after it with the same data and git merge-file
  the difference into the committed file.
- A memory budget for the compiled guide pack (`tests/guides-memory.test.js`):
  it loads `addon/Polestar_Guides/Guides.lua` under the test interpreter and
  weighs what stays resident, so a change that costs memory per goal or per
  step shows up in the suite. It also reports what one faction's share of the
  pack weighs, the figure a faction-only load would have to beat (#60).
- On Windows, the test that every hearth goes to an inn its guide binds at
  no longer fails on the Badlands and Un'Goro Crater hearths it allows: it
  compared Windows paths, with backslashes, against its list of exceptions,
  written with forward slashes.
- Guide fixes for the latest release can ship as a patch, without the full
  data build: their pull requests go to `hotfix/<version>` (for example
  `hotfix/0.2.5`), everything else to `next` (CONTRIBUTING.md, "Branches";
  docs/RELEASING.md, "Patch releases"). The `Base branch` check fails a pull
  request to `main`, and one to a `hotfix/` branch that changes more than a
  patch may carry (`release scope`). A fix merged into `next` with the
  `backport` label gets its cherry-pick pull request to the `hotfix/`
  branch on its own. `next`, `main` and `hotfix/` branches take changes by
  pull request only, with CI green.
- `release patch` builds a patch in a `hotfix/` checkout with that
  release's own tools and data addons, and stops when the branch carries
  more than guide fixes or the reference data has moved on; `release notes`
  drafts the GitHub, CurseForge and Discord notes from the changelog.
  Publishing a release opens the pull request that merges it back into
  `next`.
- i18n check and sync also cover addon/Polestar_Recorder/Locales (--addon
  limits a command to one addon); Polestar.Names gains Spell, Faction, Area,
  Instance, Taxi, Encounter, Get(kind, id) and names learned in play
  (PolestarDB.names).
- `node tools/polestar.js i18n` keeps the interface translations, adapted
  from Ding! by Yendi (@moust4ki): `status` lists the nine languages with
  their counts, status (reviewed or AI-made) and translators; `check` (run in
  CI) fails on a file Lua cannot load, a stale key or a broken format and
  warns where a translation leaves out its glossary's word; `sync` adds the
  texts the code gained to each file, commented out under their file, and
  moves translations of texts it lost to a block at the end, never touching a
  translation; `import` merges translations written apart.
  docs/TRANSLATING.md.
- `node tools/polestar.js i18n leaks` runs the addon in every language and
  lists the English left on screen, grouped by where it came from
  (docs/TRANSLATING.md, "English left on screen").
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
- i18n names reads the client's own tables in each language (wago.tools) and
  the cached Forever web names (data/sources/web/names) before DingDB
  and pfQuest, and bakes instance, encounter, faction, flight point and
  dungeon objective names too. Every addon TOC has Title-/Notes- lines for the
  nine languages, from tools/lib/i18n/toc.js.
- `travel build` gives every inn in `Nav/TravelData.lua` its AreaTable area,
  from the AreaTable `data build` caches (`tools/lib/data/areas.js`, also read
  by `compile`); `Compat.GetAreaName` reads `C_Map.GetAreaInfo`; Nav exposes
  `Nav.FindInn` and `Nav.BoundInn`. `tests/engine-l10n.test.js` plays the
  steps on a fake French client.
- Nav asks the router with the player's faction (`Compat.GetPlayerFaction`,
  opts.profile), chooses walks by the router's cost and shows and times them
  by its yards (`walkCost` returns cost, yards; `Walk.LegPath` returns yards,
  hubs). `Travel.WalkCostHook(fn)` lets a planner rule scale walk costs;
  `leg.hubs` carries the hostile towns a walk enters (journey line,
  `Travel.TakeWarning` for the arrow). `Nav.HandedOff()` is also true while
  Shortest Path Forever runs a journey not Polestar's
  (`Nav.handoff.Yielding()`).
- Pathing v2: the walking maps are format 2 (`nav pack`): every node carries a
  ground class (road, gentle or steep slope, indoor, indoor city, hostile-hub
  bits, from `nav layers roads` and `nav layers hubs` and grid v4's surface
  slopes) and every graph edge a cost per faction and its yards. The router
  (`Routing/Costs.lua`, `Path.lua`, `PathGrid.lua`) prices steps by class and
  profile, straightens only over ground no costlier, and returns `job.yards`
  and `job.hubs`; Zephras Isle is packed from our grid. `nav eval` measures a
  maps folder against a baseline (checks A1-A8 (A9, memory, by hand)).
- `sim compare` and `sim bench` take `--class`, so a chain written for one
  class can be measured: they passed `cls: null` whatever was given, and a
  quest open to fewer than five classes is left out without one, so a Priest
  or Mage chain scored as if its own quests were not there. With a class the
  chain's `only <Class>` goals and the class's quests count, its kill-speed
  prior applies, the best-found row comes from that class's `sim run` result,
  and the files are `compare-<faction>-<race>-<class>[-<pack id>].json` and
  `bench-<faction>-<race>-<class>.*`, so the class-agnostic ones are left
  alone. A name that is not a class is refused instead of silently dropping
  every class quest (thanks XrayAlpha).
- `sim run` and `sim robust` take `--class` in any case, as `sim compare` and
  `sim bench` do: they passed it on as typed, so `--class priest` missed the
  class table and searched as if the Priest's own quests were not there, and
  a name that is not a class is now refused instead of doing the same.
- `talents build` takes one plan file per class in `talents/forever/` and
  writes them all into `Builds.lua`, one class after another; every class's
  tree is known by its class skill line. Two stray talents in the client's
  tables are left out: a second Lightning Reflexes far off the Hunter tree
  and a second Holy Specialization below the Priest's Shadow column. Kept,
  they made the Hunter tree a fourth spec column and the Priest tree an
  eighth row. Rows a few units apart (Warlock's first and fourth) count as
  one, and a line the client only draws (a TraitEdge of type 0, VisualOnly)
  is no prerequisite: the Druid's Nature's Majesty and Nature's Splendor
  each seemed to need the other, so neither could be planned
  (thanks jnickles85-bit).
- Of several arrows into one talent, any one opens it, in `talents build`
  and in the addon's own check of a plan: the Hunter's Intimidation has
  arrows from Bestial Swiftness and from Bestial Wrath (which itself needs
  Intimidation), so requiring both made Beast Mastery's last talents
  impossible to plan (thanks jnickles85-bit).
- The Discord bot tells no #bugs thread about a pre-release: a test build
  published on GitHub as a pre-release is not "the fix is out", and the next
  full release still tells every fix closed since the last full one
  (`tools/discord-bot/lib/notify.js`).
- The boat, zeppelin, tram and lift captions ("Next boat in 1:20") can be
  translated: they were looked up through a variable, so no translator saw
  them.

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
  Voidglare's quests before Blood in the Streets); the instance Forever's
  quest data files a quest under counts (An Ancient Grudge in the Hall of Thanes,
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
  and an item a boss drops only rarely by the web database's count no longer ties a
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
  Stars, Onu is Meditating and the others Forever's quest data lists as renamed.
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
- 286 more NPCs show their level in Lookup (from Forever's NPC list data,
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
- `data build` applies Forever's "Renamed from Y" change notes too: a quest
  whose title is still Y takes Forever's name (its `source` gains
  `web:title`). It also reads Forever's class quest lists, so
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
  of Fire list their objectives in Forever's quest data order in the reference
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
  each with its warcraft.wiki.gg or classic quest data page), which `codex
  build` applies after the client's own gates and before a guide's; a row
  whose item, vendor or quest the Codex lacks is a build warning. Parity
  "items: rep" goes from 505 to 682 of 689.
- The Codex's web fetch reads Forever's NPC, object and item lists first
  (1,000 rows a request, by id range, cached under
  `data/sources/web/codex/lists/`) and fetches a cached page again only
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
  `codex parity` and the web fetch read the client tables of the build the
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
- The Codex's web fetch gets, one page at a time, Forever's web facts for
  what the parity report lists as missing (NPC level, rank, positions and
  drops with counts; object contents; item tooltip requirements) into
  `data/sources/web/codex/`, which a release `codex build` reads. The
  parity report now checks every internal-only fact against Forever (the
  client, the web database) and says whether it is a gap of ours, not in Forever, or
  unverified.
- `data build` keeps the droppers of pfQuest's reference loot tables (raid
  and boss loot) at an unknown rate instead of dropping them: Molten Core's
  tier pieces now name their bosses.
- A skill for coding agents, `skills/polestar-guide-pack/`: the workflow from
  `new` to `pack` (look up every id with `find`, then lint and playtest until
  both pass) and the guide format on one page. `new` copies it into the pack's
  `.agents/skills/` and `.claude/skills/`, and the pack's AGENTS.md points to
  it.
- `data build` reads Forever's zone quest lists (cached a day in
  `data/sources/web/`) and applies Forever's change notes: "Experience X
  instead of Y", "Level X instead of Y" and "Requires level X instead of Y"
  set X where the data still holds the old value (Scaring Shaky now gives
  3300 XP, not 820). Quests still without XP take the list's. `--no-web-zones`
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
