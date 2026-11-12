# Changelog

## 0.3.7.2 (2026-11-12)

### For players

- No more pointless flights. The arrow kept sending players on a flight and
  back when walking was faster: from the Crossroads to Ratchet and back, a
  hearth to the Crossroads then a flight to Orgrimmar, Stormwind to Sentinel
  Hill and back, Camp Taurajo to the Crossroads and back. Its walking maps
  counted a walk from where you stand as up to four times its length, so a
  flight on the far side looked quicker. They now measure every walk at its
  real length (#1890, #1924, #1946, #1947, #1948).
- The arrow also finds walks it used to give up on. From Stormwind's Old Town
  to the flight master it pointed through the back of Champion's Hall; longer
  walks failed the same way, about 1 in 100 in a sample of 2,000 (#1238,
  thanks asymptotic1).
- Stormwind: on the way to the Deeprun Tram, the arrow no longer leads up
  into Stormwind Keep. It takes you to the tram building's door in the
  Dwarven District, then inside and down to the tram. (#1242)
- Un'Goro Crater (Alliance 40-50): Mages reach level 50 in Un'Goro before Dink
  offers Magecraft in Ironforge, as Priests already do for Cenarion Aid. Before,
  they got there just under 50, and reaching 50 in Azshara sent the guide back
  to Ironforge (#1485).
- On top of Teldrassil, the way to Rut'theran Village (its flight master, the
  boats) no longer draws a walk straight down the tree: no path leads down,
  and jumping off the edge kills you. The route now goes through Darnassus and
  takes the portal down. The same goes for the boat from Rut'theran to
  Auberdine. (#1761)
- Cozy Sleeping Bag (Alliance): the way into Stonetalon comes from the north,
  by the Stonetalon Peak flight or the Talondeep Path from Ashenvale, instead
  of through Honor's Stand and past Sun Rock Retreat (thanks rcktman77). Off
  the Stonewrought Dam's ledge, the arrow now leads out of the river on its
  west bank, before the waterfall.
- The arrow casts a class teleport only when it clearly pays: it must save at
  least a minute over the best way without it, and a fifth of a longer trip.
  A Mage was sent to cast Teleport: Stormwind, spending a Rune of
  Teleportation, to save a few seconds over a flight (reported by Bandicoot,
  #1823).
- Loch Modan (Alliance): A Hunter's Challenge goes straight back to Daryl the
  Youngling after the boars, before the crocolisks and Daggerfang, so its
  12-minute timer no longer runs out on the shore (thanks Ami2).
- With "Use TomTom's arrow" on, TomTom's arrow now follows Polestar's route
  leg by leg: it points at the flight master, dock or portal the route takes
  next, then at the target once you're on the last stretch. Before, TomTom
  only got the final target, so its arrow pointed straight there: from Booty
  Bay to Grom'gol it led up the coast on foot instead of to the flight
  master. (#1834)
- Ashenvale (Alliance): the Tome of Mel'Thandris in the Howling Vale is read
  on the later visit to Shael'dryn's moonwell, a level or so higher, and the
  step warns of the Terrowulf packs and their rare Packlord (thanks
  ǝxǝ.ozuǝɹnɐๅ).
- Start zones: a Camping 101 step no longer waits for a quest the camp's host
  won't offer because you already know that profession's camp item (the
  trainer teaches it from skill 20); the step is skipped then (thanks Undead
  Lion).
- The Barrens (Horde Warriors): Trial at the Field of Giants takes the eggs
  and the antennae at the same mounds, then goes straight back to Ruga
  Ragetotem; the thunderhawks come after, so the 30-minute timer no longer
  runs out on the way.
- On a bridge, the arrow keeps you on the deck. Walking onto Silverpine
  Forest's bridge north-east of the Sepulcher from its south bank made the
  arrow think you stood on the beams above the deck, and it pointed back south
  before turning north. The same holds on every bridge the walking maps know
  (#1784).
- Duskwood (Alliance): the guide no longer sends you to Herble Baubbletump
  for a Bronze Tube; he is nearly always sold out. Get one at the Stormwind
  Auction House, or from Gearcutter Cogspinner in Ironforge's Tinker Town on
  the way, if he has one (#1792).
- Switching from Dungeons back to Guides clears the dungeon faction buttons, so Alliance and Horde no longer overlap the guide filters or intercept their clicks. The guide heading is restored too.
- A group quest you already picked up yourself no longer stops the guide at its accept step. When every later step for it (the kill, the hand-in) asks about it anyway, the guide moves on and asks at the first of those, where the answer matters. Barrens: WANTED: Bruuz taken at the poster held the guide in Ratchet.
- A dungeon's hand-in guide also takes a follow-up it has you pick up to its
  turn-in when the quest asks only for items you carry: after Excavation Site:
  Wetlands, Prehistoric Prism goes from Prospector Whelgar to High Explorer
  Magellas in Ironforge. Thanks to Onrevax for the report (#1817).
- A dungeon's hand-in guide keeps up with your quest log: a quest of that
  dungeon you take or finish after opening it (Earthen Echo for Excavation
  Site: Wetlands) joins the open guide, instead of the guide saying it is
  complete. A delivery the guide has you pick up on the way is handed in
  too, when its turn-in is on the same continent. Thanks to fekz for the
  report (#1748).
- Hillsbrad Foothills (Horde): Helcular's Revenge leads to Southshore's
  graveyard from the north, the way players reach it, and says where the
  town's guards stand beside the grave.
- Hillsbrad Foothills (Horde 30-40): if you bring Dangerous! from the 22-25
  guide without Farmer Kalaba or Citizen Wilkes, the catch-up steps now list
  them with the peasants and at the smithy (#1776, thanks Kolbi).
- Make room in your quest log (`/polestar questlog`) and the full-log notice
  now count every open tab: with a dungeon's pick-up guide open, the dungeon's
  quests and the quests your leveling guide in another tab still hands in are
  no longer listed as not handed in (thanks Mongo).
- Skyborne Druids following the leveling route now get the Druid class
  quests Tauren and Night Elf Druids get on it: Trial of the Lake and Trial
  of the Sea Lion to Aquatic Form, and Lessons Anew to Cure Poison, in The
  Barrens, Stonetalon and Hillsbrad (Horde) and in Darkshore, Westfall and the
  Wetlands (Alliance). Before, the route left them out, and only the class
  guides had them.
- At the Southfury River's road crossing between Durotar and the Barrens,
  the arrow says "Cross the bridge", not "Through the gate".
- The arrow's target goes to TomTom as a waypoint only when TomTom itself is
  installed. Another addon that answers TomTom's calls in its place (some
  waypoint addons do) no longer gets it, so that addon's own arrow no longer
  points at Polestar's target beside Polestar's arrow.
- With TomTom's arrow, a "Fly to" step no longer sends you across the map to
  the flight master the route expected you at: when you know the flight's
  landing and another flight master you know is much nearer, the arrow leads
  there (reported by Konky88: Ratchet instead of Thunder Bluff for Freewind
  Post).
- Tirisfal Glades (Undead Warlocks): Halgar's Summons is taken in Brill and
  handed to Carendin Halgar first, so he offers Creature of the Void.
- With Waypoint UI and "Blizzard waypoint" on, its beacon now leads the way
  the arrow does: to the portal, boat, flight master or crossing first, then
  on to the goal, instead of straight at the goal across them (#1741).
  (thanks Besaid)

### Forge

- `forge nav pack` names a passage a bridge, not a gate, when its gate is
  the ground under a bridge's deck over water (the Southfury River's road
  crossing between Durotar and the Barrens).
- `forge nav pack --leffe` writes each graph edge's own yards (the
  profile-free way's, as the grid's maps do). Every edge carried another
  edge's yards, so the in-game walk search's detour limit dropped walks the
  maps have and answered "unreachable".

## 0.3.7.1 (2026-11-12)

### For players

- Removed the Train All button and automatic spell learning at trainers.
  Existing settings cannot enable either feature. Choose and buy spells
  yourself using the game's normal Train button.
- The travel button (Hearthstone, teleport) stays under the arrow after a
  /reload instead of sitting near the top middle of the screen. It follows
  the arrow to its saved spot and size, after a drag, and while the arrow is
  hidden; a move during a fight takes the button along once the fight ends.
  (thanks rain, #1821)
- Brazilian Portuguese: the 78 guide texts 0.3.7's route changes left in
  English are translated, so every ptBR guide text is in Portuguese again.
  (thanks soulrocha)

## 0.3.7 (2026-11-11)

### For players

- Horde Hillsbrad & Arathi (29-33): Infiltration is still taken on the first
  Tarren Mill stop, but Henchman Valik and the Syndicate missive now come on
  the way back from Southshore, at about 31-32, instead of right away at 30
  next to the level 32-34 Syndicate. (#1466)
- Quest lookups and pick-up guides know that The Great Outdoors in every
  starting zone comes after The Adventurer is handed in at the camp: they had
  it as open from the start.
- Tailoring: a Night Elf learning it is sent to Trianna in Darnassus or
  Grondal Moonbreeze in Auberdine, no longer to Sinda in Dolanaar or Nadyia
  Maneweaver, who don't teach it; Nadyia now counts as a Leatherworking
  trainer. (thanks Critical Thinker and mjebalidev, #1577)
- While you're here no longer offers a click that needs an item you don't
  carry yet: Marla's Grave in Deathknell waits until you have Samuel's
  Remains from Samuel Fipps, and the line shows as soon as you pick them up
  (thanks Malifax and mjebalidev, #1578).
- Stranglethorn Vale (Alliance): Private Thorsen offers Jungle Secrets only
  while he is out of the Rebel Camp, at the foot of its path where Kurzen's
  agents ambush him every half hour. The arrow now leads there, the step says
  so, and the quest is optional, so a player who doesn't meet him isn't held
  at the camp (#1752, thanks mutaka).
- Un'Goro Crater (Alliance 49-50) and Stranglethorn Vale (Alliance 35-36) now say in
  the guide list why most of their quests are a few levels above the guide's range
  (on purpose, for the experience) and which mobs hit harder.
- Arathi Highlands & Swamp of Sorrows (Alliance 36-38): the Southshore step no
  longer waits for the Shadowy Assassin, a stealthed mob few players find, and
  the Fallow Sanctuary step no longer waits for Noboru the Cudgel, who walks a
  long path through the ruins. The Assassin's kill, Assassin's Contract,
  Baron's Demise and Noboru's cudgel quest are optional now: take them if you
  meet them; Magtoor still takes the cudgel if you carry it (thanks Fyurie).
- Stepping off the edge of a ledge or a dam no longer sends the arrow on a
  long way round. Near the Stonewrought Dam's east end in Loch Modan it could
  send you over the mountains to Grim Batol and back in through Dun Algaz to
  reach Chief Engineer Hinderweir, a few hundred yards along the dam (thanks,
  Rheuz, #1650). The arrow now keeps your ground level for a few steps where
  its map has none, so it walks you along the dam.
- The text under the arrow is wider, so a step like Accept "The Power to
  Destroy..." stays on one line instead of breaking onto a second (#1581).
- The arrow no longer gets stuck on a point of the walking path behind you.
  Cutting a corner on a hillside used to leave it pointing back at that
  corner until you walked within 5 yards of it, and running down a slope
  left it pointing back until you stopped. It now moves on with you, so you
  never have to turn back to unstick it, and when you leave the path it
  finds the new way sooner. (thanks Megabite and Paolo)
- "Set your home at the guide's inn" binds your Hearthstone on the first
  visit. Before, the game ignored Polestar's answer the first time, so only a
  second talk to the innkeeper bound it, and chat said "Bound your
  Hearthstone" even when it wasn't (#1652, first reported by Emil in #1298;
  thanks muffe and Emil, #1654).
- The arrow and Nearby services no longer lead you through a zone crossing you
  don't take: the way to Kargath's flight master and his vendor Sranda in the
  Badlands went to the Searing Gorge gate, 300 yards south, before turning
  back, because the data lists some NPCs on the next zone's map too and a walk
  could stop at a crossing it never went through. A walk now stops only at a
  crossing it takes (reported by LaboredGuineaPig, #1694).
- The bag button (the bag icon with the free slot count that deletes the
  cheapest junk) now has its own place on screen. Drag it on its own, the
  same way as the target button (Shift-drag with Lock arrow and buttons on),
  and it stays put when you move the other buttons. It starts where it was,
  and Reset button positions puts it back with the rest.
- The Barrens (Horde): Apothecary Helbrim's Apothecary Zamah, a 45-minute
  delivery to Thunder Bluff, no longer runs out on you. The guide now says to
  leave it when Helbrim offers it, since the route doesn't go to Thunder
  Bluff. Druids take it on the next Crossroads stop and hand it in first
  thing on their Thunder Bluff trip.
- Horde Barrens & Stonetalon: the last flight to Ratchet now shows only while you
  carry Sputtervalve's or Mahren Skyseer's quests. Without them the guide no
  longer flies you to Ratchet and straight back through the Crossroads for the
  next guide. (#1676)
- The Barrens (Horde 15-21) no longer sends you south-east to the Stagnant
  Oasis for Tonga's seed test alone and then back north-west to the Dry Hills.
  The seed test now goes with Verog at the same oasis, and the snapjaws for
  Altered Beings with Hezrul at Lushwater Oasis (#1644).
- Blacksmithing (Alliance): the Apprentice recipe steps no longer send new
  smiths in Ironforge to Ironus Coldsteel, the weaponsmith, who teaches
  nothing below 235.
- Enchanted Gold Bloodrobe (Warlock): the guide no longer sends you to the
  Burning Exiles at 31. The Smoldering Coal waits for level 37 and the Lesser
  Infernal Stone for 35, as their mobs are 36-39; the Hatefury vials still
  come at 31 (thanks, devanpy, #1667).
- A short line under the guide window's XP line says how long your campfire
  Boosted Rest lasts ("Boosted Rest: 42m") and, when you carry the Cozy
  Sleeping Bag, whether it is ready or how long until it is. Party members who run Polestar show their
  Boosted Rest in the party panel. Turn it off under Options > Quality of
  Life > Trackers > Boosted Rest status.
- A quest you work in one guide but hand in only in a later one (the Sceptre
  of Light, looted in Desolace and handed in at Azore's tower in the Badlands)
  now says so under its goal: "Keep this: you hand it in later in Badlands &
  Desolace (37–38)".
  When you finish the guide, the end window lists the quests still in your
  log that a later guide hands in, under "Carried to later guides", so you
  don't abandon them; with "Continue automatically" the chat names them.
- Clean up quest log no longer calls a quest unneeded when a later guide
  hands it in, even when that guide isn't loaded yet. A grey quest the next
  guide hands in is listed only with Skip grey quests on and nothing later
  needing it.
- Gelkis and Magram Centaur Reputation: taking only the Magram's Buying
  Friendship, or having handed in their first quest already, now takes you to
  the Magram half of the guide, and a Gelkis player is no longer sent through
  the Magram half at the end. The guide now has Carved Centaur Totems first:
  both clans' Buying Friendship quests are offered only once it is handed in.
- A quest giver who keeps a quest behind a chat option no longer gets a
  "Not offered? Report it" line: the step says to try their chat option
  first. Sovik in Orgrimmar gives Chief Engineer Scooty that way (#1762).
- A quest its giver only offers while you carry another one (Henchman Valik's
  errand while you have Krusk's Infiltration) no longer holds the guide once
  that quest is handed in or out of reach: the step moves on and says why,
  instead of sending you back to a giver who won't offer it (#1661).
- Class guides wait for the right level before sending you after mobs well
  above you: Whirlwind Weapon's exiles at 37 and Cyclonian at 38 (the Liferoot
  and Bloodscalp tusks now come first), Celestial Orb's and Orb of Orahil's
  Demon of the Orb at 38, the Obsidian Sentinel at 40 and the Tiara at 44,
  Brutal Armor's Hillsbrad miners at 25 and Roogug at 26, Fire Hardened
  Armor's chimaeras and Roogug at 26 and Gutspill at 30, Old Fire-Eye at 22,
  the incubus's Withered Scarf at 24, Shard of the Green Flame's Jaedenar
  essence at 53 (Azshara's now comes first), and Call of Air's totems at
  33-36 and the Ravaging Tempest at 38.
- Lookup shows the skill at which a trainer teaches each crafted item's recipe
  as Forever's trainers ask it (about 300 items were off by up to 50 points,
  e.g. Copper Mace at 15, not 55), and which trainers teach each profession.
- The item, NPC and quest lookups behind the Lookup window, the pace line and
  quest details take less time: an entry near the end of the data is found
  as fast as one at its start, and an id the data doesn't have is
  remembered as missing instead of being searched for again.
- Guide steps: a collect line names the mobs that drop the item when only one
  or two kinds of mob drop it, each at least one time in five (Dartol's Rod's
  Wooden Key: kill Withered or Crazed Ancients); before, it named them only for
  a drop chance of one in two or better (thanks collincusce).
- Prison Break In (Horde, Hillsbrad Foothills and the City of Dalaran pick-up
  guide): the arrow and map marks for the four Dalaran traitors, Ricter,
  Alina, Dermot and Kegan Darkmar, now point at the camp where they stand,
  about 100 yards south of where they used to point.
- Steps where players died among elites now warn about them: the elites in
  Elwynn's Jasperlode and Fargodeep mines and Shinyfinder Narf, Halikor on
  Durotar's Thunder Ridge, the Razormane camp's Flesheaters and Berserkers in
  the Barrens, and the Voidcallers at Darkshore's Tower of Althalaxx. Yeti
  Fur (Alliance Hillsbrad) and the Burning of Spirits' gems (Horde Desolace)
  now point at the mobs at your level, not at a camp four or more levels
  above you.
- Alliance Desolace (30-40): Carved Centaur Totems is now taken on the first
  visit with Centaur Bounty. The Kolkar drop the totems with their ears, so
  both are done at Kolkar Village and handed in on the same Nijel's Point
  stop. Thanks to rockzors.
- Alliance Desolace (30-40): Vahlarriel's Vengeance is now taken when you
  bring Vahlarriel the Malem chest's part of her search. The first Nijel's
  Point step asked for it before she offers it, so it could not be finished
  (#1579).
- Journey: with the new Options > Guide > Arrow & routes > Detour captions on, a walk that goes
  round a town of the other faction says so under its step, for example
  "Detour around Southshore". It only says so: the route and the arrow are
  unchanged, and it is off by default (thanks shatteredeagle, #1501)
- Quests the game hands in straight from the giver's window, with nothing to
  accept, are no longer listed as "Accept" steps that never tick: Whirlwind
  Weapon's Essence of the Exile at Bath'rah's Cauldron (reported by Fenn),
  Syndicate Emblems and Junkboxes Needed for Ravenholdt, Fine Gold Thread,
  Master Angler, the capitals' cloth donations, the Gahrron's Withering
  cauldron delivery, More Al'Aketh Ears, Mortal Champions and Free Knot!. In
  the leveling guides from 40 to 60 the same goes for the Scourgestones, the
  Videre Elixir, Salve via Hunting, Beads for Salfa, the Timbermaw feathers,
  Stranglethorn Fever, Locked Away, the Water Pouch and Troll Necklace
  bounties, Morrowgrain and the Super Egg-O-Matic: the guide no longer waits
  at an accept you can't take. You gather what they ask for and hand it in; a
  repeatable one no longer comes back as undone after a reload.
- When we answer a Discord bug report on GitHub (what causes it, a
  workaround, when it's fixed), the answer now appears in your #bugs thread
  too, and an edit to it updates the message there.
- The Discord #known-issues channel now lists the problems we know about,
  each with what to do until it's fixed, and says when a fix is on its way
  or out. The bot keeps it up to date.
- A bug report fixed in an update that's already out now says so in its
  Discord thread ("the fix is out in Polestar X") instead of "will ship in the
  next update", and isn't announced a second time with the next update.
- A buy or collect line that is ticked off without the items in your bags (the
  route moved past it, or you ticked it yourself) now says how many to get:
  "Buy 3 Soothing Spices", not just "Buy Soothing Spices". (#1631)
- A dungeon's entrance step (dungeon pick-up and attunement guides, Lookup's
  dungeon steps and leveling guides' dungeon runs) now says "Need a group?
  Press I for the group finder", with your own key for it. It doesn't show
  inside an instance or when your party is full. The step itself reads
  "Enter Wailing Caverns" instead of "Go to Enter Wailing Caverns", and the
  pick-up guide's last line says where to hand the quests in after the run
  without a slash command.
- Dungeon pick-up and hand-in guides: a quest item's step names the mobs that
  drop it ("Kill Burning Blade Fanatic or Burning Blade Apprentice for
  Lieutenant's Insignia"), a "talk to" step says to click through the NPC's
  dialogue, the quests already in your log are one line at the entrance
  instead of a row each, and a quest giver or hand-in right beside you comes
  first instead of after a trip across the world (#1589, #1590, #1591, #1593).
- The Dungeons pages now say who a quest is for: "Warlock only" in the
  class colour on The Orb of Soran'ruk, "Tauren only" and the like for race
  quests, on the quest card, its chain lines and attunement rows. One you
  can't take shows "Not for your class" (or race) with its name greyed, as
  the pick-up guide already leaves it out; Lookup's rows name the class too.
  Thanks to danagar for the report (#1730).
- "Guide me to the entrance" no longer keeps the arrow and the journey on a
  dungeon after you have been in it: the way there ends once you go through
  the portal, and the arrow is back on your guide. On the way, the guide
  window says where you are headed, with "Back to the guide". The map's
  dungeon pins, the training banner's Show and the class card's Show me end
  the same way once you are there. Any point of your own (a map click,
  /way) can be let go of any time: "Back to the guide" in the arrow's
  right-click menu, or the x on the journey's header. (thanks to Silverina,
  #1686)
- Dynamic Questing tells you about flight paths you pass: a friendly flight
  master near you whose flight path you haven't learned shows as "Learn the
  flight path at Thelsamar", with the guide's later step for it. Click it for
  the arrow. Learning it now ticks that later step. Turn it off under Options,
  Dynamic Questing, "Flight paths you pass".
- Flights and walks between quest hubs say what they're for: "Fly to Camp
  Taurajo" now reads "For Feegly the Exiled's quests" underneath, naming the
  next quest giver or quest the trip leads to.
- Dynamic Questing leaves a hand-in to the guide only when the guide walks you
  to that NPC about now, staying close to them on the way. Before, it held back
  any hand-in in the guide's next two steps, even when those steps first sent
  you a few hundred yards away and back.
- The "How close" setting's help now says what it measures: the distance to
  the middle of an objective's spawn area.
- Razorfen Kraul's page and pick-up guide: Elemental Aid (Horde Shamans)
  now comes from Prate Cloudseer near Freewind Post once Call of Air is
  handed in, and goes back to Rau Cliffrunner at Freewind Post, instead of
  Rau giving it and Bath'rah in Alterac Mountains taking it. Storm, Earth,
  and Fire and Heed My Call name Prate too (#1760). (thanks gabriel pasternak)
- The guide no longer sends you to a town or camp where nothing is left for
  you. When every step there is done, or doesn't apply to you right now (a
  quest you don't carry, a flight path you already know), the walk there
  passes and the guide goes on to your next work. Example: standing in Camp
  Taurajo in Ashenvale & Thousand Needles, you were sent back up to Thunder
  Bluff for nothing (#1596, reported by Redrett).
- While you're here no longer suggests taking an escort quest early to save a
  trip back: the escort starts walking the moment you accept it, so it waits
  for its own step, which keeps its warning (#1618, thanks MattMer).
- Steps with several independent field objectives now plan the remaining
  trip to reduce backtracking, with a soft preference to leave quests above
  your level until later. Priorities update as you level, while required
  waits, interactions, camp safety and manual waypoint choices still hold.
  (thanks Emlembow)
- Horde: the Barrens guide learns Ratchet's flight path on your first stop
  there, beside Sputtervalve, instead of after the beach. Tauren learn Camp
  Taurajo's flight path when they meet Kirge Sternhorn on the way out of
  Mulgore.
- Take the marked flight (Quality of Life, Travel, Flight masters; off by
  default): when the flight map opens, it flies you to the destination the
  guide marked. Hold Shift at the flight master to choose yourself (#1621; thanks muffe, #1646).
- The route no longer flies you back the way you came to walk on from a far
  flight master: a landing more than 3,000 yards from where you're going was
  priced by a straight line while your own walk was measured over the ground,
  so from Camp Taurajo the way to Feegly the Exiled went back to the
  Crossroads (reported by PSYzera). That landing's walk is measured now too,
  and the route waits for it before it changes.
- A walk or flight the guide passes because a flight comes next stays passed
  once that flight lands. Landing in Camp Taurajo no longer sends you back up
  to Thunder Bluff and then to Camp Taurajo again, and the same goes for
  every other walk straight before a flight (Duskwood before the flight to
  Stormwind, the tram before the flight to Southshore). Thanks to Etienne for
  the report (#1768).
- The arrow no longer picks a walk along a road over a flight, boat or
  Hearthstone that gets you there sooner, and it no longer sends you to a
  flight master to save a couple of seconds (#1603).
- The card that says the Polestar founder is nearby now comes at most once a
  day per account, and a /reload or relog no longer resets it (it was once
  every half hour per session). Still never in combat or instances. The card
  now shows the founder's own emblem instead of the gold star.
- Herbalism and Mining loops lead through each zone's common nodes: a herb or
  ore only a few spots carry no longer pulls a waypoint to itself or names it
  (Mulgore's loop is back at its Peacebloom and Silverleaf spot instead of a
  Stunted Silverleaf one). The step's tip still lists the rare kinds.
- Gear advice: a quest you are about to accept now shows a muted line "Reward:
  <item> +N% · at turn-in" when its best reward choice is an upgrade for you,
  so you can see a good reward before you start the quest. It stays off with
  gear advice off. (idea by IgorMagals, built by shatteredeagle, #1494)
- When the guide window reaches its maximum height, the goals list now ends on
  a whole goal instead of cutting a two-line goal in half under the tip (the
  rest still scrolls).
- Group quests: when the route passes a group quest because you chose to skip
  it (or set every group quest to skip in Options), the guide window says so,
  naming the quest and where to change the answer, instead of moving on
  quietly (thanks Optimistic Teammate).
- The guide window has a Lookup button that opens search directly, with the
  search box ready to type in (thanks fekz; built by MattMer, #1615).
- The guide menu's "If you finish this guide" card no longer counts
  thousands of kills for a quest item it only has a stray drop rate for:
  the Hillsbrad Foothills & Arathi Highlands guide said +12 levels from
  120,188 kills, and the Dustwallow Marsh, Desolace and Badlands guides
  over 3,000 kills each. Thanks to Mateo for the report (#1697).
- Polestar Guides unticked in the AddOns list (it sits indented under Polestar
  there, and ticking Polestar alone leaves it off): Polestar now says so
  instead of "No guides installed", asks once at login (never in combat), and
  the guide window and the guide menu have a Turn on Polestar Guides and
  reload button that turns it and its race, faction and walking parts back on
  for all your characters.
- A click on the step's header in the guide window, or on one of the step's
  goals on the world map, now leads the arrow there the same way a click on
  the goal's line does. A click on the arrow then moves on to the goal's next
  spot again: before, the arrow stayed on one spot, for example on the
  Discarded Fishing Toolbox in Loch Modan, which lies in one of several places
  (#1653, thanks Rheuz).
- The Hearthstone and quest item buttons no longer stay on screen during a
  flight: they go while you're on the taxi (the step key skips their items
  too) and come back on landing if the step still needs them. Flying to the
  hearth's town instead completes the step when you land there. Flying over
  a hearth town or an "enter" place on the way somewhere else no longer
  counts as being there.
- A click on the minimap button now hides everything Polestar shows: the
  guide window, the arrow, the buttons, alerts and toasts, the lines and pins
  on the map and minimap, the marks on your bags, quest windows, nameplates
  and tooltips, and its sounds. Click again and it all comes back as it was;
  your guide keeps up with what you do meanwhile. The button dims while
  Polestar is hidden, and Polestar stays hidden after a /reload. The floating
  button, Polestar's entry in the addon list on the minimap, a new "Hide/show
  Polestar" key binding and /polestar hide do the same. In a fight the action
  buttons go or come back when it ends.
- The minimap button's right-click menu now has the guide window, the arrow,
  "Hide Polestar" and, right under it, "Keep the arrow when hidden": with it
  ticked, hiding leaves the arrow, its travel button and its arrival sound.
  It is set per character, and also under Options, Guide, Window, Show and
  hide, and with /polestar hide arrow. Opening the guides, Lookup or the
  options brings a hidden Polestar back.
- Hillsbrad Foothills & Arathi Highlands (Horde, 29-33): if you skipped the
  22-25 Hillsbrad guide, the guide now starts with Darthalia's first Battle of
  Hillsbrad quests and Krusk's The Rescue from Tarren Mill, so the rest of the
  Battle of Hillsbrad and Infiltration are no longer hidden. Players who did
  the earlier guide see no change (#1660, thanks creazy231).
- Hillsbrad Foothills (Horde): the Flame of Uzel step now warns that Giant
  and Mountain Yetis (32-34) stand around the flame in pairs and the rare
  Frostmaw (37) roams nearby, and how to light the flame safely at 30-31
  (thanks Tincho).
- Hillsbrad Foothills & Arathi Highlands (Horde): Helcular's Rod points at
  the Foothill Caverns' Cave and Ferocious Yetis (30-32) instead of touring
  the cave of 32-34 yetis further north, where players at 29-30 were sent to
  farm it (thanks, Kolbi, #1695).
- Horde Ashenvale & Silverpine (21-22): Ashenvale Outrunners (level 24) now
  waits for the second Ashenvale visit at 26, where it is taken at the
  Warsong lumber camp between Torek's assault and Sharptalon's woods, instead
  of sending you after level 23-24 night elves at 22.
- Horde Ashenvale & Thousand Needles: the Galak centaurs step tells you not to
  wait for the Galak Messenger, who walks a long path between the camps; his
  note and quest stay optional.
- Horde Hillsbrad & Arathi (29-33) now says in the guide list why most of its
  quests are level 32-34: on purpose, for their experience, with a reminder
  to pull the Syndicate, Dalaran's guards and the ogres one at a time.
- Horde Skyborne Shamans now get Storm, Earth, and Fire (Call of Air) among
  the quests Polestar shows as available and as follow-ups: the quest data had
  it closed to them. The data also keeps Forever's own race limits on the
  Zephras Isle quests both Skyborne starts share and on other quests a newer
  version of the community quest database narrows, so updating it later won't
  hide quests from the races that take them.
- No more stutter while the arrow guides you indoors (the Undercity, buildings,
  caves): reading which floor you're on took up to 40 ms several times a
  second there, and now takes a fraction of a millisecond. The arrow points
  and picks your floor exactly as before (#1682; thanks to filthy and Noxis).
- The journey under the step no longer lists the same walk twice. A walk to a
  zone crossing and the walk across it read "Go to Durotar" two times over;
  now they're one row, "Walk to Durotar", with their times added. The arrow
  says "Walk to <zone>" at a crossing too.
- Favor for Krazek explains that Lesser Bloodstone Ore needs Mining 75, with
  the Auction House or a miner friend as alternatives, both at pickup and in
  Drywhisker Gorge. The quest is optional throughout, so players without the
  ore can continue with Myzrael and the rest of the route (thanks Fyurie;
  built by MattMer, #1609).
- When you level up, a quiet card on the guide window shows the class spells
  you can now train, with the game's tooltip on each icon, what they cost
  together, whether you can pay it, and where to train: your guide's own
  training stop when it is a few steps away, else the class trainer that fits
  your route, with a button for the arrow. It goes by itself, and stays away in combat, in
  dungeons and on levels with nothing new.
- Your action bars keep the exact rank you put on them, so after training
  (and at login) Polestar now lists the spells on your bars that are a lower
  rank than your spellbook's, and Upgrade puts the highest rank in those same
  buttons, out of combat. Macros and items are never touched. Right-click a
  spell on the card to keep it at its rank; a lower rank you put on a bar
  yourself is kept too. Both are under Options > Quality of Life > Vendors >
  Trainers.
- World map objectives drawn as areas cost much less while you zoom or pan
  the map, on OpenMap's map too: only the areas around what you're looking
  at are drawn, not every one on the zone or continent.
- Mulgore: Seer Graytongue and the shrine of An'she and Mu'sha now come during
  the Mountain Cougar hunt (the Seer's tent stands in the cougars' hills),
  instead of walking up to Grull and back down to the Seer.
- Nearby services no longer walks you out of a capital and back in: asking for
  Orgrimmar's First Aid trainer from inside the city sent the arrow out of the
  gate into Durotar and round, because the data also lists Arnok on Durotar's
  map. The city's own spot now wins, for every service NPC listed on both maps
  (Orgrimmar, Thunder Bluff, Darnassus, the Undercity and Ironforge).
- Nearby services and the service pins on the map lead to the right floor in
  stacked towns: asking for Reagents in the Undercity sent the arrow to the
  top of the lifts, over Thomas Mordan's spot, instead of down to him in the
  Trade Quarter. Every service NPC and mailbox with a known height is now
  sought on its own floor (#1639).
- Playing together: a party member on another Polestar version gets one line
  in chat per session ("Ana is on Polestar 0.3.6: your guides can differ."),
  since guides change between versions. Under a quest goal, a member who
  already handed the quest in now reads "already done" instead of just lacking
  it, and a member whose class or race can't take the quest is no longer
  listed. The party sync notice now comes the first time a member's progress
  shows, and says both ways: you and your party see each other's quest
  progress.
- Clicking a party member to have the arrow lead to them now chimes once when
  you reach them, and then the arrow is back on your guide. Before, the chime
  could play over and over while you kept up with them. On the way, "Back to
  the guide" in the guide window cancels it. It ends by itself if they leave
  the party or go offline, instead of moving on to whoever took their place
  in the party. (thanks to a player on Discord)
- Less work in the background, so fewer hitches: item data arriving for
  items gear advice never looked at (trade chat links, vendor pages) no
  longer makes the guide and the bag arrows recheck everything; a party
  member's XP gain repaints only the party panel instead of the whole
  guide window; the party panel reads the party once per repaint instead
  of twice; and the first item tooltip, quest loot line or quest accept of
  a session no longer stalls for a moment while the quest database builds
  its indexes. Nothing shows or reacts differently.
- A dungeon's pick-up guide now says why each quest out in the world is in
  it: "Needed for “The Wrath of Rath'mael”" on Rear Guard Patrol in the Ruins
  of Lordaeron's, "Leads to ..." on a breadcrumb. Quests built on the spot
  (pick-up, attunement and Lookup guides) also warn "Elite: group advised"
  when a step asks you to kill an elite out in the world or collect what one
  drops, as the leveling guides do.
- Profession guides know more of Forever's trainers and rules: Herbalism,
  Mining and Skinning ranks ask no character level, nor do Cooking's and First
  Aid's Journeyman; the arrow can now send you to Kamari (Orgrimmar), Dan
  Golthas (Undercity) and Shelene Rhobart (Brill) for Leatherworking, Cook
  Torka (Razor Hill) and Pyall Silentstride (Bloodhoof Village) for Cooking,
  Vira Younghoof (Bloodhoof Village) for First Aid, and more. Rugged Leather
  and its kin are learned at 225, the Tanning Rack at 125 (Forever's
  2026-11-06 hotfixes), Forever's leather armor and pants patterns 5 points
  before they turn yellow.
- Profession guides rebuilt on Forever's trainers and recipes: Leatherworking
  takes 150-225 on Heavy Armor Kits, Barbaric Shoulders, Guardian Gloves and
  the Nightscape Headband and Pants, since Forever's trainers teach Thick
  Leather at 175 and Rugged Leather at 225 (thanks Syrio86, #1553). Cloth for
  First Aid, Tailoring and the other crafts is counted in your bags (keep what
  you loot, take it from your bank or buy it), never a farm trip; Night Elf
  miners start on Teldrassil's Amber; and each guide's header names the
  trainers that teach each rank and from which skill.
- Profession guides start where you are: load one with First Aid at 120 and it
  opens at the 115-125 bandages, not at skill 1. Each skill range is a heading
  over its steps ("First Aid 1-40"), the one your skill is in highlighted, and
  the materials ask only for what the range still needs (no Linen Cloth for
  ranks you have passed). Skill-ups and new ranks update it as you go; a rank
  you still need to train is never skipped.
- Profession guides: the Expert and Artisan training steps point only at the
  trainers who teach that rank on Forever. Expert Leatherworking no longer
  sends you to Simon Tanner, Fimble Finespindle, Karolek or Arthur Moore, who
  teach only up to Journeyman (thanks mutaka, #1608). The same fix covers
  Alchemy, Blacksmithing, Engineering, Tailoring and Enchanting, and Skinning
  no longer lists Killian Sanatha, who teaches Fishing.
- An item you loot that starts a quest you can take now shows on the quest
  item button with a glow until you click it or take the quest. The step's
  own item still comes first, and several such items wait their turn, oldest
  first. Items for another race or class, or above your level, never show.
  Option: Show quest-starting loot (on by default).
- Inside a dungeon or raid, the quest tracker shows only that instance's
  quests, and Polestar's quest markers follow. The quests you were tracking
  come back when you leave, in the same order, even after a reload inside.
  Option: Track only dungeon quests in dungeons (on by default).
- Added /rl as a shorthand for reloading the UI (thanks RikyZ90, #1503).
- Added a Train All button to the class trainer window (Quality of Life >
  Vendors > Trainers, on by default) that learns every available skill in one
  click and prints the total spent and any skills it could not afford; the
  auto-learn option is now called Auto-learn new spells, to tell it from the
  button (thanks RikyZ90, #1503).
- Twenty quests now show the experience they really give on Forever, taken
  from players' recorded hand-ins (Good Steel, Baited for Success, Expanding
  Horizons and others), so the level estimates along the guides are closer.
  Call of Fire also lists Teo Hammerstorm in Dun Morogh as a giver.
- Polestar's Target, quest item, Hearthstone, rare, bag and travel buttons can
  now be bound from the game's Quick Keybind Mode (Options > Keybindings, or
  an action bar addon's /kb): hover one and press a key. While that window is
  open, the buttons the guide doesn't need right now show dimmed in their
  places so you can bind them too. Polestar's key bindings, the Recorder's
  included, now have their own Polestar section in Options > Keybindings with
  shorter names that fit the list, and searching "polestar" there finds them
  all.
- The report box takes up to 1,000 characters, so you can say everything
  that went wrong; it grows as you type, then scrolls. Copy report always
  keeps your words whole: when the report wouldn't fit in one Discord
  message, it leaves out the details that matter least (other addons,
  settings, guide packs, far-off goals, the quest log) and says so at its
  end. "Open on GitHub" carries your whole description too, except a very
  long one in Cyrillic, Chinese or Korean, which GitHub's link can't hold.
- The "Report a problem" window no longer draws the whole report over
  itself after you change the UI scale or window size, and a long report
  (many addons, a repeating error) now scrolls inside its box under Copy
  report instead of making the window taller than the screen; Copy report
  still selects all of it, and in any of Polestar's copy boxes Ctrl+A
  (Cmd+A on a Mac) selects everything again. The dungeon
  page's title also stays hidden over the dungeon's picture after such a
  change (#1753).
- Reset guide progress keeps the guide where your quests put you. It clears
  your check-offs and skipped steps from your last quest progress on, and
  no longer sends you back to a step you skipped long ago because its
  quests can still be taken. A step you skipped before that comes back when
  you click it in the step list (#1764).
- Fixed a Lua error ("Engine.lua: table index is nil") when the guide moved
  past a quest that starts from an item while that quest couldn't be taken
  (reported by Fyurie). The notice now names the quest the item starts.
- Fixed a repeating Lua error ("Engine.lua: attempt to compare nil with
  number") after picking another spot of a "kill these as you meet them"
  goal by hand while the other spots had been worked lately (reported by
  doctor-house).
- Browse all steps: a click on the step number in the guide window lists every
  step of the guide in place of the step card, each with its people and goals,
  done ones ticked and the live step marked. A click on a step looks at it; a
  second click on the number or Escape closes the list. In every look and in
  compact mode (thanks TTik3r; built by aalejandrofer, #1678).
- Class quest cards and dungeon heads-ups now come one level before their
  quest's level, not as soon as the game lets you take it. The game often
  offers these quests 3-5 levels early (The Eye of Bhossca, level 35, at 30),
  so several cards and tabs piled up at once. The guide list and a dungeon's
  page still open them early when you want them. A dungeon heads-up's "Pick
  up the quests" takes the quests it offers now and says when the rest come
  back.
- "Suggested for you" lists the guide after an open one from one level below
  it, not two.
- Less work on every step change and every few seconds while you play: the
  guide counted the done steps of every open tab each time, for a number
  only a tab's tooltip and the guide list show. It now counts them when you
  hover a tab or open the guide list.
- A step change early in a long guide no longer stalls a frame for the pace
  line under the steps: the levels each step's quests and kills give are
  worked out once, not again from the start of the route each time.
- Alliance Tanaris (40-50): the Mirage Raceway step no longer asks for
  Zamek's Distraction. It is part of Keeping Pace, which the Alliance route
  leaves out, so Zamek never offered it and the step could not be finished.
- The target button names every creature a step's quest item works on and
  every creature its kill counts: on Kodo Roundup it offers the Aged, Dying
  and Ancient Kodos the Kodo Kombobulator tames, not just the Aged ones
  (thanks rockzors, #1614).
- On collect steps whose spots run through several camps, the target button
  names the mobs of the camp the arrow takes you to: on Centaur Bounty the
  Magram at Magram Village, not the Kolkar of the step's first camp (thanks
  rockzors, #1616).
- The target button and the step key now reach the While you're here mobs on
  a step that sends you to an NPC: while you're farther than the While you're
  here radius from the step's NPCs, the mobs come first and the NPC after;
  once you're close, the NPC comes first and the mobs after. Thanks Emil
  (#1623).
- A timed quest your guide doesn't hand in now gets its own row at the top of
  the guide window: its time left, where it goes and about how long the trip
  takes, and "this guide doesn't go there". Click it to point the arrow at the
  quest's hand-in, or right-click to hide it until the timer ends. Timed
  quests no guide picks up also count down now when the game shows no timer.
- The class training reminder no longer sends you to another trainer when
  your guide trains you within the next 10 steps: it says "The guide trains
  you in 10 steps (Orgrimmar)." instead. A level-18 Tauren at the Crossroads
  was told to go to the Valley of Trials while the guide was about to train
  them in Orgrimmar.
- Training lines now say what they mean: "Learn new spells from <trainer>" at a
  class trainer, "Learn <skill> from <trainer>" for a weapon or profession skill,
  and "Learn from <trainer>" otherwise, instead of "Train at <trainer>", which
  could read as "grind here". (#1669)
- Profession training steps point only at trainers who teach at your skill.
  A trainer only offers training once your skill reaches their level (the
  Undercity's Doctor Herbert Halsey from Alchemy 125, Josephine Lister from
  Tailoring 200, a city trainer from 50), so Journeyman Alchemy no longer
  sends you to Halsey (#1708), Linen Belt no longer to Josephine Lister
  (#1498), and Expert ranks no longer to the Artisan trainers far away.
- Guide window, Transparent style: the soft shade behind each line is light
  again. In 0.3.6 it drew as a black block behind the text (#1684).
- Guide window and party panel: a count like 0/6 never splits across two
  lines any more; it moves to the next line whole (#1684).
- After a theme change, confirm dialogs still dim the screen behind them
  instead of turning it black, and the world map's info bar stays
  see-through.
- After an update adds a step behind you for a quest you already carry, the
  quest now shows under "Still to do" (and While you're here offers it) even
  when its hand-in is still ahead in the guide. After 0.3.6, The Sacred
  Flame's phial steps in Ashenvale went missing this way for players already
  past Raynewood Retreat (thanks creazy231, #1595).
- Polestar now tells you when a newer version is out. At login, a card on
  the guide window says which version is out, which one you're on and how to
  update (Polestar Client can do it for you); What's new gives you the
  release notes' link and Got it keeps the card away for a day. A line in the
  guide window stays until you update. Two or more updates behind, the card
  says so and still shows (once a day) with its option off. The newest
  version comes from Polestar Client when you have it, else from party and
  guild members running Polestar, and from players of your faction you
  target or mouse over outside cities (one hidden version check each, at
  most once a week per player and 10 a session; off with party sharing or
  its own option). Never in combat, in dungeons or in the
  first minutes of a fresh install; the option is under Options > Guide >
  Window.
- When you report a problem from an older Polestar, the report window asks
  you to update first (your problem may be fixed already), and the report
  says which version is the newest.
- Polestar Client tells the addon the newest Polestar release after each
  check for updates.
- Updating mid-guide keeps your place when the new version changes a step
  you'd already passed. Updating again in the middle of a guide no longer
  brings back steps an earlier update had passed for you, and a guide the
  update did not change keeps your place and everything you checked off or
  skipped.
- The walking router uses far less CPU while you follow the arrow round an
  objective: it no longer searches a whole map tile every time the arrow asks
  again from a few steps on, so fewer frames go over its budget. Walks and
  their costs are as before (thanks AlverezYari).
- Fixed a Lua error ("attempt to index local 'was'") when the walking line of
  a later part of your route found no path while its sketch was still being
  drawn.
- While you're here shows an objective once, however many steps of the guide
  hold it: Raptor Horns, collected on each Barrens raptor camp visit, no
  longer fills three rows. The row names the earliest of those steps and
  measures to the camp nearest you, and dismissing it dismisses it for all of
  them. A hand-in or pick-up that several steps hold shows once too.
- Zephras Isle: after Lorthuna, the arrow no longer says to hearth back to
  Valanaar. Routes now know both portals on the isle, the shrine's portal up
  to the Rohashi Spires and the Portal to Valanaar beside Lorthuna, so the
  arrow takes the portal down. (#1674)
- Simplified Chinese: the Loch Modan, Redridge & Westfall guide (19-21)
  has a native speaker's review, checked by playing through the route;
  names follow Forever's own Chinese data, not retail's (thanks 山猫, #1803).

### For guide authors

- In a guide whose `class` header names a class, that class's own spells are
  name tokens even where an NPC, object or item has the same name: in a Mage
  guide "Cold Snap", "Ice Block" and "Frostbite" are now the Mage spells, no
  longer the staff, the object or plain words, so a German client shows the
  spell's name in a Cold Snap step, not the staff's. No `reward spell` line is
  needed for that; the guide's own names still come first, and a place keeps
  its name (#1504, thanks Tom; built by FlexusDev, #1519).
- A `learn` of a class spell (or a talent, or a spell Forever added) no longer
  warns "spell N is not in data ... (new Forever content?)": a spell one of
  the client's skill lines teaches is known, and `learn <spell>` without a
  quoted name takes the client's name for it. A spell the client does not
  teach still warns, a profession's recipe still needs professions.json, and
  `craft` still needs the recipe in data (#1505, thanks Tom; built by
  FlexusDev, #1520).
- The compiler writes `carriedTo` (a guide id) on the quest work of a quest
  the guide leaves for a later guide of its chain to hand in, when every
  route and every character the goal applies to hands it in there
  (GUIDE_FORMAT.md, "Quests carried to a later guide"). Nothing to write in
  the guide; recompile to get it.
- An `accept` of a child quest compiles its `parent` (the quest it is offered
  under) from the quest data; Polestar passes the accept once the parent is
  handed in, or while the parent is not in the log and the guide no longer
  brings it (docs/PACK_FORMAT.md).
- New goal modifier `collect <item> xN anywhere`: a bag count with no place,
  so the arrow never leads to it. Without it a bag count is placed at one of
  the item's sources, which for cloth is one humanoid of hundreds near
  wherever the guide happens to be. The profession guides count their cloth
  this way.
- The compiler gives a `kill` bound to an objective the data credits on
  several creatures, and a `use` of the item such a quest hands over, those
  creatures as `fromNpcs`; a `collect` whose spots hold sources its point
  leaves out gets them in `fromNpcs` too, with `fromNpcsAt` saying which
  spawn at each spot (docs/PACK_FORMAT.md). The target button reads both.
- New guide keyword `section <Profession> <from>-<to>` (GUIDE_FORMAT.md
  "Sections"): a profession guide's skill range as a heading over the steps
  that follow it. Polestar marks a range's steps done once the player's skill
  has passed it (a rank its steps train still holds them) and asks only for
  the materials the range still needs. Older Polestar versions ignore it.

### For contributors

- `forge release credits` also counts a pull request that is still open but
  merged into the release at its exact head (an integration branch's merge),
  so a release built before its push to `next` thanks every contributor whose
  work it carries.
- Release gate for danger at the spot: `node tools/danger-gate.js` checks
  every leveling guide's kill, collect and use goals against the hostile mobs
  around them at the route's level (mobs well above you, elites, rares, packs,
  high camps) and fails on any flag missing from the reviewed baseline,
  `data/danger-baseline.json`, where each row gives its reason and evidence.
  A new flag is fixed in the guide or reviewed into the baseline. (#1575)
- The Discord bug bot no longer drops thread messages: what is said while a
  post waits for the hourly limit is copied to the issue once it is filed,
  messages sent while the bot was away or that GitHub failed to take are
  caught up, edits to a follow-up rewrite its comment, and a post its player
  tagged In progress is filed instead of skipped. Pins and renames are no
  longer copied as comments. Screenshots over 5 MiB (full-size PNGs) are now
  copied to GitHub as WebP instead of left as a Discord link.
- `polestar studio` renders a feature as it looks in game without logging
  in: scripted scenarios (a character, a place, a guide some steps in, the
  bags, bars and party, then a ding, a hover or a party member's message) run
  the real addon on the test client, with spells, items and tooltips from the
  client's own tables and client art from a local cache that is never
  committed. `--serve` shows them on a local page that re-renders on every
  Lua change; `--checkout` renders another branch's worktree. See
  tools/README.md, "The Feature Studio".
- A batch's full suites, guide compile and playtests (per guide group and
  class), and gates (skip-ahead and upgrade cases, the guide pack's memory,
  lint, reported cases) now run on GitHub's runners, started by hand on a
  pushed branch and compared with `next`, with reference data built there
  from public sources: docs/CI.md.

### Forge

- Item corrections can add droppers every source missed (`addDrops`,
  `{ npc: [ids], object: [ids] }`, added with no rate), as players'
  recordings show them. First use: Carved Centaur Totem from the Kolkar and
  Magram centaurs (#1602).
- The data build reads the community quest database's player-trace quest XP
  (`xpDB-traces.lua`, from 1.0.13) after its classic table, the traces
  winning; players' recordings still rank above both.

## 0.3.6 (2026-11-10)

### For players

- Hovering a quest to accept in the guide window now says why its giver may
  not offer it yet: "Level" shows the level the quest needs, in red while
  you are below it, and "Needs" names the quests you still have to hand in
  first. (thanks Xaden Ryan)
- Nearby services and the class-training reminder send a Shaman in Thunder
  Bluff to Siln Skychaser on Spirit Rise, not down to Palah Thunderhoof in
  Mulgore, and offer Stormwind's priests Nara Meideros too. (thanks Solgnir
  and muffe)
- The gear advice no longer suggests a profession tool as your weapon: a
  Skinning Knife, Mining Pick, Blacksmith Hammer, Arclight Spanner or Frying
  Pan is never an upgrade over the weapon you fight with. (thanks
  Staatiatwork)
- Image of Archmage Modera is shown only at the Kirin Tor camp in Silverpine
  Forest, where she stands, no longer by Dalaran's sewer entrance in Alterac
  Mountains: the Arathi Highlands guide's An Alarming Request hand-in and the
  City of Dalaran pick-up guide send you to her. (thanks rockzors)
- Gear advice no longer overrates items with bonus damage to several spell
  schools (Staff of Soran'ruk now ranks below Spine of the Devourer) (thanks
  rockzors)
- Dungeons: two turn-in NPCs the data placed nowhere now have their spot, so
  the pick-up and hand-in guides send you to them: Lady Dena Kennedy in
  Stormwind City for the Alliance's Crest of Lordaeron (Ruins of Lordaeron),
  and the Deathstalker Agent in the Wetlands for the Horde's Dragonmaw Rumors
  and Open the Maw (Excavation Site: Wetlands).
- Dungeons: "Hand in the quests" for Wailing Caverns now takes The Glowing
  Shard: it sends you to Sputtervalve in Ratchet first, then to Falla
  Sagewind to hand it in and take In Nightmares. A dungeon quest whose only
  open quest-log lines are to speak to someone outside is now handed in
  after that talk instead of being left out as not finished. (thanks
  TrustmeXD)
- With six guide tabs open, a dungeon's pick-up, hand-in or attunement guide
  and the Codex's "Guide me" no longer replace the guide you have open
  (often your leveling guide); they say that six tabs is the limit, as the
  guide menu does. A hand-in guide still takes the tab of a pick-up guide
  you have finished. (thanks Kolbi)
- After an update that moves a part of the route to another guide, your
  guide tab follows your quests: 0.3.5 turned Stonetalon Mountains &
  Ashenvale (Horde) into Ashenvale & Silverpine Forest and moved Sun Rock
  Retreat to The Barrens & Stonetalon Mountains, so a character in the
  middle of Sun Rock found the tab in another zone. A tab whose guide kept
  less than half of its steps now moves, once your quest log is in, to the
  leveling guide that has most of the quests you carry, and chat says where
  it went. (thanks Kolbi)
- The guide window's pace line, near a guide's end, says the level the route
  gets you to ("On pace for level 22.4 by step 97") instead of the guide's top
  level, which a character already at that level was told it was on pace for (#1330, thanks mcclaskiem).
- Horde: The Tear of the Moons (a level 30 quest beside General Twinbraid) is
  done at about 28, on the road from Camp Taurajo to the Great Lift in
  Ashenvale & Thousand Needles, instead of at 26 in The Barrens & Stonetalon
  Mountains, where the guide told everyone to reach level 28 first (#1333).
- A walk the guide labels only with a zone's name no longer reads "Go to
  Mulgore" while you are already in Mulgore: it says where it leads, "On
  through Mulgore to The Earthen Ring". In Ashenvale & Thousand Needles, the
  walk from Camp Taurajo to the Earthen Ring camp is named for Skywatcher
  Plateau, with a tip on the way up. (thanks Tropix)
- Ashenvale (Alliance): Insane Druids now leads to the mouth of The Dor'Danil
  Barrow Den before the three druids, not onto the hill above them, and its
  tip says they are inside the barrow, apart, rather than at the Forsaken camp
  (#1336, thanks Bennistrov). Teldrassil and the Darnassus reputation guide
  lead to the Ban'ethil Barrow Den's mouth the same way before the relics and
  Oben Rageclaw.
- Darnassus: the arrow to Mathrengyl Bearwalker and Arch Druid Fandral
  Staghelm, upstairs in the Cenarion Enclave's druids' building, now leads to
  the building's door and then straight to them, instead of round past the
  hunters' building onto a ledge outside, behind the wall (#1338, thanks
  Jaesais). This covers the druid class guides (Cure Poison, Aquatic, Bear
  and Cat Form), Teldrassil, Darkshore, the Wetlands, the Hinterlands,
  Western Plaguelands, Silithus and the Darnassus and Cenarion Circle
  reputation guides. A second quest at the same NPC (a turn-in before the
  accept) keeps the straight arrow too.
- Every leveling guide now works when you start it without the guides before
  it (a fresh start at its level, a skipped guide, or a character from
  before 0.3.5's new route order). Quests that need a quest from an earlier
  guide no longer sit in the guide as "Requires ... first": when that
  earlier quest is a short trip in the same zones, its steps are added next
  to the guide's own steps nearby; otherwise those quests are left out of
  the guide for you. (thanks Malifax)
- Quest names are in quote marks wherever they sit in a sentence, so they
  read apart from the words around them: the arrow says Turn in “Your Place
  in the World”, a notice Requires “A Threat Within” first. Each language
  uses its own marks („…“ in German, « … » in French, «…» in Russian,
  「…」 in Traditional Chinese, and so on). NPC and item names are unchanged,
  and a quest name with quote marks of its own is not quoted again. (thanks
  Havi)
- Clicking a quest's objective or hand-in in the guide window before you have
  taken the quest keeps the arrow on its quest giver and says "Take <quest>
  first", instead of pointing at something you can't do yet (#1385, thanks
  Bright).
- A bug report marks the line the arrow points at with `[→]` when you picked
  another line than the guide's current one (`[>]`).
- Wailing Caverns pick-up: no more trip to Arch Druid Hamuul for The Barrens
  Oases once you have outgrown it. It is only a lead-in to The Forgotten
  Pools, which Tonga Runetotem gives without it, and the game hides it from
  you once it is grey. Pick-up guides leave out every lead-in that is grey
  for you. (thanks to the reporter of #1436)
- A quest whose earlier quest the guide only lists for other races (because
  your race does it in its own guide before) no longer shows as ready to
  accept when you haven't done that earlier quest. A Night Elf in Darkshore
  (15-19) who skipped the Night Elf Darkshore guide now gets those earlier
  quests' steps, nearby, instead of a "Beached Sea Turtle" the game won't
  offer. (thanks frostyends)
- Leveling guides: a walking step no longer says just "Go to The Barrens" (or
  another zone's name) and leaves you at a spot with nothing to do. Every such
  step now names where the walk leads (a town, a camp, the next NPC), and the few
  that pointed off the way, or back past where a hearth or flight had already
  taken you, are gone (#1450).
- The Hall of Thanes pick-up guide sends you to the Dark Iron Spies in Dun
  Morogh for the Dark Iron Map that starts Underground Map. Pick-up guides now
  collect a quest's starting item from the mobs outside whenever nothing in
  the dungeon drops it, however rare the drop. (thanks SumnDaiy)
- A "Train at ..." step now ticks when you train with any trainer of your
  class that was missing from Polestar's list, such as Dargh Trueaim at the
  Farstrider Lodge in Loch Modan (#1507, thanks doctor-house). Sixteen class
  trainers were added; portal trainers still don't count as class training.
- Loch Modan, Redridge Mountains & Westfall: Dwarves and Gnomes, who have the
  Ironforge flight path from their start, fly there from Thelsamar instead of
  being sent through the tunnel into Dun Morogh and turned back (#1508, #1518,
  thanks Jeor and Magic).
- Loch Modan, Redridge Mountains & Westfall: the walk east through Elwynn
  points at the road below the Tower of Azora instead of into the tower
  (#1509, thanks doctor-house).
- The arrow no longer asks you to cast a class teleport to the city or zone
  you are already in: a Mage in Stormwind walks across town instead of being
  sent to Teleport: Stormwind. (thanks AUTUMNcore)
- Wetlands, Dustwallow Marsh & Thousand Needles (Alliance): the walk east from
  Highperch to the Mirage Raceway no longer points at the foot of Freewind
  Post's lift, the Horde camp; it keeps to the canyon north of the mesa.
  (thanks Bennistrov)
- Nearby services: Mailbox finds the nearest mailbox again. Every mailbox in
  the data had lost its side, so the search said there were none, even next
  to one in Stormwind. (thanks Besaid)
- A "Fly to" step now ends when you land, also where the game calls the
  place by a longer name ("Fly to Crossroads" landing in The Crossroads,
  Stormwind in Stormwind City, Grom'gol, Theramore, Feathermoon). Before, the
  step waited for you to tick it. (#1530)
- Bag space and selling junk: an item for a quest, or one that begins a
  quest, is never offered for deleting and never sold, even when it is grey.
  Noboru's Cudgel was deleted as junk, and its quest with it. (thanks
  Diceshooter)
- Ashenvale & Thousand Needles (Horde): your hearthstone is now bound at
  Freewind Post when you come back with the Galak and Alien Egg hand-ins,
  not on your first stop. If you left for the canyon without binding, the
  guide used to send you back up the lift just for the bind. (thanks Kolbi)
- The arrow no longer sends you from Darnassus down the portal to Rut'theran
  Village when your goal is on Teldrassil: it leads you out through the city's
  gate. The portal only goes down to the village, and the planner had priced a
  walk from the village's boat pier straight up the tree. (thanks Phear)
- Logging in and /reload are a little faster: Polestar now loads only the
  translation for your client's language, not all nine (#919, thanks dhaern
  for the report and muffe for the change).
- Arathi Highlands and Stranglethorn Vale (Alliance): A Meal Served Cold is
  left out. It must be back with Angus Stern in Stormwind within 30 minutes,
  and the guides took it in Stormwind and only reached the basilisks two
  guides later, so it always ran out.
- Abandoning a quest the guide had passed no longer leaves the arrow on its
  objectives: while the guide window asks, that quest's goals are greyed out
  and the arrow leads back to its giver. New in Options, Guide, Automation:
  "When you abandon a guide quest" can always go back for it or always skip
  it, with a line in chat instead of the question. (thanks Havi)
- The guide no longer points you at a quest you're too low level to take:
  a leveling guide leaves the quest out of the step, carries on, and brings
  it back when you reach its level; a reputation, class or dungeon guide
  waits at it and says the level it needs (#1320).
- Alliance 1-30 routes:
  - Westfall: the north loop is one target per step in the order you walk it, with the livers, the vulture meat and
    the bandanas picked up along the way. People's Militia part 2 and Alba's crates move to the Westfall walk at
    19-20, where you go to Moonbrook anyway, so Westfall no longer ends with a Sentinel Hill - Moonbrook - Sentinel
    Hill loop.
  - Loch Modan: Crocolisk Hunting is taken at the Farstrider Lodge and done with Daggerfang on the east shore. A
    character without The Defias Brotherhood from Westfall now skips that Westfall walk.
  - Expanding Horizons goes to Baros Alexston on the Stormwind stop before the boat back to Darkshore, and his reply
    to Thundris where that boat lands, instead of being carried for two more guides.
  - Wetlands: Insane Druids and its barrow den are left out, The Eye of Paleth goes in on the last Menethil stop,
    Trying Times is taken with Razormaw Needling, the Fen Creepers are hunted along the river near Rethiel, and
    Astranaar's hand-ins happen on the first visit. A Night Elf Druid without Trial of the Sea Lion is no longer sent
    to Moonglade.
  - Redridge: Alther's Mill's Tarantula Eggs are now a goal beside the spiders (the hand-in waited on them unannounced).
  - Teldrassil: Night Elves take Buzzbox 827 in Auberdine and finish it on the first beach walk.
  - Dun Morogh's level range reads 1-14, where the route really leaves it.
  - Trek to Ashenvale is taken in Auberdine at 21 and handed to Raene at 23 (it was held back until 28, after Volcor's escort, which it doesn't need).
  - Auberdine: if Sentinel Selarin isn't beside Terenthis, the step says she respawns shortly (thanks to the #1089 reporter).
  - Darkshore: a Night Elf without Washed Ashore now does it in Auberdine first, so the Beached Sea Turtles offer their quests (thanks frostyends).
  - Steps the arrow pointed slightly wrong: Old Murk-Eye by the lighthouse, the murloc gills along the whole Westfall
    coast, Aamelia Windfield's farmhouse and the cultist ears at Vayn's camp on Zephras Isle.
  - Group quests you choose to do in Elwynn, on Zephras Isle and in Redridge (Gath'Ilzogg, Incinerator Gar'im), and
    the optional Goaz Warders and Gol'Bolar smith's steps, now lead you there instead of being skipped at once.
- Alliance 12-21: Westfall (now 11-17), Darkshore (15-19) and Loch Modan
  (17-21) list the levels Humans arrive at too, so coming from Elwynn no longer
  shows you as under-level for them.
- Alliance 30-40: the guides hand in what they walk past (Sir S. J. Erlgadin, Bookie Herod's records, Krazek's
  Cookery, Refuge Pointe, Fiora Longears' errand at Menethil Keep), and the Swamp of Sorrows ends on the road out.
- Alliance 30-40: steps for a quest you carry (Carnage's flesh, the yeti fur, the Hillsbrad council, Bartolo's and
  Lotwil's hand-ins, Trying Times' eggs) now lead you there instead of passing by; Bartolo's and Lucien's quests show
  only when you carry the crafted items they want.
- Alliance 30-40: Vahlarriel's Vengeance on the Thunder Axe Fortress visit, Retrieval for Mauren on the Mirage Raceway
  basilisks, and the top-up to 34 in Stranglethorn as three short steps on the loop's own mobs.
- Alliance 30-40, Desolace: Karnitol's chest is opened on the first visit, beside Azore's tower, so the south loop
  dives for the satchel on its one trip to the north-west coast and stops at Nijel's Point once, at the end. Claim
  Rackmore's Treasure! is open to every race, with the golden key from the coast's naga and the chest opened right
  after the Serpent Statue.
- Alliance 30-40, Arathi Highlands: one loop from Northfold Manor (the shards and Drywhisker Gorge, the eastern circle,
  then Witherbark Village on the way south to Quae) instead of crossing the troll valley twice.
- Alliance 30-40, Stranglethorn's second loop: the Shadowmaw Panthers and the Tumbled Crystals at Lake Nazferiti right
  after Kurzen's Compound, where they live, instead of an arrow south from the north-west ruins and back; the Rebel
  Camp's hand-ins on one stop at the end.
- Menethil Harbor: the guide finds Glorin Steelbrow in the Deepwater Tavern, not up the keep.
- Alliance 40-60, walking order: Theramore's first stop visits Archmage Tervosh
  once; Feathermoon Stronghold and Gadgetzan take their quest givers in the
  order you walk past them; Linken takes his raft finds on your first Marshal's
  Refuge stop; Krakle is met as you come into Un'Goro Crater from Silithus;
  MacKinley's step in Booty Bay says he is on the top floor. A character who
  starts the Western Plaguelands guide without an Argent Dawn Commission gets
  one from Argent Officer Pureheart before the scourgestone quests.
- Alliance 40-60, quest givers you pass are visited then: Ghak Healtouch's
  mushrooms and Prospector Ironband's urns are done from the Badlands at 43
  instead of a second trip to Loch Modan at 47; Humans report to Captain Garran
  Vimes before the Theramore boat and Night Elves see Thyn'tel Bladeweaver on
  their Darnassus trip; Dorius Stonetender's escort follows the Grimesilt
  outhouse, Forging the Shaft is handed in as soon as the dagger drops, and the
  Searing Gorge steps use Velarok Windblade's Forever name; Erelas Ambersky,
  Layo Starstrike, Rifleman Torrig, Geologist Larksbane and Commander Mar'alith
  are visited on your first pass; Light's Hope's scourgestones come from
  Corin's Crossing with Carlin's spirits.
- Feralas and Winterspring (Alliance): the long level top-ups are split and
  ground on the mobs your quests need. In Feralas half of the top-up before
  Zorbin's quests is on the Rage Scar yetis, whose hides Pratt wants (the
  Pristine Yeti Hide is now part of the route); in Winterspring the first part
  is on the Frostfire Winterfall camp while Donova's and Salfa's kills count.
- Stranglethorn Vale (Alliance 42): if you skip Nesingwary's three elite hunts,
  the guide has you take their experience from the Skullsplitter trolls of
  Zul'Mamwe, whose tusks Kebok wants, instead of three basilisk top-ups in a
  row before Booty Bay. Un'Goro Crater (Alliance, second visit): Torwa takes
  The Scent of Lar'korwi and gives the Bait and The Apes of Un'Goro in one stop.
- The Hinterlands guide (Alliance 47-48) ends with a short Booty Bay stop for
  everyone, not only for groups: Stoley's bottle for "Sea Wolf" MacKinley
  (taken in Tanaris) and Fleet Master Seahorn's three Bloodsail captains on the
  ships just south of town. In Felwood, the Felpaw furbolgs' Deadwood Ritual
  Totem is part of the route; Kernda takes it on your next pass if the
  Timbermaw aren't Neutral to you yet.
- Felwood, Winterspring and Timbermaw Hold (Alliance 53-60): the Jaedenar
  chain (A Strange Red Key, Rescue From Jaedenar, Retribution of the Light,
  The Remains of Trey Lightforge) is now part of the route on the 58 visit,
  while you clear Shadow Hold anyway; at 53 it was optional, inside a cave full
  of linked groups. The Deadwood and Winterfall Ritual Totems and Meilosh's
  Runecloth come from the furbolgs the route already kills and are handed in
  when you pass Timbermaw Hold again, no longer optional.
- Arathi Highlands guide (Alliance 30-40): the Alterac steps for the
  Recovered Tomes and the Dirty Knucklebones now say which Crushridge ogres
  are elite (Maulers, Mages, Enforcers and Warmongers, 36-39) and that the
  Ogres and Brutes carry them too.
- The arrow cycles a step's places by itself. When a quest's mobs or objects
  are spread over several camps or spots, or a step has objectives in several
  places, the arrow moves on once you've stood at a place for a few seconds
  with nothing happening and you're out of combat. It goes to the nearest
  place you haven't checked, never back to one you just left, and stays while
  you're killing or looting. Cycling by hand (the objective's button in the
  guide window, or the "Next waypoint" key) still works.
- The arrow no longer swings back and forth when you walk close beside its
  path.
- The arrow's yards no longer count up as you approach the target while
  walking beside its path.
- Ashenvale guide (Alliance): Elemental Bracers now points among the water
  elementals in Mystral Lake, where players make the Divined Scroll, not at
  the lake's west edge.
- Horde, Ashenvale & Silverpine Forest (21-22): Ashenvale Outrunners (a level
  24 quest) is done on the way back from Thistlefur, after Ruul's hand-in at
  Splintertree, instead of as the first Ashenvale step at 21, where the guide
  window said "Behind" to players who were on the guide's pace.
- Ashenvale: Raene's Cleansing asks for four Bloodtooth Guards and Ran
  Bloodtooth's Skull, as the game does, instead of four kills of Ran
  Bloodtooth.
- Ashenvale (Horde): Tideress drops the Befouled Water Globe only once you have
  Stonetalon Standstill, so the guide now takes that quest from Mastok in
  Splintertree first and hunts Tideress with its elementals at Mystral Lake on
  the way back (#1346).
- Dungeons: the Sunken Temple page lists Haze of Evil (Alliance) and Zapper
  Fuel (Horde), whose Atal'ai Haze drops only inside, and Shrewd Negotiations
  is handed in to the Image of Archmage Modera outside the City of Dalaran.
  (Arrives with the next data update.)
- Dungeon hand-in guides say "turned in inside the dungeon" for quests whose
  turn-in stands inside (Commander Gor'shak and Marshal Windsor in Blackrock
  Depths, Bijou in Blackrock Spire, the Altar and Idol of Hakkar in the Sunken
  Temple, the Hall of Thanes' Ghostly Attendant) instead of "nowhere known".
  (Arrives with the next data update.)
- Merchant's Favor reputation: a Heavy Quiver writ now waits until you have
  bought one, and the guide no longer sends you to the Darkmoon Faire for a
  Heavy Leather Ball: craft it or buy it at the Auction House.
- Dungeon pick-up guides take one quest of each group that rules out the
  others (Ahn'Qiraj's Paths of the Protector, Conqueror and Invoker; the
  left and right pieces of Lord Valthalak's amulet) and follow the one you
  already hold.
- Reputation guides: old, low-level quests pay their full reputation in
  Forever at any level, as players' recordings show, so the optional hubs no
  longer say "if your first turn-in pays a fifth, skip these". The Darkspear
  Trolls guide drops three Durotar quests that pay Orgrimmar only.
- City reputation guides (Stormwind, Ironforge, Darnassus, Gnomeregan Exiles,
  Orgrimmar, Thunder Bluff, Undercity, Darkspear Trolls) now start with the
  leveling hubs in level order, then the cloth donations, and keep the level
  55-60 quests for the end, so a low-level character sees steps it can do.
- Orgrimmar and Darkspear Trolls reputation: the Valley of Trials hub takes
  Report to Sen'jin Village, so Forgotten Loa Idols is offered in Sen'jin.
  Thunder Bluff reputation: Fizsprocket's Notes comes before Ceasing
  Operations, which Morin Cloudstalker offers only after it.
- Stalk With The Earthmother: the guide counts the Seaforium Mining Charges,
  the Pine Salve and the Fish Chunks from your quest log, and you may fillet
  the smallfish anywhere: it need not be in front of Boarton.
- Azshara (Alliance Mages, 50-51): Magecraft is taken from Dink in Ironforge's
  Mystic Ward, and Archmage Xylem's Magic Dust and The Siren's Coral are done
  on the Azshara stop: the dust at the Thalassian Base Camp with Kim'jael's
  equipment, the coral at the Temple of Zin-Malor.
- The Barrens (Warriors): Trial at the Field of Giants runs for 30 minutes,
  and the guide took it long before the antennae. It is now taken from Ruga on
  Jorn's stop after the thunder lizards, with a tip naming the time limit.
- Elwynn Forest, Dun Morogh, Teldrassil and Zephras Isle (Alliance): if you
  already have a profession, the guide now includes the starting campfire's
  Camping 101 for it. You take it right after the cooking one and hand it to
  that profession's trainer on a stop the guide already makes (270 XP each).
  With auto-accept and auto turn-in on, the guide takes and hands in these
  quests for you.
- Brutal Armor (Warrior): the Dragonmaw Shinbone step shows only once Velora
  Nitely's Dragonmaw Shinbones is in your log, and says why: the orcs drop no
  shinbones without it.
- Elwynn Forest: the Crystal Lake murloc step now warns that the murlocs stand
  close together and pull in groups, the spot where most players died in
  Elwynn.
- Elwynn Forest, Dun Morogh and Teldrassil: Priests now get their level 5 robe
  quests (In Favor of the Light / Garments of the Light, In Favor of Elune /
  Garments of the Moon) in the leveling guide, on stops the route already
  makes: the letter from the start-area trainer, the wounded guard or sentinel
  on the way, and Friar's Robes of the Light or the Moon Robes of Elune on the
  next town stop.
- Class quests: at Brine in Call of Water (and every class step that hands
  in one part of a chain and gives the next), the class card shows the
  quest you carry until you hand it in, instead of an empty tick box for
  the next part, which read as though your quest were not taken. A tick on
  the next part says the one in your log is another quest of that name
  (#1372).
- In a class quest (or another guide that isn't a leveling guide), skipping
  a step the rest of the guide follows from no longer says "Guide
  complete": the window says why nothing is left and offers to undo the
  skip. The menu's Skip is off when there is no step, and `/polestar skip`
  says when there is nothing to skip (#1372).
- A breadcrumb from another giver in your log (a Tauren Shaman's Call of
  Water from Thunder Bluff where the Barrens takes Orgrimmar's) no longer
  hides the rest of its chain behind "Requires Call of Water first" (#1372).
- The start campfires' profession Camping 101s (270 XP each, for characters who
  already have the profession) are now taken by auto-accept with the Cooking one
  and handed in by auto turn-in at the trainer; before, auto-accept skipped them
  and closed the window (#1559).
- The arrow: in a cave where the game puts you on the continent's map rather
  than the zone's, such as the tunnels before Blackfathom Deeps, the route
  now knows which zone you stand in. Before, it could place you in the
  neighbouring zone and tell you to hearth (to Camp Taurajo, 46 yd from a
  Sapphire of Aku'Mai) or walk the long way round to that zone's border
  (#1359).
- Gelkis and Magram Centaur Reputation: the Valley of Bones steps wait for
  level 35, the level its quests need. At Honored below 35 the clan's giver
  had nothing to offer.
- Class guides: the Horde Aquatic Form trip takes the Barrens half pendant on
  the way to the zeppelin, so one sea crossing instead of two; Spellfire Robes
  is taken from Josef Gregorian, who gives it; Tyr's Watch leads you back to
  Hilda and Ephram for their hand-ins and tours Bandarion Keep in walking
  order; Alliance Call of Water points at the Westfall shrine's water spirit;
  a Dwarf shaman without the Archaic Rune is sent for it before Call of Earth;
  Ravenholdt has you take Syndicate Emblems before you pick Syndicate pockets;
  Holy Mightstone's Argent Dawn Commission and Moonsilver Blade's talk and
  forging wait are proper steps.
- Class quests: the "Class quest ready" card and the guide list now give a
  heads-up under the title when it applies: a long chain (how many quests
  across how many zones and continents), an escort, mobs well above the
  chain's start level, or elite mobs ("bring a group"). A chain whose
  objectives are elites is offered from two levels below its highest elite
  instead of as soon as it opens.
- Cloak of the Divine Storm, Brutal Armor and Fire Hardened Armor say they
  start now at their first level, so a level stated later in the line no
  longer reads as "you must be that level". Divine Storm also says that its
  mobs are 28-30, so it is easier nearer 30 or with a friend.
- Polestar Client: when it can't reach the Polestar recording server the
  normal way, it tries other ways before giving up: IPv4 only, its own list
  of certificate authorities added to your system's (only when your system
  doesn't know the one that signed the server's certificate; your system
  still checks it), and its own DNS lookup of the Polestar server by DNS
  over HTTPS to Cloudflare and Google. The first that works is used until
  the next start, and Status says which. If your proxy itself can't be
  reached, that one upload goes without it. A wrong clock on your PC is
  named as such, with the time it says. Uploads never follow redirects and
  use HTTPS only.
- Polestar Client 0.1.6 sends what Polestar Recorder's explorer mode maps in
  Forever's new zones and dungeons, shows those records in plain words in
  What we send, and has an Explorer mode switch in Settings > Recording.
- Polestar Client no longer says "World of Warcraft is running" (and holds
  addon updates back) while only the World of Warcraft Launcher or
  Battle.net is open (#1484).
- Polestar Client: when it can't reach the recording server it says why (a
  DNS failure, a refused or reset connection, a certificate it can't check)
  and what to try (a firewall, antivirus, VPN or proxy blocking Polestar
  Client while your browser gets through), instead of only "check your
  internet connection". An answer that didn't come from the server itself (a
  proxy's or network filter's 403, say) is named as such, and deleting your
  data says why nothing was deleted.
- Polestar Client: when the server asks it to wait (too many new
  registrations from your network today, or a busy server), Status says so
  and that your play is kept on this PC and sent later, instead of "Can't
  reach the server".
- Cozy Sleeping Bag (Alliance): the detour round Honor's Stand through the
  Barrens is only asked of you when you are not already in the Stonetalon
  Mountains, so a character who arrives by the Stonetalon Peak flight is no
  longer sent back to the Barrens (#1496, #1511, thanks shatteredeagle)
- Cozy Sleeping Bag: after the note on the Stonewrought Dam, the guide warns
  about the waterfall in the river below the dam, which killed most players
  who followed the river, and says how to get out of it and on to Arathi.
- Darkshore: It's All Fun and Games Until... is now taken from the Twilight
  Tome after you hand The Twilight Camp in to it. The tome offers it only
  then, and the guide used to send you to it first (thanks scalatrava).
- The Great Outdoors (Elwynn Forest, Dun Morogh, Zephras Isle) now waits for The Adventurer
  to be handed in, and the Tauren druids' The Great Cat Spirit in Moonglade waits for Turak
  Runetotem's quest, as in game.
- Archmage Ansirem Runeweaver is shown at the Kirin Tor camp by Dalaran, where he stands,
  instead of about 370 yards south-east of it (Arathi Highlands guide, Magical Analysis hand-in).
- More spots for Morin Cloudstalker on his walk in Mulgore, the Bloodfury Ambushers'
  eastern camp in Stonetalon Mountains and Adult Plainstriders in Mulgore.
- Arathi Highlands (Horde): the Defiler's Basic Care Package at Hammerfall is
  optional now. Rutherford Twing offers it only once you are Friendly with
  the Defilers, and the step says so.
- Tauren Druids: Silverpine Forest no longer sends you into the sea at 12-15
  for the Half Pendant of Aquatic Endurance: its Strange Lockbox gives it only
  while Trial of the Sea Lion is in your log, and the quest comes at 16. You
  open the lockbox on the ride through Silverpine at 21 and hand the pendant
  in from the Undercity after Hillsbrad, then fly to Turak for Aquatic Form.
  Night Elf Druids' lockbox steps now show only with the quest in the log
  (#1386, thanks Ash).
- Wetlands: Spark of Freedom is now asked as a group quest. Its Captive Fire
  Elemental is held at the far end of Dun Modr's elite Dark Iron ruins, so the
  guide asks before sending you in and skips it if you are alone. The Thandol
  Span step also warns about the two elite Saboteurs by Rustlocke's corpse
  (thanks Fyurie).
- Dungeons: "Hand in the quests" and a quest's Ends line send you to the
  turn-in NPC of your own faction when a quest has one for each side.
  Razorfen Kraul no longer sends Alliance Shamans to the Horde's Rau
  Cliffrunner for Storm, Earth, and Fire; Veyric Thunderhame takes it.
- Dungeons: a quest that starts from an item now says what drops it, also
  when the item comes from ordinary mobs rather than a boss, and is marked
  "Picked up inside the dungeon" when it only drops inside. When the item
  drops outside often enough, Pick up the quests collects it on the way and
  takes the quests it opens. In Blackfathom Deeps that means the Damp Note
  from the Blackfathom Tide Priestesses in the tunnels before the portal,
  handed to Je'neu Sancrea, who then gives the quest for Lorgus Jett
  (thanks creazy231). Quests started by an object inside the dungeon, such
  as Gnomeregan's Sparklematic 5200, are marked as picked up inside too.
- A dungeon's "Pick up the quests" guide no longer sends you far off your way
  for a breadcrumb whose quest you can take directly: from Stormwind,
  Gnomeregan's guide no longer goes to Stonetalon for Castpipe's Task or to
  Darnassus for Klockmort's Essentials, and the Excavation Site's no longer
  goes to Ashenvale for Seeking Caitlin. Breadcrumbs on your way (Tinkmaster
  Overspark in Stormwind, The Greenwarden in Menethil Harbor) are still picked
  up.
- A dungeon's "Pick up the quests" guide no longer sends you for a quest whose
  earlier step you can't start yet: Bazil Thredd and The Stockade Riots wait
  until you have The Unsent Letter from the Deadmines, Old Ironforge Incursion
  until you have the Dark Iron Map, and the Blackrock Spire, Scholomance and
  Stratholme guides lose their "First do the quest" steps for quests that
  start inside another dungeon. With the item in your bags the quest is
  picked up as before.
- Dungeons: when you skip a step of Pick up the quests that a later quest
  needs, such as the Defias Traitor's escort before Gryan Stoutmantle's last
  The Defias Brotherhood quest, the later accept now says "Requires ...
  first" and the guide moves on, instead of sending you to a quest giver who
  can't offer the quest yet (thanks In0k). The same goes for quests found
  with Lookup and for the follow-ups on Hand in the quests.
- Dungeons: Pick up the quests no longer sends you across the sea for a
  quest that only points you to another quest you can take anyway, unless
  its giver is in the town you're standing in. From Stonetalon, Gnomeregan's
  guide now skips Castpipe's Task as well as Klockmort's Essentials and goes
  straight to Ironforge (thanks Geekmandem).
- Options, Discovery, Dungeons, "Dungeons in leveling guides" lists only the
  dungeons your guides have steps for, instead of every dungeon. More appear
  as dungeons are added to the guides' route; a choice you made for one no
  longer listed is kept.
- Dungeons: every dungeon now says the level it suits best next to its range
  ("35-47 · best at 43"), on its card and its page, worked out from its bosses'
  levels. "For your level" still lists a dungeon from the bottom of its range,
  but lists the ones that suit you best first, and marks the ones where you are
  4 or more levels under that level as "Tough at your level": Uldaman at 35
  now reads as tough and comes after the dungeons that fit.
- The Dungeons hub's "For your level" lists a dungeon from its recommended
  level, so the Ruins of Lordaeron (15-22) no longer shows
  at level 13. A dungeon whose entrance is inside the other faction's
  capital (The Hall of Thanes in Ironforge, Ragefire Chasm in Orgrimmar, the
  Stockade in Stormwind) is no longer listed under that faction.
- Duskwood: Look to the Stars needs a Bronze Tube, and Herble Baubbletump in
  Darkshire is nearly always sold out. The Stormwind stop before Duskwood now
  sends you to the Auction House for one (optional), and the Darkshire tip
  says what to do without one. The Rogues' Touch of Zanzil also gets its tube
  at the Auction House instead of an engineering supplier who is always sold
  out (thanks uNBEx and Bennistrov, #1348).
- Companion pets: the White Kitten guide now says Xaphod Bizznox keeps one
  kitten at a time, like Lil Timmy; Mayhoa Skyhoof's one pup at a time is
  confirmed by players' merchant windows.
- Eastern Plaguelands (Alliance, 59-60): Flint Shadowmore's The Eastern
  Plagues is taken at Chillwind Camp, its three remains at the Marris Stead
  are collected on the way back from Egan, and the last top-up in Terrordale
  now stops just short of 60, so the Chillwind hand-ins (this and A Plague
  Upon Thee) give you the last experience instead of coming after 60.
- Latin American Spanish (esMX): the 621 interface texts that were still
  untranslated (the guide window and its pace line, options, dungeons,
  Discovery, Recording and Report pages) are now written, so they no longer
  show in English (thanks kinyenzm).
- A quest that fails (an escort who dies, a timer that runs out) no longer
  leaves the guide waiting with no word: its goals are greyed with "failed:
  abandon it and take it again", the arrow leads to the quest giver once the
  rest of the step is done, and after you abandon it the guide takes you back
  to the giver without asking.
- Felwood and Winterspring (Alliance): Flute of Xavaric, Felbound Ancients and
  the Winterfall Firewater chain are no longer marked optional: the route's
  own kills give every player their items, so the guide counts on them.
- Feralas (Alliance, 56): The Giant Guardian and Wandering Shay are done on
  the late Feralas stop, from Rockbiter beside Gregan Brewspewer, where the
  harpies around Shay are well below you.
- The arrow knows every flight path your character has, including ones learnt
  while Polestar was off or not installed, without you having to open a
  flight map first. Before, it could tell you to walk somewhere you could fly
  to until a flight master's map showed it the flight path (#1308, thanks
  healies).
- A floating Polestar button you can put anywhere on the screen (Options,
  Guide, Window, Show and hide; off by default): click it to show or hide the
  guide window, right-click it for a short menu, drag it to move it. It hides
  with the window in combat and in dungeons and battlegrounds when those are
  set to hide. The minimap button's switch sits beside it.
- The first time the guide window hides itself in a dungeon or battleground,
  a note at the top of the screen says "Polestar is hidden here" and how to
  bring it back: the minimap button, your key binding or /polestar.
- A "Fly to" step whose flight path you haven't learned yet (after switching
  to a new guide mid-level, for example) now sends you there by road, boat or
  the flights you know, reads "Go to", and is done when you arrive or learn
  that flight path. You're no longer sent to a flight master for a flight
  you can't take.
- Stormwind: when you skipped Captain Stoutfist's A Friend of the Family, the
  guide no longer sends you to Bolvar Fordragon for his, which he offers only
  once the first is handed in to him (thanks Bennistrov). The same holds for
  follow-ups in the Druid cat form, Paladin Cloak of the Divine Storm, Lumina
  Windsinger, Shaman Call of Air and Kirin Tor chains, and for Ward
  Restocking at Hammerfall: a skipped quest takes the one after it along.
- Polestar now tells you when its founder is nearby. Walk past Fitz Polestar
  (Fitz plays on the EU PvP realms) and a card says so; the rare button then
  targets him and waves, if you click it. Horde or Alliance, everyone gets
  the card, so the other side knows where to find him. It shows at most once
  every half hour, never in combat, dungeons or battlegrounds, and you can
  turn it off under Options > Discovery > Rares.
- French: kill objectives no longer show the game's raw
  "|4personnage tué:personnages tués;" text in the step window and in
  party chat progress lines, and objectives written with a no-break space
  match their guide steps again.
- The game menu (Esc) has a Polestar button that opens the guide menu, in a
  small section of its own after Shop (right under another addon's button
  when one is there), looking like the menu's other buttons, restyled ones
  included. You can turn it off under Appearance, Windows, Menus.
- Gear advice with Stat weights on Automatic now reads Forever's talent
  columns, so a Restoration Druid (or any spec) gets its own weights instead
  of the class default (Feral for Druids) whatever the client's language.
- German: the 0.3.6 interface texts are translated, including the hidden-window
  hints, the floating button, minimap route colours and the target icons.
  German translation by Cortexyn (#1460).
- German: the class quest guides are translated for all classes (thanks Cortexyn).
- German: the Exploration, Legacy Challenges, Library Books, Stalk with the Earthmother and Cozy Sleeping Bag guides and the mount and pet guides are translated (thanks Cortexyn).
- German: the profession guides are translated (thanks Cortexyn).
- German: the reputation guides are translated: Cenarion Circle, Argent Dawn, Thorium Brotherhood, Zandalar Tribe, the battleground reputations, the city reputations, Supply Factions and the rest (thanks Cortexyn).
- German: the nearby-search categories, the minimap icon size option, the
  open-objectives hints and the reputation and raid folder names in the guide
  list are translated (thanks Cortexyn).
- German: the While you're here lines and options, the level-pace line,
  quest-chain tooltips, dungeon heads-ups, party panel hints and the
  objective-area options are translated (thanks thecodingcortex).
- Wetlands, Ashenvale, Ironforge & Stormwind City: Vengeful Trail is taken
  from Maseara Autumnmoon at Forest Song, and Satyrnaar's Circle of
  Imprisonment is visited on the way back from Fallen Sky Lake, so the scroll
  from Kurothel's Knapsack beside it goes in with Kayneth's hand-in (1,700 XP,
  no extra walk).
- Teldrassil: Sentinel Shayla's bounty is handed in on the walk south from
  the Oracle Glade to Ursal, which shortens the loop. Tallonkai's second
  Twisted Hatred is offered as a group quest (Xethorr the Wicked is a level 12
  elite) and done on the walk from Dolanaar to the glade (900 XP).
- Wetlands, Ashenvale, Ironforge & Stormwind City: Bloom of the Heavens is
  taken from Sylessa Duskwhisper by Menethil's docks, Nord'el picked up on the
  shore just south of the town, and its follow-up handed to Thundris
  Windweaver when the boat lands in Auberdine (2,950 XP on stops the guide
  already makes).
- As a ghost, the arrow now stays on your corpse (or the Spirit Healer) until
  you are alive again: a step change, the guide's next goal, a goal clicked in
  the guide window, /way or another addon's waypoint no longer take it away,
  not even for a moment. Once you are alive it goes back to the guide, or to a
  point you picked on the same step (thanks Emil).
- Grinding steps ("Level 35: grind on Lashtail Raptor") point the arrow at the
  nearest place that mob spawns, not at one fixed spot. If you are already
  among them, the arrow stays with you instead of sending you to another camp
  across the zone. Where the game data knows no spawns for the mob, the arrow
  goes to the step's spot as before.
- After updating, a guide whose contents changed no longer says you've
  reached its end on every step.
- "You've reached the end of this guide" no longer shows near the start of a
  guide because you went into the town or zone its last step travels to (the
  Undercity, for Hillsbrad Foothills & Arathi Highlands). Ahead of where the
  guide is, only quests you've finished end it, never where you stand. End
  messages saved by earlier versions are cleared on the first login after
  updating, and Reset guide progress clears a guide's end too.
- Leveling guides, a night of fixes from players' reports and recordings:
  NPCs who walk a road or a loop (Mountaineer Kadrell, Sentinel Shayla,
  Warcaller Gorlach, Craven Drok, the Forsaken Courier, Boss Tho'grun and
  others) are searched for along their walk; The Missing Diplomat is handed
  in where Tervosh and Jaina actually stand; a few flight master and city
  waypoints that pointed beside the place now point at it; Hearthstone binds
  that were never used no longer replace the one the route hearths to next,
  and Winterspring's exit hearths to Thelsamar when you're still bound there;
  quests the route walked past are taken (Further Instructions, Bloom of the
  Heavens, Vengeful Trail), and The Super Egg-O-Matic is done at 47-50 in
  Tanaris; Defenders of Darrowshire waits for Uncle Carlin; a guide loaded
  fresh no longer shows "Requires ..." lines from an earlier guide's chain in
  Azshara; four guides' level ranges match where players are.
- Guide menu, Browse: click a folder's header ("Alliance 1–30  15") to fold
  its guides away and again to bring them back, or press A on it with a
  gamepad; its count stays, the menu remembers it across your characters, and
  the folder of the guide you have open always opens with the menu (#1358).
- Guide menu: guides of the same name and levels say whose they are, as
  "Dun Morogh (Dwarf)" and "Dun Morogh (Gnome)", or the faction where only
  that differs (#1358).
- Guide menu: the "Group" tag is gone from 18 guides whose group content you
  only do if you choose to: Vagash in both Dun Morogh guides, the elite and
  dungeon quests you may skip in 14 more leveling guides and in Timbermaw
  Hold, and a dungeon quest's hand-in in Dustwallow Marsh (#1358).
- A few guide texts that showed in English though their translation was
  already there are translated again: the Villards step in Hillsbrad Foothills
  (every language), and "Fly to Orgrimmar" (Brazilian Portuguese) and "Fly to
  Tarren Mill" (French) in the Horde guides that had it empty.
- Translated guide texts lost in 0.3.5 are back (French, German, Russian,
  Simplified and Traditional Chinese, Brazilian Portuguese, Spanish and
  Korean): guide texts naming a place had fallen back to English on those
  clients.
- Guide window: pointing at the goals' scroll bar no longer throws a Lua
  error ("attempt to call a nil value", `GuideFrame.lua:4294` in 0.3.5); the
  bar shows and fades as it should (thanks soulrocha, #1030).
- Guiding Stars (in the options) thanks the people who report bugs too: a
  third column lists the top 40 bug reporters, from Discord and GitHub, by
  their reports that were confirmed or fixed, with the top bug reporter on
  a podium beside the top supporter and the top contributor. Pull request
  and report counts now show as plain numbers, so all three lists fit side
  by side in every language.
- Map: where a step places its point on a camp, the other places it marks
  for that item are only those of the same creatures, not of other creatures
  the guide chose against (the Barrens: no Savannah Matriarch marks by Ratchet
  for the Savannah Lion Hides, which the step farms in the Dry Hills).
- Hillsbrad Foothills: Hillsbrad's Hoard now sends you to the Hillsbrad
  council in the farms west of Southshore, after the Syndicate camp, to
  deliver Captain McManus' Sealed Company Request. The guide used to hand it
  in on the spot. It stays optional.
- Hillsbrad Foothills: Hillsbrad's Hoard is optional now. Nobody has seen
  Captain McManus in Southshore yet, so the step says to skip it if he
  doesn't offer it.
- Horde 30-40 checked end to end: Stranglethorn hands Hostile Takeover in at
  Booty Bay and kills the Lashtail raptors on the walk back to Grom'gol; the
  Badlands take Lotwil's slabs beside Agmond's End instead of walking back to
  his camp; Gol'dir is freed, not killed; Desolace's Demon Pick, Gem of the
  Serpent and clams are steps of their own; Portals of the Legion uses the
  Hand of Iruxos; Lydon's Shindigger keg (Dun Garok, elite) is a group choice;
  and tips that pointed the wrong way or gave the wrong levels now match the
  map.
- Horde 40-60 takes and hands in quests where you walk past their giver:
  The Singing Crystals in the same Stranglethorn stay as The Fate of
  Yenniku, Gadgetzan's quests when the flight lands, Beware of Pterrordax on
  the first Un'Goro stay, Linken's Sword at Marshal's Refuge, Mickey's
  termite barrel with Radley at Northridge, and more. The Western
  Plaguelands and Winterspring are each played one way instead of crossing
  back.
- Every Horde 40-60 guide now opens where a player who starts it fresh, with
  no quests from earlier guides, finds nothing blocked: Stonard offers Dar's
  and Fel'zerul's quests on the swamp guide, Orgrimmar offers Belgrom's
  Betrayed, and some guides now start one hub later or earlier. Pureheart's
  Scourgestone turn-ins at Chillwind Camp (Alliance quests) are gone from the
  Horde guide, and the Blood Red Key chain shows only when you have the key.
- Searing Gorge's Velarok Windblade has his Forever name in the guide.
- Horde 40-60 counts more of the quests on its way, so the "until level"
  top-ups between 40 and 60 are shorter:
  - Noboru the Cudgel, The Gordunni Scroll and Dark Ceremony are handed in
    for good (the guide took them but left the hand-in optional).
  - Whiskey Slim's Lost Grog: taken at the Booty Bay inn, the bottles from
    the Hinterlands beaches next to Revantusk Village, handed in on the
    Booty Bay stop at 50.
  - The Winterfall Firewater chain (Winterfall Firewater, Falling to
    Corruption, Mystery Goo, Toxic Horrors, Winterfall Runners): the flask
    drops from one Winterfall furbolg in ten, and Winterspring's quests
    send you through dozens of them.
  - Uncle Carlin, Pamela's message, on the Light's Hope Chapel stop.
- Horde 50-60 top-ups sit on mobs a quest still wants: the Diseased
  Grizzlies and the Deadwood of Felpaw Village, Talo's grizzlies and
  ravagers in Irontree Woods, and Un'Goro's ravasaurs for Bone-Bladed
  Weapons. The last top-up before 60 is on the Rabid Shardtooths of
  Frostwhisper Gorge, next to the strange source, instead of level 54
  furbolgs.
- Felwood (Horde 53-55): the Felpaw Village step now goes on until a
  furbolg drops the Deadwood Ritual Totem, and its quest is part of the route.
  Kernda just inside Timbermaw Hold takes it right away if the Timbermaw are
  Neutral to you, or when the last Felwood guide passes the cave again.
- Stranglethorn Vale (Horde 40-42): the arrow for the Skullsplitter Tusks
  leads to the trolls' camp north of the Zul'Mamwe ruins, where the step
  sends you, instead of a lone panther 230 yards south of it (#1149).
- Horde 40-60 takes more of the quests that lie on its way, so the "until level" top-ups between 40 and 60 are
  shorter:
  - Stranglethorn Vale: The Gurubashi Legends of Old from Kin'weelay, with the legend from Zul'Kunda. Martek's News
    for Fizzle from the Badlands goes to the Mirage Raceway on the way from Freewind Post to Tanaris, with Pozzik's
    Keeping Pace and Rizzle's Schematics.
  - Swamp of Sorrows: Continued Threat at Misty Reed Post; on the way to the Blasted Lands at 49, the Fallen Hero of
    the Horde's story, then Dispatch Commander Ruag and Bengor in Stonard.
  - Tanaris: Tanaris Field Sampling just south of Gadgetzan, and its samples to Apothecary Zinge in the Undercity.
  - Booty Bay at 50: The Bloodsail Buccaneers' three captains on the ships south of the bay.
  - Steamwheedle Port to Flame Crest: Yorba's word for Yuka Screwspigot. Orgrimmar to Feralas: Warcaller Gorlach's
    errand to Talo Thornhoof at Camp Mojache.
  - Western Plaguelands: after the Writhing Haunt, the Bulwark's last cauldron at Gahrron's Withering and Mission
    Accomplished!
- Hillsbrad Foothills (Horde): Key to the City is taken with Prison Break In
  and handed in before Dalaran Patrols. Magus Wordeen Voidglare offered
  Dalaran Patrols to players only right after they handed it in, and the
  Grimy Key is looted beside the traitors you kill anyway; the step now
  points at it.
- Kodo Roundup (Desolace, both sides): the step no longer says to kill Aged Kodos. It shows the Kodo Kombobulator
  to use on a kodo in the graveyard, then the tamed kodo to talk to at Smeed's camp, five times (thanks Fyurie).
- Steps whose quest is done with an item now say so instead of "Kill": curing the Sickly Deer and Gazelles, waking
  the Lazy Peons, catching the Deeprun Rats, scaring Sprinkle, Quixxil and Legacki with Umi's Mechanical Yeti,
  marking Andorhal's towers, capturing a Rabid Thistle Bear and stabbing a Devilsaur.
- If your language's Polestar folder (Polestar_deDE and the like) is missing
  or turned off in the AddOns list, a line in chat at login now says so;
  without it Polestar shows in English.
- Hillsbrad Foothills (Horde): Elixir of Agony takes a Lesser Troll's Blood
  Elixir, and the Undercity step now says so (it named a Strong Troll's Blood
  Potion). The quest's own text still says Strong; the Lesser one completes
  it.
- Items named by their names in the game, where guides used their old names:
  the Craftsman's Writ hand-ins of Supply Factions Reputation (Lesser Troll's
  Blood Elixir, Elixir of Defense rather than Greater, Draught of Water
  Breathing, Elixir of Ogre Strength), the Flagon of Dwarven Honeymead in
  Wetlands, the Potion of Demon Slaying for Rhok'delar and the Draught of
  Water Breathing for Fire Hardened Armor.
- A step that only takes or carries a delivery no longer warns "Level N
  quest" in red: the hint counts quests with something to do (#1333).
- Stranglethorn Vale (Alliance 40-43): Stranglethorn Fever and Stoley's Debt
  are taken on later Booty Bay stops, once you are level 40, not on arrival.
- Un'Goro Crater (Alliance): Priests reach level 50 before leaving, so High
  Priest Rohan in Ironforge offers Cenarion Aid.
- Horde: the Barrens (now 14-21) and Tanaris (46-48) list the levels every
  race and class arrives at.
- Start zones: class quests that need level 10 now wait for it, the way the
  Hunters' and Shamans' in Kharanos already did: the Dwarf and Gnome Priests'
  Desperate Prayer and Confounding Flash, and the Skyborne Warriors', Hunters'
  and (Horde) Shamans' class quests in Valanaar. Mulgore waits for level 12
  before Until Death Do Us Part.
- Tirisfal Glades: Scourge Paladins take Coming to Terms after Scavenging
  Deathknell, at level 4, not on the church stop where it isn't offered yet.
- The guide no longer reads like you're falling behind. A step where you
  only take a quest never shows a quest-level warning: taking a higher
  quest early is normal. The pace line says "Behind" only when you're more
  than a level under the route, and a hard quest is named calmly, only on
  the step where you fight it.
- A guide no longer skips its travel and training because you carry a
  quest from an earlier visit to the zone.
- Target and step buttons now refresh their NPC names and target macros
  after learning a localized NPC name, once safe outside combat.
- Riding reminders now resolve trainer names by NPC ID through the existing
  name resolver, keeping the English fallback when no localized name is
  available (thanks nepyanbin, #1447).
- Loch Modan: the Discarded Fishing Toolbox for Silver of the Waves turns up
  at one of four places on the bed of the loch, and the guide knew only one.
  The arrow and the map now have all four, and the step's tip names them
  (thanks nikilok).
- The mage staff-or-orb guide (Alliance) says which quests really shut each
  other out: Speak with Jennea and Speak with Bink, and Mirror Lake and Bink's
  Gizmonitor. It no longer says that Speak with Bink shuts out Mirror Lake.
  (thanks drixus)
- Mark what they target (the target button and the step key's skull) minds
  the group: in a party you don't lead it only marks a mob with no icon yet,
  so someone else's mark stays, and in a raid it marks only when you lead or
  assist. The target button's tooltip says what a press will mark.
- The Polestar button on the minimap is now on by default: click it to show
  or hide the guide window, right-click it for a short menu, drag it around
  the minimap's edge. Turn it off under Options, Map, Guide & quests,
  Minimap button, and it stays off. Minimap button collectors gather it like
  any other addon's button, and it now stays where they put it.
- Minimap button: minimap tidiers (Leatrix Plus's Enhance minimap, button
  bars) show Polestar's logo, not a plain beige circle, and its hover stays
  a faint glow.
- Minimap: the route line no longer has to blend in with your herb and ore
  dots. The Route lines gear (Options > Guide > Arrow & routes) adds a Dot
  colour (the route colours, or cyan, magenta or white, which stand apart from
  the minimap's yellow tracking dots and gold quest marks) and the minimap
  line's own opacity and size. A new switch, Route line on the minimap
  (Options > Map > Guide & quests), takes the line off the minimap and keeps
  the guide pin there.
- Druids can train with Loganaar in Moonglade, and Rogues with Ian Strom in
  Booty Bay and Fahrad at Ravenholdt: they were missing from the class
  trainers, so the Moonglade training step of the Horde 50-60 guides sent
  Druids out of Moonglade to another trainer.
- Swamp of Sorrows and Desolace: My Little Friends (Amaryllis Webb) and Hate
  the Hatefury (Aka'rai) are optional now. Nobody has seen either of them in
  the game yet, so each step says to skip the quest if its giver doesn't
  offer it, and nothing later in the guide waits on it.
- Quests Forever added carry a small, quiet ∞ beside their name: on guide
  steps, While you're here, the Codex's quest pages and quest tooltips. Hover
  a step for "New in Forever"; turn it off under Options > Guide > Window.
- While a quest timer runs, the arrow no longer sends you to cast a teleport or
  use your Hearthstone, and the Trial of the Lake steps (Aquatic Form, and the
  Night Elf and Tauren druid steps in Darkshore and the Barrens) say not to
  until Tajarri has the quest (#1327, thanks FlyHifiGuy).
- The guide window's pace line no longer says "Behind" when you are on the
  guide's pace and a quest ahead is just 3 or more levels over you: it reads
  "On pace, but Ashenvale Outrunners (24) at step 4 is hard: you'll be 21.3;
  reach 22 first". "Behind" is kept for when you really are short of the
  guide's level.
- No more hitch on every kill on a long leveling guide: the guide window's
  pace line ("On pace for level 21 by step 98") no longer reads every step
  left each time you gain XP, only after a turn-in or a level. And with a UI
  that hides the game's XP bar, the guide-level mark skips its work too
  (thanks AlverezYari).
- Sharing a quest with your party no longer risks a Lua error in a dungeon or
  boss fight: while the game hides its system messages from addons, the
  answer to the share is passed over instead of read.
- The party line places members by the step itself, not its number: a
  Warrior and a Mage on the same step read as "on this step" even with a
  Warrior-only step before it, and "1 step ahead" counts only the steps you
  both have. A member on another version of the guide pack is placed too.
- Sync to my guide: a button on the party panel (or /polestar party sync)
  asks your party to move to your step. Each member gets a prompt naming the
  quests the move passes that they haven't done, and the ones they did
  already; accepting opens your guide, in a new tab when needed, and moves
  to your step, keeping their ticks and skips (Undo takes it back).
  Declining changes nothing. Party members only, once every 30 seconds.
  (thanks uNBEx)
- "Pick up the quests" says how many quests you can take now and how many
  wait for a level, as in "3 now · 2 at level 16"; its tooltip lists the
  waiting quests and why (the level, or the quest needed first). The
  pick-up guide lists them as "Comes back at level 16", and when you reach
  that level with the guide open, a chat line tells you and the quest giver
  is marked on your map and minimap.
- Brazilian Portuguese: 0.3.6's new interface texts (the What's new window, the skipped-step card, the hidden-window hints and the new options) and the guide texts its later route fixes added or reworded are in Portuguese (thanks soulrocha).
- Brazilian Portuguese: the druid, hunter and mage class guides show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the paladin, priest and rogue class guides show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the shaman, warlock and warrior class guides show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the mount and pet guides show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the exploration, miscellaneous and legacy guides and the pack's own titles show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the guide texts new or reworded in 0.3.6 are in Portuguese, the translations left in the "No longer in the guide" blocks moved onto their new lines,
  and the skyboat is "barco celeste" everywhere (thanks soulrocha).
- Brazilian Portuguese: the Alliance leveling guides (the human, dwarf, gnome, night elf and Zephras Isle starting zones and the route from 10 to 60) show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the Horde leveling guides (the orc, troll, tauren, undead and Zephras Isle starting zones and the route from 10 to 60) show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the profession guides show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the reputation guides of the capital cities and the battlegrounds show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the reputation guides of the world factions show their steps, tips and labels in Portuguese,
  with the game client's own names (thanks soulrocha).
- Brazilian Portuguese: the whole interface is translated again: the party
  panel, the dungeon heads-up, the level pace line, Dynamic Questing, quest
  chains, the dungeon entrances, the minimap icon size and the guide window's
  labels show in Portuguese instead of English (thanks soulrocha).
- Quest data: Seasoned Wolf Kabobs needs only the Lean Wolf Flanks, Mercy
  Falls on Deaf Ears five ears, and Open the Maw, An Ancient Grudge, Unending
  Torment, Brewer's Trade, Ott's Masterwork and A Void Path list their
  objectives, from the game's own quest records and players' recordings.
- Alliance 30-40: Red Jack Flint's errand to Fiora Longears is taken on
  Menethil's docks and handed in where the boat lands in Theramore.
- Horde 30-40: Kravel Koalbeard's parts order for Wharfmaster Dizzywig is
  taken at the Mirage Raceway and handed in on the Ratchet docks you already
  stop at, and the WANTED poster for Baron Vardus is taken in Tarren Mill and
  done on the walk to the Perenolde manor.
- The rare alert card has a Target button that targets the rare. With "Mark
  what they target" on, it also puts your mob icon on it. During a fight the
  button is greyed out and its tooltip points you to the rare button and its
  key. On the card for Polestar's founder the button waves.
- The rare button and the card's Target button ping the rare after targeting
  it, so your group can see it behind rocks and buildings. A new option,
  "Ping what they target" (off by default), does the same for the mobs the
  Target button and the step key target; in a raid it pings only when you
  lead or assist. NPCs you talk to are never pinged.
- Recorder: in Forever's new zones and dungeons (Zephras Isle, Riverglades,
  Shen'dralas, Mount Hyjal, the new dungeons and more) it now records a bit
  more detail while you record, to map them: the creatures there and the way
  you walk, quest map points, dungeon floors, boss pulls, where quest givers
  stand and the chests you open. It's all about the game world, nothing new
  about you, and it says so once in chat the first time. `/psrec explore off`
  stops it.
- Shared recordings from a French game client are no longer turned away by
  the recording server when you accept a quest with a kill objective: the
  Recorder now names the objective without the client's grammar code, so the
  five minutes of play around it arrive.
- Recorder: a loot window is read before fast loot empties it, so shared
  recordings no longer miss the quest item a corpse dropped (and no longer
  credit a boar's Goretusk Liver to the Goretusk Snout lying beside it).
  Polestar's quest data takes a recorded item for a quest's objective only
  when the item is that quest's.
- Recorder: `/psrec on` (and `/psrec` while play waits) says to type /reload
  or log out to send what's recorded: the game writes the recording, and
  whether recording is on, to disk only then, so Polestar Client sees it only
  after that (#1453).
- Shared recordings are no longer turned away by the recording server for a
  quest you paid to hand in (Grime-Encrusted Ring and the Sparklematic 5200
  cost 3 silver, for example), or, on a French game client, for accepting a
  quest with a kill objective. Both lost the whole five minutes of play
  around them; Polestar Client's "Some data was skipped" note named the
  first (`bad value '-300'`).
- Recorder: `/psrec on` (and `/psrec` while play waits) says to type /reload
  or log out to send what's recorded: the game writes the recording, and
  whether recording is on, to disk only then. Polestar Client says its "Off
  in the game" is as of your last logout or /reload, and to /reload after
  turning it on.
- A guide tab closed by accident comes back as you left it. For ten seconds
  the guide window offers "Closed <guide> · Reopen"; after that, the window
  menu and the tab menu have "Reopen closed tab", `/polestar reopen` does the
  same, and you can bind a key to it under Key Bindings. The guide list's
  Recent tab now starts with "Recently closed". Reopening a guide, or loading
  it again from the list, brings back the step you were looking at, as a
  /reload does, with your ticks and skips; before, closing a tab forgot that
  step and the guide reopened wherever the quest log put it. Loading a guide over
  the current tab, or changing route to the other zone, keeps the guide it
  replaces under Recently closed too.
- The Sleeper Has Awakened: the escort ends at Kerlonian's bag on the road at
  the southern edge of Darkshore, then you hand in to Liladris at Maestra's
  Post; the step no longer says the escort goes into Ashenvale.
- Slimy Menace (Elwynn Forest): the guide's two kill goals read the right
  lines of the quest log (7 Murlocs, then 4 Murloc Streamrunners).
- Desperate Prayer (Dwarf Priests): handed in to High Priest Rohan in the
  Ironforge Hall of Mysteries, not to High Priestess Laurena in Stormwind.
- Frostmane Hold: the arrow leads to the end of the cave, where exploring it
  counts.
- Maps: the way to your goal can be one solid line. It follows the walking
  path over a soft shadow that reads on any map, the stretch you have
  walked fades out behind you, flights are dashed
  in their own colour, a stretch with no known path is a paler dashed line,
  and a new goal's route draws in from you. Pick Line, Dots or Sparkles on
  the welcome's Make it yours page or in Options > Guide > Arrow & routes;
  the gear beside Route lines sets the line's thickness. New players start
  on the line; if you already play, your dots stay until you switch.
  Sparkles show as dots while Reduce motion is on.
- Minimap: each style keeps its own Minimap size (the line 50 %, the dots
  80 %, the sparkles 150 % to start with; a size you set before stays), the
  route dots flow toward your goal again at the same size at every zoom, and
  dots, lines and sparkles no longer sit on your own arrow and always start
  beside it, also when you walk a road next to the path. Dot colour now tints only your walks, so a walk and a flight never
  look like one line.
- Setting your Hearthstone at the guide's innkeeper ticks the step's "Set your
  home" goal even when the game names the bind location differently from the
  guide. Before, Polestar could miss the bind and you had to tick it by hand
  (#1298, thanks Emil).
- Stonetalon Mountains guide (Horde): the Beren's Peril step now says to pull
  the Ravenclaws away from the Offering Stone, where an elite spirit often
  stands.
- The flight timer now follows Appearance > Windows > Skin like every other
  Polestar window, and changes with it at once. So do the instance tracker,
  the party panel and the confirm dialog, and the quest item and travel
  buttons' hover highlight now changes with the skin too (thanks Emil).
- Looking ahead with the mouse wheel over the step number no longer jumps back to the guide's step while you are
  doing the step you are looking at, nor in the middle of a fight: it goes back only after a few seconds with
  nothing done there. The < and > arrows never jump back.
- Undoing a Skip now undoes everything the skip did: a step the guide passed on the way because its level wasn't
  reached yet comes back once you reach it, and an extra quest step the guide had added for you comes back too.
- Stalk With The Earthmother: the arrow for the Windfury Cones and the
  Mortar and Pestle leads to the cones on Windfury Ridge, not about 300
  yards away from them.
- The step key's interact option no longer throws "attempt to compare a
  secret string value" when the game hides your target's name in combat;
  it still matches the step's NPC by its id (thanks Tangens, #1182).
- The step key also targets the mobs of the While you're here suggestions,
  nearest first, after the current step's own, whenever it targets or has
  nothing else to do. It changes only out of combat, and a switch under
  Dynamic Questing in the settings turns it off (#1316, thanks muffe).
- Stonetalon Mountains guide (Horde): The Offering of Blood now has you use the
  Tortured Soul beside the Offering Stone, and its kill goal ticks when the
  elite spirit dies, instead of waiting on the wrong quest-log line.
- Stonetalon Mountains: Gerenzo's Orders, Piznik's defence in the Windshear
  Mine, is now asked as a group quest in the Alliance and Horde guides, with a
  tip on what it takes: five minutes of kobold waves at the bottom of the mine,
  and the quest fails if Piznik dies. Alone, skip it; the Alliance arrow into
  Stonetalon no longer leads into the mine (thanks Emil).
- Hillsbrad Foothills: Talk of the Town is optional now. Nobody has been
  offered it by Barkeep Kelly in Southshore yet, so the step says to skip it
  if she doesn't offer it, and its Booty Bay hand-in is optional too.
- The Target button shows who it targets: its icon is what you do with the
  name the next click targets (a speech bubble, ! to accept, ? to turn in, a
  sword, a bag for a collect's droppers, a skull for an elite, rare or boss),
  the name sits beside it in green for a friendly NPC, red for a mob and gold
  for an elite or rare, and small icons show the names it cycles to next.
  Once you have seen an elite, a rare or the step's NPC (your target, the
  mouseover or a nameplate), its face takes the icon's place. On a step with
  no mob to target, the button targets the step's NPCs (talk to, accept from,
  turn in to...), and the arrow's goal comes first. "Show who it targets"
  under Options > Questing > Buttons turns it off; "Name new targets in chat"
  (off by default) adds a "Targeting: ..." line when the names change
  (thanks Mokii, #1387; portrait idea first proposed by CDVolvik, #1012).
- The Target button also targets the mobs of the While you're here
  suggestions, nearest first, after the current step's own mobs (or alone
  when the step has none); a step that sends you to an NPC keeps the NPC.
  It changes only out of combat and drops them when the suggestions hide
  (thanks Emil, #1441).
- Teldrassil: Iverron's Antidote is taken from Dirania on the way down from
  Aldrassil, after Crown of the Earth, and carried straight to Iverron. It
  lasts five minutes, and taking it before the moonwell and two climbs to
  Tenaron could run the timer out.
- Timed quests show their clock: the guide window, in full and compact mode,
  puts the time left after each of the quest's goals ("4:12 left"), amber
  under two minutes and red under one, and says before you accept how long
  the quest allows. The arrow shows the same countdown under its distance.
  A chat line and a sound warn at 5 minutes, at 1 minute and if the quest
  fails (Questing > Quests > Timed quest alerts), and the step tells you
  when the way to the hand-in takes longer than the time left. Delivery
  quests that are ready the moment you take them count down too. While a
  timed quest runs, "While you're here" keeps showing that quest's own
  objectives and hand-in, first, and holds the rest until it is done.
  (Discord request)
- With "Use TomTom's arrow" on, a goal on another continent no longer leaves
  you with no arrow at all: TomTom's arrow cannot point across the sea, so
  Polestar's own arrow and its route (the zeppelin or boat) guide you there,
  and TomTom's takes over once you arrive (thanks Konky88).
- A class training step no longer holds the guide when your trainer has
  nothing new for you: opening the trainer's window ticks it when the list
  has nothing you can learn now. When there is a spell to learn, the step
  still waits until you learn it.
- Class training steps send you to the town the step names (Orgrimmar, the
  Undercity, Stormwind, Ironforge, Darnassus) wherever you stand when the step
  comes up, instead of the trainer nearest you at that moment. A Shaman still
  in the Barrens at Orgrimmar's training step was sent to the Valley of
  Trials, and the Undercity's training step pointed back into Orgrimmar while
  you waited for the zeppelin (thanks MrBackus). A trainer right beside you
  still counts.
- Guide window, Transparent style: each line of text now sits on a light,
  soft-edged shade of its own, so it reads over bright ground while the world
  still shows through; Appearance > Windows > Backing gives a dark backing
  behind the whole window instead, or turns it off. Tick boxes get a dark fill
  and an edge so they show over the world, and "Keep the bar shown" keeps the
  tabs and the step bar on screen instead of only under the cursor. (thanks
  Saulo)
- Updating Polestar in the middle of a guide no longer sends you back. The
  new quests an update puts behind where you are are passed for you, and so
  are new travel steps there. Your check-offs, skips and the step you were
  looking at stay on the same goals even when their step changed. A quest
  you carry whose remaining steps the update moved behind you shows under
  your step as "Still to do", with where it is and how far: click it for the
  arrow, right-click to skip or abandon it, and "While you're here" offers
  it when you pass by. A quest ahead that needs one of the passed quests gets
  it back just before it if it's on your way. Otherwise that quest is left
  out of your guide. Reset progress brings everything back.
- "Sell and repair at …" now ticks at any merchant who repairs in the same
  town, not only the one the guide names: in Menethil Harbor, Brak Durnad
  beside Murndan Derth counts too (#1400, thanks Emil). A step that sends you
  to one vendor for something only they sell still waits for that vendor.
- With Waypoint UI and Blizzard waypoint on, the plain map pin set at login,
  before Waypoint UI was ready, no longer stays on the map once Waypoint UI
  tracks the quest instead (thanks Fitz and neopterygii).
- The welcome's Route style page shows what each style does on the map, as
  on polestar.guide: Northshire Abbey to the Westfall bridge in Elwynn
  Forest, Fastest, Balanced or Roads with its length. Picking another style
  replays its walk and leaves the last one as a faint dashed line (at once
  with Reduce motion on).
- The welcome on a new account no longer leaves a tall empty band above the
  buttons on Hello, Route style and Your first guide: Make it yours is more
  compact, and a shorter page sits in the middle of the window.
- Westfall: Humans now get Alba Fairmoon's Toxic Soil quests (Testing the
  Wells to Explosive Consultation), as every other Alliance race does;
  players' recordings show Humans taking and handing them in.
- Wetlands: From the Ashes now points at each of the four Attack Plans in
  the Dragonmaw camp north of Whelgar's dig, instead of at Chieftain Nek'rosh,
  who stands apart and isn't needed for it (thanks Bennistrov).
- Wetlands guide: Uncovering the Past now warns that the elite Goaz Warders
  (32) stand among the relics and the Loose Soil at Whelgar's dig.
- Wetlands: Hearts of the Lost is gone from the guide. It isn't in the live
  game (Corma Villard offers it to nobody, and Essene Villard isn't there),
  so after Dun Modr the guide goes straight to Ebenezer Rustlocke's corpse
  under the Thandol Span (thanks Fyurie, Jamemba, Crunchybob, Bennistrov and
  twisted).
- Wetlands and Arathi Highlands: MacKreel's Moonshine, which must reach
  Southshore within 15 minutes, ran out on the way to Menethil and the boat.
  It is now taken in the Arathi Highlands guide after Kor'gresh's cave and
  handed in straight off the flight from Refuge Pointe to Southshore, with a
  tip naming the time limit (thanks Fyurie).
- Wetlands: the guide no longer asks for This Land Was Their Land on your first
  Menethil visit. Captain Stoutfist offers it only once Defeat Nek'rosh is
  handed in, so it now comes after that group quest, with the walk back east
  to Howin Kindfeather (thanks Bennistrov).
- Wetlands guide: War Banners now points at the Dragonmaw Raiders' and
  Swamprunners' camp north of Whelgar's dig, so the arrow no longer can lead
  you among the elite Dragonmaw further east.
- A What's new window after updating, so you know the routes changed. It
  opens once per account on the first login after an update (never in
  combat, in an instance or over the welcome); `/polestar whatsnew` and
  Options > About bring it back.
- Dynamic Questing: a hand-in the "While you're here" panel shows is now
  handed in automatically at its NPC, the same way as the guide's own steps
  (auto turn-in on, Shift to hold it back). A quest with several rewards to
  choose from still waits for you to pick one (#1408, thanks Emil).
- Dynamic Questing offers a hand-in again when the guide would send you away
  and back for it. Walking past Seer Graytongue with Rites of the Earthmother
  done while the guide headed to Grull first, you got nothing; now the line
  says "Hand in … to Seer Graytongue, then take …: saves a trip back", and a
  hand-in shows whenever you stand at its NPC, as before 0.3.6.
- Talking to an NPC, quest automation also takes the quests the guide picks
  up from that NPC in its next few steps, so you are not sent back for them.
  It leaves out quests you can't take yet, optional and group quests you
  haven't chosen, timed quests whose walk would not fit their time, and
  anything that would fill your quest log.
- While you're here now shows a quest to pick up near you that the guide takes
  later ("Take The Disruption Ends from Thork: saves a trip back"), with
  auto-accept on or off, as soon as its prerequisite is handed in, from any
  step of the loaded guide and any zone of it; rows for steps further on say
  "later in this guide" and come after the near ones. A timed quest is never
  picked up early, nor one more than two levels above you (thanks Fitz)
- Dynamic Questing: a nearby hand-in is weighed by how far out of your way it
  is, not by its distance. It shows when visiting the NPC and getting back on
  your way costs at most 20 seconds of walking, or the NPC is in the town
  you're in, so an NPC 60 yards off in town now shows where before you had to
  be within 30 yards. Set the seconds under Options > Guide > Window >
  Dynamic Questing, "Hand-ins: how far out of your way" (0 to 60), apart from
  "How close". It never offers a hand-in on another floor or across a river
  with a long walk round, nor one the guide goes to in its next two steps.
  When waiting for the guide's hand-in would cut the quest's XP (you would be
  more than 5 levels over it by then), it may be twice as far out of your way.
- Zephras Isle: Aetheen of the Gales is taken from Rorian the Dayseeker
  right after you hand him Harmony, before the class letters in the
  watchtower, so there is no walk back to him.
- Simplified Chinese: clearer wording for declined gear (remembered per
  character), going back for or skipping a missing quest and its
  follow-ups, the quests you can abandon to make room, and removing an item
  from restock (thanks nepyanbin).
- Simplified Chinese: nearly every guide text is translated now, about
  5,900 more of them, written for the current routes, and the interface
  wording is refined, with Dynamic Questing translated (thanks nepyanbin).
- Simplified Chinese: the Westfall leveling guide has a native speaker's
  review; names follow Forever's own Chinese data, not retail's (thanks
  山猫).
- Simplified Chinese: the remaining Westfall guide texts were moved onto
  their current lines after the 0.3.6 area-name fix (thanks 山猫).

### For guide authors

- The guide menu's "Group" chip (the compiled guide `group`) now counts only
  the route every player follows: a step with `when group <quest>` or `when
  dungeon "<Name>"`, the later goals of a quest accepted only in such a step,
  and a dungeon or raid quest's turn-in no longer flag the guide (#1358).
- `polestar playtest --honest` no longer reports "nothing there drops it"
  for a `loop` step's `collect` whose source stands at a later spot of the
  loop than the first (Gordo's Report in Tirisfal Glades): it checks every
  spot, as `forge judge` does (thanks neopterygii).
- Lint flags a `when group` or `when dungeon` step whose goals are all
  `optional` (an error in our guides, a warning in other packs): such a step
  is done at once, so the player who chose the group way got no arrow. The
  elite-work hint now says to drop `optional` inside a `when group` step.

### For contributors

- The Codex build tests no longer fail now and then with "cannot open
  /tmp/polestar-codex-pack-<pid>/…": measuring a pack's memory used one scratch
  folder per process, and `cargo test` runs tests as threads of one process,
  so two tests building a pack at once deleted each other's files. Each
  measurement now gets a folder (and script) of its own (thanks soulrocha).
- The recording server counts the chunks it turns away by reason (the rule,
  never what was sent or who sent it) for 30 days, public in `/v1/stats`
  `rejects`, so a rule that refuses real game data shows within minutes.
  Polestar Client's upload preview no longer says a paid quest hand-in or a
  French kill objective "would be turned away".
- The recording server registers the maintainer's test identities (smoke
  tests, end-to-end runs) without using the network's daily registrations,
  and keeps whatever they upload out of the export and the public totals, so
  our own tests no longer use up players' registrations.
- French kill objectives in recordings from Polestar Recorder 0.3.5 keep
  their names: the recording library takes out the game's grammar code and
  the count before it instead of emptying the name.
- The hostile-key Lua checks pass on Windows, whose Lua interpreter writes
  CRLF to stdout (thanks FlexusDev).
- The wording checks no longer read their own fixture file on Windows, whose
  path separator differs from git's (thanks FlexusDev).

### Forge

- `forge release credits` also fetches the repository's issues and writes
  the top 40 bug reporters to `Core/Credits.lua` (`bugReporters`): the
  Discord name the bot filed a report under, else the GitHub login, counted
  when the report is labelled `confirmed` or `fix-merged` or was closed as
  completed by a fix, never when it is a duplicate, not planned, invalid,
  still waiting on `needs-info`, or a feature request. `exclude` and `names`
  in `data/credits.json` now take Discord names as well as logins
  (docs/forge/release.md, "The credits").
- The route writer reads the chain in the route's order: a guide v1's `next`
  links do not reach no longer sits after every guide they do. Silverpine
  (12-15) after the Barrens (15-21) left the Druids' Strange Lockbox step at
  12-15, before the Barrens' accept of Trial of the Sea Lion it is for
  (#1386). A step for a quest its players only take in guides they don't play
  is now gated `when onquest` instead of left as it was.
- Every guide stands on its own: the writer lists accepts in a guide's first
  10 steps that need a quest only an earlier guide hands in, which a player
  loading the guide fresh cannot take. `forge writer apply-route
  --fresh-openers move` takes each to the guide's later visit to its giver
  where there is one; `off` skips the check.
- A guide fix's level gate can name the players it holds: `"only":
  "Priest"` writes `level 10 only Priest`, and the step's other classes go
  on.
- `forge record learn` reads players' recordings and writes what they teach
  about the quests Forever added, with how many players back each fact, to
  `data/recorded/`: where each objective is done, and prerequisites and
  minimum levels from givers' refusals only. The Codex uses them (one
  player's facts marked provisional), the data build takes the trusted
  prerequisites and levels, and corrections always win.
- `forge release pack` stops when a guide changed since its walking legs were
  baked, naming each such guide, instead of shipping them without legs.
  `--bake` (with `--grid` and `--leffe` for the maps `guides/legs.json` was
  baked on) bakes just those guides, updates `legs.json` and its
  `GENERATED.json` hash, then packs.
- The route writer no longer writes a group quest's asked steps (`when group`)
  with `optional` goals: a step of optional goals only is done at once, so a
  player who chose to do the quest with a group got no arrow to its item,
  accept or hand-in.

## 0.3.5 (2026-11-08)

### For players

- Pick-up, hand-in and attunement guides now lead the arrow to the right
  floor: Apothecary Zamah, in the Pools of Vision under Spirit Rise in
  Thunder Bluff, was pointed to from the top of Spirit Rise, out of the
  cave. The mage portal guide also says Birgitte Cranston stands down in
  the Pools of Vision with the mage trainers, not on Spirit Rise. (thanks
  Pilk)
- The guide window now stays out of the way in dungeons, raids, battlegrounds
  and arenas by default, with its action buttons and alerts: /polestar or the
  key binding shows it there until you leave. The first time it hides, one
  chat line says so. If you already picked "Hide" it stays as is; if you
  want it on screen, set Options > Guide > Window, "In dungeons and
  battlegrounds", to Keep visible. (thanks Tangens)
- Standing beside a quest giver no longer sends you on a walk away and back
  again: next to Arch Druid Hamuul Runetotem or Nara Wildmane on Thunder
  Bluff's Elder Rise, the arrow pointed back over the bridge to the lift (or
  down to Mulgore) and, once you got there, back to the hut, over and over.
  It happened when the step came up far away, in the Barrens or Mulgore.
  (thanks troders and Pilk)
- The Barrens (Horde): Hezrul Bloodmark's step says he walks the west shore
  of Lushwater Oasis, so if he isn't at the arrow you know where to look.
  (thanks GuardMoony)
- Dungeon pick-up guides no longer send you for a quest whose earlier quest
  needs a higher level: Fury in the Depths waits until you can take The Dark
  Iron War (level 25) first, instead of leading you to Motley Garmason, who
  refuses it. (thanks Jamemba)
- Quest objective markers no longer pile up over the map (#1085): three or
  more of a goal's spots close together now show as one soft shaded area in
  your theme's colour with one marker in the middle, on the world map and the
  minimap; lone spots keep their marker. Options > Map > Guide & quests >
  Quest markers has the choice (Areas for groups, Icons only, Areas only), an
  Area opacity slider and a Quest marker size slider. The old Objective areas
  toggle is replaced by this choice. (thanks VenoMan)
- Horde Ashenvale: only Warriors are sent to Alonso at Mystral Lake. His
  Dragonslayer quests are for Warriors, and other classes found no one
  there. (thanks soockee)
- A "use this item" goal with no quest of its own (the Runes of Summoning for
  the Warlock's voidwalker, a Sapta, a flare gun) now counts as done once the
  quest work after it in the step is, so the step moves on instead of waiting
  for a tick. (thanks Fitz)
- Horde Hillsbrad: Mountain Lion Blood is collected on the walk back from
  Hillsbrad Fields to Tarren Mill, not as a stop of its own on the way down,
  so the few, contested lions don't hold you up twice. (thanks Rohkin)
- Arrow: at the top of a zeppelin tower (the Undercity's, for Orgrimmar) the
  "Take the zeppelin" prompt now comes up where you stand, as it does at a
  boat's pier; it used to wait until you stood within 5 yards of one spot on
  the platform. (thanks Fitz)
- Arrow: a guide waypoint after a trip (Tirisfal's "The Barrens" after the
  zeppelin) is walked along the path again, not drawn as a straight line
  because the zeppelin tower's waypoint came before it. (thanks Fitz)
- Rogue class guides: items that come by Pick Pocket say so on the goal
  ("Pick Pocket a Venture Co. Logger for a Venture Co. Work Order") instead
  of telling you to kill the NPC, in The Horn of Xelthos, the Blade of Cunning,
  Poisons and Ravenholdt guides. (thanks Erá)
- The Barrens: the Raptor Heads and Plainstrider Beaks no longer have a step
  of their own right after the Crossroads. Raptors are few and often taken by
  other players, and only one plainstrider in four drops a beak, so you
  collect both on the way: the guide window shows your counts under the
  current step from the Crossroads on. Sergra takes the beaks on the stop
  after the Razormane camp, and Gazrog the heads on the stop after
  Echeyakee. If you are still short then, one step first sends you where
  players get the most kills (plainstriders north of the Crossroads, raptors
  around Echeyakee's lair); if you already have them all, it never comes up.
  (thanks Fitz)
- Ticking a quest goal done by hand no longer treats the quest as complete.
  The guide moves on as before, but the quest's hand-in waits until the game
  counts the objective, says why in its line, and the arrow no longer leads
  you to the quest giver early.
- The arrow no longer stops at a waypoint with nothing to do before leading
  on to the work: The Barrens' Zhevra and Savannah Prowlers lead straight to
  the nearest of them, Feralas' forest walkers too, and Eastern Plaguelands'
  Corin's Crossing step points at Corin's Crossing instead of Nathanos's
  camp. (thanks Fitz)
- Horde Hillsbrad: Valuable Vantages now has its three vials, each on its own
  peak, before you go back to Deathstalker Masoj; the guide used to ask you
  to hand it in right after taking it. (thanks Konky88 and soockee; the prerequisite as
  iamthecountofmontecrypto-a11y found in #1161)
- Rogue: The Eye of Bhossca waits for level 30, when C's letter arrives in a
  capital city's mailbox after the horn job; the guide and the class-quest
  heads-up offered it at 25, when the Dead Drop has nothing yet. (thanks Erá)
- Travel: a flight master you haven't learnt yet now counts as a way to
  fly out. Polestar walks you to it, you learn it there, and you fly on to
  a flight path you already have. Standing in Ironforge's Great Forge with
  Menethil Harbor learnt, the way to Dun Modr is now a flight to Menethil
  Harbor, no longer the long walk through Dun Morogh and Loch Modan.
  (thanks WHOLF)
- The quest item button no longer causes "blocked in Polestar: UNKNOWN()"
  errors in combat with a friendly target, such as a flight master. Its
  red out-of-range tint now waits until the fight ends, whatever you
  target. (thanks Konky88)
- Polestar's buttons (target, quest item, Hearthstone, rare, bag) show a
  bound key the way the action bars do: M4 instead of "Mouse Button 4",
  MwU for the wheel, and modifiers as one letter (sM5 for Shift and mouse
  button 5). The label stays inside the button and no longer runs over the
  mob's name. (thanks czak)
- Dun Morogh (Dwarf, Gnome): the Frostmane Troll Whelps for The Troll Cave are
  part of the Coldridge Valley step with Felix's parts again, so the guide
  waits on the slopes until both are done instead of sending you to Grelin
  with the whelps still short.
- Dungeon pick-up guides take an open breadcrumb of a quest chain on the way,
  right before the quest it leads to: for Excavation Site: Wetlands, The
  Greenwarden in Menethil Harbor before Tramping Paws at Rethiel. Taking the
  follow-up first passes the breadcrumb.
- Pick-up guides now send you to the NPC a quest asks you to speak to
  before you hand it in: the Ragefire Chasm guide had you hand in Hidden
  Enemies to Thrall without visiting Neeru Fireblade in the Cleft of
  Shadow. The same goes for every quest whose objective is to speak to
  someone, in the pick-up guides and quest lookups. (thanks dwood-97,
  Hnrq and kjk-kjkmeg)
- 30-40 (both sides): every written grind step says where to grind and names a
  dungeon you can run with a group instead; Stranglethorn's second Alliance
  visit tells you about the level 36 top-up before the Skullsplitter trolls.
- Winterspring (Alliance): the level 55 top-up before Everlook grinds the
  Winterfall furbolgs at Frostfire Hot Springs, which raises your Timbermaw
  reputation, instead of naming Timbermaw furbolgs, which would lower it.
- Mulgore (Tauren Druids): after the Moonkin Stone the guide carries on
  east through the pass to the Crossroads. It no longer sends you to the
  Crossroads, back into Mulgore and out to the Crossroads again.
- Alliance 12-20: Darkshore is now played in two parts around a trip to the
  Eastern Kingdoms at 18-20: Loch Modan from the north (the dam, the loch's
  toolbox, Ironband's Excavation, the Farstrider Lodge's hunts, Ylva's
  banner), out through Ironforge, then Redridge's 15-20 quests while they
  still give full XP, the Defias chain from Wiley the Black through Sentinel
  Hill, Stormwind and Moonbrook, and the lighthouse's Old Murk-Eye; the
  gryphon to Stormwind and the boat take you back to Auberdine for
  Darkshore's southern loops and Kerlonian's escort into Ashenvale. Marshal
  Marris's Blackrock quests, Alther's Mill and Murloc Poachers are taken on
  that first Redridge visit and done on the second, at 24. Dwarves and Gnomes
  walk east Elwynn in one loop on the way to Westfall (Guard Thomas, the
  Eastvale Logging Camp, the Tower of Azora, the Jasperlode Mine). Ashenvale
  no longer starts with a grind. In Westfall, Humans take Scout Galiaan's
  quest beside Thor and walk Stormwind's errand in a shorter order.
- Guide end: Redridge's guide (Alliance 23-25) now ends once its last
  hand-ins are done; it waited for a visit to a vendor. Sell-and-repair stops
  in the Alliance 12-20 guides are optional.
- Alliance 12-30: the level ranges in the guide list match where players actually are in each guide (for example
  Westfall 13-17 instead of 11-15, the Wetlands 27-30 instead of 26-30).
- The Alliance route from 20 to 30 now goes Ashenvale and Stonetalon, then the
  first Wetlands visit, then Duskwood and Redridge together: Duskwood's first
  loop, one Redridge loop, then Duskwood's second loop. You reach Redridge at
  its level, so the grind to 23 at the Blackrock camps is gone (thanks to the
  player who reported on Discord that Redridge left you two levels short of
  Duskwood). The same Redridge loop brings Tharil'zun, Shadow Magic,
  Gath'Ilzogg, Incinerator Gar'im and Lieutenant Fangore, with a tip to group
  up for the elites. After Stonewatch Keep you go on to Render's Valley and
  walk Keeshan down to Lakeshire, then hand in everything on one pass through
  town. Bellygrub is killed on the way to Martie's first visit, and Duskwood
  asks for level 23 before Worgen in the Woods.
- Fewer stops in a town for a single quest. Darkshore ends heading south from
  Volcor: his escort goes to Terenthis when the boat stops in Auberdine. Fall
  of Dun Modr is handed in on the later Dun Modr stop, not on a walk north for
  it alone. Ashenvale's Astranaar hand-ins wait for the stop after the Zoram
  Strand. Ormer gives his second raptor quest when you hand in the first.
  Speaking of Fortitude, a walk into Stormwind Keep for 195 XP, is left out.
  Astranaar and Menethil are visited in walking order.
- After the second Wetlands visit the boat takes you straight on to
  Ashenvale's 27-32 quests (they used to wait until 33-34). Making Do goes to
  Thundris on the way, and the grind to 28 before Pilot Longbeard is gone.
  From the Ashes is taken with War Banners, its attack plans fetched at the
  Angerfang camp on the walk east from the dig, and both are handed in on one
  Menethil stop, so there's no walk back east for the plans. Lightforge Ingots
  is no longer offered at 27, since it needs The Lost Ingots first.
- The Alliance route from 30 to 40 now takes the zones in the order their
  quest levels fit: Wetlands and Hillsbrad, then one boat trip to Theramore
  for the Mirage Raceway in Thousand Needles and the Shady Rest quests, then
  Stranglethorn's first loop, Desolace, Stranglethorn's northern loop, the
  Swamp of Sorrows, Arathi and Alterac, and the Badlands with Desolace's
  south loop. The Mirage Raceway used to have a boat trip of its own at 30,
  and Desolace came at 32, where you had to grind for its quests. The long
  grinds in Desolace and Stranglethorn are gone.
- Quests far above your level are no longer taken early and carried for
  hours: The Karnitol Shipwreck waits for Desolace's south loop, Ironband
  Wants You! for the last Ironforge stop before Loch Modan, Skullsplitter
  Tusks for the 40-50 Stranglethorn guide, and Bookie Herod's chain and
  Krazek's Cookery for Stranglethorn's northern loop.
- New on the way: Highperch Venom, Hardened Shells, Load Lightening and A Bump
  in the Road.
- Hillsbrad (Alliance 30-38): Bartolo's Yeti Fur Cloak is optional and says it
  also needs a Hillman's Cloak (Leatherworking) and a Bolt of Woolen Cloth
  (Tailoring), which no vendor sells; the yeti cave is only for players who
  took it.
- Wetlands & Hillsbrad (Alliance 30-32): the Ironforge stops are called Hall
  of Explorers and King Magni Bronzebeard; they were both called Deeprun Tram,
  which this visit doesn't take.
- Thousand Needles (Alliance 32-33): from the Mirage Raceway the guide takes
  the road south to Gadgetzan and flies to Theramore, instead of walking back
  through the Barrens.
- Alliance 40-60: every "grind to level" step now ends with the dungeon you can run with a group instead (Uldaman,
  Zul'Farrak, Maraudon, the Sunken Temple, Blackrock Depths, Lower Blackrock Spire, Scholomance or Stratholme, by level).
- Alliance 40-60: after Azshara the route stops at Chillwind Camp in the Western Plaguelands on its way from the
  Hinterlands (Clear the Way, the Felstone Field cauldron, Janice Felstone), then goes on to the Burning Steppes.
  Quests five or more levels above you are now taken on a later visit to the same quest giver instead of making you
  grind first: Skulk Rock Clean-up, The Altar of Zul, Tran'rek, Super Sticky, The Smoldering Ruins of Thaurissan,
  Jaron Stoneshaper's chain in Winterspring and The Restless Souls. On the way to the Eastern Plaguelands, Chillwind
  Camp and Mulgris now hand out the Western Plaguelands quests you used to ride past. New on the way: ... and Bugs.
- Alliance 40-60: tips and notes left from an older order now match where you are: Vital Supplies is for Watchmaster
  Sorigal in Darkshire (not Nethergarde Keep), the Ironforge stop before the Badlands no longer starts with a tram
  ride you already took, Sigrun Ironhew at Hammertoe's Digsite is one stop, Feralas no longer says you end at the
  dock before the Thalanaar hand-in, Felwood's way in from Astranaar is on its first stop, and Un'Goro's
  Ironforge training step no longer says "Bind".
- Alliance 56-58: the guide's title now names Un'Goro Crater and Silithus, where a quarter of its quests are.
- Alliance route 20-30: Ashenvale, Stonetalon and the first Wetlands quests
  now come right after Darkshore, at about 20-24, when they are your level,
  and Redridge and Duskwood follow at a level that fits them instead of two
  levels short. The higher Wetlands quests (the Third Fleet, Ormer's Revenge,
  Fall of Dun Modr, War Banners), Pilot Longbeard in Ironforge and The
  Missing Diplomat in Stormwind move to a new guide after Duskwood, so the
  Wetlands are one visit at 27-29 and the old grind to 28 before Ironforge is
  gone. The Zoram Strand is back in Ashenvale now that its naga are your
  level.
- Badlands (Alliance 38-39): Lotwil's last test says its bracers come only
  from the Greater Rock Elementals (42-44) in the south-west, and is optional;
  the notes on Lucien's crafted bracers and on Murdaloc now say what they
  mean.
- Alliance 30-40: Fizzle Brassbolts now gives Martek the Exiled at the Mirage
  Raceway, since you hand in both his quests there. Martek and Indurium are
  done on the Badlands loop the route already walks, and News for Fizzle goes
  back to him on the Mirage Raceway stop at 45.
- Stranglethorn Vale (Alliance 33-35): after the flight to Sentinel Hill, the
  basilisk step says the way leads south out of Westfall to the Crystalvein
  Mine in Stranglethorn's north-west; it said to walk back north.
- Western Plaguelands (Horde, 57-59): Chromie's Counting Out Time is taken and done in Andorhal on your
  first visit to her, instead of on a return later in the guide.
- Arathi Highlands (Alliance): Worth Its Weight in Gold is done in one visit to Witherbark Village, where
  the trolls are, instead of a few tusks west of Refuge Pointe and a second trip for the knife.
- Arathi Highlands guide (Alliance, 37-39): The Lost Caravan's tip in the Swamp
  of Sorrows now says the wrecked caravan's chest is beside Galen Goodward's cage
  at the north end of the Fallow Sanctuary, where the arrow already leads, not
  near Watcher Biggs.
- Arathi Highlands (both sides): Sunken Treasure's escort tip now says the
  professor walks up to the cave above Faldir's Cove, where two water
  elementals ambush him; it said naga attacked on the shore.
- The arrow no longer asks for sharp turns back to the trail when you run
  beside it. In open ground, up to about 100 yards from the drawn path, it
  points ahead to a spot on the path you can run to in a straight line, and
  the route line joins the path there; it no longer plans the walk again
  while you do. Beside a cliff, a river crossed by a bridge or a building's
  walls it still leads you back to the path the way it did.
- The arrow no longer swings back for a moment when you run beside the path
  or onto it: something small in the way, like a lamp post or a fence post,
  no longer makes it point at a spot behind the one it was showing.
- Ashenvale, Wetlands & Stonetalon (Alliance, 20-24): from Menethil Harbor the guide takes the gryphon to Ironforge
  instead of walking through Dun Algaz, Loch Modan and Dun Morogh; you have both flight paths since your first trip east.
- Ashenvale, Wetlands & Stonetalon (Alliance, 20-24): the way through the Talondeep Path into Stonetalon is on the step
  that walks it, not on Kaela and Gaxim's after you've arrived, and Ziz Fizziks' hand-in and his Super Reaper 6000 are
  one stop at his hut.
- Ashenvale (Horde): Broodmother Valraxx is elite, so The Broodmother is asked
  as a group quest at the Earthen Ring camp.
- Ashenvale and Thousand Needles (Horde): Sharptalon's claw on the way north
  from Torek's fight to Splintertree Post instead of a walk back south; Tauren
  and Skyborne fly from Zoram'gar straight to Thunder Bluff for the Earthen
  Ring; Test of Strength is offered by Dorn only once Test of Endurance is in,
  so the guide asks for it there; the Whitereach Post step is named for where
  you stand.
- Auberdine (Alliance): The Family and the Fishing Pole is offered only to characters who have Fishing; before, the
  guide offered it to everyone, and most players without Fishing took it and later abandoned it.
- Azshara & The Barrens (Horde, 56): the Undercity stop no longer asks for Prompt Potion Runner, a level 16
  errand the Hillsbrad guide now does on its Undercity visit.
- Azshara, Feralas & Stranglethorn Vale (Horde, 50-51): the Orgrimmar stop after the flight from Valormok
  no longer tells you to take the zeppelin, and the Camp Mojache stop no longer says the next guide starts
  there (the muisek chain, Zorbin and Gadgetzan still follow).
- Badlands (Alliance, 39-40): Agmond's End (the skeleton, the ogres, the
  buzzards, the troggs and Theldurin) is one sweep from the Valley of Fangs
  before you go west to Lotwil, instead of a walk to Lotwil for his quest alone
  and back; his Lesser Rock Elementals also give Ghak's shards, and the Indurium
  flakes are no longer an "along the way" list.
- Badlands (Alliance, 30-40): Indurium and Barbecued Buzzard Wings are handed to Martek and Rigglefuzz on the walk from
  the Ancient Chest back south to Theldurin, which passes their camp, instead of in the 40-50 Badlands guide.
- Badlands (Horde): Jarkal's Badlands Reagent Run is taken in Kargath before
  the Lesser Rock Elementals, so its Rock Elemental Shards drop while you
  collect Lotwil's Small Stone Shards; Rigglefuzz's Buzzard Wings are collected
  with the troggs on the way to Agmond's End, and Rigglefuzz and Martek take the
  wings and the flakes as you pass the Valley of Fangs on the way north to the
  Uldaman chest.
- The Barrens 12-16: the zhevra hooves come on the road out to Ratchet
  instead of a walk north of the Crossroads and back, the prowler claws on
  the western loop by Regthar where the prowlers roam instead of a walk east
  of their own, and the last loop goes round once (Lushwater, the Dry Hills,
  Wenikee and the Sludge Fen, then Echeyakee on the way home), with
  everything handed in on the final Crossroads visit in walking order.
- The Barrens 12-16 no longer sends Orcs and Trolls to Ratchet for its
  flight path and straight back: it is learned on the Ratchet visit. Kolkar
  Leaders is taken with Centaur Bracers at Regthar and Barak Kodobane killed
  on the same loop; Orc and Troll Warriors and Shamans clear Thork's
  quilboar and crates while they are in the Razormane camp anyway; no step
  is an "along the way" list. In the 19-23 guide Raptor Horns is handed in
  on the first Ratchet stop when it is done, and Warriors hand Speak with
  Thun'grim in on the last Crossroads loop instead of walking there and back
  from Camp Taurajo.
- The Barrens (Horde, 19): Mebok offers Raptor Horns only from level 13, so
  players who reached Ratchet at 12 now take it on the first Ratchet stop at
  19.
- The Barrens (Horde, 19-23): Ratchet in walking order from the flight master,
  with the grind for those who skip Bruuz on the way south instead of between
  the town's quest givers; the Silithid eggs on the walk south to Gann,
  Sulhasa's Field to Clear taken with Gann's first quest and its lizards and
  stalkers on the plain by Blackthorn Ridge, instead of a walk back north to
  the Field of Giants and two more trips to Sulhasa.
- The Barrens (Horde, 56): after the flight to Ratchet, Liv Rizzlefix and Islen Waterseer come first and the
  ride north ends at Dokimi's crates in the Crossroads, whose flight goes on to Orgrimmar, instead of riding
  to the Crossroads and back to Ratchet.
- The Barrens: the quest data now knows the order of Vrang Wildgore's and
  Walton's chain (The Hermit Tanner after both of Vrang's quests, then
  Trouble in the Valley, then Unwelcome Guests), as players' recordings show
  it, so lookups and pick-up guides no longer offer a step early.
- Bug reports: an action the game blocked from Polestar now says which line
  of Polestar made it, so "blocked in Polestar: UNKNOWN()" can be traced.
  Another author's addon whose folder starts with "Polestar_" is no longer
  counted as Polestar's.
- The arrow says Walk to the Brill Inn entrance (and the same at every inn's
  door) instead of naming only the town, and it leads to Deathguard
  Bartholomew where he waits beside Dillinger, not to the middle of his walk
  to the graveyard (thanks Fitz).
- Burning Steppes (Alliance): the medallions and relics are listed in the steps that do them, and the trip to
  Mountaineer Pebblebitty is only for players doing The Horn of the Beast.
- Burning Steppes (Alliance, 50-53): the top-up to level 52 is done once, on the Dreadmaul Rock ogres on the way
  from Morgan's Vigil to Flame Crest, instead of a short top-up there and a ride back to the same ogres after the
  Flame Crest accepts.
- Stranglethorn Vale and the Hinterlands (Alliance, 40-50): Vital Supplies goes to Watchmaster Sorigal when you
  land in Darkshire on the way into the Swamp of Sorrows. His Crate of Power Stones, which lasts an hour, is now
  taken at Darkshire on the way to the Blasted Lands and goes straight to Nethergarde Keep; before, it was taken at
  the start of the Hinterlands guide and ran out long before the keep.
- Darkshore: Auberdine is walked in one direction on the first visit (from the pier up to Hollee and Thundris, then down the main street to Gwennyth and Gubber by the beach) and on the visit after Bashal'Aran (Thundris and the moonwell right after Terenthis, Gubber last on the way out). The two Beached Sea Creatures of the second loop are now taken on the fourth loop, with the remains by Murkdeep's camp and on the walk north from the Grove, instead of a walk down the coast and back.
- Darkshore: Fruit of the Sea goes to Gubber Blump on the Auberdine visit right after Cliffspring Falls, where the crab chunks come from, instead of a whole loop later.
- Druid Cat Form chain (Tauren and Skyborne): Polestar's quest data now
  knows each step's quest needs the one before it, as the server's own
  quest records have it, so the quest lookup and pick-up guides show the
  chain in order and never suggest a later step early.
- Desolace (Alliance): the Scorpashi venom comes from the scorpids around the Kodo Graveyard while you round
  up the kodos, instead of a stop of its own at Kormek's Hut and a walk back for the last hides.
- Desolace & Hillsbrad (Horde): Blackmoore's Legacy's hand-in says where Krusk stands in Tarren Mill, not "head back
  south to Tarren Mill" while you are already there.
- Desolace & Hillsbrad (Horde): Druids and Paladins train in Thunder Bluff at 30 on the way to Sun Rock Retreat.
  At 32 Druids fly from Shadowprey Village to Thunder Bluff and on to Orgrimmar, and Undead Paladins train with Garen
  Largo in the Undercity before the flight to Tarren Mill, with no flight back to the Undercity. The potion shopping
  tip and the Shamans' Sepulcher trip come before Tarren Mill too.
- Desolace (Horde): Other Fish to Fry is handed to Drulzegar Skraghook in
  Shadowprey Village right after you kill the naga, instead of being carried
  into the Dustwallow guide, which sent you back to the naga and handed it in
  hours later.
- Dun Morogh (Dwarf, Gnome): after the gryphon from Thelsamar, Ironforge is one round of the city: Golnir and the
  flight path in the Great Forge, Tinker Town's mailbox, the Forlorn Cavern, the Mystic Ward, the High Seat, the
  Military Ward and the tram, each class trained where the round passes its trainer. Before, the guide sent you to
  Tinker Town first, back to the Great Forge, and across the city four more times.
- Dun Morogh (Dwarf, Gnome): the guide ends with a loop through Loch Modan
  from the South Gate tunnel: the tunnel post's trogg quests, Kadrell's Stout
  and Rat Catching, Vidra's sausages, Stormpike's task and Filthy Paws, and
  Honor Students for every class, with its flight to Ironforge. Monty's rats
  and his letter to Nipsy are done on the tram, and Stormpike's Order is
  handed in at the Stormwind end. The grind at the snow leopards is gone.
- Dun Morogh (Dwarf): the Scalding Mornbrew is taken last at Grelin's camp, after the troll whelps, so its five minutes run only on the walk to Anvilmar. Both Dun Morogh guides: Stocking Jetsteam and The Grizzled Den go to the two pilots on one Steelgrill's Depot stop after the den, with the boars and bears killed on the walk back from Rumbleshot's camp, instead of two trips to the depot.
- Dun Morogh (Dwarf and Gnome): the Gol'Bolar Quarry's Skullthumpers and
  Bonesnappers are killed in one step, and Foreman Stonebrow, Senator Mehr and
  Quarrymaster Thesten take their quests on the first return, before Helm's
  Bed Lake, instead of a quarry stop for each hand-in. Back in Kharanos after
  Rumbleshot, Senir, Tognus and the distillery are one stop with one Rhapsody
  Malt, and Razzle's cogs and gears are collected with the Leper Gnomes instead
  of being listed along the whole walk west.
- The heads-up that a dungeon has opened up now shows the dungeon's own
  picture in its ring, the loading screen art you see on the way in
  (Ragefire Chasm's lava, the Deadmines' ship), instead of a flat purple
  circle. A dungeon without a picture shows the dungeon doorway icon.
- Dungeons: Ruins of Lordaeron and The Hall of Thanes show under "For your
  level" for their whole level range, not only at their first level. Their
  quests now set the top of the range.
- Dungeons: an instance whose entrance is in the other faction's land says so
  in a warning colour, on its card, its page, the dungeon heads-up and the
  arrow: Ruins of Lordaeron for the Alliance (outside the Undercity), The Hall
  of Thanes for the Horde (in Ironforge), and Ragefire Chasm and the Stockade.
  The heads-up for one leads with the dungeon's page instead of picking up
  its quests.
- Durotar (Orc and Troll): Warriors hand Conscript of the Horde to Kargal
  Battlescar, beside Uzzek, on their first stop at Far Watch Post instead of
  walking past him and back. Troll Durotar also takes Lar Prowltusk's Kolkar
  quest on the first visit to Sen'jin Village, visits Razor Hill once after
  Tiragarde Keep, and gathers the eggs and tiger fur where the coast walk
  meets them.
- Durotar and The Barrens (Orc and Troll Shamans): Kranal Fiss's Call of Fire
  and Telf Joolam's are taken at 10 on the trip across the river, and the
  Reagent Pouch drops in Drygulch Ravine on the north loop, instead of a
  second walk to Kranal, Telf and northern Durotar from the Crossroads.
- Durotar (Orc and Troll Warriors): Conscript of the Horde is handed in once,
  on the first Far Watch stop; the last Far Watch step no longer asks for it
  again.
- Duskwood (Alliance, 29-30): The Weathered Grave and Morgan Ladimore, two talk-only quests on the Duskwood return, are
  in the guide for every race from level 28; they were shown to Dwarves and Skyborne only.
- Duskwood flows in one direction more often: Darkshire's first visit goes
  round the town from the flight master in walking order and hands Look to
  the Stars in at once (Herble's Bronze Tube is beside Viktori), Blind Mary
  takes its second part on the Embalmer chain's visit, and you no longer walk
  back north into Darkshire from the Tranquil Gardens for The Night Watch
  alone: it's handed in on the next big visit, its Skeletal Horrors with the
  Rot Blossoms and its Fiends on the cemetery walk to Jitters. The Totem's
  spider venom comes from the spiders you kill at the Hushed Bank instead of
  a walk back west from the Yorgen Farmstead, the level-27 worgen wait for
  the Duskwood return, and no step is an along-the-way list.
- Duskwood: Elaine Carevin's Raven Hill and Jitters' Growling Gut are done on
  the first Duskwood loop: Jitters is on the Raven Hill stop, Chef Grual on
  the way back through Darkshire.
- Eastern Plaguelands (Alliance, 58): at Light's Hope Chapel both Darrowshire hand-ins go to Carlin Redpath in one
  visit, then Caretaker Alen, instead of Carlin, Alen and Carlin again under a tip about riding to Chillwind Camp.
- Eastern Plaguelands (Horde): Corin's Crossing is done on the ride south from Quel'Lithien Lodge, so all
  three of Nathanos Blightcaller's quests are handed in on one visit, and The Everlook Report goes to
  Argent Officer Garush at the Bulwark on the way in.
- Elwynn Forest flows in one direction more often: the first Goldshire stop
  goes from Marshal Dughan to Remy to the inn on your way out to the lake,
  Baited for Success is handed to Jason Mathers and the kelp collected on the
  walk east instead of on the walk back, Princess is fought with the river's
  Downstream search instead of on a second trip south, and the end no longer
  walks from Goldshire to Westbrook, back to Goldshire and out again: Maybell,
  the Stonefield Farm, the Applejack Still, then Westbrook Garrison and its
  gnolls, on the road to Westfall. No step is an along-the-way list.
- Northshire: Milly's Harvest goes back to Milly right after the grapes and Garrick Padfoot, and Garrick's head goes to Deputy Willem on the Abbey visit after Echo Ridge Mine, instead of a walk back to the Abbey between Garrick and Milly.
- Eastern Plaguelands, Winterspring & Tanaris (Horde, 56-57): only Druids and Paladins fly from Bloodvenom
  Post to Thunder Bluff and back to train; everyone else stays in Felwood (the guide sent every class on
  the round trip). The Thunder Bluff cloth donations are handed to Rumstag Proudstrider when you take
  them in the Winterspring guide, if you carry the cloth. The Plaguebats and Carrion Grubs are goals of
  the hills step instead of lists along the way.
- Felwood (Alliance): Laris's ooze jars are filled on the southern loop, the Cursed Oozes in Jadefire Glen and the
  Tainted Oozes at Jaedenar, among the satyrs and cultists you kill there, instead of on stops of their own later.
- Felwood & Western Plaguelands (Horde, 53-55): Kirsta Deepshadow's Unfinished
  Business is taken before the level top-up on Northridge's Scarlets, so the
  Scarlets you grind count for it. The guide had you grind there first and
  walk up to Kirsta afterwards.
- Felwood, Moonglade & Winterspring (Horde, 59-60): while you are still in Felwood the guide no longer
  asks for a level top-up on Winterspring's furbolgs, a ride through Timbermaw Hold and back; the top-up
  waits for Winterspring, where the route goes anyway.
- Felwood, Moonglade & Winterspring (Horde, 59-60): Donova Snowden is one
  stop, with the way there through the Timbermaw tunnel on it; the tip sat on
  a second Donova step after you had already arrived.
- Feralas (Alliance): a player under 45 takes the boat to the coast before the level-45 grind in Feral Scar Vale,
  instead of grinding on the mainland and riding back to Feathermoon's dock for the boat; the way to the Grimtotem
  camp is described from Thalanaar, where the flight lands.
- Feralas (Alliance): Lord Shalzaru on the Isle of Dread closes the southern mainland loop and you swim back to
  Feathermoon for all its hand-ins at once, instead of a boat trip out and back for him alone. The Groddoc livers
  come from the apes around Feral Scar Vale on that loop.
- Feralas (Horde, 43-45): the last trip out of Camp Mojache is one sweep west, from the Writhing Deep to
  the Ruins of Isildien and Feral Scar Vale, with one return to the camp for every hand-in. There is no ride
  to the Forgotten Coast for OOX-22/FE's beacon: any beast, gnoll or ogre in Feralas can drop it.
- Feralas, Dustwallow Marsh & Swamp of Sorrows (Horde, 45-47): the Pool of Tears comes on the ride east,
  before Misty Reed Post, instead of a ride from Misty Reed to the pool and back. Natural Materials is
  gathered in two stays (the sprite darters and a forest walker west of Camp Mojache, then the
  hippogryphs). The Thick Yeti Hides are gathered on your first Feralas visit, so Improved Quality's Rage
  Scar yetis are done on the way back from the Northspring harpies and handed in before you fly on.
- Feralas & Tanaris (Horde, 43-45): Stoley, the Haughty Modiste and the
  Security Chief get what Lost Rigger Cove gave you on the ride back to
  Gadgetzan, and Yeh'kinya's Screecher Spirits is taken there. The 45-47 guide
  no longer flies from Brackenwall Village to Gadgetzan and rides to
  Steamwheedle Port and back for them: it flies straight to Camp Mojache.
- Feralas (Horde, 43-45): Zukk'ash Report goes to Zilzibin Drumlore on the Orgrimmar stop at the end of
  the guide, which passes him, instead of being carried to the Azshara guide.
- Feralas (Horde, 43-45): the OOX-22/FE distress beacon is listed again in the robot's step, so the guide
  shows it when it drops.
- Flights: the arrow no longer sends you to a town where nothing is left to
  do just to take another flight from there. A flight step now leads to
  the flight's end, so the travel route flies there in one go from the
  nearest flight master that reaches it; when the work at a stop on the
  way is already done or skipped, the guide flies you on directly; and
  when a flight path you know is clearly quicker for the next work
  (Thunder Bluff for the Earthen Ring instead of Camp Taurajo), the route
  takes it. The Hinterlands (Horde) flies from Thorium Point straight to
  Tarren Mill, Druids and Paladins in the Eastern Plaguelands fly from
  Orgrimmar to Thunder Bluff first, Shamans in Desolace fly from Freewind
  Post straight to Sun Rock Retreat, and Druids in the Barrens fly from
  Ratchet straight to Thunder Bluff for training. (thanks Bennistrov and
  Konky88)
- The guide menu scrolls better with lots of guides, community guides
  included: the guide list has a scroll bar you can see and drag (it was
  hidden behind the details pane), and the sidebar, the list and the
  details stay where you scrolled them when you pick a guide or your guide
  updates, instead of jumping back to the top.
- The arrow takes your Hearthstone sooner: a trip of over 3 minutes that
  hearthing shortens by at least 2 now hearths (it was 8 and 5), so routes no
  longer walk long ways home with the stone ready (thanks Fitz, #1096).
- Wetlands & Hillsbrad Foothills (Alliance, 30-40): Druids train with Sheldras Moontree on the walk from the Mage
  Quarter to the Stormwind harbour, instead of between Elling Trias's hand-in and his next quest.
- Wetlands & Hillsbrad Foothills (Alliance, 30-40): Dun Modr is one stop on the way north (Longbraid the
  Grim, Rhag Garmason, Roggo Harlbarrow and the Heart of Modr), the Villards come next on the road to the
  Thandol Span, and Ebenezer Rustlocke is handed in as you cross the span to Foggy MacKreel.
- Wetlands & Hillsbrad Foothills (Alliance, 30-40): Gleaning Our Future is a group quest. Golm, Ados, Neru and Modr,
  whose hearts it asks for, are level 32 elites; their steps show only when you choose to group for it, with a tip
  that says so.
- Wetlands & Hillsbrad Foothills (Alliance, 30-40): Warriors take The Islander from Wu Shen on the Dashel Stonefist
  stop in Old Town, instead of walking to Old Town first and back to the Trade District. The Ironforge stop's tip
  says where Stormpike, Karnik and Roetten stand, not to take the tram you didn't need.
- Hillsbrad (Alliance, 30-40): Southshore is picked up in one pass from the
  boat, Farren gives Reassignment when you hand in Stormwind Ho!, the Syndicate
  Footpads and Thieves are killed at the camp with the documents instead of a
  detour into north-west Alterac and back, and in Stormwind Elling Trias is
  visited on the way to the Mage Quarter and the harbour.
- Wetlands & Hillsbrad Foothills (Alliance, 30-40): every race hands The Thandol Span in at Ebenezer Rustlocke's corpse,
  beside Essene Villard on the walk north from Dun Modr. Humans no longer carry it to the Arathi guide and walk from
  Faldir's Cove back onto the span for it.
- Horde Hillsbrad no longer walks you from Tarren Mill to the Hillsbrad
  fields and back five times in a row for Battle of Hillsbrad: parts 4 and 5,
  whose Magistrate Burnside and Foreman Bonds are level 30, come on the
  Tarren Mill visit at about 32, with the town hall after the yeti caves and
  the Azurelode Mine on the way to Dalaran's crater.
- Hillsbrad Foothills (Horde): Prompt Potion Runner is taken from Alessandro
  Luca and handed to Doctor Martin Felben beside Faranell on the Undercity
  visit, and the walk from the western peak back to Tarren Mill has its own
  step.
- Hillsbrad Foothills (Horde): no second bind step at Tarren Mill on the way
  to Hillsbrad Fields, and the Undercity visit's tip no longer tells Skyborne
  to fly from the Crossroads.
- The Hinterlands (Alliance, 40-50): Uldaman Reagent Run is taken from Ghak in Thelsamar where the flight lands,
  so Loch Modan is crossed once each way (Thelsamar, Ironband, the Uldaman dig, Ironband, Thelsamar), and the
  flight to Booty Bay after Nethergarde is only for players doing The Monogrammed Sash.
- The Hinterlands (Horde, 48-50): Separation Anxiety, Kidnapped Elder
  Torntusk! and Dark Vessels are group quests. They send you into Jintha'Alor,
  where every troll is elite, and the guide had you go alone at about 48. Now
  the guide asks whether you have a group; alone, you skip them and the level
  top-up after Revantusk Village makes up the experience.
- The Hinterlands (Horde, 48-50): the Silvermane Stalkers and the Vilebranch scalpers are goals of the
  temples step instead of lists along the way, and the Revantusk Village stop in the middle of the guide
  no longer says the next guide starts there.
- The Barrens at 19: Egg Hunt is taken from Korran on the last Crossroads stop
  before the Field of Giants, not at 17, so it no longer sits in your log
  through the whole stay.
- The Barrens at 21: Jorn Skyseer takes the thunderhawk wings on the walk back
  north after the Silithid eggs (and, for Warriors, beside Ruga), instead of a
  walk back into Camp Taurajo between the hawks and the eggs.
- Hillsbrad Foothills at 22: the bears and creepers, Hillsbrad Fields and the
  lions are one walk west; Lydon and Umpi take Elixir of Suffering on the
  Tarren Mill stop after the fields, not on an extra trip back up the hill.
- Silverpine Forest at 13: the Decrepit Ferry's boat is handed in on the shore
  walk from the murlocs to Ambermill, and Hadrec takes Rot Hide Clues on the
  Sepulcher stop after Ambermill, instead of a separate trip to the ferry.
- Texts: Regthar's watch post is west of the Crossroads; The Binding's note
  points to the next guide's Orgrimmar stop; Deathguard Bartholomew stays beside
  Dillinger in Brill; the Skyborne Druid's Cat Form trip is in the Barrens
  guide at about 21.
- Ashenvale at 21: The Warsong Reports is left out. Its walk east of Night Run
  and back to Kadrak after Thistlefur cost more time than its XP brings; you
  now fly from Splintertree to Orgrimmar right after Yama Snowhoof.
- Grind steps say you can run a dungeon of your level with a group instead
  (Thousand Needles: Blackfathom Deeps, Razorfen Kraul or Scarlet Monastery).
- Durotar (Orc, Troll): Conscript of the Horde is handed to Kargal at Far Watch
  Post at the end of the Durotar guide, so it no longer sits in your log through
  Silverpine Forest. Warriors hand Veteran Uzzek in there too and take the
  Thunder Ridge lizards on the road north to Orgrimmar.
- The Barrens at 18-19: from Ratchet the walk goes south-west to Sergra's
  raptor nests and Gazrog's stolen silver, takes Gazlowe's Stolen Booty
  crates on the beach, clears Northwatch Hold and walks Gilthares back to
  Ratchet, then flies to the Crossroads. The escort no longer ends in Ratchet
  only to send you straight back south past Northwatch, and the first Ratchet
  stop no longer walks down the beach a second time for the booty.
- The Crossroads, Sun Rock Retreat and Camp Taurajo visits list their quest
  givers in walking order, so the arrow no longer crosses the town to the
  same person twice.
- The Horde route from 12 to 30 now takes the zones in the order their quest
  levels fit: Silverpine Forest first at 12-15, straight from every start
  (Tirisfal Glades walks south into it; Durotar, Mulgore and Zephras Isle go
  by Orgrimmar and the zeppelin), then the Barrens and Stonetalon's road in
  one stay at 15-21, Ashenvale and the ride through Silverpine to Hillsbrad at
  21-22, Hillsbrad at 22-24, the Barrens and Sun Rock Retreat at 24-26, and
  Ashenvale and Thousand Needles at 26-30. The grind to 19 in Silverpine and
  the second walk through the Barrens' north are gone.
- Orgrimmar's own quests (Meal Appeal, Yelmak's Medley, Rocks to Rests) are
  done on the walk in from the main gate, and the Silverpine stay ends in the
  Undercity with Raleigh, Prompt Potion Runner and Zinge's delivery, whose
  sample goes to Helbrim at the Crossroads.
- In the Barrens, the quests are taken the first time the walk meets their
  giver: Miner's Fortune at the first Ratchet stop, Verog at Regthar's first
  stop, Mankrik's two, Egg Hunt and Report to Kadrak at the Crossroads stop at
  17, Ziz Fizziks with Samophlange. The Orgrimmar training trip comes after
  Agama'gor, at 20, where the level-20 class quests are offered. Seereth's,
  Makaba's and Xen'Zilla's quests ride with the road into Stonetalon at 20.
- Ashenvale's first visit does Thistlefur Village and Hold (Troll Charm,
  Between a Rock and a Thistlefur, Freedom to Ruul) and Vorsha the Lasher
  from Zoram'gar at 21,
  instead of carrying them through Stonetalon and Hillsbrad. Stonetalon
  Standstill is left out.
- Silverpine at 12-15 leaves out Fenris Isle (its gnolls are 15-22) and the
  grey deliveries Mura Runetotem and Ride to Orgrimmar; Further Instructions is
  left out too. Thousand Needles' top-up before Roguefeather Den is two short
  steps that skip themselves once you are past them.
- Undead Paladins, who learn Thunder Bluff's flight path with Alodan's
  training, fly from Zoram'gar to Thunder Bluff for the Earthen Ring instead
  of to Camp Taurajo and the walk through Mulgore.
- Horde 30-40 now goes through the zones in the order their quest levels fit,
  instead of Desolace at 30 with top-ups at Sargeron and on the coast to
  reach its quests' levels:
  - Hillsbrad and a first Arathi visit (30-33): the Tarren Mill quests, with
    Helcular's Revenge finished at Southshore's graveyard, then Hammerfall's
    first quests and the Witherbark trolls.
  - The Shimmering Flats (33-34): every Mirage Raceway quest in one visit
    (Rocket Car Parts and Salt Flat Venom used to be done alone at 29),
    with Hardened Shells, Load Lightening, A Bump in the Road and Moktar
    Krin's silithid dig.
  - Desolace's 33-36 quests (34-35), with the Book of the Ancients, the
    Hand of Iruxos and Aka'rai's Hate the Hatefury; its 38-40 quests
    (Melizza, the ghost-o-plasm, the portals, the centaur totems) on a short
    stop from Ratchet after Dustwallow.
  - Stranglethorn (36-37), Dustwallow (37-38), then Alterac with the
    Perenolde manor and the rest of Arathi (38-39), and the Badlands (39-40),
    from where you fly to Booty Bay for the 40-50 guides.
- Martek the Exiled is taken at the raceway once Hardened Shells is in:
  Fizzle Brassbolts offers it only then, so the 27-30 guide no longer asks
  for it after Salt Flat Venom alone, when he does not offer it.
- Stolen Freewind Supplies is done with Stop the Screeching in the
  Roguefeather harpy den.
- Where the band runs short, a few short "until level N" steps at camps the
  route already passes (Arathi's Boulderfist camp, the Shimmering Flats, the
  Mosh'Ogg camp, the Mirefin murlocs), each skipped once you are past that
  level, with a dungeon you can run instead where one is near. Optional
  dungeon and group quests are offered on the way: Rig Wars in Gnomeregan,
  the last Battle of Hillsbrad and Humbert's Sword at Dun Garok, and the
  Stromgarde quests in Arathi.
- Horde 30-40 (Shaman): Call of Air is taken from Searn Firewarder on the
  Orgrimmar stop at about 31, before the flight to Freewind Post. It was on
  the stop at 29, a level before Searn offers it.
- Hillsbrad & Arathi (Horde 30-32): the level 31 top-up no longer says
  Hammerfall's quests start at 31 (they are 32-36), and the level 30 top-up by
  Tarren Mill suggests the Scarlet Monastery's Graveyard if you have a group.
- Horde 40-60 no longer asks you to take quests the game won't offer yet, or
  ones far above you:
  - Stranglethorn Fever comes on the Booty Bay stop after the Wild Shore,
    Stoley's Debt with Return to MacKinley, and Tran'rek on the last Booty Bay
    stop. All three need level 40 and used to be on the stop where you land
    from Kargath, just under it.
  - The Strength of Corruption comes from Talo Thornhoof on the Camp Mojache
    stop at about 49, not at 46.
  - Secret Communication is taken and handed in on the same Cenarion Hold
    stop: the texts drop without the quest.
- The top-up steps now aim where the next quest needs you:
  - Zul'Kunda: 41, for Speaking with Gan'zulah.
  - Azshara: 50, for March of the Silithid.
  - Un'Goro: 52, for The Rise of the Machines in Kargath.
  - Silithus: a new step to 58 before Dearest Natalia.
- Horde 40-60: every level top-up step names the dungeon to run instead with
  a group, for example the Maraudon dungeon in the Hinterlands, the Sunken
  Temple or Blackrock Depths dungeon in Felwood and the Western Plaguelands,
  and the Scholomance or Stratholme dungeon near 59. The long grinds on the
  Bloodscalps in Stranglethorn and on the Deadwood furbolgs in Felwood say so
  too.
- Horde 40-50, riding at 40: Trolls learn to ride at Sen'jin Village from the Orgrimmar stop at the start of
  the Feralas guide, instead of a trip from Stonard by flight and boat to Durotar and back in the middle of
  the Swamp of Sorrows; Undead learn it in Brill on the Undercity stop of the next Feralas guide, instead of
  a loop from Gadgetzan through Orgrimmar and Tirisfal and back; Taurens, Druids and Paladins fly from
  Orgrimmar to Thunder Bluff (riding in Bloodhoof Village, class training) and on to Freewind Post, and
  Warlocks take the Felsteed in Ratchet from Orgrimmar, instead of flying back from Gadgetzan.
- Horde 40-60: tips that pointed the wrong way now match the route. The
  Ironjaw Basilisks are on the road north of Booty Bay, back towards Grom'gol;
  the Altar of Zul is south-west of Valorwind Lake in the Hinterlands; Rogue
  Vale's screechers are just north of Zorbin's dock in Feralas; and Felstone
  Farm is reached from the Bulwark, where the step before leaves you.
- Winterspring and Azshara (Horde, 55-56): the Orgrimmar Wool, Silk and
  Mageweave donations are handed in when you take them at the end of the
  Winterspring guide, if you carry the cloth, as the Thunder Bluff ones are.
  The Azshara guide flies from the Crossroads straight on to Valormok instead
  of landing in Orgrimmar again to hand them in.
- Horde Ashenvale & Thousand Needles: Stonetalon Standstill's elementals and
  gazebo are done at Mystral Lake while you hunt Tideress, instead of a walk
  back to the lake later; Shamans fill Brine's waterskin at the fountain in
  Ursangous's ruins (no walk back to Zoram'gar) and hand it to Brine on the
  road from Camp Taurajo to the Great Lift (no flight back from Freewind
  Post); Splintertree Post and Freewind Post are walked through once, with
  their inns entered once; after Roguefeather Den, Freewind's hand-ins come
  before Dorn Plainstalker on the way out to the Shimmering Flats.
- Stranglethorn Vale and the Swamp of Sorrows (Horde, 39-47): Cortello's Riddle is optional: its scroll lies
  on the Bloodsail ships, crewed by pirates of 42-45 at about level 41. Its later parts show only if you
  have the part before.
- Silithus (Horde, 57-59): Pawn Captures Queen tells you where to use the Gorishi Queen Lure.
- Stranglethorn Vale (Horde 34-37): the tips put the tigers and panthers
  around and west of Nesingwary's camp and the Venture Co. camp by Lake
  Nazferiti, south-east of it, where they are; the step you land in from the
  zeppelin is called Grom'gol, not a flight.
- The Barrens: Counterattack! at Regthar on the last Crossroads stop. Orcs and
  Trolls take Doras's errand in Orgrimmar back to Zargh.
- Silverpine Forest: Arugal's Folly from Dalar, the spellbooks at Valgan's Field on the walk north.
- Stonetalon Mountains: Time To Strike (Deathstalker Lesh, on the road into Hillsbrad) is a regular step,
  no longer optional.
- Tirisfal Glades (Undead): Hilda's and Ephram's quests are regular steps, no longer optional, and Johaan's
  delivery goes to Renferrel on the first Sepulcher stop.
- The guide menu's section rail keeps its labels (Guides, Lookup, Dungeons
  and the rest) after a fresh start of the game, also with EllesmereUI's
  font; they could be left blank until a /reload. The version line at the
  foot of the guide menu and the settings no longer runs under the Discord
  mark or puts the Beta badge over "Reset page".
- The level line in the guide window now always says where you stand, not
  only when a grind step is ahead: on pace; behind, by how many levels or
  bars, and what the guide does about it (a step that grinds it, with about
  how long at your XP an hour); or, when nothing in the guide makes it up,
  which quest ahead will be too hard and how long to grind before it. A step
  whose quest is 3 or more levels above you says so under its title ("Level
  25 quest: you're 19.7"). Thanks to a player on Discord.
- Polestar now tells you at login when its folders come from different
  versions, naming each one, for example Polestar_Guides_Orc or
  Polestar_Nav_EK left from an older zip, even folders it loads only for
  another race or language. Delete every Polestar folder and install again
  with the Polestar Client, the CurseForge app or the latest zip. The bug
  report shows it too.
- Mulgore: Bloodhoof's finished quests are handed in on the visit that walks
  past them (Swoop Hunting and Rite of Vision with Poison Water, Mazzranache
  with Thunderhorn Totem), Morin's caravan and Longwalker Malah come with the
  Winterhoof well trip instead of a second walk out, Preparation for Ceremony
  is taken beside Eylah in Thunder Bluff, and the "along the way" lists are
  plain steps.
- Mulgore: arriving at the Crossroads, both of Tonga Runetotem's quests at
  the south gate come first, then the rest of the town in walking order, so
  you no longer cross the town three times.
- On a non-English client, the guide window names a quest's objectives in
  your language before you take it (or reads "Complete <quest>" when an
  objective has no name to give), as do the pace line's quest and the
  class-quest card's giver.
- The arrow uses much less memory and CPU on long walks: when you ride off
  the drawn line, the walking router now reuses its work between searches,
  asks for the walk again less often, and near the target measures only your
  own walk again instead of every flight master's. A long walk off the line
  makes about a fifth of the garbage it did in 0.3.4, which is what pushed
  Polestar_Nav's AddOn Memory figure up.
- Night Elf Darkshore crosses the sea once: Bashal'Aran's last part (the
  Ancient Flame at Ameth'Aran, then Asterion) is done on the second loop,
  before the boat to Stormwind, instead of a trip back from Goldshire and a
  second boat out. The Plagued Lands bear is captured south of Auberdine on
  the way to the furbolg camp, instead of north of the red crystal with a long
  walk back south.
  Washed Ashore is handed to Gwennyth on the walk back from the Long Wash at
  the end of Teldrassil, the first NPC on the way into Auberdine.
- Night Elves (Alliance, 18-20): Further Concerns, from Marshal Dughan at the end of the Night Elf Darkshore guide, is
  handed to Guard Thomas on his bridge as the walk to Redridge passes it, instead of being carried to the Duskwood and
  Redridge visit at about 24.
- Objective counters in a few class quests point at the right objective: A
  Moon-Kissed Blade, The Tarnished and Storm, Earth, and Fire, and Defending
  the Dead at Gloomrise.
- Step changes are quicker: quest objective markers and their spot areas
  (#1085) are worked out only while they show on a map, a quest log change
  works out only the new quest's areas instead of every quest's, spawn areas
  are grouped about a third faster, and the guide window redraws just its
  tabs when a step moves on instead of laying itself out a second time.
- Quests the guides asked for before their giver offers them, found in
  players' recordings: Karl Boran's Return the Statuette is taken once the
  old Return the Statuette is handed in to him, so Captain Stoutfist's A
  Friend of the Family comes after it (thanks Fyurie); Lightforge Ingots is no
  longer asked for in the Wetlands, since Glorin Steelbrow offers it only after
  The Lost Ingots (thanks Fyurie); Duskwood takes Worgen in the Woods on the
  second Darkshire visit, from level 23 (thanks L10NH34R7); The Broodmother is taken from Muln Earthfury
  once Defending the Dead is handed in, in the Ashenvale and Thunder Bluff
  guides (thanks DexeeXI); and a Skyborne takes Journey to the Crossroads from
  Thrall after handing him Welcome to Azeroth. Crimson Crate Delivery is no
  longer taken in Menethil, since James Halloran offers it only after Crocs of
  the Sky (thanks Fyurie). Warriors in Stormwind are told to go straight to
  Harry Burlguard if Ilsa Corbin doesn't offer A Warrior's Training.
- Orc Durotar: Lar Prowltusk's Kolkar quest is taken on the first visit to
  Sen'jin Village, so you no longer walk back there from Razor Hill after
  Tiragarde Keep; the coast is walked once from Razor Hill south to the Echo
  Isles, Razor Hill's hand-ins after the keep are in walking order, and the
  egg and tiger fur lists are plain steps.
- Paladin and Shaman class quests: the Tome of Divinity, the Tome of Valor and
  the replacement Saptas no longer come back as undone after a reload. Their
  givers hand them straight back, a quest the game never marks completed, so
  the guide kept sending Paladins who had done Redemption back to its start.
- Party chat lines start with a star now and name the quest first: "[Plagued
  Lands] Plagued Hide 5/5, Rabid Wolves 8/8" and "[Plagued Lands] is ready to
  turn in". Objectives finished together go out as one line, and a new line
  tells your party when you loot an item that starts a quest. Party members
  with Polestar see Polestar's own star on these lines, and your own lines
  stay out of your chat. Options > Questing > Quests > Group has the new
  switches: quest-starting loot, your own lines in your chat, hiding other
  players' Polestar lines, and speaking only when someone in the party
  doesn't have Polestar.
- Hovering a quest in the guide window now shows what it leads to: the next
  part of its chain ("The Defias Brotherhood (part 2 of 7)") and where the
  chain ends, and quests other people give that need it ("Red Silk Bandanas,
  from Scout Riell"). Skip and Skip this quest list the later quests that go
  with them, and a quest the guide left out because you skipped the one it
  needs tells you which. (thanks to a player on Discord)
- Redridge flows in one direction more often: after Lakeshire's first stop
  you head straight out west to Guard Parker and the gnoll hills instead of
  swimming east for the Sunken Chest first, and on the way back the town is
  crossed once, east to west: Deputy Feldon by the gryphons, the chest in
  the lake with the murlocs around it for the fins and sunfish, Foreman Oslow
  at the bridge, Dockmaster Baren on the docks, Martie Jainrose's garden, then
  the Brutes just north of it for the Iron Pikes. The sunfish are no longer
  listed in the gnoll hills, where nothing drops them, and no step is an
  along-the-way list.
- Russian and Simplified Chinese: the whole interface is translated again,
  Polestar Recorder too, along with every guide's title and menu folder and
  the step texts of Elwynn Forest, Westfall and First Aid.
- Searing Gorge (Alliance, 48-49): the way in from Thelsamar (through the Badlands, past Kargath) is now described on
  the first stop, the Grimesilt outhouse, and Thorium Point's step tells you to ride north-west across the Cauldron
  from there.
- Searing Gorge (Alliance): Suntara Stones is taken from Dorius right before his escort at the end of the guide
  (taken at the start, the escort failed on the way to Thorium Point); Caught! is handed in at the outhouse right
  after the geologists; the Taskmasters, Slavers and Incendosaurs are steps where they live, not lists to keep in mind.
- Searing Gorge (Horde): Caught! is handed in at the Wooden Outhouse right after the geologists, instead
  of a ride back to the dig site at the end, and the Smithing Tuyere comes from the same Steamsmiths as the
  Thorium Plated Daggers.
- Silithus (Alliance): class training is in the Ironforge stop instead of a tram ride to Ironforge and back before
  Stormwind, and the last city visit is one Stormwind stop and one Ironforge stop instead of Ironforge, Stormwind,
  Ironforge, Stormwind.
- Alliance 58-60 (Silithus, Felwood, Winterspring & the Plaguelands): the Felwood stop now starts from Talrendis
  Point, where the flight lands; Everlook no longer asks for the flight you just took; Ranshalla's escort is no longer
  said to come later (it is next); the Dire Maul note points at the guide's solo grind in Terrordale.
- Silithus (Alliance): Noggle's Lost Satchel is taken from Noggle, who stands beside Beetix, when you hand in
  Noggle's Last Hope, instead of on the next Cenarion Hold stop.
- Silithus (Horde, 57-59): Dearest Natalia's step says to question Frankal
  Stonebridge and Rutgar Glyphshaper at Bronzebeard's Encampment instead of
  showing only two kills, and the level top-up before it names Commander
  Mar'alith, who gives it. Two notes that said to skip quests the guide had
  just taken (Dearest Natalia and Skeletal Fragments) are gone; Mar'alith's
  note now names the follow-up to skip, Into the Maw of Madness.
- Silithus & the Plaguelands (Horde, 57-59): the Stonelash Flayer stingers are no longer listed along the
  way ahead of the dunes step that gathers them; the Marshal's Refuge tip that broke off at "J.D." reads
  whole again; and the Bulwark stop in the middle of the guide no longer says the next guide starts in the
  Undercity.
- Silverpine Forest (Horde, 16-19): the Orgrimmar training comes before the
  zeppelin instead of after the walk to Silverpine; Paladins train in Brill on
  the way from the zeppelin towers, Druids fly to Thunder Bluff and Moonglade
  from the Crossroads at the end of The Barrens instead of riding the zeppelin
  back from the Sepulcher, Paladins learn axes from Sayoc on the Valley of
  Honor stop, and a stray swimming tip at the Sepulcher is gone.
- Silverpine Forest: on the Sepulcher stop after Ambermill, Return to Quinn
  (Again) is taken from Apothecary Renferrel as you hand in Wild Eyes, before
  Dalar Dawnweaver, instead of walking back to Renferrel for it.
- Silverpine Forest: after Fenris Isle the guide goes south along the lake
  shore (where it has you grind) to Ambermill and Beren's Peril, then hands
  everything in on one Sepulcher stop, Journey to Hillsbrad included, before
  the road north. You no longer walk back to the Sepulcher between the island
  and Ambermill, nor out to the lake shore and back for Journey to Hillsbrad
  alone; Beren's Peril is taken with Ambermill Investigations.
- Swamp of Sorrows (Horde, 45-47): the Sawtooth Snapper Claws are a goal of the coast step with the
  Monstrous Crawlers instead of a list along the way, and two leftover lines are gone: a tip at Misty
  Reed Post saying the next guide starts there, and a note about keeping The Sunken Temple, which you
  don't have yet at that point.
- Feralas (Horde, 45-47): the last Camp Mojache stop goes Jangdor, Uzer'i, Talo in the order you ride in.
- A new setting, Wait for Spoken (Options, Integrations), holds each automatic
  quest accept, turn-in and reward pick for 200 ms, so the Spoken addon has
  time to read the window. On by default while Spoken is installed (thanks
  uNBEx).
- A step's tip now starts on one line, so the guide window doesn't open on a
  wall of text: click the tip to read it in full. To have every tip open all
  the time, turn on Options > Guide > Window, "Expand step tips".
- Stonetalon Mountains (Horde): at Beren's Peril the Note Scrap is handed in
  at the Offering Stone first, which then offers The Tortured Soul and The
  Offering of Blood; the guide asked for The Tortured Soul before the stone
  offers it. The walk to Malaka'jin no longer sends you back to the Crossroads
  from Seereth Stonebreak.
- Stranglethorn Vale (Alliance, 40-43): Nesingwary's last hunts (Tethis, King Bangalash), or the solo top-ups on the
  Cold Eye Basilisks, now come after the Crystalvein Mine and before the last Booty Bay stop, instead of a ride back
  north from Booty Bay and south again to fly.
- Stranglethorn Vale (Alliance, 30-40): the haunted island is reached from the Crystalvein Mine on the first jungle
  loop and handed in on the Booty Bay return, so the water elementals and the Snapjaw crocolisks are done on the
  northern loop and handed in on the last Booty Bay stop. No more round trip from Booty Bay to the river for the skins,
  or walk from Booty Bay back to the island, on to Westfall and a flight back. Druids train in Stormwind after the
  flight there, instead of a trip through Ironforge that ended at Menethil's flight master, and the level-40 Jungle
  Stalkers are no longer a list to keep in mind at 36.
- Stranglethorn Vale (Alliance, 30-40): Krazek's Cookery is taken on the first Rebel Camp visit and handed
  to Krazek on the first Booty Bay stop, with Favor for Krazek, instead of waiting for the second visits.
- Stranglethorn Vale (Alliance, 40-50): the Jungle Stalkers for Raptor Mastery are killed with the Cold Eye
  basilisks on the jungle loop, and Hemet Nesingwary takes the quest on the ride to the Rebel Camp, instead of a
  trip back north from Booty Bay for it.
- Stranglethorn Vale (Alliance, 40-50): Night Elves learn to ride from the first Stormwind stop instead of
  walking from the Swamp of Sorrows to Stormwind and back; Dwarves and Gnomes learn it on the way out of Ironforge
  instead of riding back from the Badlands; only Humans go by Darkshire to Booty Bay (everyone else lands there by
  boat and no longer flies to Darkshire and back); the Mistvale Giblets come with the Gorilla Fangs; and the flight
  to Stormwind leaves from Booty Bay.
- Stranglethorn Vale (Horde, 39-43): the flight from Kargath goes to Grom'gol
  first, for Kin'weelay, the Jungle Stalkers and Far Seer Mok'thardin, and on
  to Booty Bay from there. The guide flew to Booty Bay, then to Grom'gol and
  back again. The arrow also goes straight from Booty Bay to the Bloodsail
  cove instead of out into the jungle first.
- Stranglethorn Vale (Horde, 30-40): after the flight into Grom'gol, the step says where Nimboya stands instead of
  "follow the road south to Grom'gol".
- Stranglethorn Vale (Horde, 30-40): the six "along the way" lists are gone; each
  of their goals is in the step that already does the work, and the Shadowmaw
  Panthers are no longer listed on the Savage Coast, where none live.
- Stranglethorn Vale (Horde, 39-43): Scaring Shaky is taken from "Sea Wolf" MacKinley on your first
  Booty Bay stop, with Stoley's Debt, instead of on the next one.
- Stranglethorn Vale (Horde, 39-43): the Aged Gorilla Sinew is gathered with Unbagwa's gorilla fangs in
  Mistvale Valley, not on the Wild Shore step, and the guide no longer opens with a stray vendor stop in
  Ratchet or a note about Tarren Mill that belonged to an earlier guide.
- Stranglethorn Vale & Swamp of Sorrows (Horde, 39-43): the way into the swamp
  no longer tells you to go north into Duskwood after the Duskwood stop, and
  Stonard is one stop: Dar's two quests, the flight path, Helgrum, the bind and
  Fel'zerul, without a second step that said you start there.
- Swamp of Sorrows (Horde, 39-43 and 45-47): the first visit is one pass.
  Galen's strongbox comes on the way back west and Magtoor at the Harborage
  last; there is no ride to Misty Reed Post for Lack of Surplus alone. Tok'Kar
  takes the crocolisk flanks on the second visit, which goes to Misty Reed Post
  anyway.
- Tanaris (Alliance, 45-47): Sprinkle's Secret Ingredient no longer comes with a note telling you to skip it; the
  route takes it, the ingredient is picked up in the Hinterlands and Sprinkle gets it on the next Gadgetzan stop.
- Tanaris & Searing Gorge (Horde, 47-48): the Noxious Lair comes before Tooga's escort, so the escort
  ends at Steamwheedle Port with its hand-in instead of a ride back west to the lair and east again, and
  the arrow points to Torta during the escort. In the Searing Gorge the taskmasters, slavers and golems are
  killed on the ride from Thorium Point down to Kalaran, where you cross them, and the lava spiders are a
  goal of the Cauldron step, instead of lists along the way; and two tips that still spoke of Kargath and of the
  next guide starting at Thorium Point are corrected.
- Teldrassil: Ferocitas' necklace and Tallonkai's Jewel are looted on the same
  visit to his camp as the Gnarlpine Mystics, and Tallonkai takes the jewel as
  you pass back through Dolanaar, instead of a second walk east to the camp and back
  after Lake Al'Ameth. The guide no longer ends with a boat to Stormwind
  before the Night Elf Darkshore guide.
- Teldrassil walks you back and forth less: The Balance of Nature's north kills,
  the Webwood Venom Sacs and Iverron are one trip from Aldrassil (no walk back to
  Conservator Ilthalaine in between); the Fel Cones are picked on the road east
  to Zenn instead of a trip of their own before the west loop; you train on the
  Dolanaar stop instead of coming back for it; Dolanaar's NPCs come in walking
  order; the Amethyst Phial is filled on your first visit to the Oracle Glade's
  moonwell; Warriors take Nessa Shadowsong's quest on their first walk into
  Darnassus; and the two "along the way" lists are normal steps.
- Teldrassil: Sentinel Shayla's fang bounty is handed in on the road west to
  the Oracle Glade, the Strange Fronded Plant is taken on the walk north to
  Lady Sathrah, and the last owl in Darnassus is placed on the walk south from
  the Cenarion Enclave, so the island's west side is no longer walked twice.
- Teldrassil: the west loop goes into Darnassus once, on the road past
  Sentinel Shayla Nightbreeze, for Rellian's Tumors, The Temple of the Moon,
  Tears of the Moon and Eyes of the Sentinels; the Gnarlpine fangs, the
  timberlings, Lady Sathrah and Mist are done on the loops you already walk,
  and Sathrah's Sacrifice and the owls finish on the last city visit.
- Teldrassil: the tip for handing Zenn's Bidding to Zenn now matches the walk (he is reached from Dolanaar, before Starbreeze Village and the lake).
- Theramore: The Black Shield goes on to Caz Twosprocket and back to Captain
  Vimes on the same Theramore stop.
- Thunder Bluff reputation: The Broodmother is taken from Muln Earthfury as
  Defending the Dead goes in, before Mazu'kon's and Yorn's hand-ins.
- Tirisfal Glades: characters already level 7 on the first pass through Brill take
  Carolai Anise's, Coleman Farthing's and Gretchen Dedmar's quests there, and at
  level 10 The Argent Emissary on the Brill stop after the north loop, handed to
  Hadric at Deathguard Linnea's camp right after; anyone below the level takes them
  on the next visit as before.
- Tirisfal Glades flows in one direction now: out of Deathknell you take
  Fields of Grief and Calvin's letter at the Solliden farmhouse, pick the
  pumpkins next to it and take Gordo's Task on the road; Brill is entered past
  Dillinger, Bartholomew, Holland and Eleanor's camp before the square, where
  Zygand and Johaan take everything you carry; Linnea's camp comes next, then
  one west loop that fights Calvin's duel on the way to the Crusader's
  Outpost, and the hides for Shelene are collected from the darkhounds, bats
  and murlocs those loops already kill. No step is an along-the-way list any
  more (thanks Fitz).
- Tirisfal Glades: Warriors take Ulag the Cleaver from Deathguard Dillinger
  when they hand him The Mills Overrun, instead of coming back to him.
- Sun Rock Retreat (Horde): Tammra Windfield comes before Braelyn Firehand
  and the flight master, so you no longer walk back across the town to her.
  (thanks Bonesavv77)
- Kodo Roundup (Desolace): the tip says to talk to each tamed kodo at
  Smeed's camp, which counts it and lets you tame the next, one at a time.
  (thanks Gray)
- Duskwood: the arrow looks for the Pygmy Venom Web Spiders on the Hushed
  Bank west of Raven Hill, where most of them are, and the tip no longer puts
  them east of the cemetery. (thanks jkhjkhjk778787)
- City of Dalaran pick-up guide: Heart of Disruption waits until level 30,
  after the quest that leads to it (Blood in the Streets for the Horde, An
  Alarming Request for the Alliance); Image of Archmage Modera doesn't offer
  it before that. (thanks JonnyDisco and rockzors)
- Troll Durotar no longer walks you from the Crossroads back to Razor Hill
  and then back to the Crossroads: Threat from Below is handed to Orgnil on
  the way from Margoz to Far Watch Post, as in the Orc guide, and the
  Crossroads quests are all taken on the stop you arrive at. Hunters are no
  longer sent to Ormak in Orgrimmar before they have his quest. The Durotar
  "along the way" lists are steps (Orc and Troll).
- Un'Goro Crater (Alliance, 40-50): the Lar'korwi glands and the wrecked raft are done right after Torwa, at the
  foot of the ramp, before the ride north to Marshal's Refuge, instead of a ride back south-east for them later.
- Un'Goro Crater (Alliance, 40-50): the pylon loop goes one way round, down the east side, the Gorishi hive, the
  south-west and the Western Pylon, then north to the refuge; in Ironforge, Tymor comes before Archesonus on the
  way round the city.
- Un'Goro Crater (Horde, 51-53): in the Undercity Harbinger Balthazad, beside the bat master, comes first,
  before Oran Snakewrithe; the pterrordax step is titled and explained for the pterrordax instead of the
  Gorishi hive; the Kargath stop and the Hunter and Shaman training trip no longer speak of the Grom'gol
  zeppelin (you arrive by the boat to Powderfuse Port); and the note calling Pawn Captures Queen an elite
  quest to skip is gone, since the guide takes it (the hive queen is a normal creature in Forever's data).
- Un'Goro Crater: Marin Noggenfogger's elixir is handed in on the Gadgetzan
  stop, straight after Delivery for Marin.
- A "Sell and repair" line no longer keeps you on a step once its hand-ins
  and other work are done: if you have nothing to sell, the guide moves on
  without a visit to the vendor. This also lets Redridge Mountains end at
  "Back to Lakeshire" as it should. A step that is only a vendor stop still
  waits until you open the vendor's window, or skip it.
- Westfall: at the Stormwind stop, the Nightcrawlers for Fishin' Time are bought with the Shiny Bauble in one stop, after Woo Ping, instead of two visits to Catherine Leland.
- Westfall's first loop from Sentinel Hill is one loop: the Molsen Farm
  fields (the Defias for the Militia, the Harvest Watchers, the livers, snouts
  and vulture meat), the north hills and coast, the Jansen Stead's oats and
  well, then every hand-in at Saldean's Farm at once on the way back to the
  hill. It no longer comes back to Saldean's in the middle for two hand-ins,
  and Dwarves, Gnomes, Night Elves and Skyborne fill the Jansen Stead's well
  vial with the oats instead of on a walk of its own. No along-the-way list.
- Westfall and the start guides: Humble Beginnings is taken from Baros
  Alexston on each race's walk through Stormwind (Humans on Thor's free flight
  from Sentinel Hill, with Continue to Stormwind, Dungar Longdrink and Return
  to Lewis), its compass is picked up at the Alexston Farmstead on the west
  loop, and it is handed in with Elmore's Task (from Smith Argus in Goldshire)
  on the Stormwind visit before the boat, where Borgus Steelhand gives
  Business in Auberdine for his brother. Night Elves also take Philmor's Favor
  and Gatehouse Goods between the harbour and the flight master.
- Wetlands: Einar Stonegrip's Daily Delivery is taken on the road between
  Howin Kindfeather and Rethiel and handed to James Halloran on the next
  Menethil stop.
- Wetlands: Daily Delivery is handed to James Halloran after Captain
  Stoutfist's last quest, on the way to the boat, instead of between two of
  Stoutfist's.
- Alliance Wetlands: the guide no longer asks for quests the givers don't
  offer yet. Rethiel the Greenwarden's Carnage now comes after Fen Creeper.
  Prospector Whelgar's Gleaning Our Future comes after Understanding Our
  Present, and For Further Study after Gleaning Our Future, on the Dun Modr
  visit. Sara Balloo's Plea comes after Sully Balloo's Letter.
- These quests are now left out, because their givers won't offer them on
  the route: Tharil'zun and Shadow Magic (Redridge); Martek the Exiled and
  its sequels (Thousand Needles, both factions; Indurium in the Badlands;
  News for Fizzle, Keeping Pace and Rizzle's Schematics at the Mirage
  Raceway); and Greater Friend of the Library (Stormwind; it stays in the
  Library Books guide). Kurzen's Mystery (Stranglethorn) is now taken once
  Bad Medicine and The Second Rebellion are handed in.
- Wetlands & Hillsbrad: the Thandol Span chain goes on past Rustlocke's
  corpse: his parchment goes back to Rhag Garmason in Dun Modr, the Dark Iron
  cache is destroyed at the span's Arathi end beside Foggy MacKreel, and
  Rhag's Plea to the Alliance is handed to Captain Nials at Refuge Pointe.
- Dynamic Questing's suggestions have their own small "While you're here"
  panel under the step, in your accent colour, dulled so the text stays easy
  to read: each suggestion is written like the step's own goals ("Kill
  Kobold Vermin 8/10", the target in its colour) with its step under it, and
  its own distance and close button on the right. Long suggestions wrap onto
  a second line instead of being cut off.
- Dynamic Questing: when you pass through the area of a later step's
  objective whose quest is already in your log, a "While you're here" panel
  slides in under the current step with that objective, for example "Kill
  Kobold Vermin 3/15, step 14, 45 yd". Any later step of the guide counts,
  also one after the guide has taken you to another zone and back, and it
  goes by where you
  are, not where the arrow points: chasing slow drops past another step's
  objective catches it. Up to three show at once, the one you can only do
  around here (a pool, a camp) before mobs found all over the zone. A mob it
  needs that you can see (its nameplate, your target) counts too, wherever
  its usual spawns are. A suggestion stays while you are near its mobs, however
  long. Grab it now and
  that step is done or shorter when you get there. Click a suggestion to point
  the arrow there; right-click it (or its close button) and it stays away
  until you have left the area and a couple of minutes have passed, then
  comes back when you are near again; dismissed twice it stays away for the rest of the
  zone. Walk away and it goes, and comes back when you meet
  its mobs again. A soft chime plays and its mark on the minimap
  pulses so you know to look (at the minimap's edge when it is further
  out), and the quest item button offers its item when the step has none.
  A quest ready to hand in to someone standing right there shows the same
  way. With the guide window hidden, one small toast says it. Never in
  dungeons, on flights or boats, or during timed and escort quests.
  Options, Guide, Window, "Dynamic Questing" turns it off, sets how close
  (60 to 400 yards, 180 by default), the hand-ins and the sound. A bug
  report says what the panel shows, or why it shows nothing.
- Winterspring (Alliance): all four Kel'Theril relic fragments are picked up on the first pass by the lake. In the
  Eastern Plaguelands, Defenders of Darrowshire goes to Carlin Redpath on the last Light's Hope stop with the
  Scourgestones, without a ride back to the chapel in between.
- Winterspring (Alliance, 53-56): after the top-up to 55 the guide no longer suggests the Sunken Temple or more yetis
  to reach level 54.
- Winterspring (Alliance): Speak to Salfa is handed in where Timbermaw Hold's tunnel comes out, and the Winterfall
  camp's furbolgs for Threat of the Winterfall are a step by the hot springs instead of a list.
- Winterspring (Horde, 55-56): Morrowgrain Research and Morrowgrain to Thunder Bluff are optional at
  Bashana Runetotem: they want ten Morrowgrain, which the Evergreen Pouch grows one slow try at a time,
  and the guide had you accept, finish and hand them in on the spot. The Raging Owlbeasts' tip no longer
  sends you west when you ride east, the Den Watchers and owlbeasts are no longer listed along the way,
  and Bashana's step loses a warning about Gorishi silithids that belonged in Un'Goro.
- Winterspring (Horde): Speak to Salfa is handed in where Timbermaw Hold's tunnel comes out, and
  Winterfall Activity taken there, instead of on a ride back west from Everlook.
- Western Plaguelands (Alliance): the Temporal Parasites are drawn out on the Andorhal visit for the Annals of
  Darrowshire, instead of a second trip to Andorhal later.
- Western Plaguelands (Alliance): A Gnome's Assistance goes to J.D. Collie on the first Marshal's Refuge stop,
  beside Linken, and the Scarlet Knights, Carrion Grubs and Super Sticky tar are in the steps that do them.
- Felwood & Western Plaguelands (Horde, 53-55): coming in from Tarren Mill, Auntie Marlene is handed in at
  Sorrow Hill before the ride north to Mulgris at the Writhing Haunt (the order went to Mulgris and back
  south); Kirsta's Scarlets are no longer a list along the way; and the Bloodvenom Post flight path is
  learned at the Bloodvenom Post stop, not in the step for the optional Blood Red Key.
- Zephras Isle (Alliance): after the Ursera den, Aetheen and Valreaa take their hand-ins first and Hanaa Nightwind comes on the way south to Shen'dar, instead of a walk back north to the grove.
- Zephras Isle walks you back and forth less. Both factions: Fendaal
  Windstone's Al'Aketh Assassins are done where the road to Valanaar passes
  him, not on a later trip back. Alliance: Taleen's A Little Beauty and
  Ealaane's two quests are taken on your first visit to Shen'dar and
  Valanaar, a Druid hands The Great Ursera Spirit to Urs'endris on the
  watchtower trip, and the last Valanaar stop starts where the portal sets you
  down. Horde: you sit by Raan's campfire when you first reach Shen'dar
  instead of walking back from the hippogryph nests, Aamelia's farm is finished
  before the trip north for the construct parts, and the Windsong Lake quests
  are one sweep. The four "along the way" lists are normal steps.
- Zephras Isle (Horde): Valreaa's and Aetheen's hand-ins in Thendal Village
  come before Hanaa Nightwind, whose camp is on the road south to Shen'dar,
  so you no longer walk back north to the village after her.

### For guide authors

- New step line `background`, on an `along until <label>` step: its goals are
  slow, zone-wide collections worked over the whole stay. Each quest
  objective in it needs a finish step before the step that hands its quest
  in, and the lint says so if it is missing. See docs/GUIDE_FORMAT.md,
  "Background goals".
- `polestar playtest --honest` no longer crashes on a `when complete`,
  `when turnedin`, `when available` or `when group` line, and it opens a held
  container for the items in it (A Small Pack's compass, map and key in
  Un'Goro) instead of reporting them as having no source.
- Lint: a flight to a stop where nothing is left to do, followed straight
  away by another flight, is reported (an error in Polestar's own guides);
  fly to the second flight's end instead.
- A `vendor` goal beside other goals of its step no longer holds the step:
  the step is done once those are, with or without the merchant window. It
  is still listed while the step is live, the arrow still leads to it in
  its turn, and opening the merchant still ticks it. A step whose only
  goals are `vendor` waits for the merchant window as before. The playtest
  and the guide-end check play such a vendor the same way (they leave it
  alone).

### For contributors

- `forge data check-corrections` no longer reports a `remove: true` quest
  correction as "no quest in the data": the build itself takes that quest
  out, so its absence is the record working. A correction that sets fields
  on a missing quest, or links to a removed one, is still an error.
- CI no longer downloads the client tables from wago.tools on every run: a
  weekly workflow caches them, the texture and data-corrections checks read
  the cache offline, and the texture check runs only when a generator or its
  inputs change. `polestar media --offline` reads the cached tables only, and
  a wago.tools 429 or 5xx is retried before it fails a download.
- The Discord bug bot takes 5 reports an hour from each player (was 3), and a
  report held past that now gets a reply in its thread saying when it will be
  filed; the reply turns into the issue link once it is.
- The Discord bug bot no longer holds server staff (administrators and
  moderators, by their roles) to the hourly report and follow-up limits;
  `RATE_EXEMPT_IDS` exempts more users. A player's report or follow-up past
  the limit is filed once the hour allows instead of at the bot's next start.
- Recording server: a single teleport the game makes (the spirit healer
  after a release, the Rut'theran portal, a quest teleport) and kills other
  players had tagged no longer mark a recording as suspect, so these sessions
  reach the data. Movement faster than 100 yards a second twice in a row, or
  more than twice in five minutes, is still flagged. Recordings held back by
  the old checks are checked again when the server starts.
- `tools/lib/route/prereq-order.js` plays every leveling path (each start and
  each `next` option) as every race and class it is for, with group quests
  both answered and skipped, and reports an accept whose blocking
  prerequisites that path hasn't handed in yet. Lint's check counts a hand-in
  on any branch into a guide. `tests/guides-reported.test.js` runs it over
  all guides, so a guide that takes a quest before its chain fails the tests.

### Forge

- A `background` record in data/guide-fixes.json makes a slow, zone-wide
  collection a goal of the whole stay: the writer lists the objective on the
  way from the quest's accept to the step that hands it in, puts a finish
  step at the record's point right before it (`when !has <item> x<count>`
  for an item), and adds the record's mention to the steps between that pass
  the dropping mobs. `forge data check-corrections` checks the record.
- Forge now writes three of 0.3.4's hand edits itself. A v1 goto 200 yd or
  more from the kill or collect after it is dropped (the Barrens' Zhevra,
  Feralas' forest walkers). A repeatable quest its giver takes back on the
  spot becomes a `direct` turn-in (The Tome of Divinity). The seed points
  Eastern Plaguelands' Corin's Crossing step at the town.
- Players' recordings never override our corrections: the data build puts
  every corrected value back after the recordings overlay, lists each value
  the recordings disagreed with in its warnings, and the knowledge base ranks
  corrections above recordings. A correction's value is now copied into the
  record, so a later stage can no longer edit the correction itself.
- `forge record resession` re-reads every archived upload into the session
  files, so record kinds an older forge skipped (refusals, group size, spawns,
  gathering, failed quests) come back without a new pull.
- The recordings folder's `config.json` takes an `exclude` list of
  contributors the maintainer's audit rejected: their sessions never count and
  never make their cohort count.

## 0.3.4 (2026-11-06)

### For players

- Ashenvale: Va'xug Firefure's A Void Path is taken once Never Coming Back is
  handed in to him, on the same visit, instead of together with it, when he
  doesn't offer it yet (thanks soockee and jiskim, and CDVolvik for the same
  fix in the quest data).
- Druid Cat Form: the arrow for the Great Cat Spirit's quests leads to where it
  stands, on the hill by the bridge in southern Moonglade, instead of a spot
  about 90 yards east of it (Cat Form guide, Darkshore and The Barrens)
  (thanks Snowiee, #1003).
- Ratchet, the Crossroads, Sun Rock Retreat and Tarren Mill: the guide binds
  your hearthstone at the inn after the givers beside the ones you just
  visited (Mebok Mizzyrix's Raptor Horns by the WANTED poster, Mankrik,
  Maggran Earthbinder, Apothecary Lydon), instead of sending you up to the inn
  and back to them (thanks Bill).
- Dungeons: "Pick up the quests" follows your own faction for every quest and
  giver, whatever the page's Horde / Alliance / All switch shows. Blackfathom
  Deeps no longer sends Horde characters to Darnassus for the Alliance's In
  Search of Thaelrid (thanks jiskim, #1026).
- When a level-up, or a quest you hand in, opens a dungeon's quests to you, a
  card on the guide window says so, once per dungeon ("Wailing Caverns is open
  to you: 3 quests to pick up"). Pick up the quests opens a guide for them in
  a new tab, and Open in Dungeons shows the dungeon's page. Turn it off on the
  card or under Options > Discovery > Dungeons (thanks mcclaskiem, #836).
- Arrow: from Rut'theran Village to the top of Teldrassil, the route takes the
  portal up to Darnassus and walks on from there. It no longer draws a walk
  straight up the tree, or sends you back down the portal once you're in
  Darnassus, round and round (thanks Dante).
- The Deadmines pick-up guide sends you for Murloc Gills before Moonbrook
  Espionage: Alba Fairmoon offers Moonbrook Espionage only once both Murloc
  Gills and The State of the Mines are handed in (thanks Slugstur, #991).
- Nameplate icons: a new setting, Options > Questing > Quests > Nameplate icon
  position, moves the quest skull and your progress (3/10) from the left of
  the health bar to its right or above the name, so another addon's quest
  icon no longer covers them (thanks VenoMan).
- The "You've reached the end" window no longer opens in the middle of a
  guide when you talk to a quest giver before handing in the quest that
  unlocks their next one (Regthar Deathgate and Kolkar Leaders in The
  Barrens, with 46 steps still to go). A guide's last step now ends the
  guide early only when you have really done it, not when its quest is just
  out of reach for the moment. A class or race quest done elsewhere no
  longer ends a leveling guide either: Cat Form, the last step of The
  Barrens (19-23) for Druids, done early in its class guide used to end
  The Barrens halfway. (thanks MrM00se)
- The Codex behind Lookup, Nearby services and the Dungeons pages is rebuilt
  only from sources we're allowed to ship (the game client, Questie's quest
  data, our recordings and public facts) and catches up with this month's
  fixes: Nearby services now finds food and drink, arrow, bullet, bow and gun
  and general goods vendors, pick-up guides follow quest chains such as The
  Wrath of Rath'mael's (thanks lif3l3ss and boldarblood37), dungeon pages
  show each quest's XP, Onyxia's attunement can be guided, lookups leave out
  stray spawns, and your own race's vendor mounts no longer ask for Exalted.
  The Forever-only racial mounts (the Reins of the Striped Dawnsaber, the
  White Kodo, the Black Skeletal Horse) now name their vendor.
- Quest data: The State of the Mines (Deadmines) now needs both Testing the
  Wells and Murloc Gills, and the Moonsilver Blade quests before Old Fire-Eye
  (Shadowfang Keep) are listed in their order, as players' recordings show.
- The guide window's look-ahead lines ("Then out here: …", "Then: Gakin the
  Darkbinder · Turn in The Binding"), Along the way and Up next wrap onto a
  second line instead of cutting names off with "…". Opened, a look-ahead
  line names only the place or the person, since its goals are listed right
  under it (thanks to a player on Discord).
- Party play works on Forever: Polestar now recognises party members by
  their full first and last name, so party sync, the party line and the
  party panel see each other. In a group with someone else running
  Polestar, nothing needs turning on: sync starts by itself and the party
  panel opens the first time their Polestar is heard (close it and it stays
  closed; `/polestar party` brings it back and says why when nothing can
  show yet). The Characters page keeps two characters with the same first
  name apart, and the Recorder leaves out your last name too. (thanks
  uNBEx)
- With Waypoint UI installed and Options > Navigation > Blizzard waypoint on,
  its marker in the world now follows the guide by name: a turn-in, or a quest
  objective at one spot, tracks the quest itself (Waypoint UI's own quest
  marker); any other goal, a kill or collect among spawns included, is a pin
  named after the step ("Talk to Executor Arren") at Polestar's spot instead of
  "Map Pin". Polestar only clears the pin or tracked quest it set, never one
  you chose. Without Waypoint UI nothing changes.

### Forge

- `forge release pack` warns when `Polestar_Codex` was built from another
  reference data build than `data/forever`: the pick-up guides' quest chains
  read the Codex, so a prerequisite fixed since (The Wrath of Rath'mael after
  the Rear Guard Patrol chain) reaches players only with a rebuilt Codex
  (thanks lif3l3ss and boldarblood37).
- `forge data codex` no longer reads ForeverLevelingBiS or any installed addon
  for a release build. It reads the item sources players' recordings show
  from the committed snapshot `data/codex/recorded.json` (only players the
  data build counts; `--recordings <dir>` rewrites it from a recordings
  folder), and a collectible guide's `buy` step names the item's vendor.
  `forge release pack` refuses a Codex that still names ForeverLevelingBiS.

## 0.3.3 (2026-11-06)

### For players

- Westfall: if a Harvest Watcher or Golem dropped you the Precessive
  Autocognition Assembly, the Saldean's Farm step waits again until you hand
  Harvesting the Harvesters to Ozwin Ironsprocket, instead of moving on
  without it; without the Assembly it still does not wait (thanks Smuve, #298).
- Horde Stranglethorn Vale: the tip for the last trophy skulls says they are
  a short walk west, not a short ride, since you get there before riding at
  level 40 (thanks Pynte, #404).
- Without a known flight path, the route from Tarren Mill to Brill no longer
  walks through Alterac Mountains and Western Plaguelands: every stretch of a
  long walk now counts the zones far above your level it passes, not only the
  ones in its middle (thanks dogoku, #566).
- On top of Teldrassil, the route to Darnassus walks in through its gate
  instead of down to Rut'theran Village for the portal back up: when no walk
  reaches a portal's entrance, the route leaves that portal out (thanks
  EpicTibbles for the report and Patrick for the fix, #568).
- With Grow upward, the guide window stops at the top of the screen instead
  of moving down when a long step doesn't fit above it, so its bottom edge
  (and the bar, with Bar at the bottom) stays where you put it; the step's
  goals scroll, as they do past the maximum height, until there is room
  again (thanks thmastin and Deadshot0330, #666).
- Westfall: at Sentinel Hill the guide again takes the quests at the top of
  the tower before Thor's flight path at the foot of the hill, instead of
  sending you down for the flight path first and back up (thanks TP1186, #727).
- Gear advice no longer calls a better weapon a downgrade for an Orc Hunter
  because the old one is an axe: Axe Specialization (and the Human and Dwarf
  weapon racials) now count for Hunters and casters only as much as they fight
  in melee (thanks jtac, #833).
- Dungeon pages show the XP from Polestar's own quest database: about 50 quests,
  in dungeons like Ragefire Chasm and the Ruins of Lordaeron, showed less than it
  says, and their level and chain totals came out low too (thanks mcclaskiem,
  #837).
- Zephras Isle no longer sends you to Dondallion Whisperwind to hand in The
  Missing Scholar: Fillion Flamebreeze, who stands beside him, takes it
  (thanks Visur, #848).
- The Ruins of Lordaeron pick-up guide no longer sends you to Deathguard
  Kristof for The Wrath of Rath'mael before he offers it: it takes you to
  Deathguard Linnea for the Rear Guard Patrol chain first (thanks Pilk, #849).
- An NPC's or object's lookup no longer sends you to a spot it was seen at only
  once or twice, far from where it usually is: a group of two spots or fewer is
  left out when the main group is at least four times bigger (vendors and other
  services, and mailboxes, still show every spot). Riptear in Tirisfal Glades
  now leads to the north-east, where he roams (thanks Pilk, #852).
- Before handing in a quest whose work along the way is still open (Legging
  It, The Battleboars and many more), the arrow now leads to that work instead
  of the quest giver, and the turn-in says its objectives are still open
  (thanks Bill, #853, and striderZA, #862).
- The walk to an NPC only Forever has now ends on that NPC's floor in stacked
  places like the Undercity: Tanis Alderwood's turn-in in Tyr's Watch leads
  down to the Trade Quarter, not up the lift to the ruins (thanks Engholm, #855).
- Quests where you talk to people, like Desperate Times on Zephras Isle, now
  say "Talk to" and move on when you do; steps no longer ask for kills the
  quest doesn't count (The Cult of the Damned's Darkhounds) (thanks Visur,
  #859).
- Ruins of Lordaeron pick-up guide: The New Plague is taken from Theodore
  Griffs once the A Recipe For Death chain is handed in, not before, when he
  does not offer it yet (thanks Pilk, #867).
- No more "action blocked" error from the quest item button during a fight:
  the button now skips its range check on an enemy target while you are in
  combat (thanks for the report, #871).
- Silverpine Forest: Watching the Roads is taken from Shadow Priest Allister
  once you hand him Dalaran's Intentions, not on the first Sepulcher visit,
  when he does not offer it yet (thanks DexeeXI, #872).
- Curing the Sick and Are We There, Yeti?: the goal now says to use the
  Curative Animal Salve on the deer or gazelles, and Umi's Mechanical Yeti
  beside Legacki, Sprinkle and Quixxil, instead of "Kill" (thanks Bennistrov)
- Tyr's Watch and Redemption (Forsaken paladins): the last step now says
  Danitha Morr is back upstairs in Bandarion Keep, after Deathguard Billmuth
  downstairs (thanks SUBDUBBUB, #874).
- Filling a phial, flask or waterskin now moves the guide on by itself: the
  Crystal Phial at the Teldrassil moonwell and about forty steps like it (the
  Druid, Mage and Shaman water quests and the Shaman saptas among them) no
  longer wait for you to tick the use off (thanks Phear, #875).
- Silverpine Forest: the Orgrimmar stop takes Whuut's the Rush from Yelmak
  after Yelmak's Medley is handed in to Kor'geld, when Yelmak offers it, not
  straight after taking the Medley (thanks DexeeXI, #891).
- Wetlands and Stormwind: Crocs of the Sky is taken from James Halloran when
  you hand him Apprentice's Duties, and The Shamed Lieutenant from Lord
  Grayson Shadowbreaker once you hand him A Friend of the Family, not before
  they offer them.
- The Barrens: Northwatch Hold's captain, cannoneers and medals come first,
  then you free Gilthares Firebough, whose escort walks straight back to
  Ratchet, instead of taking the escort along through the hold (thanks
  DexeeXI, #907).
- Night Elf Druids in Darkshore train in Stormwind as they get off the boat,
  instead of walking to Goldshire, back to Stormwind and back again. The same
  rule sends Horde Paladins heading to Orgrimmar from Felwood to their trainer
  in Brill before the zeppelin (thanks Snowiee, #912).
- A goal inside a cave that you aim at before reaching the guide's way in
  (Frosthowl in the Grizzled Den) now leads you along the walking path to
  it, instead of pointing straight at it from the hill above (thanks
  joshvette001, #914).
- A dungeon's "pick up the quests" guide lists a long quest chain from its
  first quest: the Deadmines guide starts Alba Fairmoon's chain at Testing
  the Wells, before The State of the Mines (thanks rockzors, #918).
- Darkshore and Ashenvale: The Sleeper Has Awakened is taken from Kerlonian
  Evershade on the way south to Ashenvale, right before his chest and the
  escort to Maestra's Post, instead of hours earlier on the Darkshore visit,
  so the 25-minute Horn of Awakening is still there for the escort (thanks
  Fyurie, #920).
- Darkshore: the "Level 20" grind leads to the Elder Darkshore Threshers on
  the northern coast, not to the lower Darkshore Threshers by Auberdine. A
  grind's arrow now always goes to the mob the step names (thanks lax, #924).
- A follow-up is taken from the NPC you just handed its quest to again, before
  the guide sends you to anyone else: Captain Vimes from the Theramore
  Lieutenant before the walk up to Lady Jaina (Stranglethorn Vale), The Atal'ai
  Exile from Fel'zerul before Dar (Feralas, Horde), Letter to Jin'Zil from
  Darsok before the Tauren Druids' and Warlocks' hand-ins at the Crossroads
  (The Barrens), and the class letters from Rorian before Falorne and Elatrell
  (Zephras Isle, Alliance) (thanks Zepheriel, #310).
- Darkshore: the Auberdine step now says Wizbang Cranktoggle (Buzzbox 827)
  stands upstairs in the inn; the arrow alone stopped on the ground floor
  below him.
- Bags: items in the reagent bag slot are no longer skipped. Junk you marked
  there can be the bag button's cheapest junk and is sold at a vendor, and the
  warning before selling a quest item covers that bag too. Its free slots
  still don't count toward your free bag space, since it holds only reagents
  (thanks Tazul, #946).
- The Barrens: Warlocks are no longer sent from Regthar Deathgate into
  Stonetalon Mountains and straight back with nothing to do there. Your
  quests with Ken'zigla in Malaka'jin come later in the guide, as before
  (thanks Rohkin, #947).
- Rogue (Certificate of Thievery): the guide ends when Lucius takes the token
  back. Horns of Nez'ra is not in the game on Forever (Arantir never offers it),
  so the guide no longer sends you to Arantir for it, and the quest is gone
  from Polestar's quest data (thanks Erá, #948).
- Steps that only said to finish a quest now show its objectives when they are
  plain ones: the Venture Co. workers and supervisors in Mulgore,
  Fizsprocket's clipboard, the Crystal Pylons in Un'Goro, the Eggs of Onyxia,
  Salfa's beads, Mankrik's wife, the Zephras Isle talks, and the Symbol of
  Life on Henze and Narm Faulk and the meat for Kyle. The guide window gives
  each one its target, where it is and its progress from your quest log.
- The Barrens: Mankrik's Bristleback tusks are collected while you kill the
  Bristlebacks for Mangletooth's Tribes at War, not in the same camps before
  you reach Camp Taurajo. Mankrik's wife is still found on the walk south
  (thanks Rohkin, #957).
- Quest givers on an upper floor: the steps now say to go up for Dendrite
  Starblaze in Nighthaven, Beetix and Noggle Ficklespragg at Cenarion Hold,
  Ginro Hearthkindle at Feathermoon, Daryn Lightwind in Rut'theran Village,
  Gaerolas Talvethren in Starbreeze Village, Priestess Josetta and Zaldimar
  Wefhellt in Goldshire's inn, Khelden Bremen in Northshire Abbey, Neeka
  Bloodscar in Kargath, Primal Torntusk in Revantusk Village, and the steps
  at Captain Stoutfist, Gazlowe and "Sea Wolf" MacKinley that did not say so
  yet. The arrow alone stopped on the floor below them.
- Class trainers upstairs: the training steps in Northshire (#961: Mages were
  led outside the Abbey instead of up to Khelden Bremen), Goldshire's inn
  (priest, mage and rogue trainers), Brill's inn (mage, priest, warlock and
  rogue trainers) and Aldrassil (every trainer is up the tree's ramp) now say
  to go up.
- Leveling guides: the guides no longer have "Hearth to ..." steps. The arrow
  tells you when hearthing is the quicker way to the next stop, so you can
  hearth or walk, and the guide just takes you to the next stop. Guides still
  tell you where to set your Hearthstone (thanks Fitz).
- Badlands: the Rock Elemental Shards for the Badlands Reagent Run are
  collected at Agmond's End with Lotwil's rock elementals, not at Hammertoe's
  Digsite, where no rock elementals live.
- Stranglethorn Vale (Horde): the Bloody Bone Necklaces are finished at the
  Ruins of Zul'Kunda, after the ears and shrunken heads that send you back
  to the same Bloodscalp trolls, instead of all 25 at Nesingwary's camp
  (the same pattern as Rohkin's #957).
- Travel tips no longer send you on flights you can't take where you stand.
  Seventeen tips from older versions of the routes named a flight path you
  hadn't learned yet (Ratchet in Ratchet's and Un'Goro's Alliance steps,
  Talonbranch Glade, Zoram'gar Outpost, the Undercity and Tarren Mill,
  Stormwind for Humans in Westfall) or a flight from a town you weren't in
  (Thunder Bluff, Valormok, Shadowprey, Cenarion Hold). Each now says how the
  guide really gets you there.
- Guides no longer send you into areas far above your level. Redridge Mountains
  leaves out Galardell Valley: Lieutenant Fangore (level 26), Solomon's Law and
  the Old Lion Statue among the 22-26 gnolls, and Bellygrub (24), all at about
  level 21 (thanks Fyurie on Discord, #977). The Mirage Raceway in Thousand
  Needles (Alliance) and from Ashenvale (Horde) leaves out the Gazers, the
  tortoise shells and the vulture bones (32-35 at 30), Feralas leaves out
  Wandering Shay among the level 49 harpies, and the Eastern Plaguelands trip
  of the Horde's Un'Goro Crater guide leaves out the optional Invader's
  Scourgestones (57 at 52). Elwynn's Croaky's Head (a level 11 elite) is asked
  for only when you group for it, and the Rogues' Venture Co. tower shows from
  level 23.
- Cure Poison (Druid): Alliance Skyborne take Lessons Anew from Mathrengyl
  Bearwalker in Darnassus (Teleport: Moonglade, then the druids' flight to
  Rut'theran Village), not from Alfina Nightgaze west of Dalaran, who doesn't
  offer it and was a dangerous walk through Alterac at level 14 (thanks Nikil
  Kuruvilla, #978).
- Along the way lists only what the walk really passes. A list opens where its
  mobs are, not as soon as the quest is taken, and one whose walk mostly misses
  them is an ordinary goal at the stop with most of them near, its note saying
  where: Darkshore's Fine Crab Chunks are collected at Cliffspring Falls among
  the crabs instead of being listed from Auberdine for ten stops; 35 lists in
  29 leveling guides change this way (thanks Fitz).
- The quest automation toggles, "Accept guide quests" and "Turn in guide
  quests", are now under Options → Quality of Life → Quests and Options →
  Questing → Quests (one setting, shown in both), next to the other questing
  helpers. Hold Shift still skips them once.
- The guide window reads one person at a time: the person to talk to now shows
  in full, every other person of the step is one line ("Then: Rejold
  Barleybrew · 1 hand-in, 2 quests"; a click lists their goals), and big hubs
  show three of them and "+ N more people". Finished goals fold away into a "✓
  3 done" line instead of piling up, and the window stops at half the screen
  and scrolls past that (Options > Guide > Window: "Maximum height", and "Show
  the whole step" for the full list). "Along the way" no longer repeats goals
  the step already lists (thanks Phear for the report, and Totowora, whose
  pull request for hiding finished goals, #903, helped shape the fold).
- The class-quest card's "New weapon" or "New ability" badge no longer crowds
  the quest's name: the name starts below it.
- The class-quest card no longer shows for an ability you already know, and
  its tick box works.
- The class-quest card only shows for quests that really are for your class.
  Stalk With The Earthmother is now a Miscellaneous guide for Tauren of every
  class, and the library book Magma or Lava? is for every class.
- A class-quest card's route (Ironforge › Stormwind City › Loch Modan) no
  longer shows boxes between the places: the game's font has no arrow, so
  the card uses a chevron.
- Enable "Click objectives to target" in Questing options under Buttons
  to target an objective's NPC when clicking its row outside combat.
  It uses the existing "Mark what they target" toggle and mob/NPC icons.
  This is off by default; normal arrow navigation and completion controls
  keep working.
  A failed search shows which NPC was not found nearby (thanks codyharris91).
- Polestar Client: What we send has an Already sent tab, so you can look back
  at exactly what the last 8 days' uploads held as well as what's about to go.
- Polestar Client: the window can be made larger, so a tiling window manager
  (Hyprland, Sway, i3) can tile it. It opens at its usual size (smaller only on
  a screen too small for it), can't be made smaller than that, and does not
  maximize (#902, thanks petllama).
- Polestar Client no longer says World of Warcraft is running when only an
  addon manager such as WowUp is open.
- Human priests are no longer sent to Priestess Josetta in Goldshire for
  Desperate Prayer, which she doesn't offer them in Forever, or to Stormwind
  to hand it in. They still take Divine Grace from her (thanks Dingus, #844).
- Dun Morogh (Dwarf): in the Thunderbrew Distillery you train last again,
  after Ragnar, Tannok and Maxan, since some classes' trainers stand
  outside (thanks thmastin).
- Dungeon pages colour quest rewards the way the game's tooltip does: Axe of
  Orgrimmar and others showed green while the game says blue (thanks
  mcclaskiem).
- Stranglethorn Vale and Badlands: Gnome Warlocks learn Ratchet's flight path
  at the boat to Booty Bay, so their Felsteed trip at 44 flies from Theramore
  to Ratchet instead of walking there. Found while checking every guide for
  flight paths passed by and needed later, after TP1186's Sentinel Hill report
  (#727).
- Silverpine Forest: Tauren and Skyborne Druids learn Orgrimmar's flight path
  when they step off the zeppelin and fly from there to Thunder Bluff for
  their training and back, instead of walking to Ratchet's flight master and
  back.
- Stranglethorn Vale: Gnomes, Night Elves and Skyborne take the boat from
  Ratchet to Booty Bay before the guide asks for the flight to Darkshire.
- The Barrens, Stonetalon Mountains and Ashenvale (Horde): class training
  steps no longer ask you to fly to Orgrimmar or Thunder Bluff while you are
  already standing there, and Druids no longer train twice in one Thunder
  Bluff visit. Found while checking every guide's flights.
- Group play, only with party members who also run Polestar: on joining a
  party Polestar says a small hidden hello, and syncs with whoever answers;
  friends without Polestar see and get nothing more. Party sync is now on by
  default (turn it off under Options > Questing > Quests > Group), and the
  first Polestar member found says so once: if you had it off before, this
  update turns it on once, since up to v0.3.2 that choice wasn't stored;
  from now on, turned off, it stays off. When you finish an objective such a
  member on the same quest still needs, the step and its turn-in wait for
  them ("Waiting on Ana: 3/8 Boar Ribs", then "Everyone's ready") and the
  arrow leads to what they still need; a member in another zone or offline
  for over 2 minutes doesn't hold you, and "Go on without them" moves on. A
  Share button on a quest you have that they lack, with the reason when they
  can't take it; a party panel (click the party line or /polestar party)
  with each one's level, step and what they still need; and "Ana still needs
  2" on collect goals and on loot they need and you don't.
- Guide tabs are easier to close: the close button on each tab of the guide
  window shows faintly instead of hiding until you point at it, and the cards
  under Continue on the guide menu's Home have their own close button (and a
  right-click menu to close or move the tab; Y with a gamepad). Continue now
  shows one row of cards, your current tab first, then the ones you used
  last, with "Show all" for the rest (thanks to a player's question on
  Discord).
- Hearthing is no longer a step of its own. A step that only says to hearth is
  passed over and no longer numbered, and the arrow's travel line suggests the
  Hearthstone for any target when it is clearly worth its cooldown: the trip
  without it takes at least 8 minutes and hearthing saves at least 5. The line
  says what it saves ("Hearth to Sentinel Hill: saves 6 min"), and the button
  under the arrow casts it. A 2-minute walk to the inn keeps your Hearthstone
  (thanks Fitz, from his in-game note on Westfall's "Hearth to Sentinel Hill").
- Hiding the guide now also hides the action buttons (quest item,
  Hearthstone, travel, target, rare and bag) and the rare and transport
  alerts, and showing it brings them back. The arrow stays unless you turn on
  "Hide the arrow with the guide" (Options, Guide, Arrow & routes), and the
  arrow back to your corpse or a Spirit Healer always shows (thanks rohkin).
- The "Looking ahead" and "Looking back" banner closes with its Dismiss
  button again; it stays closed on that step, and another step shows its own.
- Dungeons: "Guide me through it" builds the Alliance Onyxia attunement
  (Drakefire Amulet) again, and Lookup shows the racial mounts (sabers, rams,
  horses, wolves and the rest) as sold by their vendor, no longer as needing
  the other races' Exalted (#785).
- Polestar's marks on the minimap no longer hide your own arrow: a mark over
  it fades so the arrow shows through, and comes back in full once you walk
  off it. Appearance › Arrow › Map icons has a new Minimap icon size setting
  for smaller (or bigger) minimap marks (thanks Fitz).
- Mulgore starts with Grull Hawkwind, who stands beside you at Camp
  Narache, before Chief Hawkwind in the big tent, as it did before 0.3.0.
- Nearby services: the vendor page finds the nearest general goods vendor
  (`/polestar near general`, or `goods`). Thanks Yendi.
- Nearby services: Vendor opens a page to find the nearest vendor of food and
  drink, arrows, bullets, or bows and guns (the ammunition and weapons only
  for classes that use them), and the arrow names the vendor's trade ("Keina
  (Bowyer)"). Profession trainers the data listed as vendors, such as Fanorran
  Stilloak at the Night Elf start, are no longer offered as vendors. Thanks
  Yendi.
- Nearby services: Mailbox points the arrow at the nearest mailbox of your
  side (`/polestar near mailbox`, or `mail`). Thanks Yendi.
- A step no longer lists the same mob or item twice: Brewnall Village in Dun
  Morogh had the boars and leopards once as "on the way" and once more below,
  Elwynn's river step had the Prowlers and bears up to three times, and
  Andorhal's silos step had the Temporal Displacer three times. Each is one
  line now (#843, thanks Phear).
- Open Sans can now be chosen as the font, with any look, under Look > Colour
  & type (thanks RikyZ90, #923). The default stays the game's font.
- In a party, Polestar tells the group in party chat when you finish one of a
  quest's objectives ("[Polestar] Finished: Plagued Hide 5/5 - [Plagued
  Lands]") and when the quest is ready to turn in, with the quest's link, so
  friends see your progress whatever addon they run. Never solo or in a raid,
  nothing for what was already done when you log in, reload or join, and never
  the same line twice. It is on by default; the first line says once where to
  turn it off (Options > Questing > Quests > Group, "Tell my party in chat
  when I finish a quest objective").
- Items a quest still needs get a yellow "?" in your bags, and their tooltip
  names the quest, until you hand it in. That covers quests in your log and
  quests your guide has ahead for your character that you have not accepted
  yet (the tooltip shows how many you carry). Deleting such an item adds
  "Needed for: <quest>" to the game's confirmation. Sell one at a vendor and
  Polestar asks whether to buy it back, and its own automatic sale of grey
  items keeps it (thanks jaff and thmastin). The marks and the buyback
  question have their own settings under Questing; hiding the marks keeps the
  other protections.
- Brazilian Portuguese: the 246 interface texts still in English are
  translated (bag space and junk, restock, characters, class quest cards,
  party sync, Hearthstone advice, the Recorder's chat lines).
- Options → Quality of Life now also holds the other conveniences: instant
  quest text, skipping gossip, faster auto-loot, hiding combat errors and the
  game's quest tracker, taking and wearing the best reward, the quest item
  button and the step key, the Hearthstone and travel buttons, transport
  alerts, nearby services, trainer reminders, the minimap button and
  coordinates. Each is still on its old page too, as the same setting. The
  settings search is forgiving: it finds a setting from a misspelled or
  half-typed word, words run together ("autoaccept"), other words for the same
  thing ("fps", "junk", "minimap icon") and English on a translated client,
  puts the best match first, and when nothing matches it suggests the closest
  settings.
- The quest log cleanup is easier to find: the guide window's menu shows
  "Clean up quest log (4)" while there are quests to clear, and Options has a
  button for it under Questing > Quests. It now also lists quests that have
  gone grey and give no experience any more, unless the route still hands
  them in later in the same guide (thanks to a player's suggestion on
  Discord).
- The Recorder also notes the herbs, ore, fishing pools and locked chests you
  gather, with where they stand and the skill you had; how big your group is
  when you kill, level and turn in (never who is in it); when a creature you
  killed comes back; quests that failed; and when the game refuses something
  for a requirement (a level, an item, a quest, a skill), by the game's own
  message name, never its text. Polestar Client shows all of it under What we
  send. It reaches the database once Polestar Client is updated.
- Settings search finds a single Chinese, Korean or Cyrillic character inside
  a setting's name. Short English fragments still stay out of unrelated
  words, so "lag" does not match "flag".
- Silithus, Felwood, Winterspring & the Plaguelands (Alliance): after Umber's
  and Rabine Saturna's quests in Moonglade, the guide takes Nighthaven's flight
  path right there and flies on to Rut'theran Village, instead of hearthing to
  Cenarion Hold, flying to Rut'theran and coming back into Moonglade for the
  flight path (thanks Fitz).
- Teldrassil has you hand your class sigil to your trainer again on the
  visit to Aldrassil after Shadowthread Cave, when you train, rather than
  at level 2 with nothing to learn and a walk back to Conservator
  Ilthalaine (thanks Pynte).
- A "complete the quest" goal in the guide window no longer reads just
  "Complete Plagued Lands": it shows the quest's own objectives with their
  counts ("Rabid Thistle Bear Captured 0/1"), starting with "Use Tharnariun's
  Hope:" while the item the quest gave you is in your bags. Looked at ahead,
  before you have the quest, it shows what the quest asks for.
- A person with goals before and after someone else's in a step (Thundris
  Windweaver in Auberdine) is listed once in the guide window while you talk
  to them: their later quest shows with them, not on a second line.
- An object that starts two quests and is named like one of them (Auberdine's
  WANTED poster) no longer heads the other quest with that title: the guide
  window names it from the guide's note, or calls it the object here.
- The guide window shows only your character's steps: another class's or
  race's steps (a Druid's Moonglade trip for a Mage) and the "on the way"
  steps (Darkshore's Fine Crab Chunks) are never paged to and no longer count
  in "Step N / M", the progress, Up next, the map's numbered pins or the bug
  report (idea and first version by aronjanosch, #954). Their goals done on
  the way stay under "Along the way" of the steps that follow, which now says
  until which step ("Along the way, until step 30"), and the arrow no longer
  leads to them when you page through.
- Looking ahead at a step that depends on what you do (Elwynn's Goldshire
  hand-in of Book Return, for a group) no longer shows just its title when it
  holds nothing for you yet: the guide window says why in one line, such as
  "Only if you do Book Return with a group".
- On the Horde Zephras Isle start, Warriors, Rogues and Hunters hand their
  class letter to the trainer at the Thendal Village turn-ins, where they
  train, again, rather than at level 2 with nothing to learn.

### For contributors

- Forge's writer engine tests on full local data (`POLESTAR_V1` set,
  `--include-ignored`) keep one copy of the data per running test instead of
  one per test run so far: a whole run peaks at about 1 GB with one test
  thread (2.4 GB with four), down from about 14 GB.
- Translations: `forge i18n audit` holds the interface and guide texts against
  the client's own names for spells, talents, areas, skill lines and talent tabs, and
  lists each text that leaves the client's name out. Read only.
- RELEASING.md's smoke test command runs the release tests again: they are
  the `release::` tests of the `addontest` target, not a `release` target.

## 0.3.2 (2026-11-05)

### For players

- Tirisfal Glades no longer sends you to Executor Arren for The Adventurer
  before he offers it: the quest needs The Red Messenger handed in first
  (thanks mtbhuskies, Soulevoker, mcclaskiem and petllama, #792).
- Durotar (Orc, Troll): Forgotten Loa Idols is taken from Master Vornal right
  after Report to Sen'jin Village is handed in, when he offers it (thanks
  kieran1188, #796).
- A quest's objectives listed "along the way" no longer vanish when the guide
  reaches the step that hands it in: they stay under the step until they are
  done, so "Turn in" never hides what is left (thanks Zyd and jkw, #797,
  #809).
- Tirisfal Glades: if you are already level 5 on the road from Calvin
  Montague to Brill, Gordo's Task and its Gloom Weed are listed along the
  way, so you can take it when you pass Gordo (thanks petllama, #798).
- Tirisfal Glades: Tomb Weed is taken from Junior Apothecary Holland when
  Doom Weed is handed in, not on the first Brill stop, and Paladins take A
  Difficult Path once The Mindless Ones is handed in (thanks Livnthedream,
  #800).
- Tirisfal Glades: WANTED: Maggot Eye is taken from the poster in Brill on
  your second visit, when you have the level 6 it needs, still before Maggot
  Eye's camp (#801, thanks petllama).
- Zephras Isle (Alliance): Welcome to Shen'dar Village and The Missing
  Scholar say "Talk to" Rathiril Sunlance, Coriella Calmbreeze and Fillion
  Flamebreeze instead of asking you to kill them (thanks Visur, #802).
- Durotar (Orc, Troll) and the Orgrimmar and Darkspear Trolls reputation
  guides no longer send you to Rezlak for Stormy Potential before he offers
  it: it follows A Simmering Storm, which starts from the Dull Storm Orb a
  Storm Witch may drop, so it is now an optional extra, and without the orb
  you skip the last walk back to Rezlak. The reputation guides' tip now says
  the orb drops from the Storm Witches, not the lizards (thanks Rohkin, #807).
- The class-quest card no longer shows up for a line meant for every class
  but one: a Mage in Tirisfal is not told to learn Redemption, and Warriors
  in Durotar don't get a Warlock card for Vile Familiars (thanks Michael,
  #812).
- Elwynn Forest: the Applejack Still comes once, right after Homer Stonefield
  sells you the apples, instead of on the first trip west before you have
  any, and the guide says the quest never shows in your log, to keep the
  Thunder Applejack for Sergeant De Vries, and that looted apples count too
  (thanks Onrevax and bob, #820, #823).
- Zephras Isle: A Last Request's Bloody Note is ticked as soon as you read it,
  instead of waiting for Skypriest Aanders (#825).
- On a "kill these as you meet them" step the arrow now leads to the nearest
  mobs at or below your level + 1 first, and moves on to the tougher ones
  once those are done or you have levelled: in Westfall, a level 12 player
  leaving Sentinel Hill is sent to the Defias before the Goretusks and
  Harvest Watchers. For an item that several kinds of mob drop, the arrow
  searches the places of the ones at your level first (thanks Erá, #827).
- Leveling routes no longer send you to a quest giver before you are high
  enough to take the quest: the quest is taken on a later stop by its giver,
  or the guide says to reach its level first. In the Valley of Trials, Lazy
  Peons is now taken on the way back to the Den after the valley loop, not at
  level 2.
- Polestar Client shares your play by default, unless you stopped sharing in
  it or typed `/psrec off` in the game. A notice says once what is shared (no
  character, realm or account names) and where to see exactly what was sent,
  with a Stop sharing button. The Recorder on its own, without the Client,
  still stays off until `/psrec on`.
- Polestar Client no longer stops sending your play after an upload with
  "PolestarRecorderDB.chunks has an unexpected value" (thanks Fyurie).
- Polestar Client shows a waiting update across the top of every page, with
  "Update to <version>": one click, instead of scrolling to the bottom of
  Settings.
- Darkshore (Night Elf): Swelling Forces and its level 20 naga wait for your
  later Darkshore visit, when Arbal offers it, instead of a trip north at
  level 13.
- Elwynn Forest: a clear warning that Croaky is a level 11 elite (optional;
  with a group or from level 10).
- The Recorder no longer shows a Lua error about `isFullUpdate` when the game
  hides your buffs' details from addons.
- Smoother frame rate while you move: the arrow's path finding takes a small,
  fixed slice of each frame instead of up to half of it at high frame rates,
  reuses the map pieces it has just read instead of reading them again, and no
  longer works out flight and hearth options for a waypoint within 400 yards
  of you. The short stutters when a new waypoint is set, or every 50 yards of
  running, are much rarer and shorter.
- Westfall: Harvesting the Harvesters sends you to the Harvest Watchers for
  the Harvester Gyrostabilizers, the only mobs that drop them, instead of the
  level 17-18 Harvest Reapers (thanks Erá).

### For contributors

- The Discord bot no longer answers reports with a note about the pathing
  overhaul or puts them on hold: walking and arrow reports are triaged like
  any other.

### Forge

- Hand in while there: a quest finished within 160 yards of its turn-in NPC is
  handed in before the route walks 300 yards or more away, not on a trip back
  (Sarkoth at Hana'zua). Waiting stays when the follow-up needs a level not
  reached yet or the route returns to that NPC anyway. The route planner moves
  and guards it, `forge judge check` reports it as `finished-near` (a blocker to
  level 30, a warning above) and `forge sim route --audit` lists it on written
  routes.
- A turn-in whose NPC stands on a loop's way is written inside the area step,
  right after the goal that finishes the quest, when it adds at most 40 yards
  and saves a walk back later.
- Guide titles leave out the capitals and zones the guide hardly quests in;
  a race's lead-in to the shared guide of the same zone is merged into it.

## 0.3.1 (2026-11-04)

### For players

- Orcs and Trolls are no longer held at the Den waiting for level 3 to take
  Lazy Peons: Foreman Thazz'ril gives it on the return to the Den, once the
  valley's turn-ins have brought you to level 3; you wake the peons sleeping
  around the Den and the lumber piles, then take Thazz'ril's Pick with you to
  the Burning Blade Coven. The same fix for two other
  quests the route offered just before their level: The Red Crystal for Night
  Elves (now on the next Auberdine stop) and Beren's Peril in Silverpine (now
  on the later Sepulcher stop, before its loop).
- The arrow gives you room again. It points down the road instead of swinging
  at every bend (bends up to 20 yards to the side count as the road), lets you
  walk up to 15 yards beside the path with the arrow pointing along it, and,
  outdoors, lets you join a road at an angle instead of sending you to the
  exact spot where the path meets it. Real corners, doorways, bridges and
  switchbacks still turn it at the corner.
- The Polestar emblem in the main menu looks like the app icon now: a bolder
  star and ring with its bright centre and a soft glow.
- French: the guides' texts are translated (9,493 of 9,934; the rest are
  texts new in 0.3.1): steps,
  tips, notes and route choices of the leveling, class, profession, reputation
  and collectible guides. Thanks Yendi.
- French: the whole interface is translated (503 strings and the Recorder's
  10), and the welcome's sample goal and the class card's quest giver name the
  NPC or item in French. Thanks Yendi.
- German: the 157 texts new in 0.3.0 are translated (bag space and junk,
  Restock, class quest cards, the guide's hand-in warnings and more), so the
  German interface is complete again (thanks Cortexyn).
- German: the Cozy Sleeping Bag's step names Honor's Stand by the client's
  German name, Ehrenwacht (thanks Cortexyn).
- The end of a leveling guide is no longer silent: when you finish its last
  step, a window says you completed it (or reached its end, and how many steps
  you left undone) and offers the next guide, the zones to choose from, or the
  guide menu. Stay instead and the guide window keeps a "Start <next guide>"
  link at the top. It asks once per guide per character. The old option
  "Continue to the next guide" is now "When a leveling guide ends": "Ask me"
  (the window) or "Continue automatically" (the next guide loads by itself and
  the guide window says so). Everyone starts on "Ask me", also if you had the
  old option on: pick "Continue automatically" in Options → Guide →
  Automation to keep the old way.
- One Barrens guide for every Horde race: the Orc and Troll arrival steps (the
  Crossroads, Thun'grim, the Shaman's fire totem, Ratchet) open "The Barrens
  (12-16)" for Orcs and Trolls only, instead of a separate guide with the same
  name; Durotar hands over to it directly. Guide names leave out capitals and
  zones you only pass through (Silverpine Forest, Arathi Highlands & Badlands,
  Winterspring and more).
- Talent plans are paused for now: the Talents page says "Coming soon", and
  Polestar no longer marks the game's talent frame, adds plan lines to talent
  tooltips or reminds you of unspent points. The plans weren't ready to
  recommend picks yet; they'll come back once they are. Gear advice still
  follows the talents you've chosen.
- Quests are handed in where you finish them instead of on a later trip back:
  Sarkoth at Hana'zua as soon as he's dead, before the Vile Familiars (Orcs
  and Trolls), Crossroads
  Conscription to Sergra as you arrive at the Crossroads (Orcs and Trolls),
  MacKreel's Moonshine on the first Southshore stop, Fiery Menace! and Curse
  These Fat Fingers at Thorium Point, A Strange Historian and A Matter of Time
  to Chromie right after the Andorhal towers, Gahz'ridian on the way past
  Marvon, and Duke Nicholas Zverenhoff on the first Light's Hope stop.

## 0.3.0 (2026-11-02)

### For players

- Ashenvale: Kerlonian's escort now has you take the Horn of Awakening from
  Kerlonian's Chest beside him first; the guide never sent you for it (#424).
- A Skyborne character's visits to Nazgrel, Vol'jin, Lady Sylvanas Windrunner
  and Cairne Bloodhoof read "Talk to" instead of "Kill" (thanks EpicTibbles
  and mcclaskiem, #532).
- Hunters' Taming the Beast quests now say "Tame Webwood Lurker" instead of
  "Kill Webwood Lurker", in every starting zone's guide and in the guides
  Lookup builds for a quest (thanks EpicTibbles, #565).
- A hearth step while your Hearthstone is on cooldown says how long until it
  is ready and points the arrow at the inn, so you can walk there instead of
  waiting (thanks Hotline and mcclaskiem, #576).
- The Barrens: Ishamuhale now has you loot a Fresh Zhevra Carcass from a
  zhevra and use it at the Dead Tree north-west of Ratchet, which brings him
  out, before you fight him (thanks Miguel Antunes).
- Wetlands: Blisters on the Land now leads you to the Fen Creepers in the
  Sundown Marsh waterways, where most of them are, not the few by Rethiel the
  Greenwarden (thanks Tazul | Robin, #610).
- Night Elf: Tallonkai's Jewel is taken from the Gnarlpine Necklace where
  Ferocitas drops it, not on a later trip back to Dolanaar (#619). Any quest
  item found only inside another item is placed where that item drops.
- Zephra's Isle (both factions), Durotar and the Barrens ask whether you are
  in a group before WANTED: Vulgara the Insatiable, Threat from Below and
  WANTED: Bruuz, whose targets are elite; alone, the guide skips the whole
  quest instead of listing it as an optional extra (thanks mariusch, #639).
- The trainer reminder now names the class trainer on the way your guide is
  heading, not the nearest one: a Dwarf Shaman who reaches level 6 in the
  Coldridge tunnel is sent on to Kharanos instead of back to Anvilmar (thanks
  milanaddons and PRDesrochers, #664).
- A hearth step while your Hearthstone is bound to another inn says so and
  points the arrow at the step's inn, so you can walk there instead of
  hearthing to the wrong place (thanks mcclaskiem, #667).
- The trainer reminder now says how many steps ahead your guide trains your
  class, and at which step ("The guide trains you in 5 steps (Thunderbrew
  Distillery)."), or that the guide has no class training ahead, so you can
  weigh a detour against waiting for the guide's stop (thanks milanaddons and
  PRDesrochers, #664, #668).
- Tirisfal Glades: the Paladins' arrow for Rediscovering the Light leads to
  the Injured Deathguard in front of the church, beside Aramis, instead of 60
  yards north of it (thanks yiliev0, #672).
- Tooltip annotations no longer disappear when a tooltip is cleared and
  rebuilt (thanks Deadshot0330).
- The help for Skip single-option gossip says what still skips a gossip with
  it off: the game itself, for some NPCs, Pick what the step asks for at the
  step's NPC, and Open the flight map at flight masters (thanks PRDesrochers
  and Evolution9840, #684).
- Cozy Sleeping Bag: the first note now waits for level 14, when the chain
  opens, and says so before you set out for Westfall or the Barrens (thanks
  Hotline, #698).
- The City of Dalaran's guides and arrow send the Alliance in through the
  sewer pipe in Cantrips & Crows, inside the city, instead of the Horde's
  tunnel on the western wall (thanks Visur).
- Fishing: the Undead's Silverpine Forest step (50-125) leads to Lordamere
  Lake by the Decrepit Ferry instead of the Great Sea coast west of the
  Sepulcher (thanks Hotline, #718).
- Darkshore no longer points Druids to the Stormwind boat before their Cat
  Form trip to Darnassus and Moonglade; the boat comes after it. Westfall's
  Sentinel Hill finishes the tower quests before Thor's flight path and the
  inn, so the hill is walked down once (thanks TP1186, #727).
- Dun Morogh: The Quarry's Smith counts your Toughened Boar Hides on their
  own line instead of the Copper Bars line, so the step no longer reads
  done or stuck by the wrong count (thanks TP1186, #727).
- Dun Morogh: the Toughened Boar Hide goal of The Quarry's Smith now checks
  off with the hides, quest objective 2 after the Copper Bars (thanks TP1186,
  #727).
- Gear advice: Feral Druids weigh their weapon's DPS, at 14 attack power per
  DPS like the other melee specs, since in Forever Cat, Bear and Dire Bear
  Form hit with the equipped weapon (thanks IgorMagals, #731).
- A Light in the Darkness tells you to free the Webbed Forsaken by attacking
  their cocoons in Night's Web Hollow, under the name you see over them,
  instead of a bare "Complete A Light in the Darkness" (thanks Fitz, #735).
- Leveling routes walk each town and camp in one sweep: everything ready
  there (quests you can take, quests ready to hand in) is done on the visit,
  the NPCs in walking order from the side you come in, and a quest giver
  you pass on the road is visited on the way. In Tirisfal Glades A Light in
  the Darkness is handed to Aramis on the way back from the cave, Fields of
  Grief is taken from Deathguard Simmer before Gordo instead of walking back
  west, and A Putrid Task is taken from Deathguard Dillinger between Holland
  and Zygand (Fitz, #736, #737, #739, #740).
- Tirisfal Glades: A Light in the Darkness stays handed to Aramis in
  Deathknell before the Scarlet farm in every built route (thanks
  PRDesrochers and Fitz, #736).
- Generated routes list work "along the way" only when the walk comes within
  60 yards of where it spawns, not just near the edge of its area: the
  Tirisfal Pumpkins are no longer listed on the walks through Brill (thanks
  Fitz, #737).
- Tirisfal's Sticks and Bones line says Deathguard Bartholomew walks up to the
  graveyard north of Brill and back, so you know where to look when he is not
  at the arrow (thanks Fitz, #741).
- The guide moves on only on what the game confirms (#741, #739). Opening an
  NPC's chat no longer checks off a "Talk to" goal: it counts once you pick a
  chat option or take or hand in a quest there. A "Train" goal checks off
  when you learn a spell from a trainer of your class, not when the window
  opens. A vendor goal needs that vendor's window. A window still open when
  the next step comes up checks nothing off there.
- An accept you ticked by hand while the quest is not in your quest log stays
  open and says "isn't in your quest log"; its hand-in is no longer hidden.
- A quest its giver does not offer is never skipped for you: the arrow stays
  on the giver and the line says "Not offered by …? Report it with
  /polestar". Nothing about it is kept across a logout. You can still skip
  the quest yourself.
- Quest automation takes and hands in only the quests of the step the guide
  is at, never a step ahead and never a step you are only looking at.
- In a quest hub the window keeps every goal of the step listed while the
  arrow moves from person to person: what you took or handed in stays
  checked. A quest passed over while you look at another step is said once
  you are back on the step the guide is at.
- When a generated route splits a written step, a tip about an NPC goes with
  the part that visits them: Calvin Montague's duel is mentioned where you
  take it, not at Deathguard Simmer on the first walk past the farm (thanks
  Fitz, #742).
- Every start zone's Camping 101: Cooking now has you learn Cooking from its
  trainer before the hand-in (William Pickman in Brill, Cook Torka in Razor
  Hill, Pyall Silentstride in Bloodhoof Village, Tomas in Goldshire, Zarrin in
  Dolanaar, Zerril Softbreeze on Zephras Isle), as the quest asks, instead of
  "ask him about cooking" (thanks Fitz, #743).
- Polestar Client: picking your game on the first screen ticks it. On Windows
  (and on Linux when the game sits behind a linked folder) the choice was
  saved but no game showed as selected, so it looked as if none could be
  picked (thanks Pynte). The client now only offers the game's `_forever_`
  folder: a `_classic_beta_` folder left from the beta is no longer listed.
- With "Match EllesmereUI font" on and a font with an outline, labels on the
  accent colour (Load guide, Copy report) were drawn dark with a black outline
  and smeared together. Text on the accent now has no outline.
- Alliance leveling guides, 37 to 43: Driftwood is taken on the Swamp of
  Sorrows visit after the Stormwind stop at about 42, so Riding at 40, The
  Tome of Nobility and Summon Felsteed stay in that level-40 Stormwind stop
  instead of turning up at 37 with flights to Stormwind and back; Stranglethorn
  Fever is again the first thing taken in Booty Bay, so the Ratchet flight path
  is learnt before the boat and Warriors finish The Affray on the way to
  Ratchet, not by a boat back from Booty Bay.
- Alliance: the arrow now leads to Plagued Lands' bears in Darkshore, to
  Rockbiter's camp while you escort Shay in Feralas, and to Narm and Henze
  Faulk for the Paladins' Tome of Divinity, instead of showing nothing until
  the objective was done.
- Elwynn Forest: Wolves Across the Border is handed to Eagan Peltskinner on the
  same visit as his breadcrumb, Stolen Enchanting Supplies to Blixie Fitzwink
  beside Hamish Bergwort, and the Painted Gnoll Armbands to Deputy Rainer as you
  leave Forest's Edge, so the guide no longer walks back east from Forest's Edge
  or bounces Westbrook -> Goldshire -> Westbrook at the end of the zone. The
  Fargodeep Mine is one visit: Kobold Candles, Gold Dust and Goldtooth together.
- Redridge Mountains: the Battleworn Axes are collected in the Blackrock camps
  south of Galardell Valley right after Fangore, not between Render's Camp and
  Keeshan. The Price of Shoes is no longer taken (it went grey in your log and
  sent you back to Goldshire after the Stormwind training).
- Alliance leveling route: Westfall's Testing the Wells and Murloc Gills are
  taken on the first Sentinel Hill stop again, so the north loop is not
  split into several trips back to the hill. Darkshore's Buzzbox 525 bears are
  done on the Grove of the Ancients visit, not on a run from the Tower of
  Althalaxx to the far south and back. Stones of Binding is handed in in the
  Arathi Highlands at 38 instead of a flight back there at 40, and the guide no
  longer flies you to Booty Bay and back at 43 for The Monogrammed Sash or to
  Arathi for Breaking the Keystone, two elite quests a solo player skips.
- Alliance guides travel more sensibly: Skyborne players are no longer sent
  on a walk through Arathi and Redridge after the portal to Stormwind; Dwarves
  and Gnomes take the tram, learn Stormwind's flight path and then do their
  Stormwind class quests; and there are no more boat round trips to Ratchet
  in Stranglethorn just for a flight path. Also fixed: "Fly to" steps with no
  flight in them, a second flight to Astranaar from Maestra's Post, and Humans
  walking back to Sentinel Hill for a hand-in or to Goldshire from Westfall.
- A new Characters page in the hub (`/polestar alts`) lists every character
  you have played on the account: level, class, zone, hearth, gold,
  professions, the guide it follows and an XP bar with its rested XP
  estimated to now. Sort by last played, most rested or level, and see how
  many instances you have entered this hour. Each character appears once you
  log in on it. (thanks XrayAlpha, #654)
- More field steps whose mobs share the same ground are now one "kill these
  as you meet them" step, so you work the area once instead of crossing it
  several times. This now also covers mobs placed only on the live map
  (Redridge's gnolls), steps without a zone line, a quest stop on the same
  ground in between (Lakeridge Highway around Three Corners), and a camp only
  some classes work.
- The arrow no longer says you have arrived while you stand a floor above or
  below the target (the Undercity, caves, towers). A small up or down mark
  beside the distance shows which way to go.
- The arrow follows a walking path smoothly: it counts a point you walk past
  to one side as passed and aims along the path ahead of you, so coming at a
  road from the side or walking beside it no longer holds it on a point behind
  you, and it swings round gently instead of snapping from point to point,
  while turning your camera still moves it at once (thanks loney)
- The guide arrow has more room between the arrow and its distance, and between the distance, the place and the time lines under it.
- Alliance leveling guides, Ashenvale: the Dal Bloodclaw tip calls the
  Thistlefur camp north of Astranaar furbolgs, not gnolls.
- Ashenvale, Wetlands & Stonetalon Mountains: Unrequited Love is picked up
  from Archaeologist Hollee in Auberdine before the boat and handed to Tarrel
  Rockweaver before In Search of the Excavation Team, which he won't offer
  while you carry the note; both are optional (thanks Ioney).
- The item the current step uses, or a quest item it has you collect, now
  glows in your bags (and in Baganator), beside the quest item button, so you
  find the carcass, the seeds or the horn at a glance (Options, Questing,
  Buttons: Highlight the step's item in your bags; on by default).
- Bag space: when your bags are nearly full (2 free slots or fewer, set on
  Quality of Life > Vendors > Bags), a button shows the free slots and the
  cheapest junk in them, and while the step collects something the guide
  window says so too. Press it twice to delete that junk; nothing is ever
  deleted on one press. `/polestar bags` prints the count.
- Junk and keep marks: Ctrl+Alt-click an item in your bags to mark it as
  junk (sold at merchants with the grey items), again to keep it (never
  sold or deleted by Polestar), and again to clear the mark. Its tooltip
  shows the mark.
- The arrow follows the walk into each guide step that was worked out when
  the guides were built, from where you stand on it, instead of searching
  for a way first; it searches as before once you leave that walk by more
  than 25 yards, and for a step without one.
- The Barrens: the Trouble in the Valley step (quest 95621) now warns that the
  Kul Tiras Marines near Corporal Adamore are linked and gives a pulling tip
  for handling them solo (thanks Fitz).
- The Barrens: the Dry Hills step reminds you to collect the Intact Raptor
  Horns for Raptor Horns from the Sunscale Scytheclaws there, if you still
  need them (thanks Fitz).
- New, off by default (Quality of Life > Travel > Death, "Warn when out of
  breath"): under water, a red edge round the screen, a warning sound and a
  taskbar flash with 10 seconds of breath left, and again at 4.
- Buying for the guide (Quality of life, off by default) now spends your money
  only for Polestar's own guides. For an imported or community guide it names
  what to buy and what it costs, and leaves the buying to you.
- Hillsbrad Foothills, Dustwallow Marsh (both factions), Teldrassil and the
  Paladin charger and Warlock dreadsteed guides: when you hand in a quest
  whose item was bought steps earlier (the Soothing Spices, the Empty Vial and
  Spring Water for Byancie, the Enriched Manna Biscuits, the Xorothian
  Stardust), the guide sends you to a vendor for it first if you have none,
  instead of straight to the quest giver.
- The "Riding at 40" steps for Orcs, Trolls, Night Elves and Skyborne now show
  only once you are level 40, instead of sending you to a riding trainer early.
- Skyborne are told that Genn Fairweather on Zephras Isle teaches their riding
  and sells their Galestriders, and how to reach the isle (the skyboat north of
  Thunder Bluff for the Horde, from Dalaran for the Alliance), instead of being
  sent to another race's riding trainer.
- Quests ready to hand in where a flight, a deathskip or your hearthstone lands
  you are handed in right there, with the follow-ups the same NPC gives: Sen'jin
  Village's quests on the deathskip's landing before Kolkar Crag, Mebok's at
  Ratchet, Uzer'i's at Camp Mojache, Felnok's and Umi's in Everlook. Hadoken's
  and Nathaniel Dumah's hand-ins are done beside the flight master before the
  flight out, and Ozwin's isosprings at the Saldean's Farm stop in Westfall.
- Druids and Paladins coming back to the Crossroads from Thunder Bluff are no
  longer shown everyone else's flight from Orgrimmar.
- The Badlands' Rock Elemental Shards step says every rock elemental drops them,
  so the Lesser Rock Elementals near Lotwil's camp do: the Greater Rock Elementals
  (42-44) are only for Lotwil's optional bracers.
- Exploration guides: the zones of each band now run from low to high level
  (Alliance Eastern Kingdoms 1-30 does Dun Morogh and Loch Modan before
  Westfall, Redridge before Duskwood, and takes the Menethil Harbor boat to
  Southshore instead of crossing the Arathi Highlands; Eastern Kingdoms 45-60
  starts in the Hinterlands and Searing Gorge before Deadwind Pass and the
  Blasted Lands). The Riverglades are entered from the southern Badlands and
  lead on into the Swamp of Sorrows, with their flight paths named. Tours start
  where you really walk in (Honor's Stand, the Great Lift, Mulgore's pass,
  Valanaar's skydocks) and end at the way out. Feralas's level 60 Oneiros and
  Dream Bough and Dustwallow's Alcaz Island wait in a step of their own at the
  end of the zone instead of opening the 30-45 tour.
- Legacy Challenges: Darkspear Islands Exalted is the fourth battleground
  point; the dungeon checklists follow Forever's three lists (with Hall of
  Thanes, the Ruins of Lordaeron, Excavation Site: Wetlands, the City of
  Dalaran and Forever's other new dungeons); the Valthalak step ends with your
  class's Saving the Best for Last; the raids show their size, opening date and
  the Drakefire Amulet both factions need.
- Library Books: the books come in four parts by level, each ending at the
  library, so Friend of the Library's necklace comes after the low-level books;
  the milestones say how many books they take; Secrets of the Dreamers points
  you to the cave mouth at Lushwater Oasis; the level 60 books are added.
- Cozy Sleeping Bag: the Stonetalon hideout is north-west of Sun Rock Retreat,
  not in eastern Stonetalon.
- Inside Ironforge the walk out to the gate is found in about half the time,
  and the walks further along the route no longer slow it down.
- Class quests: once you have taken your class quest, its card folds to one
  slim line that says who to hand it in to, so the step's next person stays
  the task. Before you take it, the card says the guide already includes it:
  just follow the guide. (thanks Fitz)
- Priest and Shaman class collections: retain one Ichor of Undeath for
  Ogtinc's follow-up and explain that carrion birds can supply either
  Spirit Totem material. Includes Simplified Chinese.
- Classes back from their own trainer trips now rejoin the route where it
  goes next, instead of walking back to the town's training stop first
  (Warlocks after Stormwind, on to Rainer, not via Goldshire).
- Class guides for every class quest chain from 1 to 60: new guides for the
  Imp and Voidwalker, Taming the Beast, Call of Earth and Call of Fire, Tome of
  Divinity, the mage staves at 10, the priest robes, teleports and portals and
  more, Forever's own chains (Undead paladins, Skyborne, Ravenholdt), and
  every step says where to go, what drops where, which fights are elite and
  whether to bring a group. The level-up heads-up no longer offers raid and
  dungeon set pieces.
- A class quest's step now leads with a card in your class colour: what the
  chain teaches or gives (Cat Form, the Voidwalker, the Whirlwind weapon...)
  with its icon, the trip ahead and its steps, and a short shine and chime the
  first time (Class quest chime in Options, Colour & type).
- When you reach the level of a class quest (Cat Form, your Voidwalker, the
  Whirlwind weapon...), a heads-up says what is ready, where to get it and
  whether your route goes there, and can open its class guide in a new tab at
  that quest. The class card now holds the step's accept line.
- When one of your class's quest guides opens for you (you reach its level,
  or its first quest becomes available), the guide window offers to open it
  in a tab next to your leveling guide. "Later" asks again at your next
  level; dismissing it stops the offer for that guide. Turn it off in
  Options, Guide, Automation, "Offer class quests".
- Polestar Client, a small app for Windows, macOS and Linux: it finds WoW:
  Forever, installs and updates Polestar, the Recorder and LibForeverData
  (each download checked against its published checksum, other addons never
  touched), and joins the recording program: with your consent it sends what
  the Recorder records, showing exactly what each upload holds first. Pause
  it, or delete everything it sent, any time.
- Polestar Client 0.1.2: the app opens again on every Linux desktop. On some,
  0.1.1 opened on "Something went wrong: Command
  plugin:notification|is_permission_granted not allowed by ACL" instead of its
  window.
- Community guide updates are no longer installed automatically unless you
  turn on the new setting, and then only a day after release and only when
  the guide's publisher and folders are unchanged. A guide the site pulls is
  turned off or removed, with the reason shown. Guide downloads accept only
  the files the guide compiler makes.
- A guide pack step to loot an item a quest only uses, tied to one of the
  quest's lines, now notices the item in your bags and moves on: in a Barrens
  pack, the Sunscale Feather for The Angry Scytheclaws waited for the Blue
  Raptor Nest, and the Fresh Zhevra Carcass for Ishamuhale waited for his Fang
  (thanks defect). This needs Polestar's quest database, which the quest
  tooltips and markers load.
- Roll the mouse wheel over the step number to look through the steps (hold
  Shift for ten at a time); a few seconds after you stop, the window is back
  on the step you're on. Click the number for a list of the steps around it,
  with done ones ticked and your step marked, and click one to look at it.
  Looking never changes anything.
- Cozy Sleeping Bag: on the way to Stonetalon, Alliance characters now go
  round Honor's Stand, the Horde post on the Barrens road west, instead of
  straight through it (thanks dgc1980).
- Links to Polestar's CurseForge page point at its new address,
  https://www.curseforge.com/wow/addons/polestar.
- The Dalaran Sewer Key's note says the Alliance walks in through the
  sewer pipe in Cantrips & Crows, not through the Image of Archmage Modera.
- Darkshore's How Big a Threat? marks the furbolg camp by the Rabid Thistle
  Bears on the map, not a camp far to the north-east of Auberdine, and the
  arrow leads to that camp (thanks Deadshot, #560).
- New option "Use deathskips" (Automation, Guides; off by default): where
  dying and taking the Spirit Healer's resurrection is faster, the guide can
  show a step for it. Always off on Hardcore characters.
- Rare alerts waiting for combat to end now respect changed alert settings
  and ignored rares, and stop when that same creature is observed dead,
  even just after it was first spotted.
- Dustwallow Marsh & Desolace (Horde): Ghost-o-plasm Round Up now sends you to
  the Valley of Bones, where the Magrami Spectres are, on the Mannoroc Coven
  trip, instead of showing the Kodo Graveyard (thanks Syrael, #575).
- The Discord link in game, in the README and in the docs is now
  discord.gg/polestar. The old invite still works.
- Dungeons: a quest with a chain before it shows what the quest and its chain
  are worth together, with the levels panel on hover; hovering a quest in the
  chain shows its level, state, rewards and its XP at your level (thanks
  mcclaskiem).
- Died in a dungeon and released outside it? The death helper now runs you
  back to the dungeon's entrance, with your corpse inside, instead of
  sending you to the Spirit Healer because it couldn't find the body.
- Dungeon quests now appear in readable cards with clearer objectives,
  requirements, rewards, and numbered steps in their quest chains.
- Options, Discovery, Dungeons has a new section, Dungeons in leveling guides:
  a switch per Classic dungeon, from Ragefire Chasm to Stratholme. A community
  guide with dungeon steps takes you through the dungeons you turned on and
  keeps to its solo route for the rest; Polestar's own guides have no dungeon
  steps. Every switch is off at first, each character picks its own, and a
  change affects only the steps still ahead of you.
- The arrow says which way a lift goes: "Ride the elevator up" or "Ride the
  elevator down", from 30 yards before its landing, with the departure time
  under it.
- Elwynn Forest: the Forest's Edge step no longer waits for Gruff Swiftbite, a
  rare. The Gold Pickup Schedule and The Collector are optional; if you take
  The Collector, it and Manhunt follow as before (thanks zeike, #553).
- Elwynn Forest: in the Jasperlode Mine the Mining Tools come first, picked up
  on the walk in, then the mine's far end, then the Kobold Geomancers on the
  way out (thanks Nittepitte).
- Elwynn Forest: back in Goldshire from the east, you hand in to Marshal
  Dughan while William Pestle brews the liquor for The Escape, instead of
  waiting by him (thanks Nittepitte).
- Empty section headers are gone (three in a row in Ashenvale), and a step no
  longer repeats a tip it already gives (Captain Stoutfist in Menethil Keep).
- A bug report now ends with what Polestar noted just before it (a short
  rolling log kept even with debug output off), your quest log as quest ids
  and objectives done, and the settings you changed. Errors in Polestar's
  per-frame and timed work are now caught and counted like any other, and a
  repeating one reaches the error window once every half minute instead of
  flooding it.
- Guides Polestar builds for you (dungeon quest pickups, Lookup quest chains,
  attunements) now point the arrow at an explore or event objective, such as
  The Forgotten Pools' waters, instead of back at the quest giver (thanks MgM,
  #515).
- Horde Rogues: Taskmaster Fizzule's step says to fire two flares with the Flare Gun and /salute him
  before going near him.
- Alliance: after the Menethil hand-ins the guide asks for level 28, and says where to grind for it,
  before Pilot Longbeard's quest in Ironforge (#617).
- Dwarf Paladins: the arrow for Narm Faulk points to Helm's Bed Lake, not into Ironforge (#303).
- Night Elves: the hand-in to Byancie reminds you to buy another Refreshing Spring Water if you drank
  yours (#365).
- Horde: Protect Kanati Greycloud has an arrow back to Kanati at Whitereach Post.
- Trolls: Aggor the Young is asked about as a group quest, with its elite warning, as for Orcs (#639).
- Horde Stranglethorn: the tips no longer tell you to ride before you can learn riding.
- A corrected tip now replaces all of a step's old tips, so a stale second
  tip no longer sends you to the wrong place.
- The WoW Forever skin is back in Options: the guide window's bronze border
  sits below the tabs instead of cutting through their text and no longer
  shades the step counter and progress bar, the progress bar shows its fill,
  buttons keep their icon and label under the hover glow, and the goals have
  room inside the border, with the lit goal's tick box centred inside its
  outline (thanks imp and mcclaskiem, #306).
- Polestar runs on the `_forever_` stress-test client; install it into that
  client's `Interface/AddOns` folder the same way you would for the beta.
- Gear advice now gives melee weapon DPS a small value for Druids and
  casters, whose stat weights had none: a staff or dagger that hits harder is
  an upgrade when nothing else about the two differs, as it is for a low
  level character who fights with it. Stats still count for more. Feral
  Druids stop counting it once they learn Bear Form, as forms ignore it.
  (thanks thmastin)
- The upgrade arrows on bag items now show in EllesmereUI Bags too, bottom-left
  on the item, beside the Pawn arrow that EllesmereUI Bags draws bottom-right
  (Options, Questing, Rewards & gear: Upgrade arrows in bags).
  (thanks thmastin)
- The upgrade arrow in your bags now shows on an item that fits an empty
  slot even when your stat weights give it no value, such as a staff for a
  Druid, which the tooltip already called an upgrade (empty slot). An item
  that would be a loss, or needs a higher level, still gets none.
  (thanks thmastin)
- With Pawn installed, a new "Leave bag arrows to Pawn" option (Options,
  Questing, Rewards & gear) hides Polestar's bag arrows so an item does not
  carry two.
  (thanks thmastin)
- Gear advice can use your own stat weights: paste a Pawn scale string
  (Options, Questing, Rewards & gear: Manage custom weights, or `/polestar
  gear import`) and pick it under Stat weights as "Custom: <name>". Every
  tooltip, bag arrow and reward pick then scores with it. The window lists
  your scales for every class, with Use, Rename, Export and Delete. Details
  lets you change any weight, add a stat or remove one, and shows the Pawn
  stats the scale left out (resistances, weapon speed and the like). "Copy a
  built-in spec" starts a scale from Polestar's own weights. Drag the
  corner of the window to make it bigger; it remembers its size.
  (thanks thmastin)
- Generated guides no longer send you to hand in a quest you passed by: the
  hand-in of a quest picked up on the way (optional, or from an item drop) and
  of the quests that follow from it is skipped when it is not in your log.
- Generated guides warn you before an ambush, stealthed mobs, extra mobs that
  join a fight, or an attack when you loot, on the step where it happens.
- Generated guides now say where a quest NPC or object is when the arrow alone
  would not: below ground, upstairs or on the top floor, inside a cave or
  mine, or underwater. An NPC who walks around (Deathguard Bartholomew in
  Brill, #741) says so, and the map circles the ground he covers.
- German: names written as the client has them (Lord Grayson Schattenbruch,
  Majordomus Executus, Fürst Hydraxis, Drachenfeueramulett, Kugel von
  Althalaxx, Einsteigerpaket für Entomologen, Krümel, Blackrockspitze and the
  talent notes' Tierherrschaft and Heiligspezialisierung).
- German: five guide texts corrected (Journeyman Riding as the client names
  it, two sentences in Azshara and the Hinterlands, and the Fishing Traps
  sentence in Elwynn Forest, which showed the English name).
- German: 268 more guide texts translated (Dun Morogh, the Library Books and
  Cozy Sleeping Bag guides, the Barrens, Desolace, Dustwallow Marsh, Arathi,
  Teldrassil and the class and profession guides).
- German: the last 15 texts translated (the Options preview, the Recorder's
  chat lines and a Priest talent note).
- German: the interface texts new since 0.2.5 are translated (the bug report,
  target marks, the sparkle line style, the weapon masters, the XP preview and
  the import messages).
- German: 127 more texts translated (skipping and group quests, Pawn
  scales and custom stat weights, NPC services on the map).
- German: the texts new since 0.2.6 are translated (the riding reminder, the
  quest tracker option, the XP of a quest chain and the build sources).
- German: 50 more texts translated (the Characters page, map icon options, the
  uploader and the Community guides notes).
- German: the talent plan notes use the names the German client shows for
  talents and spells (Schlaghagel, Arkanschlag, Göttliche Pein and so on) and
  for the Feral Combat tree (Wilder Kampf).
- At a group quest a guide marks as one, the guide window now asks before
  sending you on: Skip it keeps to the solo route, Do it with a group takes
  the quest on. Your answer is kept per character, and Options, Discovery,
  Group quests lists the answers to change them.
- You can answer every group quest at once: Options, Guide, Automation,
  "Group quests" asks at each (as before), or does them all with a group
  (a party levelling together) or skips them all (solo), so the route never
  stops to ask. An answer you give for one quest still wins.
- Each elite or group quest the guide takes says so on its first step: that
  the mobs are elite and grouping up is encouraged, how hard they are (a level
  10 elite most classes solo at level 12, or the group size it needs, shown
  under its kills too), and that you can skip it alone. Skip it and the guide
  adds a grind right after it, to the level the quest would have given you, so
  the rest of the route stays on plan.
- Guides keep one copy of an NPC list that several steps of a guide repeat
  (vendors, innkeepers, trainers): the guide pack takes about 15 % less
  memory, and each goal still picks and cycles its own NPC (thanks HershelW,
  #574).
- Polestar's guides take about 15 MB of memory instead of 24, with the whole
  new route set and every new guide shelf on board, and loading them no longer
  spikes to 47 MB (about 32 now): a character loads only its own
  faction's guides, and a goal's spawn spots stay packed until the goal is
  shown. The other faction's guides load when you pick that faction in the
  guide menu (#693).
- New Guiding Stars page in the options: the people who support Polestar on
  Ko-fi and everyone who has contributed on GitHub. "Special thanks to" at the
  top of the guide menu and the options leads there.
- A hand-in you may not have (an optional or found quest) at a quest giver
  you are already talking to now stays in that step, marked optional, instead
  of being split into a step of its own.
- A hearth step weighs your Hearthstone against the trip: while it waits it
  says whether to set off now or wait for it, and when the inn is close by it
  suggests going there and keeping the Hearthstone. It never holds the step.
- A class quest step held for later is now titled for the quest giver you
  actually meet there (Tarshaw in Razor Hill, not Torm Ragetotem).
- Questing options: a setting to hide the game's quest tracker, as Questie
  can. Off by default.
- Horde Shamans hand in whichever Call of Fire trainer lead they already
  carry at Kranal Fiss before continuing the shared ritual, without
  another trip to a trainer.
- Horde: Betrayed points at Rimtori's camp, Scouring the Desert at the
  Horde Silithyst delivery point, and Camping 101: Cooking at Pyall.
  Their quest completion conditions and route order stay the same.
- Horde rogues: prepare Lockpicking and keep the supplied flare gun before leaving Orgrimmar, fire two flares before saluting Fizzule, and distinguish the tower key from the lockbox. Finish Hinott's brewing follow-up to learn Poisons, even after the debuff is removed; resume unfinished class quests without restarting completed ones. Includes Simplified Chinese (thanks HershelW).
- Horde leveling guides: Kolkar Leaders is taken at Regthar on the level-20
  Barrens pass again, so Orcs and Trolls no longer fly Orgrimmar to the
  Crossroads and back before the zeppelin at 16, and the level-20 class quests
  in Orgrimmar are no longer written at level 16. The Gizelton caravan escorts
  in Desolace (Bodyguard for Hire, Gizelton Caravan) are left out: the caravan
  offers them only once per long loop, so following the guide meant waiting
  for it.
- Horde leveling guides: the Swamp of Sorrows is done in one stay around
  level 44. Report to Helgrum, Pool of Tears, Fresh Meat, the Soggy Scroll
  and the Misty Reed murloc quests are finished before the boat to Tanaris,
  so the guide no longer flies back from Orgrimmar through Grom'gol to
  Stonard at 45 and back again.
- In the other faction's capital (a Tauren in Stormwind) the walk out goes
  through the streets and the gate instead of over the walls and round the
  mountains, and a walk into such a town comes in by its gate; the town is
  still named on the step.
- Human leveling: Elwynn's east (Guard Thomas, Eastvale, the Tower of Azora)
  is finished in one loop before the walk west to the farms and the
  Westbrook Garrison, instead of crossing the zone back east from Westbrook.
- Human Paladins start The Tome of Divinity from Duthorian Rall at the
  Stormwind stop after Westfall, with no walk back to Goldshire; Henze Faulk
  is visited on the road east to Redridge and Redemption is learnt at the
  next Stormwind stop.
- Elwynn Forest (Human): on your first stop in Goldshire you hand Rest and
  Relaxation to Innkeeper Farley while you bind there, and take Gold Dust
  Exchange and Kobold Candles from Remy and William Pestle beside him, instead
  of on the way back from Crystal Lake. Bounty on Murlocs is taken from Guard
  Thomas on the first visit to the bridge.
- Pasting a long import string on the Import page no longer freezes the game:
  the box keeps only the string's beginning and its size.
- A crafted import string can no longer freeze or crash the game: Polestar
  refuses a string whose guide lists more spawn spots, predicates, jumps,
  reagents, sources, quest ids or names than any real guide needs, and stops
  shading a goal's spawn areas when it has too many spots to group quickly.
- After a /reload in Ironforge's gate the walk out no longer starts on the
  mountain above the gate and leads you over the peaks; it takes the road.
- Items a later step of your guide needs are kept: a lock marks them in your
  bags, their tooltip names the step, a merchant warns you before you sell
  one, and grey selling never takes them.
- The arrow's walking routes run on Leffe's navigation maps: his surfaces and
  floors everywhere, with the jumps and drops off ledges he found. Each
  continent's maps load when you get there (a journey to the other continent
  estimates the walks over there until you arrive), so Polestar holds only the
  one you are on, and a search keeps far less in memory than before (thanks
  Leffe).
- Westfall (Dwarf, Gnome, Night Elf and Skyborne): Murloc Gills is now handed
  in on the regular Sentinel Hill visit, with The People's Militia and
  Patrolling Westfall. You no longer walk down from Jangolode Mine just for
  it and then back north to the farms.
- Tanaris (Horde): Wastewander Justice and Water Pouch Bounty are taken in
  Gadgetzan when you arrive, before the ride to Steamwheedle Port, so you
  no longer ride back to Gadgetzan for them.
- Searing Gorge (Horde): Caught! is handed in at the outhouse as soon as it
  is done, not on a later trip back from Thorium Point.
- Ashenvale (Horde): Ashenvale Outrunners is handed in to Kuray'bin right
  after the kills, not levels later.
- A `level 18.6` grind line now counts as 60% of the way through level 18 when
  the guides are checked and when routes are planned, not as the start of 18.
  The check had timed Silverpine's two hearths to the Sepulcher as less than an
  hour apart for every Horde start.
- A "Reach level" goal says how much XP is still to go, and a target inside a
  level (level 12 and 40%) moves the XP bar's guide mark to that point of the
  bar.
- Walks that ride a lift now get on and off where the car actually stops.
  This covers the Thunder Bluff lifts, both Great Lift cars and both
  Freewind Post cars. Before, a landing could be a few yards off, on the far
  side of the car, or a step below it.
- Walks ride lifts: from the Undercity's lower floor the arrow takes you up a
  lift to the entrance hall instead of out through the sewers, and Thunder
  Bluff's and the Great Lift's crossings walk you to the lift and say "Ride
  the elevator up" or "down" instead of pointing over the edge.
- Lookup no longer builds a "Guide me" guide for a mount from its best source
  alone (such a guide left out level 40, riding and the gold, and read a rare
  drop as a plain kill). A mount with a guide of its own (the Warlock and
  Paladin class mounts) still opens it; any other mount's Alt-click opens its
  Lookup page, with where it comes from, its cost and what it needs, and its
  tooltip no longer says "Alt-click: guide me".
- Lookup: quest steps that Lookup builds, the dungeon pick-up guides among
  them, now know every place a quest's mobs and objects spawn, so the arrow
  takes the camp you are at or searches them one after another, instead of
  pointing only at the spawn nearest the quest giver (thanks Tazul).
- Abandoning a quest the guide had already taken you past no longer drags
  you back to its giver without a word. The guide stays where you are and
  asks: go back for it, or skip it along with the quests that follow from it.
- A waypoint clicked on the map where two floors lie close together (William
  MacGregor's house in Westfall) is walked to instead of pointed at straight.
- New map and minimap icons: one family of glyphs drawn for Polestar, each in
  a bevelled medallion, replace the mix of Polestar glyphs and game art. Kill
  objectives get their own glyph instead of the raid skull, mobs that drop a
  quest item a loot glyph, and every NPC service its own (vendors no longer
  share the banker's). Boats, zeppelins and the tram, and dungeons and raids,
  are told apart; a flight master you have not learned carries a "?"; the inn
  your Hearthstone is bound to is circled; a rare seen lately sits in a dashed
  ring; a city's services show how many they are. The icons sit at the size
  of the game's own map marks and grow as the map or the minimap zooms in
  (thanks Fitz). A mark held at the minimap's edge keeps its icon, with a
  pointer toward it. Appearance › Arrow › Map icons picks the medallion: the
  skin's (the default), Polestar's, Halo's, Hearth's, or glyphs alone.
- Sell grey items stops the sales still queued when you turn it off or hold
  Shift, and turning it back on does not start them again; a sale still
  running at one merchant no longer carries on at the next one you open with
  Shift held. Holding Shift also skips the repair and buying that would
  follow.
- Right-clicking the minimap button opens a small menu: show or hide the
  guide window, the guides, Lookup, the options, and Report a problem.
  Polestar also has an entry in the game's addon list on the minimap, where
  the client has one: a click shows or hides the guide window, a right-click
  opens the same menu.
- A goal the route does somewhere else no longer brings the old step's
  "walk here" lines with it.
- Mulgore: Sharing the Land points to the three Palemane gnoll objectives
  and tracks their remaining counts, including when the quest is already
  partly complete.
- On a client in another language the names of quests, NPCs, items and places
  take about 1 MB of memory instead of 3 to 4.4 MB, and loading them no longer
  spikes to 9-11 MB: the names stay packed until one is shown (#693).
- Walking routes on Darkcloud Pinnacle in Thousand Needles now cross the
  rope bridges to Arnak Grimtotem and Lakota Windsong along the top, instead
  of leading you down into the canyon and round by the Great Lift (thanks
  ddos, #374).
- In a step with several kill, loot or click objectives, the arrow leads to
  the nearest one instead of the first written (Garren's Haunt from Brill no
  longer sends you to Maggot Eye first). It moves on once another is clearly
  nearer or the objective is done, never in the middle of a fight; the list
  keeps its order and the marked row shows where the arrow is.
- Night Elf route: Teldrassil and Darkshore's first loop take you to about
  level 14, then you join the Alliance route in Westfall and come back to
  Darkshore with it, instead of finishing Darkshore first and doing Westfall
  with every quest grey. Night Elf Warriors earn Defensive Stance from
  Elanaria in Darnassus on the way through the city, not on a boat trip to
  Stormwind.
- The guides no longer ask you to grind to a level where the route doesn't
  grind ("Grind to 51" in Un'Goro, a Dire Maul note for the last levels).
- The guide no longer tells you to fly to the town you are already in, and
  two "go here" steps to the same spot in a row are now one.
- Map: NPC service and mailbox icons on zone and city maps, off by default
  (Map > Rares & travel > NPC services, or the map's tracking menu). Turned on,
  they show class trainers and mailboxes; repair, vendors, bankers, auctioneers,
  profession trainers, weapon masters and the rest are one click away. Tooltips
  list each NPC's services and a click sets the arrow there. On region maps,
  services in a city or another area with a detail map share one compact group:
  click it to choose an NPC. Minimap icons are optional. Flight masters and inns
  keep their own toggles under Dungeons and travel (thanks RikyZ90).
- A quest with two kill targets in one area is no longer reached twice: The
  Hammer May Fall's ogres and Boulder'gor share one trip to Arathi.
- From the Barrens and Westfall on, every race of a faction plays the same
  leveling guides. A trip that only one race or class makes (the Undercity
  zeppelin for an Undead quest, Moonglade for Night Elf Druids) is shown only
  to them, and quests your race can't take are hidden. Duskwood no longer
  shows the Thousand Needles notes or asks you twice for the Darkshire flight
  path. Undead Paladins hand Shadowvale's elixir bottles quest to Carolai
  Anise together with everyone else, instead of coming back to Brill from the
  Barrens.
- A goal you work "on the way" is no longer left optional when the later
  step that asked for it is gone, so the hand-in never waits on a goal no step
  shows (Mazzranache's parts).
- The options window has a new look: a gold rim of light along the top, a
  menu scale control in the header, every setting's description shown under
  its name, the settings of a section together in one panel, settings that
  depend on the one above them indented and dimmed while it is off, a dot on
  every setting you have changed with a reset button beside it on hover,
  and a live preview of the guide window and the arrow over Appearance's
  colours. Resetting a page, your guide progress or every setting now asks
  in a small dialog instead of a second click.
- Horde, level 38: off the zeppelin in Orgrimmar you now train there before
  flying to the Crossroads, instead of flying to the Crossroads and back;
  Druids and Paladins fly from Orgrimmar to Thunder Bluff to train and on to
  the Crossroads. Every race's riding lesson, and the trip to it, waits for
  level 40, and Gnomes learn to ride from Binjy Featherwhistle like the other
  races from their own trainer.
  The rare-drop chains (The Green Hills of Stranglethorn and its chapters,
  Study of the Elements: Rock) are optional extras: taken and handed in only
  if you have the drops.
- You can now follow another race's starting zone on your side, say the Human
  start as a Night Elf: the guide menu lists them under "Other starting
  zones". Polestar doesn't guide you there; the guide picks up when you
  arrive, and quests your race can't take are left out.
- When Polestar's own guides are switched off on the Community guides page,
  the guide window and the guide menu now say so (not "the community addons
  are switched off"), and the guide window has a Show Polestar's guides button
  that turns them back on
- The guide window's XP line now forecasts your pace: with the guide's
  quests and kills from here to its next level target, are you on pace for
  that level by that step, or about how many bars short. It needs the Codex
  (Lookup on).
- Playing with friends who share their progress, the guide window now shows
  where each of them is on the same guide ("Ana: 3 steps ahead"), a quiet
  "Still at it" when you're done with a step's objectives and they aren't,
  and a line to click that shares a quest of the step someone lacks. You
  also hear once a session when a party member has a newer Polestar or guide
  pack. Nothing waits on anyone.
- Custom gear scales now round negative weights correctly in Pawn exports,
  preserving penalties when edited scales are shared and reimported.
- The guide menu opens on your own faction again after you looked at the other side's guides on another character (the filter was saved for the whole account).
- The experience line under a step no longer runs out of a narrow guide window: it ends with "..." and hovering it shows all of it.
- Dungeons: picking up Wailing Caverns' quests now takes you to Thunder Bluff
  for Hamuul Runetotem and Nara Wildmane first, so Leaders of the Fang is in
  your log before the run. Talk-only quests ahead of a dungeon quest are done
  on the way instead of being left for after the run, which also brings Dark
  Iron Legacy, Dawn's Gambit, Into the Depths, Secret of the Circle and
  Amulet of Secrets into their pick-up guides. (thanks mcclaskiem, #519)
- Pin any quest as along the way (#644): right-click it in the quest log, or
  use the guide window's menu, and its open objectives join the Along the way
  list beside whatever step you are on, with their map marks, the target
  button and the arrow on a click, until they are done or you unpin it
  (right-click its row). A step ahead that turns the quest in while it is
  still open shows in the warning colour and says so. Pins are saved per
  character.
- A goal pinned to a point whose item's droppers have no known drop chance now
  marks the other places those droppers spawn, instead of a single pin
  (27 goals, among them Longshore Murloc Gills in Westfall and the Barrens and
  Tirisfal quest items).
- The route choice, the rare alert and the transport alert match the new
  welcome: a gold rim, a night header, and cards with a quiet hairline. The
  rare alert now reads top to bottom: what it is, how far, then what to do,
  with Set waypoint on the right.
- Alchemy and Enchanting guides: herbs and ore up to Journeyman are picked in
  your own starting area (Night Elves in Teldrassil, Tauren in Mulgore, Undead
  in Tirisfal, Skyborne on Zephras Isle) instead of on your faction's other
  continent. Alchemy levels on trainer recipes from 75 to 265 (Elixir of
  Wisdom, Lesser Troll's Blood Elixir, Mana Potion) instead of two
  limited-stock recipes and 58 Swiftthistle. Enchanting runs on Strange Dust
  from 25 to 130 (Chest - Inferior Stamina, Cloak - Minor Protection) instead
  of 100 Lesser Magic Essence and a limited-stock formula. Rank prices are
  shown, rods' materials say which rod they are for, Shadowgem and Black Pearl
  are no longer sent to a farm spot that drops one in a hundred kills or
  worse, and Stonescale Oil counts are right.
- Crafting profession guides: an Expert or Artisan rank that only a few
  trainers teach (Ainethil or Doctor Herbert Halsey, Kylanna Windwhisper or
  Rogvar for Alchemy; Kitta Firewind or Hgarth for Enchanting) now comes after
  the bracket's shopping and gathering. You bring everything, train, craft on
  the spot and learn each later recipe there, one trip instead of three. A
  herb, ore or leather the bracket before also needs is gathered there in one
  go (Alchemy picks 152 Briarthorn at once, not 128 and then 24 more after
  Expert).
- Cooking and First Aid guides: Cooking levels 130-225 on Curiously Tasty
  Omelet (Alliance), Hot Lion Chops (Horde) and Roast Raptor instead of
  clams and spider meat, with every Clamlette Surprise item gathered before
  one trip to Gadgetzan and Monster Omelet to 300; Night Elves start on Herb
  Baked Egg instead of fishing; the Basic Campfire Kit explained. First Aid
  switches to Heavy Mageweave at 240 and warns to turn Triage in at once.
- Alchemy, Blacksmithing, Enchanting, Engineering, Leatherworking and
  Tailoring guides rebuilt from Forever's trainer lists: each explains the
  profession and Forever's changes, lists the route and the shopping per
  rank, names who teaches each rank (Expert and Artisan only where they
  really are taught), the camp item at 20, the sellers and stock of every
  recipe to buy, where each material comes from, and the specialisations.
  Merchant's Favor patterns are no longer priced in gold, recipes taught
  earlier on Forever are learned when the trainer offers them, and parts
  such as bolts of cloth count towards the skill.
- Profession guides (First Aid, Cooking, Fishing, Mining, Herbalism,
  Skinning): Skyborne get Zephras Isle routes; Forever's trainer skills and
  prices (Cooking's trainer path, Heavy Linen at 40), smelting steps,
  Forever's starting-area nodes, camping items and Camping 101, costs for
  every rank, recipe and book, clams opened for clam meat, and routes from
  every known node.
- Leatherworking guide: Expert is one visit to Telonis, Una, Drakk Stonehand
  or Hahrana Ironhide (train, craft there, learn Thick Leather and Thick Armor
  Kit on the spot), not three; only Rugged Leather at 205 is a second trip, to
  Drakk or Hahrana. Heavy Leather is skinned once (308), not twice.
- Tailoring guide: 205-225 now uses Mageweave (Black Mageweave Vest and
  Headband, 900 Mageweave in all) instead of Runecloth from level 56-59 mobs at
  about character level 44; Runecloth starts with Artisan.
- Profession guides send an Undead to Hillsbrad and a Night Elf to Stonetalon
  or Thousand Needles when no spot is near their starting area, rather than
  across the sea (Medium Leather, Heavy Leather, Heavy Stone).
- Professions: the Skinning, Mining and Herbalism guides no longer ask for
  level 5 first; they're learned at level 1, and the arrow can lead to the
  Junior trainer in your starting zone (thanks Schpune).
- Quest log and objective tracker menus open Polestar's guide search for
  that quest, showing its matching steps without changing the active guide
  (thanks RikyZ90).
- A full quest log no longer catches you out at a quest giver: on a step
  whose quests won't fit, the guide window says so and names the quests to
  let go, starting with ones the route never hands in. Make room (or
  `/polestar questlog`) lists those quests with an Abandon button each, which
  asks in the game's own window first. Nothing is abandoned for you.
- The quest database (quest markers, available quests, quest tooltips) takes about
  1.2 MB of memory instead of 6.6 MB once loaded, and loading it no longer spikes
  to 12 MB: its records stay packed until one is read (#693).
- The leveling guides for your race now take about 2 MB of memory instead of
  tens: only your own class's route is read in, and of that only the guides
  you have open hold their steps in full.
- The route now goes up short flights of stairs and ramps whose foot the
  walking maps used to miss. One is the top flight of the zeppelin tower
  outside the Undercity, where the zeppelins dock. Another is the bell tower
  steps in the Ruins of Lordaeron. Before, the arrow either stopped at the
  last landing or went a long way round.
- Warlocks: the class training reminder and `/polestar near class` know
  Strahad Farsan in Ratchet trains warlocks, though he has no Warlock Trainer
  title, so a warlock in the Barrens is sent to Ratchet instead of Durotar or
  Orgrimmar.
- Polestar Recorder, rebuilt for the recording program: it writes compact
  chunks (about 50 KB an hour of play instead of megabytes) with no character,
  realm or account names, and records what the guides need most: kill pace
  and kill XP, drops counted against what your quests still needed, which
  quests each NPC offered you, trainer and vendor lists, flight times, item
  uses and gossip choices. Chunks Polestar Client has sent are cleared at
  your next login. What it records, field by field, is in docs/RECORDING.md.
  Recordings from the old Recorder are cleared once.
  Start sharing in Polestar Client is the only switch: the Recorder turns
  itself on at your next login and says so; `/psrec off` keeps it off until
  `/psrec on`.
- Report a problem: the Addons line names every addon you have on. It was cut
  after about five names; now it is only shortened when the whole report would
  not fit one Discord message.
- Reputation guides rebuilt from Forever's data: every standing band now says
  how much each turn-in, kill or run pays, how many you need to the next
  standing, where the items come from, when kills stop counting, and what
  the quartermaster sells at each standing and for how much.
- New reputation guides: Wintersaber Trainers, Brood of Nozdormu, Zandalar
  Tribe, Steamwheedle Cartel (with Forever's new goblin-town quartermasters),
  Bloodsail Buccaneers, Ravenholdt, the Gelkis and Magram centaurs,
  Darkspear Islands, Nightclaw Druids and the Kirin Tor.
- Restock: set how many drinks, how much food and how much ammunition this
  character keeps (Quality of Life > Vendors > Restock), and any other item
  such as reagents with `/polestar restock <item> <amount>`. At a merchant
  that sells what you are short of, a Restock button under its window buys
  the rest: the best drink and food for your level, and arrows or shot for
  the weapon you wear. Nothing is bought until you press it.
- Accept resurrections accepts only the offer it was waiting on: when another
  player's offer replaces it (even one it declines, from a caster in combat),
  the offer changes or is withdrawn, you come back to life or die again, or
  the setting is turned off and on during the corpse delay, the waiting offer
  is dropped; a new offer it accepts waits out its own delay.
- Horde leveling guides, Hillsbrad Foothills and Alterac at 33: Elixir of
  Agony (the Strong Troll's Blood Potion chain) is optional from its first
  step, so players without the Alchemy potion no longer walk down to the
  Daggerspine and Torn Fin shores and the Shindigger keg for it. Helcular's
  three flames are lit in one Alterac stop before the grave, without a walk
  back to Tarren Mill between them.
- Horde leveling guides, Silverpine Forest: Troll Priests hand Hex of
  Weakness to Ur'kyo on the Orgrimmar stop at 19 instead of riding the
  zeppelin to Orgrimmar and back right after reaching the Sepulcher.
- Horde leveling guides: The Sacred Flame is no longer picked up in Thunder
  Bluff at 29 and carried to 57.
- Tauren Druids hearth back to Thunder Bluff from Moonglade again: the guide
  kept the Thunder Bluff bind but had lost the hearth that uses it.
- At the Crossroads, Tauren take The Forgotten Pools from Tonga Runetotem as
  they hand him The Barrens Oases, instead of walking back to him later.
- Dwarf and Gnome leveling guide, Dun Morogh: the east of the zone is walked
  once. After Brewnall's second visit and Tundra MacGrann's stash, the guide
  goes east through Kharanos and Steelgrill's Depot to Misty Pine Refuge,
  Amberstill Ranch, Farsen and the Gol'Bolar Quarry, Helm's Bed Lake, the
  South Gate and the North Gate, and back west to Ironforge, instead of
  hearthing back to Brewnall halfway and crossing the zone two more times.
- The Stormwind flight path is taken when the tram arrives, so the later
  trips from Westfall to Stormwind are a flight instead of a walk.
- Horde leveling guides, the Barrens and Stonetalon at 21-24: Stepping Stones
  and Scramble (the Cozy Sleeping Bag chain) are no longer written: Stepping
  Stones is only offered at the second Burned-Out Remains, in Westfall for
  the Horde, which the route never visits.
- Horde leveling guides, the Sludge Fen: the druids' Strange Lockbox step
  shows only while Trial of the Sea Lion is in the quest log; the box gives
  its half pendant only to players on that quest.
- Mulgore: in Thunder Bluff each class trains at its own trainer's rise
  (Warriors and Hunters on Hunter Rise, Shamans on Spirit Rise, Druids on
  Elder Rise) instead of being sent off from Cairne's tent and back.
- Mulgore: Kyle the Frenzied is fed in Bloodhoof Village (the step said
  "Thunderhorn Water Well"), and the guide says the plainstriders at the well
  drop his Tender Strider Meat.
- Tauren Druids bind with Innkeeper Pala and take Heeding the Call while
  buying the incense parts on the central rise, and take Jahan Hawkwing's
  A Bundle of Hides chain on the flight back to Turak (about 1,900 XP).
- Human leveling guide, Elwynn Forest: no second walk east from Goldshire
  at level 10 for Bounty on Murlocs alone, and no trip back to Goldshire
  from the Westfall road for The Collector (a rare drop at the last stop
  before Westfall) or its Manhunt. Both are left out.
- Dwarf leveling guide: Wanted: "Hogger" is no longer sent through
  Westbrook between the tram and Stormwind.
- Horde leveling guide, Silverpine Forest at 16: after the Sepulcher's flight
  path and quests you go straight on into the forest, instead of riding the
  zeppelin back to Orgrimmar to train and taking it out again. You train at
  Razor Hill on the way to the zeppelin.
- Horde leveling guide: Stolen Booty is handed to Gazlowe before you fly out
  of Ratchet; The Engraved Ring is taken at the Sepulcher and handed to
  Magistrate Sevren in Brill on the way to the zeppelin at 19, not on a Brill
  stop of its own at 36; Rilli Greasygob gets Wenikee's letter on the
  level-19 Orgrimmar visit, not at 51; in Tanaris, Gadgetzan comes before
  Steamwheedle Port, so the Gadgetzan flight path is taken on the way in.
- Horde leveling guide, Hillsbrad at 33: the step back to Tarren Mill no longer
  tells you to hearth while your hearthstone is set to Shadowprey Village.
- Horde riding at 40: the Troll, Tauren and Undead steps no longer suggest
  trying Kildar in Orgrimmar first; he teaches other races only at Exalted.
- With reward auto-pick on, a reward whose link, sell price or gear verdict
  had not arrived yet could be taken as if it were worth nothing, so the wrong
  item was picked. Auto-pick now leaves the choice to you until every reward
  is known, and a pending pick is dropped when another quest's rewards are
  showing or auto-pick is turned off and on again.
- At levels 40 and 60, if you have not yet learned riding, a banner appears
  in the guide window: the cost (100 g / 1,000 g, 10% off at Honored with
  the home faction) and your balance. "Take me there" points the arrow at
  your race's riding trainer when you can afford it, or appears straight
  away when the gold comes in. Warlocks are pointed to Strahad Farsan
  (Summon Felsteed chain); Alliance Paladins to Lord Grayson Shadowbreaker
  (Tome of Nobility). Each tier shows once per character. Turn it off under
  Quality of Life > Vendors > Trainers > Riding reminder.
- Alliance rogues: prepare for lockpicking on the shared Stormwind visit,
  and explain safer practice at Alther's Mill (thanks HershelW).
- Rogue solo jobs: explain the half-keys, Scarlet Monastery wing order and disguise, and C's follow-up mail before the payment. Add Vanish preparation and clarify that the Eye's data minimum does not guarantee its invitation. Includes Simplified Chinese.
- Quest items sold by a vendor are bought where the route already stands in
  town, also before the quest is taken: the Horde buys Soothing Spices in
  Orgrimmar on the way to Dustwallow Marsh instead of flying back to the
  Barrens for them. A buy no longer counts as made at a vendor the route
  passed many levels earlier; it has to be within the hour before the quest.
- Generated leveling guides no longer send Humans, Dwarves and Gnomes to
  Darnassus just to train: the route planner now counts what a training costs
  the classes a town has no trainer for even when none stands on its island
  (Paladins, Mages and Warlocks on Teldrassil; Hunters, Shamans and Druids in
  Undercity), and trains in Stormwind or Ironforge instead.
- Long level grinds are split into top-ups of at most a quarter of an hour,
  spread over the camps before them (and the zone before, when the grind comes
  at the start of a zone), each after the hand-ins waiting nearby: the
  Alliance's Feralas, Tanaris, Un'Goro and Burning Steppes grinds of several
  hours in one go are now short top-ups.
- Those top-ups are mostly not steps of their own: right after a camp, the
  camp's step holds the level ("kill on until level 52.3"); top-ups close
  together in a zone become one, and a short one goes into the next camp's
  step or is left out (the Human guides: 88 top-up steps down to 26).
- A camp is worked in one go: when the route used to do part of a camp, talk
  to someone there (Guard Parker, Kalaran Windblade, Smeed...) and then come
  back for the rest, the camp's objectives now go together and the talk comes
  before or after them.
- Generated leveling guides come back to the same ground less often: work
  done on a trip of its own, when the route returns to that ground later
  anyway, is done on the later visit. Feralas no longer rides west for the
  Rogue Vale screechers, hearths back to Camp Mojache and crosses the zone
  again to Zorbin's giants beside them: one trip does both.
- Generated leveling routes take a quest together with the quests it opens
  when the chain is worth it, fold a trip back to a town for a single hand-in
  into the next visit there, and train within four levels of a new rank
  instead of carrying it for five or six. Grinding that is left in a route
  is written as short top-ups at the camps you are already at, and a skipped
  quest now says which rule kept it out. The Buzzbox chain in Darkshore is
  back in the Alliance route, and A Free Lunch, Raven Hill and Philmor's
  Favor are no longer listed as skipped for a player report they never had.
- Routes do more at once: mobs of every open quest that live on the same
  ground are counted as they are met, so overlapping kill quests are held open
  and done in one pass; a quest open on an earlier visit to its giver can be
  taken then and done beside that work; cloth donations are handed in where
  they are taken.
- Routes learn a flight path whose flight master they walk past on a trip by
  tram, boat or flight: Stormwind's when the Deeprun Tram arrives, Gadgetzan's
  on the way from Freewind Post to Steamwheedle Port. Later trips there can
  then fly.
- The routes use your hearthstone when it is ready and saves 3 minutes or
  more, not only where the old guides hearthed (no more long flights home with
  the stone ready).
- The leveling guides' level ranges come from the route itself: a start's own
  part of a zone the shared route visits later shows its own levels (the Night
  Elves' Darkshore 12-14, Orc and Troll's Barrens stop 12-13), so the guide
  list reads in rising levels. Orc, Troll, Dwarf and Gnome guides carry only
  their own race's steps, without the other race's class lines.
- A quest is moved to an earlier visit to its quest giver only when the route
  already stands next to that giver, not 100 yards away: Rest and Relaxation
  is no longer a detour of its own from Northshire Abbey to the stables at
  level 1.
- Generated leveling routes now do what is ready at a town in one visit:
  every quest you can take and every quest you can hand in there, in one
  walk through the NPCs, instead of sending you past givers you come back to
  later or back and forth across town (Brill, Deathknell). A hand-in or a
  quest whose NPC you walk right past is done on the way (#736, #740).
- The route no longer hearths to the inn it is standing next to: Alliance
  guides used the hearthstone in Lakeshire, a few steps from its inn, while
  walking the long way back from the Blackrock camps. The hearth now goes on
  that walk back.
- Far waypoints: every walk of the route is drawn along the ground on the map
  and minimap within a moment of setting it, instead of straight lines across
  mountains until each walk had been searched in turn, and the walk on from a
  zone crossing (out of Thunder Bluff off its lift, on from the Barrens into
  Stonetalon) is walked by the arrow along the path instead of in a straight
  line.
- Generated leveling guides cross the sea fewer times: a short trip to the
  other continent that the route makes again soon after (Night Elves sailing
  to Stormwind at 13 to train and hand in A Fishy Peril, back to Auberdine,
  then to Westfall a level later) is done on the later crossing.
- Night Elf guides take Fruit of the Sea in Auberdine before the Buzzbox 827
  crawlers again, so the crab chunks drop on the same shore loop. The shared
  route had pulled the crawlers ahead of it.
- Leveling routes never plan a hearth while the Hearthstone is still on
  cooldown, no longer send you to kill mobs more than three levels above
  you (Khan Dez'hepah in Desolace, Lieutenant Fangore in Redridge), and
  take The Green Hills of Stranglethorn as soon as it is offered.
- Generated leveling guides grind less from 30 to 60: the route planner now
  counts an hour of grinding as two and a half when it compares routes, so it
  takes the quests that are nearly as fast as grinding instead of grinding
  (Bracers of Binding, Helcular's Revenge, Alliance Relations, Silver Heart and
  more for the Horde). A zone can now be visited later, when its quests are on
  level, and a zone's low quests earlier as their own visit; a level grind waits
  until just before the quest it is for; a quest the game would refuse because
  you are a little under its level gets a level step right before it; and a
  breadcrumb is handed in before its follow-up is taken at the same quest
  giver.
- The route planner can go back to a quest hub at the level its quests open
  when their quest XP pays for the trip (the Alliance route now takes Sully
  Balloo's and the Thandol Span quests in Arathi at 30 instead of grinding).
- A fix to the leveling order can no longer take a quest before the quest
  whose hand-in opens it: Night Elves get the Crown of the Earth chain back
  in Teldrassil. When a fix can only be kept that way it is left out and named
  in the build report instead.
- Fixes from player reports and reviews of the leveling order no longer get
  lost when another fix moves the same steps: every "this before that" and
  "do these together" fix is repaired again until all of them hold. Elwynn
  Forest hands Collecting Kelp in before Marshal Dughan's turn-ins again, and
  Teldrassil does the Webwood lurkers for Zenn's Bidding and the Recipe of the
  Kaldorei's spider legs in one pass. When two fixes ask for different things
  at the same step, the player report wins and the other is named in the build
  report.
- Riding is learned on the first visit to your riding trainer at level 40
  (an Orc in Orgrimmar at 40 no longer waits until 45), and the routes count
  the mount from there.
- Tauren, Undead and the other starts that join another race's route in the
  Barrens get their own quests on the way again: a rule read off a start's own
  old guide that the shared Barrens route breaks (the Tauren's Prowler Claws
  before Stalking the Plains) no longer stops every quest from being added to
  that start's own zones. Preparation for Ceremony and Rites of the
  Earthmother can now come into the Tauren route.
- Skyborne (Alliance): leaving Zephras Isle, the guide now follows the
  skycutter to Denaaris Stargale in Alterac and the Skyborne Portal to
  Stormwind, instead of sending you round the world on four boats.
- Kills a fix asks to do together with another quest are planned at the camp
  by that quest for every kind of mob that drops them: Undead guides take the
  Vile Fin skins by the Crusader's Outpost and keep Maggot Eye in Brill's
  north sweep instead of a walk to Garren's Haunt at the end of the west loop.
- A town's flight path is learned when the route trains there, even when the
  flight master stands a few hundred yards from the trainers: Horde guides
  pick up Thunder Bluff's flight path at the 28 training instead of riding
  through Mulgore to Thunder Bluff at 50.
- Class training is placed where it teaches something: a trainer visit with
  no new rank is left out (Northshire at 3.06, a second Goldshire stop at 9.7),
  a pass by a trainer town with a new rank gets one, and a profession's
  training line is no longer counted as class training.
- Generated leveling guides make fewer trips just to train: a class training
  that has waited a few levels now happens on the route's next visit to a
  trainer town (Ironforge or Stormwind when the route is there anyway), a trip
  for it never takes a boat or zeppelin, and one the route's own next training
  soon covers is left out (the Alliance's Stormwind trip from Darkshore at 16).
- The Alliance no longer trains in Darnassus on the way through: Humans,
  Dwarves and Gnomes have classes with no trainer there, so the route trains in
  Ironforge or Stormwind instead.
- A planned hearthstone bind or flight path is only taken where you stand at
  that inn or flight master: no more "bind at Ratchet" from Shady Rest, and a
  flight path is learnt when the route reaches it. Quests the route fixes
  skip are left out of the written guide.
- Leveling routes no longer hand out a quest at the very end that you can't
  finish before 60 (Of Lost Honor in Silithus).
- Leveling routes walk past fewer ready hand-ins. The route is checked on
  the guide as you walk it, flights and boats included, and a quest ready
  at a stop you pass is handed in there. Cloth donations are handed in when
  you take them, a capital visit a level before the next one waits for it,
  class training sits at the town instead of in the middle of field work,
  and a lead-in quest is handed in before its follow-up is taken.
- Items a quest asks you to buy are bought at a vendor the route already
  passes (Soothing Spices in Ratchet on the way into Dustwallow Marsh), and
  an object quest's items are gathered where the zone's other work is (the
  Well Stones at Winterhoof Water Well).
- Zephras Isle: the routes can bind at Shen'dar Village and Valanaar, and
  take the Portal To Rohashi Spires up to Lorthuna.
- Generated leveling guides no longer walk over borders there is no way
  across: a walk from one zone into another now has to pass a known zone
  crossing. Gone: Thunder Bluff over the mountains into Desolace (flown to
  Shadowprey or walked through Stonetalon instead), Theramore along the coast
  to Gadgetzan (the Barrens road and the Great Lift), the climb from the Swamp
  of Sorrows into Redridge (Deadwind Pass), Feralas straight into Silithus,
  Moonglade straight down to Darkshore, the Searing Gorge's locked gate into
  Loch Modan, Stonetalon into Mulgore, and the drop down the Undercity's lift
  shaft (the lift is taken).
- The Riverglades' ways on foot to Redridge, the Badlands and the Swamp of
  Sorrows, and the Southfury River between Durotar and the Barrens, count as
  crossings, as do Orgrimmar's west gate, the Barrens road out of northern
  Dustwallow, the northern way between the Plaguelands, the western way from
  Stranglethorn into Duskwood, and the swims from Westfall up the river into
  Stranglethorn and from the Alterac Mountains across Lordamere Lake.
- The leveling routes are rebuilt from the game's data: each race's own
  starting zone, then one Horde route from the Barrens and one Alliance route
  from Westfall to 60, the same for every race of a faction. Before shipping,
  the guides are played through the way you follow them, and a step that
  can't be done as written is refused. No hearth while the stone is cooling
  down, the orders players reported as wrong are followed, quests that need a
  rare drop are optional extras, towns are swept in one visit, class training
  comes on the way, and you walk past fewer open quests and grind less.
- Redridge (Alliance): the Blackrock Champions are killed on the same trip
  north as Corporal Keeshan's escort, after the Battleworn Axes are handed in,
  instead of a separate trip to Render's Valley before the hearth.
- Wetlands (Alliance): From the Ashes is taken from Captain Stoutfist only
  once War Banners is handed in, as the game offers it.
- Dwarf and Gnome leveling guide, Dun Morogh: Hunters, Shamans and Priests
  take their level 10 class quests in Kharanos right after the hearth again,
  so Hunters tame their pet there instead of walking back from Ironforge.
- Ironforge is visited once, at the end of Dun Morogh on the way to the
  tram, after the Dark Iron Spies and Senator Mehr's troggs, instead of a
  trip up to the city and back out to Helm's Bed Lake.
- Farsen's Watch is taken after A Visitor to Dun Morogh is handed in to
  Earthseer Farsen.
- Dwarf Paladins' Tome of Divinity says it needs level 12 before Ironforge.
- Tauren leveling guide, Mulgore: Hunters take Taming the Beast straight from
  Yaw Sharpmane on their last Bloodhoof visit and hand Training the Beast to
  Holt Thunderhorn during the Thunder Bluff stop. They no longer fly back to
  Thunder Bluff from the Crossroads and back again.
- Druids make Thunder Bluff their home with Innkeeper Pala before Teleport:
  Moonglade, so the hearth home lands next to Elder Rise instead of in
  Bloodhoof Village.
- Rite of Vision is taken from Baine and Zarlman Two-Moons on your first
  Bloodhoof visit, together with the quest that leads to it.
- Routes now take elite and group quests where they beat grinding: soloable
  elites like Bhag'thera and King
  Bangalash, and group quests sized from Forever's creature data (a group of
  2, 3 or 4). Bosses stay out. Each one asks you first, and if you skip it the
  guide has you grind its XP back right after, so you reach the same levels as
  a group would.
- The Eastern Plagues (Alliance) no longer counts as a group quest: it never
  needed Nathanos Blightcaller killed, only the three SI:7 Insignias.
- Routes buy a quest item a vendor sells near the quest giver instead of
  farming it from a rare drop (Look to the Stars' Bronze Tube in Darkshire).
- Westfall (Alliance): Red Leather Bandanas count from the Defias you kill for
  the People's Militia, instead of a separate trip to Moonbrook.
- Map: nearby observations of the same service NPC share one icon, including
  Zephras Isle's repair vendors and observations on overlapping maps. Grouping
  on the same map also works without world-coordinate conversion. Different NPCs
  and distant locations stay separate; clicking keeps an original destination. Vendors use the native
  vendor icon instead of the banker's two sacks (thanks RikyZ90).
- Skip one quest: right-click its line in the guide window, Skip this quest.
  The guide drops it and the quests that follow from it, in every guide, while
  the other quests of the step stay; the banner's Undo, or a right-click on
  the line, brings it back. It works for a quest already in your log too.
- Notes that told you to skip a quest, or said it is not on the route, are
  gone where the route now takes that quest.
- Each start's way onto the shared route (its hearth, its zeppelin tip) is
  now its own, written in the start's own guide.
- At the step's NPC, Polestar now picks the chat option the guide names, or
  opens the goods or training the step needs, on the step the guide is at.
  Hold Shift to choose yourself; turn it off under Questing > Quests, "Pick
  what the step asks for".
- With the flight map open, the step key now takes the flight the guide
  marked, once it has checked you can reach the node and pay for it. Looking
  at another step leaves the key alone, and nothing flies without your press.
- New, off until you turn it on (Questing > Buttons, "Step key talks and
  loots"): once the step key has your target on the step's NPC, the next
  press talks to them; on the corpse of the step's mob it loots; and in the
  step's quest window it accepts, continues or completes. It only ever acts
  on the step the guide is at, and only out of combat.
- A step the route split off is now named for the quest giver it sends you
  to (Deputy Willem, not Eagan Peltskinner; Senator Mehr, not Earthseer
  Farsen).
- Walking out of Stormwind (or any capital whose streets are open to the sky)
  no longer sends you along the canals and over the mountains: the walk
  starts on the street and leaves through the gate.
- A step with several things to kill or collect now lists them in the order
  you meet them, starting from where you come in, and a named, tougher target
  comes last. In Tirisfal Glades, the Rot Hides just north of Brill now come
  before Maggot Eye on the far hill, and the tips follow the same order (Fitz).
- Town visits keep the quest orders players reported. Quests you can only
  take at a certain level wait about a level longer in the starting zones
  (Gordo's Task, #739). A campfire or emote right beside a quest giver is done
  while you are there, so you don't come back to it later (Kaga Wildhoof in
  Bloodhoof Village). A quest's steps on the shared route show for every race
  that can take it (Testing the Wells). The Scalding Mornbrew is handed to
  Durnan first in Anvilmar, before it goes cold.
- A quest you start in the middle of a field step, from an item you find
  there, is now always listed before its own goals. In Felwood's Jadefire
  Run, the Flute of Xavaric's quest comes before the Felbind it asks for,
  so the guide no longer asks you to collect for a quest you don't have yet.
- A field step's goals that name only their quest (no objective number) are
  now listed in the order you meet them too. On the Lakeridge Highway the
  arrow no longer runs from the gnolls south to the poachers and back north
  to the thrashers.
- Right-click a guide tab and pick Choose guide to switch that tab to another
  guide without closing it.
- Talent plan labels use localized spell names from the client while the live
  talent tree is unavailable (thanks HershelW).
- Talent plan source descriptions follow the client language instead of
  leaving English prose inside a translated page (thanks HershelW).
- The Target button names a mob for every open goal of a step: on Teldrassil's
  Zenn's Bidding it tries the owls and spiders as well as the Nightsabers,
  which used to fill its list (thanks Pynte, #571).
- Teldrassil: Ferocitas the Dream Eater has you loot the Gnarlpine Necklace
  from Ferocitas first, then open it for Tallonkai's Jewel, instead of
  looking for the jewel straight away (thanks Pynte, #619).
- Teldrassil: accept Soft Saber Pelts (87288) from Aldia on the first Dolanaar
  stop so both Nightsaber quests are done in the same east loop as Zenn's
  Bidding, not a separate pass (closes #555).
- Teldrassil: the Oracle Tree Bark's own quest, Teldrassil (440 XP), is taken
  right after The Oracle Tree and handed to Fandral on the Darnassus visit
  that already goes to him (thanks Pynte).
- Teldrassil (Night Elves): Drained Vessel and Moonwell Remnants are handed to
  Lariia and Tyrande in the Temple of the Moon on your first walk through
  Darnassus, so Westfall no longer ends with a boat, a flight and the portal
  back up to Darnassus before Darkshore.
- Shadowglen: Githyiss the Vile is killed on the Webwood Egg trip to the back
  of Shadowthread Cave, and his fang is handed to Gilshalan with the egg,
  instead of a first walk to the back of the cave on the venom trip.
- A Text size setting (Look > Colour & type) makes Polestar's text larger or
  smaller, from 80% to 140%, without scaling the windows. It changes at once,
  no reload.
- Fewer Polestar folders, and one tidy line for them in the AddOns list: each
  language's guide texts and game names now share one folder
  (`Polestar_deDE`, `Polestar_frFR` and so on) instead of a `Polestar_Guides_`
  and a `Polestar_Names_` folder each, and every Polestar folder sits under
  its own "Polestar" heading, which folds away with its arrow (#510). When
  updating, delete the old Polestar folders first; Polestar reminds you at
  login if the old language folders are still there.
- An item that runs out is now picked up on the way to where you use it,
  instead of early with a walk back: Kerlonian's horn chest is taken when you
  escort him, not at 19.
- When the route splits a step, each part now keeps the tips about its own
  quest givers, from every tip line of the step, and a moved sentence starts
  with a capital.
- Tirisfal Glades: the Doom Weed for Junior Apothecary Holland is no longer
  listed "on the way" during the trip west to Solliden Farmstead, where none
  grows. It is picked in its own step in the graveyard fields north of Brill.
- Tirisfal Glades: Gordo walks the road between his spot west of Cold Hearth
  Manor and the edge of Brill. The step where you take his quest now says so,
  and the step where you ask him for his report leads you along his road from
  Brill's side until you meet him (thanks yiliev0).
- Tirisfal Glades: every class goes down into the Shadowvale basement once,
  after Leonid at about 12, for That Shadowvale Green Elixir (Paladins do Hilda's
  and Ephram's quests in the same step), instead of at 9-10 on the west loop,
  where its Mystics are a real danger. Gordo's Task is handed in after the
  hearth back from Calvin's duel, so the fields west of Brill are one trip, and
  the murloc skins for Hides for the Forsaken come from the shore by the
  Crusader's Outpost. The Solliden step no longer says Calvin wants a duel
  before he can offer it (#742).
- When a town has no trainer for your class and you won't pass one soon, you
  now train at the route's next training stop instead of being sent across the
  sea (Darnassus after Ironforge).
- A town visit now has one training stop, the later one, not two.
- Learn new spells stops buying as soon as you turn it off or hold Shift
  while it is learning, and turning it back on does not pick the cancelled
  run up again. A spell already paid for when it stops is still listed in
  the "Learned" line.
- The AddOns list names the Undead guides folder "Polestar Guides (Undead)" in
  English too, not "(Scourge)".
- Tirisfal Glades, Undead Paladins: the guide no longer sends a level 8-9
  Paladin down into Shadowvale's basement for the elixir bottles. Paladins take
  A Second Home from Shari Stilwell in Brill, and at Bandarion Keep do Murlocs
  at the Gates (a weapon) and Touring the Grounds to Danitha Morr; the bottles
  come with Hilda's and Ephram's quests on one Shadowvale trip after level 10.
- In the Undercity's canals and on the ring the arrow no longer loses the lift
  at some spots and points at the entrance hall above you: with your floor not
  yet known, the walk starts only on the floors you can be on. (thanks Fitz)
- In the Undercity the arrow no longer breaks a walk into "Walk to the Ruins
  of Lordaeron cave mouth" steps that point at spots inside the city. Walks on
  the Ruins above no longer stop at them either. A cave or building entrance
  now only counts when it is on the floor you are walking.
- In and out of the Undercity the arrow now takes one fixed way, by the south
  lift, through the entrance hall and out of the front gate (the way Fitz
  walks it), instead of switching between the three lifts as you move. (thanks
  Fitz)
- Leaving the Undercity, the arrow keeps you on the way out through the Ruins
  of Lordaeron's courtyard and gate instead of sending you back down the
  lift to start again (thanks Fitz).
- In the Undercity's Trade Quarter, right under the entrance hall, the arrow
  no longer takes you for being in the hall already and points north through
  the Ruins: it sends you to a lift to ride up. (thanks Fitz)
- New, off by default (Map > Guide & quests, "Numbered pins for the steps
  ahead"): small numbered pins on the world map and minimap show where the
  next few steps take you, fainter the further ahead. Steps in the same spot
  share one pin, with all of them in its tooltip. The count follows Up next.
- Two new key bindings (and gamepad chords), Next waypoint and Previous
  waypoint, move the arrow through the step's places: the next spawn spot of
  a mob that roams, else the next goal of the step that has a place.
- Leveling guides: when the route already stops in Stormwind, Ironforge,
  Darnassus, Orgrimmar, Thunder Bluff or Undercity at level 10 or later, a
  short step after your class's own step there suggests the weapon skill your
  class levels with from that city's weapon master: two-handers for Warriors
  and Paladins, Staves and (from 20) Polearms for Hunters, Swords for Rogues,
  Staves for Priests and Warlocks. It shows only while you can pay for it (10
  silver, Polearms 1 gold) and have not learned the skill, and never sends you
  on a trip of its own (#655).
- Gear upgrades from kills, chests and merchants: when a new piece in your
  bags is an upgrade for your spec (with Gear advice on), the guide window
  offers to put it on. Nothing goes on until you press Wear it, and Not this
  one stops it asking about that item on this character. Turn it off under
  Questing > Rewards & gear > Loot and merchants.
- The welcome has a new look: a wider window under a night sky with your
  start zone's painting faintly in it, cards that show the guide window, the
  arrow and the guide list in miniature, colour scheme cards drawn in each
  scheme's own colours, a map of your guide's first walk on the Route style
  page, and a calmer start page that says what Start guide does.
- Westfall: Poor Old Blanchy's oats are gathered in the Jansen Stead's fields
  on the way back to Verna, instead of the arrow searching every Sack of Oats
  in the zone as you arrive (thanks Xaden Ryan).
- Wetlands: the grind to level 28 for Pilot Longbeard's quest now comes after
  the hand-ins in Menethil Harbor, at the Dragonmaw camp on the way east, so
  their XP counts towards it (thanks Ioney).
- The Excavation Site: Wetlands pick-up guide has you do Young Crocolisk Skins
  for James Halloran first: he offers Highland Hides only once it is handed in
  (thanks Visur).
- Ashenvale, Wetlands & Stonetalon Mountains: Digging Through the Ooze leads
  to the oozes at Ironbeard's Tomb, where the quest sends you, instead of
  cycling through every ooze in the Wetlands (thanks Ioney).
- The Excavation Site: Wetlands pick-up guide no longer sends you to Llana in
  Astranaar for Seeking Caitlin once you have Lost in the Thicket Things: it
  is only the way to Caitlin Grassman, and Llana stops offering it. The
  Ashenvale & Wetlands guide skips it too if you already have the quest
  (thanks Visur).
- A quest that kills several kinds of mob is done at one camp when one camp
  has them all (Sharing the Land at Palemane Rock, the Southsea Freebooters on
  one beach), not split over two trips.
- Generated leveling guides: in Durotar the Abandoned Training Weapons are
  listed before the walk to the Den, so the arrow's last stop before Kzan
  Thornslash is the Den's mouth; Druids, Paladins and Warlocks fly back from
  their trainers before everyone walks on into Tanaris; the boat at Auberdine
  is the last thing in town; the Jaedenar moonwell step points at Felwood, not
  Darkshore; the cleansing bowl is filled without holding the step; Book
  Inventory is optional with the Nibbled-On Book it follows; the Priest-only
  hand-in at Ogtinc is marked for Priests; a step done out on the plains is no
  longer named after the Thunderhorn well; several steps in a row at the same
  town are one step. Class steps out on their own (trainers, class quests)
  now come with that class's flight there and back, and Orcs and Trolls no
  longer get the Barrens' Stagnant Oasis, Scytheclaws and Wenikee hand-ins a
  second time. Class training is one trip: no second flight back to
  Orgrimmar or Thunder Bluff to train again between two hand-ins at the same
  place, and no trip to Ironforge to train when Stormwind's trainer is on the
  way. Class quests of a zone are done before the guide crosses the sea, not
  after, and nobody walks to the Undercity for another race's errand.
  Objectives whose mobs share the same ground, worked back to back, are one
  step to do as you meet them, with a circle of spots to search, not one camp
  at a time; quests taken at the camp come first and hand-ins there after.
  Dwarves and Gnomes who just trained in Ironforge are no longer sent back
  out to Kharanos before the tram; only Hunters, Shamans and Priests go, for
  their class quests there. Dwarf Paladins who fly from Thelsamar to
  Ironforge walk down to the gates, not fly back to Thelsamar first. Orcs and
  Trolls in the Crossroads guide no longer get bare "The Barrens" waypoints
  between the other races' steps. In Feralas, Orgrimmar's training and the
  Warlock's Felsteed quest come with the route's Orgrimmar stop, not after
  Gadgetzan as a walk across Kalimdor, and the Fly to Gadgetzan step flies.
  Two steps in a row at the same place (Sen'jin Village, Razor Hill) are one,
  without a "follow the road to" tip for a place you are standing in. Horde
  Ashenvale leads everyone to Alonso again (#383, #396), and Undead Warlocks
  collect the Rattlecage skulls while killing the skeletons (#345). The
  Cleansing Bowl is filled at the Auberdine moonwell, not used empty at the
  furbolg camp (#302). The arrow goes into Shadowthread Cave through its
  mouth again (#328).
- Generated leveling guides walk over the zone crossings: a walk from one zone
  into another that would cross a border with no way over it first goes to the
  crossing (Felwood's Timbermaw tunnel on the way from the Emerald Sanctuary
  to Everlook, not a flight to Talrendis Point and a walk from Azshara into
  Winterspring).
- A walk out of Riverglades says the way out: Redridge Pass for the Swamp of
  Sorrows, north of Twilight's Shroud for the Badlands (Kargath).
- Alliance 30-40 Arathi: Stormwind to Southshore is the tram and the Ironforge
  flight, as the route goes, not a flight to Menethil and the boat followed by
  a flight to Southshore from Ironforge.
- Horde 50-60 Eastern Plaguelands: the way to Thunder Bluff is the Light's Hope
  flight to the Undercity, the zeppelin and the Orgrimmar flight, written once
  for everyone, not a walk to the Tirisfal tower in thirteen copies.
- Alliance 30-40 Thousand Needles: Stormwind to Menethil for the Lightforge
  Ingots is the flight again, not a walk through Elwynn, Redridge,
  Riverglades and Loch Modan. A walk over several zone crossings that a known
  flight, the tram or a boat makes quicker goes that way.
- Alliance 50-60 Felwood: both ooze jars are filled in the Oozes step, with no
  trip by the Barrens, Booty Bay, Ironforge and Auberdine between them.
- Alliance 50-60 Silithus: the Ironforge cloth donations follow the tram from
  Stormwind, with no walk to the Wetlands and Searing Gorge for cloth from the
  bags and no top-up grind there.
- Horde 30-40 Arathi: Orgrimmar's training step no longer sends everyone to
  Thunder Bluff and back (a "Fly to Thunder Bluff" step without its flight);
  the Druids and Paladins still fly there to train.
- A walk the route makes by a flight master it only passes (Camp Taurajo to
  the Shady Rest Inn by Brackenwall Village) is one walk.
- Alliance Skyborne, Zephras Isle: the hearth back from the Windfield farm
  lands you at Valanaar's inn, and Deliver the News and Crab Season are handed
  in right there. Warriors and Hunters take The Skybreaker Bulwark and Taming
  the Beast on their first walk into Valanaar again; Hunters tame the Windsong
  Crawler among the crabs on the missing scholar's trip and hand the rod back
  to Quel'ana on the way west to the Windstone Formations, with no walk back
  to the shore. Druids take The Great Ursera Spirit at the Valanaar training
  after level 10 instead of being told to reach level 10 in town.
- Alliance Skyborne, Zephras Isle: you set your hearthstone at Valanaar's inn
  on the way into town and hearth back from the Windfield farm instead of
  walking across the isle. Warriors and Hunters take The Skybreaker Bulwark
  and Taming the Beast at their first Valanaar training, and Warriors take the
  Bulwark from Zaal Stormshield on the way in to the Shrine of Akir. Druids
  hand in Strength and Mercy (Bear Form) as they leave Valanaar for the north,
  not on a walk back from Shadowgale Forest. Crab Season's crawler meat is
  gathered on the missing scholar's trip, where the crawlers are, instead of
  on a trip of its own. Journey to Sentinel Hill is handed in on your first
  stop at the hill again.
- Zephras Isle (Horde): Warriors hand Seena the Skybreaker Bulwark in
  Valanaar before the skycutter, not after landing in Mulgore, and Druids see
  Turak Runetotem on their first Thunder Bluff visit instead of flying back
  from the Crossroads. Hunters take the first Taming Rod beside Riaani and
  tame their Windsong Crawler on the crawler trip. Unwelcome Spirits is done
  at Windsong Lake with Free the Hollows, where the Wind Hollows live. The
  Confront Lorthuna tip explains the ledge, the wind current and the Portal
  to Valanaar back down, and a few Shen'dar and Valanaar tips no longer tell
  you to walk to the town you are standing in.
- Zephras Isle (Horde): you bind at Valanaar's inn on the first walk into
  town and hearth back from Windfield Orchard after Standing Our Ground.
  Druids meet Urs'endris on the East Pylon trip, kill Ur'endra in her cave
  beside the turncoat's house and take Bear Form on the way north from
  Valennia, instead of walking back from Windsong Lake. The step for Lady
  Sylvanas Windrunner (Exploring the Horde) now points to the Royal Quarter,
  not to Lordamere Lake.
- Zephras Isle (Horde): Hunters, Shamans and Druids hand their class letters
  to the trainers beside Rorian straight away, and Rogues take At Home in the
  Shadows with the others. Shamans finish Call of Earth before they leave
  Thendal Village instead of walking back from Shen'dar, take Call of Fire
  beside Ayessa, see Olariaan while at the orchard and kill Skypriest Faladiel
  at the East Pylon Watchtower; Warriors take The Skybreaker Bulwark beside
  Riaani. The tips now send you to the Galestriders for the Small Eggs, find
  the hippogryph nests and the Broken Construct's parts, and say how to leave
  the isle.
- Skyborne leveling guides, Zephras Isle: Hunters tame the Ornery Galestrider
  and the Vuldren Alpha in the fields just north of Quel'ana Quickgale instead
  of walking to the Windfield farm and back for each rod. The Alliance guide
  now says how you leave the isle: the skycutter from the dock tower south of
  Valanaar lands beside Denaaris Stargale and the Skyborne Portal (the old tip
  said zeppelin). WANTED: Vulgara the Insatiable, an elite, is no longer
  counted on for your level.
- Alliance Skyborne, Westfall: Journey to Sentinel Hill is handed to Gryan
  Stoutmantle on your first stop at the hill, with the hearth and the flight
  path, instead of on the second stop.
- Simplified Chinese: fill 86 missing leveling and sleeping-bag guide texts,
  and migrate eight outdated guide translations while preserving their old values
  (thanks HershelW).
- Simplified Chinese: translate Ravenholdt's Rite of Cunning in the class guide directions and objective tooltip using the Forever quest's Chinese objective name (thanks HershelW).
- Simplified Chinese talent advice uses spell names from the Forever client
  and correctly distinguishes parry, block and wands; Elwynn and Westfall
  directions are clearer (thanks HershelW).
- Fewer trips back to a zone you just left in the 30-60 routes: Donova Snowden's
  quests wait for the last Winterspring visit, A Final Blow is handed in right
  after the fight, Torwa's Un'Goro quests are done on the way out of Silithus,
  the Horde gets the Super Egg-O-Matic's egg before Silithus, Magtoor is visited
  on the walk into the Swamp of Sorrows, and Alliance players stop in Darkshire on
  the way into Stranglethorn. Silver Heart and Trull's second Wild Guardians are
  left out of the Horde route, and the Super Egg-O-Matic out of the Alliance
  route, because each needed a trip back.
- Winna's kitten carrier step in Felwood now points to the Felwood moonwell
  instead of a spot on the Darkshore map.

### For guide authors

- Two new goals: `abandon 783` is done once the quest is out of the log and
  its `accept` stays done, so a guide can drop a quest without the route going
  back to the giver; once the route has passed it, it stays done even when the
  guide takes the quest again later. `destroy 6948 "Hearthstone"` is done once
  the bags hold none of the item (a start-zone Hearthstone to free a slot). A
  pack using them is written in pack format 5 (Polestar 0.3.0) (thanks
  aronjanosch).
- `cast 818 "Basic Campfire"` is a goal for casting a spell: it checks off
  when the player's own cast of that spell succeeds while the goal is open
  (its step, or listed along the way); a cast before that does not count.
  Name the spell unless it is a recipe in the data. A pack using it is
  written in pack format 5 (Polestar 0.3.0).
- `collect … quest Q.O` on a quest line that is not an item (an object to
  visit, a kill, an event) now warns: the quest log never counts the item
  there. For an item the quest uses without counting it, this warning and the
  one for another item's line say to drop `quest` so the step counts the bags.
- A new `die "<Graveyard>" @x,y` goal for deathskips: the arrow points at the
  graveyard's Spirit Healer (the coordinates, checked against the healers'
  spawns), and the goal is done once you are back alive beside him. Low-level
  routes use it where dying and taking the resurrection beats the walk
  (through level 10 it costs no resurrection sickness). Needs Polestar 0.3.0.
- A `die` step only shows to players who turned on "Use deathskips" (never on
  Hardcore); for everyone else it passes and the next step's travel takes them
  there, so write the route so it reads right without it.
- `enter "Goldshire"` is a goal for being in a zone or an area: it checks off
  once the zone or subzone text reads that name, in any client language, and
  stays done when the player walks on. `@x,y` points the arrow there. A pack
  using it is written in pack format 5 (Polestar 0.3.0).
- Guides compile with `forge guide compile` and check with `forge guide
  lint`: `node tools/polestar.js compile` and `lint` are gone and print the
  forge command. It works on a pack the same way: the folder you name (or
  `--pack`), else the nearest `pack.json`, with our guides as context, into
  `<pack>/dist/<folder>/`, with `--no-data`, `--include-drafts` and
  `--format text|json|github`. Generated files now say `Generated by
  \`forge guide compile\``; folders built before (the old header) are still
  recognised as generated and replaced.
- Two additions to the guide format: `gossip <id>` on a `talk`, `vendor` or
  `train` goal names the gossip option Polestar picks at that NPC, and
  `wait <seconds> ["what for"]` is a countdown in the step that starts once
  the goals before it are done, shown in the window as a draining line.
- A pack with a `wait` goal is written in pack format 9, so an older Polestar
  lists it as needing a newer version instead of refusing each guide.
- Lint takes elite work in a step with `when group <quest>`, and the goals
  of a quest accepted only in such a step, as a party's: no "is elite"
  error for them in a Leveling guide.
- Lint warns about a class list that admits every class, such as
  `only !Hunter,!Mage`: each negation adds every other class, so the line
  never left anyone out. List the classes the step is for instead.
- Lint refuses a radius below 0.005 (`kill 6 r 0.004`): the pack writes it with
  two decimals as `r = 0`, which the addon refused at load ("bad radius").
- Two new goals and a condition: `money 1s` is done once the character holds
  that much and stays done for the rest of its step ("loot until you can
  afford it"), `task "Tame a Venomtail Scorpid"` holds the step until the
  player ticks it, for what Polestar cannot see, and `when money>=1s` makes a
  step depend on the money held. A pack using them is written in pack format 5
  (Polestar 0.3.0).
- `playtest --group do` plays the route of a player who does every group
  quest (`when group`); without it, every group quest is skipped, the solo
  route.
- `polestar playtest --learn Herbalism,Skinning` plays a player who chose
  those professions: the guide's optional `train` of each is taken while its
  step is current, then the steps behind `when skill` it opens are played.
  Without it the simulator takes no optional goal, so it never plays a
  profession branch.
- A pack's leveling chains for one class (a guide with both a `class` and a
  `race` header) now ship in a load-on-demand addon per race,
  `<folder>_<race>`, which Polestar loads for the player's race only, and a
  pack folder's `retired.json` lists guide ids a new route set replaced: a
  character with one of them open gets the pack's guide for its level
  instead, its progress read from the quest log (docs/PACK_FORMAT.md, "Race
  parts" and "Retired guides").
- A step can skip ahead: `skipto <label> when <predicate>` skips that step and
  the ones up to the labelled step when the predicate holds as the route
  reaches it, kept for the character so the jump doesn't undo itself (the
  player can unskip them). `when done <label>` makes a step depend on another
  step being completed, not skipped or jumped over. A pack using either is
  written in pack format 5, which needs Polestar 0.3.0 (GUIDE_FORMAT.md,
  "Jumps"; thanks petllama, #455, after #43).
- `when cooldown item 6948` makes a step depend on a cooldown: it applies
  while the Hearthstone (or any item, or a spell with `cooldown spell <id>`)
  is cooling down, and `when !cooldown item 6948` while it is ready. The
  global cooldown does not count, and Polestar looks again when the cooldown
  runs out. A pack using it is written in pack format 5 (Polestar 0.3.0).
- A step can be for characters who run a dungeon: `when dungeon "Ragefire
  Chasm"` applies only when the player turned that dungeon on in Options
  (Discovery, Dungeons), and `when !dungeon "Ragefire Chasm"` is the route for
  everyone else. Write the dungeon as the game names it; the compiler finds
  the instance in the client's tables and warns about a name that is no
  dungeon. A pack that uses it is written in pack format 5 (Polestar 0.3.0).
- `when group 6284` puts a group quest to the player: when the route gets
  there, the guide asks whether to do it with a group or skip it, and
  `when !group 6284` is the solo way to the same objective. Put it on the
  quest's accept step: skipping it drops the quest's turn-in and objectives
  too. Not on a `next` line or a `skipto`. A pack using it is written in pack
  format 5 (Polestar 0.3.0).
- Steps can depend on whether the character knows a spell: `when knows 100`
  applies while they know Charge, and `when !knows 100` is the step that
  trains it, which a character who has it passes on. A pack using it needs
  Polestar 0.3.0 (thanks jfuglas).
- `when skill` reads weapon skills too, by the skill's name or its trainer
  spell's: `when !skill "Two-Handed Axes" 1` applies while the character has
  not learned Two-Handed Axes (`Swords` and `"One-Handed Swords"` are one
  skill). It works on every client language, like a profession.
- `when skill Cooking 50` makes a step depend on a profession's rank: it
  applies while the character's rank is 50 or more, and `when !skill
  Herbalism 1` while they have no Herbalism. The profession is named as for
  the `skill` goal. A pack using it is written in pack format 5 (Polestar
  0.3.0).
- A step can be for characters the item would help: `when upgrade 2488`
  applies only while Polestar's gear advice rates that item an upgrade for
  the character (wearable at their level, and better than what they wear in
  that slot for their spec), and `when !upgrade 2488` is the route for
  everyone else. An item the gear advice cannot judge counts as an upgrade,
  so the step is shown. A pack that uses it is written in pack format 5
  (Polestar 0.3.0).
- Lint's hint for an `enter` place or a `when zone` name it does not know no
  longer suggests `polestar find --kind zone`, which does not exist: it says
  where the game shows the name.

### For contributors

- data/corrections.json keeps the fixes an independent source backs,
  each naming it in `source` (an in-game check or issue, a recording, the
  client, EG Link, CMaNGOS, the Forever TrinityCore DB, QuestieDB, pfQuest or
  Factoruide); the others move to a private overlay,
  data/local/corrections-private.json, which `data build` merges over it when
  present (`--corrections-private <file>`, `--no-corrections-private`).
- The data files the builds read moved out of tools/ into data/: rules.json (the availability rules), crossings.json (the
  shipped zone crossings), credits.json, nameguard-allow.json and the Codex's
  curated tables (data/codex/attunements.json, entrances.json,
  journal-quests.json, repgates.json). The public data pack carries the
  files at the same paths.
- `forge data build` checks each build before it replaces `data/forever`: the
  field statistics (quests with a giver and ender, ids the data knows, givers in
  their zone, race and class masks, spawns, the AreaTable rows, our guides' name
  tokens per kind, compile errors, names the translations have) against the last
  good build's. A large shift stops the build, leaves the data as it was and says
  which fields moved; `--accept` takes an intended change. `forge data check`
  does the same for the data as it is: a checkout without `data/sources` now
  fails it instead of silently writing `{object:81}` for Sentinel Hill.
- The data gate also watches what the sim's leveling reads: quests with a
  reward spell, quest XP (count and sum), the XP values the knowledge base
  changed, corrections, class training rows, riding trainers and mount
  vendors; a new correction or a 0.5% move in quest XP needs `--accept`.
- `gear build` and `codex build` only build from MIT-licensed
  ForeverLevelingBiS versions: a copy under another licence is refused with a
  message, and nothing is written.
- The corrections moved to the public database's folder, forever-db/corrections:
  one file per section (quests.json, npcs.json, objects.json, items.json,
  mechanics.json, the last taking data/mechanics-public.json's `corrections`),
  same entries, each with its `source` and `note`. forever-db/ also holds the
  generated tables of Polestar's open quest database, and
  forever-db/corrections/notes.json the fixes to its quest steps and notes;
  forever-db/README.md explains how to contribute.
- `install` now detects the `_forever_` stress-test client (flavor `wowf`) and
  installs into every detected Forever client automatically; use `--client
  <folder-or-flavor>` (e.g. `--client _forever_`, `--client wowf`,
  `--client beta`) to pick one. `dev` handles multiple clients the same way.
- `forge build` runs on Windows: its stage folders are linked with Windows
  symbolic links (Developer Mode or an administrator shell) instead of
  stopping with "needs symbolic links (unix)", and docs/FORGE.md says how to
  build Forge there.
- `forge data gear` and `forge data codex` (Rust) only read ForeverLevelingBiS when its LICENSE is the MIT licence and reserves no further rights. For any other copy both builds stop with "ForeverLevelingBiS <version> is not MIT-licensed; the gear data stays as last built from an MIT version" and write nothing. A codex build without ForeverLevelingBiS installed still only warns.
- guidecheck moved to forge: `forge guide check <dir>` (with `--json`, `--fix`,
  `--data`) reads written guides as a player would and gives each line that
  lacks what it needs its cheapest repair, with the same rules, messages and
  repairs; travel steps are left to the writer's travel pass in `forge build`.
  The toolchain no longer has an npm dependency (clingo-wasm is gone).
- The translation tools moved to Forge: `forge i18n status`, `check`, `sync`,
  `keys`, `import`, `leaks` and `guides sync|check|stats` (docs/forge/i18n.md)
  replace `node tools/polestar.js i18n ...`, which now prints the forge
  command; CI's translation check and `npm run i18n:check` run Forge. The
  glossary and the leaks lists live in `data/i18n/`. `i18n names` and
  `i18n fit` stay on the JS tools for now.
- Leveling guides that Polestar Forge writes start with "# Generated by forge
  build" and are listed in guides/GENERATED.json; CI fails a pull request that
  edits them by hand and says where the fix goes instead (corrections.json,
  mechanics-public.json or route-fixes.json). forge guide seed, publish and
  check-generated cut the seed, write the generated guides and run the check.
- The name guard's allowlist only shrinks: it refuses new "phase2" entries,
  and a new entry must be "excluded" with a reason, agreed in review; its
  failure message asks for rewording instead of a list entry.
- A test fails when a tracked file names a web quest database the project no
  longer cites, outside the files listed with why in
  data/nameguard-allow.json; the list only shrinks (a listed file that
  no longer names one fails until it leaves the list).
- The walking-map rebuild has an acceptance set to be judged against:
  `tools/lib/nav/eval/acceptance.json` (reported walks, underworld caves,
  chokepoint walks), a broad random sample, chokepoint checks and
  `judge-pr.sh`, which measures a nav pull request against today's maps. The
  planner's acceptance cases are ignored tests in forge-addontest's
  nav-e2e (`-- --ignored acceptance`) until the rebuild lands.
- Every pull request goes to `next`; patch releases are a smaller, sooner
  release from the same branch.
- The route planner's Quest marks layer shows, at the selected step, the
  quest marks the game would show there (yellow and grey ! and ?), the walk
  through the hub with numbered stops, the ready marks it walked past or left
  behind, the hub's other visits and the ideal loop through it, by the
  judge's hub rules (`hub_view`). `planner --guides <dir>` plays another
  guide set in place of ours, and `?start=&race=&cls=&step=&marks=1` links
  to a step.
- The route planner has a review mode (`/?review=1&start=…&race=…&cls=…`):
  the route one town visit at a time with the game's quest marks, our
  numbered path, the ideal loop and the problems in plain words, and a
  one-click note on any mark, stop or stretch of path, saved for the
  maintainers. The quest marks are now the game's own icons, a quest waiting
  on a prerequisite shows as a faint `!`, and playback starts at each race's
  real spawn point.
- `playtest` (and `tests/guides.test.js`) plays on a pool of long-lived
  lua5.1 processes, each play in a fresh environment, several at once
  (`POLESTAR_PLAY_WORKERS`, default up to 8): the full playtest set gives the
  same results as one process per play, about four times faster.
- Quest XP: the server database's own reward XP now counts as an independent
  source when the quest page's lower value meets a higher one. 59 level-40+
  quests keep the page's XP, the ten level-60 Ahn'Qiraj reward quests take the
  higher value both agree on, and quests whose server XP backs neither value
  keep the page's and are listed for an in-game check.
- `readme charts` draws the README's route chart (`starts.svg`, hours to 60
  and grinding per start) from two `forge judge check` results (`--check`,
  `--base`) instead of the JavaScript simulator; the level-by-level chart
  (`levels.svg`, `levels.png`) is gone, since the route check keeps each
  start's totals only.
- The README is rewritten for Polestar as it is now: polestar.guide's guide
  library, community guides and docs, the Polestar Client, the guide counts
  of the shipped guides, the newest features, and current pictures of
  the hub, the guide window, the arrow, Lookup, Dungeons, the site and the
  Client. `readme brand` draws a Polestar Client button
  (`docs/assets/client.svg`) beside the CurseForge and download buttons.
- Recorder: `/psrec trail on [label]` records a dense position trail while you
  walk (a point every yard or 2 seconds, with speed and mount, swim, fall,
  indoor and flying flags) until `/psrec trail off` or 30
  minutes, and `record trail <session> [--out file.json]` writes the trails
  out as labelled point lists for the navigation work. `/psrec ui` (also
  Options > Recorder and the guide menu) opens a small Recorder window: on/off,
  the trail's label and Start/Stop with its time, points, distance and
  countdown, a mark, the checklist of spots to walk for your faction (ticked
  when a trail with the spot's label stops), this session's trails and Save
  now; a key binding starts and stops the trail.
- The JavaScript route search and its tools are gone: every `sim`
  subcommand but `compare` (each prints its Forge replacement), the v2
  simulator and writer, `polestar judge` (now `forge judge`),
  `tools/writer-sweep.js`, `tools/rebuild*.js`, the CCH backend and the
  `build:native` addon. `sim calibrate` is `forge sim calibrate`.
- The route simulator's world gains what the simulator works on: objectives
  with their camps and drop chances, quest kinds, services by NPC, areas
  (towns first, the rest at most 250 yd across) and walks to camps, read
  through a compact per-band walk lookup. Players' reported game facts are
  kept in data/rules.json and their reported route problems as
  checkable cases, each with its source and credit, both checked against the
  data.
- The route simulator's world is rebuilt for sim v2: one drop-rate table per
  item; respawn times and class training costs; heights on every place; camps,
  trainers, vendors, inns and flight masters (Zephras Isle included) as
  places; the addon's lifts, tram and portals; and walks routed per level band
  with the router's cost, cached by place so a rebuild routes only what
  changed, with a report of the walks the router can't make.
- `npm run test:changed` runs only the test files a change can reach
  (`tools/testsel.js`: the require closure for code, the addon files a test
  loads, the paths it reads), with the reason for each; `npm test` stays the
  CI gate.

### Forge

- `forge build` has a legs stage after the guides stage (and `forge guide
  bake --guides <dir>` for one written guides folder): the walk into every
  step of the written leveling guides, drawn on Leffe's navigation maps and
  on our grid where his have no way or a detour (as the walks stage
  chooses), kept as its corners with each stretch's move and floor and the
  ground's height every 2 yards, written beside each start's guides as
  `legs.json` (`legs-qa.txt` lists the walks left out, and why). Compiling
  the guides puts them into the race parts' `Legs.lua` (pack format 7); the
  old `node tools/polestar.js bake` is gone.
- Thunder Bluff's six rope bridges are walkway WMO groups for the walking
  grid (their hand ropes and posts are walls, not spans over the planks), so
  a rebuilt grid walks Spirit Rise to Hunter Rise over the bridges.
- Route hearths stay an hour apart for every start of a shared guide: the
  hearthstone's cooldown runs on time less grinding, since a player at a
  top-up's level skips it and the grind before a quest taken far under its
  level is never written (c16: Silverpine 20 min, Booty Bay 24 min). The
  writer hands The Green Hills of Stranglethorn in after its chapters, keeps
  the chapters' accepts before it, moves The Final Message to the Wildhammer
  with Another Message's hand-in when the feathers come later, and writes an
  optional accept or hand-in after the route's last line by its NPC (no trip
  away and back across Stormwind for Clavicus' cloth). `forge build`'s data
  stage keys on the private corrections and warns when its forge cannot read
  them.
- The shared Horde route no longer flies to Booty Bay and back from Tanaris
  and the Hinterlands for the OOX-17/TN and OOX-09/HL rewards: the rare
  beacons' escorts stay in their zones' steps for a player who finds one, and
  the hand-ins go with the route's next Booty Bay visit when it has one.
- The route check no longer grinds a character to an optional quest's level
  (Vehena's cloth donations in Orgrimmar read as 12 hours of grinding), and
  Mike_'s Bandarion Keep check counts only what a Mage is required to do.
- The shared Horde route reads cleaner: the Barrens' Beaten Corpse is no
  longer written as a flight to Orgrimmar and back, Darsok's Letter to Jin'Zil
  is taken at the Crossroads before the Warlocks' Ken'zigla trip, and the
  Rogues no longer fly from Ratchet to Orgrimmar and straight back. Gadgetzan's
  flight path is learnt on the way in, not after Steamwheedle Port. Undead
  Paladins see their Shadowvale quests, Sprogger's Facing Negolash comes after
  its prerequisite's hand-in, Thunder Bluff's weapon master step comes beside
  him, classes trained two levels before are not sent across the map from a
  town without their trainer, a class is trained once per town visit, and the
  Southshore Stout is bought on the first pass through Tarren Mill.
- Route writer, c18's double trips: a hub's hand-ins ready before a trip go before it (Nesingwary's
  camp before Grom'gol), a first stop waits for the return after a trip (Ma Stonefield with Bernice),
  a route-fixes hand-in pair is honoured where the hand-in is ready (Kuray'bin), the Orgrimmar class
  training goes before the zeppelin to the Sepulcher, weapon steps judge "beside the master" by where
  a step ends (Woo Ping), class steps of a town go beside their own NPC (Turak on Elder Rise), a class
  hand-in with no later pass waits for its work (Call of Fire), class ways price walks over zone
  crossings (the Warlocks' Takar), and a start's own Darkshore copy leaves lines the route plays
  after the join.
- Route fixes: a `deliberate`/`overrides` pair may carry `"faction"` (Western Plaguelands' Mulgris
  pair is the Horde's only); the Tirisfal Fields of Grief pair now orders the Gloom Weed first.
- Route writer, c18g's shared-order blockers: another start's quest event no longer lands after a
  later event of its own chain that is already in the shared order. Alba Fairmoon's Testing the Wells
  is taken at the first Sentinel Hill stop beside Scout Galiaan, not after its own vials and hand-in
  (Westfall, Dwarf/Gnome/Night Elf/Skyborne); the Tauren's Monogrammed Sash comes before The Captain's
  Cutlass (Stranglethorn, Azshara guide).
- Each race's own ways on the shared guides no longer count a flight path learnt in a start-guide step
  whose quests the shared guides now take: Orc and Troll learn Ratchet's flight path in the shared
  Barrens guide before flying from it.
- Where starts disagree on where another start's quest event goes in the shared order, it goes where
  most of them have it, and nearness to the shared route is judged where its chain puts it (Testing the
  Wells handed in after Blanchy's oats with the Murloc Gills). A hand-in the hub tour takes on the way
  never goes ahead of a hand-in a route-fixes pair puts first.
- Walks to a place without a height stand on the street or deck under the
  open sky, not on the terrain buried under a city: Stormwind's, Booty Bay's
  and Darnassus's walks no longer loop under or around the city (on a
  recorded Stormwind walk the worst stray from the walked line drops from
  625 to 55 yards).
- Legs drawn on Leffe's maps carry our grid's floor, heights and ground
  class (indoor, steep), so the arrow follows them on the right surface.
- The data pack carries the walks answered on Leffe's navigation maps and
  no longer our grid's walk stores (they are keyed by the grid they were
  built on, and every contributor builds their own grid): the archive is
  about 230 MB.
- Travel data: the Druids' own flight masters in Nighthaven (client TaxiNodes 62
  and 63: Silva Fil'naveth to Rut'theran Village, Bunthen Plainswind to Thunder
  Bluff; out of Moonglade only) are taxi nodes marked `class: "DRUID"`. The
  simulator's world leaves them out; the honest playtest and the writer's travel
  repair let Druids alone fly from them, with no flight path learnt; the addon's
  router (TravelData.lua's tenth field) routes Druids alone through them.
- `forge build` no longer searches every route again after a late failure.
  The extra walk pairs a routes stage adds (the legs it priced with no walk)
  are walked in the same build and the routes written again on them from the
  same search, and the search key leaves those pairs out: a search is kept
  while they only grow, and run again only when one it ran with is gone. A
  c14 build that failed in its report grew 60 pairs, and its rerun searched
  for 45 minutes again.
- The writer checks every guide tree it writes as the pack and refuses one
  the pack check would (`the pack has errors:`), so a bad line (c14's bare
  `tip` in the Night Elf Teldrassil guide) stops the routes stage at its
  first write instead of the report 45 minutes later.
- The data builds moved to forge, and their JavaScript is gone: `forge data
  sources` downloads what they read into `data/sources` (the client tables,
  pfQuest at a pinned commit, EG Link, forever-vo, the CMaNGOS dump, web quest
  XP); `forge data build` fetches first unless `--offline` and stages each build
  behind the statistics gate (`--accept`), which `forge data check` reruns;
  `forge data itemdb`, `forge data talents build|check` and `forge data maps
  build|overlays` write the same files the JS did. `polestar data`, `dungeons`,
  `trainers`, `itemdb`, `talents`, `maps`, `gear build`, `codex build` (the
  release build) and `profession build` print their forge command and exit 2.
- `forge data codex --local-extras` builds the local comparison Codex (with
  the installed AtlasLoot, RareScanner and `dungeons.json`) into
  `data/local/codex-extras`, byte for byte as the JS build did; `polestar codex
  build --local-extras` now prints that command and exits 2.
- Polestar Forge, the tool that makes Polestar's leveling routes, has its
  first public release: one `forge` program for Windows, Linux and macOS.
  `forge build` reads the game installed on your computer and the current
  guides, improves each start's route to level 60, writes it into the guides
  and reports what changed. `forge doctor` checks your setup first. See
  docs/FORGE.md.
- Every build applies the fixes of one checkout and says so: corrections,
  public mechanics and route fixes (data/route-fixes.json, now read at run
  time instead of built into forge) come from the checkout being built, and
  fixes.md lists the commit of each input and every fix record as applied,
  redundant, unused, stale, left out or undone; forge build --strict fails on
  the ones that no longer apply.
- `forge build` reads the Forever client tables (zones, map frames, races,
  factions, items) at the build its walking grid was built from, from a copy
  saved under `data/sources/client-tables/<build>/`, not from whatever client
  is installed. Uninstalling the beta client quietly switched the zones and
  map frames to Classic Era's (Zephras Isle gone); now a build reads the same
  tables whatever you install. `--forever-tables client` refreshes the copy
  from an installed client at that build, `--forever-tables wago` reads the
  wago.tools cache; the log names the source and build, and tables of another
  build stop the build unless `--allow-build-mismatch`. `--until data` stops
  after the data stage. `forge doctor` says whether the grid's build is saved.
- `forge build`'s guides stage takes each start's guides from the routes
  stage's last check on the written guides when they were written from the
  same route and inputs, instead of writing them again; a start whose last
  check round was turned down is written again as before.
- Walks on Leffe's navigation maps now ride lifts: Forge splices Leffe's lift
  layer (its lifts, found beside his maps and used only on their own grid
  build) into his search. Thunder Bluff's bluff and the Undercity are reached
  by their lifts instead of falling back to our grid or the sewer, a walk
  across their floors always takes a lift (the Undercity's south lift only, as
  in game), and baked legs mark the ride as a lift.
- The walking maps and their ground layers moved to forge: `forge nav pack`
  writes Polestar_Nav's maps (byte-identical to the Node writer on the
  1.60.1.70532 grid), `forge nav check` holds them to `PACK.json`, and
  `forge nav layers roads|hubs` build the roads and hostile-hubs layers that
  `forge nav prepare` and the pack read; the road-texture allowlist is now
  `data/road-textures.json`. `polestar nav pack|check|layers` print the forge
  command instead. The addon router's tests write their hand-made maps with
  forge-nav's fixture writer (forge-addontest's navmap).
- Arrow points, roads, tips and level gates for the generated guides now
  live in two record files, `data/places.json` and `data/guide-fixes.json`,
  anchored on a quest's goal. `forge build` applies them every time it writes
  the guides, so a fix survives every new route; the fixes ledger says for each
  record whether it applied, and `forge data check-corrections` checks them.
  The eleven leveling-guide fixes merged since the guides were taken over
  (#646, #672, #674, #692) and #703's objective arrows are records now.
- `forge build` finds QuestieDB in any client's AddOns folder that has its
  Forever store: the live client first, then a leftover beta folder (also one
  without its flavor file) or a test server install. It stops when there is
  none, unless you pass `--no-questie`: building without it quietly left out
  about a sixth of the quests. The data stage also stops when a build has over
  5% fewer quests than the previous one, naming what is missing by source
  (`--accept-fewer-quests` takes it).
- `forge guide compile` and `forge release pack` now quote any table key that
  is not a plain Lua identifier, as the JS compiler has since #750. Keys that
  are plain identifiers are written as before.
- Routes: a quest started by a rare drop is no longer counted as certain; it
  counts at the chance the route's own kills give its drop (and its chain
  after it at the same chance), and it is never farmed for. A v1 `train <npc>`
  line (a riding trainer) is no longer moved as a class training stop.
- `forge record import` and `forge record pull` bring the Recorder's new
  chunked recordings into `data/recordings` (from this PC's game, a file a
  player sent in, or the recording server), with no character names, realms
  or account names. `node tools/polestar.js record import` and `record watch`
  are retired. The data build trusts other players' recordings only where it
  should: a spawn, a learned path or a drop chance replaces another source's
  only when two players saw it, and names from non-English clients never
  replace English ones. After a pull has stored everything, it tells the
  server, which then deletes those chunks after two weeks.
- Releasing the addon moved to Forge: `forge release version`, `forge release
  pack` (the release zips and SHA256SUMS, now byte-identical on every
  machine), `forge release notes`, `forge release credits` and `forge
  changelog add|check|show|build`. The old `version`, `changelog`, `release`
  and `credits` commands print the forge command instead, and CI checks the
  changelog fragments with `forge changelog check`.
- Routes: a v1 hearth line met on cooldown leaves the travel plan before the
  search, and a cast waits `hearthCooldown` × 1.25 (`hearthMargin`), so no
  hearth is planned or walked on cooldown; kill work waits until its mobs
  (at most the quest's level) are `workGap` (3) levels up or less; a quest
  with no kill or escort of its own is taken without the danger grind; an
  item from a locked object (Benedict's Chest) comes after the kill that
  drops its key; a route-fixes `after` rule v1 breaks on one map is kept by
  moving its step; inserted quests come after their prerequisite's hand-in;
  the Skyborne-alliance exit is the skycutter to Alterac plus the Skyborne
  Portal to Stormwind; the skip ledger names quests whose chain starts with
  a quest left out of the world, and an undisputed KB objectives doubt that
  lists the data's own objectives no longer refuses a quest; the fixes
  ledger flags an order rule the cut's own order breaks.
- Route fixes: a `together` rule v1's order breaks now moves `b` next to `a`
  (a record can pull a step earlier); a pair's objective index names that
  objective's task; a moved v1 `train class` line keeps its town (#664).
- `forge build --search edits|free|hybrid` (with `--tries`, `--members`): the
  free search, or the free search followed by the edit descent, for each
  start and the shared tail; the default stays the edit descent. The free
  search now keeps every rule the edit descent keeps, and a free or hybrid
  route's edit ledger lists the free search's changes against the guides.
- `forge build`'s walks stage is keyed by what the walks are made of (each
  world's places and the zones' danger, the walkers' answer versions, the
  walking maps), not by the data at large: a data fix that moves and adds no
  place skips it, and one that adds places (#735's kill camp) routes only the
  new places' pairs, the walk stores answering the rest by their ends. The
  walks files carry the world's `walksKey`, which the routes stage, the
  writer and `--walks-from` check them against, and the extra walk pairs
  (`walks/extra-pairs.json`) are kept by their places, so a correction that
  shifts point ids no longer points them at other places.
- `forge build` writes each faction's shared guides once for all its starts
  (the canonical start's run and every race's and class's own ways), not
  once per start: the guides stage and the routes stage's check on the
  written guides take about a fifth of the writer time they did, with the
  same guides. `POLESTAR_BUILD_TIMES=1` prints where a build spends its time
  (each start's search, post passes and check rounds, the writer's parts)
  and keeps it in `<out>/.forge/timings-<stage>.json`.
- `forge writer apply-route` writes where-notes and walk notes on goals (R9,
  `--no-tips`), `Careful:` tips from the quest notes (R10, `--no-warnings`),
  and `when onquest` on the hand-ins of quests picked up on the way (R3).
  `forge data build` writes `moves.json` (classic-db creature walks), and the
  compiler gives a walking NPC's goal its walk as its spawn spot.
- A grind top-up the route inserts (a `level` item with no v1 line) is written
  as a step of its own at the route's point, `when level<N.FF`, with a tip
  naming the hand-ins it tops up for.
- Leffe's navigation maps are private: the data pack no longer carries
  them, and `forge data pack` refuses a pack that holds them. It carries the
  walks his maps answered instead (`walks/store-leffe-*.psbn`, with each
  place's zone on his maps), and `forge build` without his maps runs the
  hybrid on those saved walks, with our grid for the walks they lack and for
  the legs. `forge doctor` shows which you have.
- A release build (`forge build --strict`) refuses to walk on our grid alone,
  and every report's first line names the walking maps the build used.
- `forge guide publish --from <out>/guides` publishes every start of a build
  at once: each faction's shared route a single time (it refuses when the
  starts wrote it differently), each start's own guides, Orc and Troll's
  Durotar and Dwarf and Gnome's Dun Morogh routes once per race (`orc/`,
  `troll/`, `dwarf/`, `gnome/`, their old ids retired), and one `legs.json`.
  The compiled guide parts stay about 2 MB per faction instead of carrying the
  shared route once per race.
- The data build trusts recordings from the recording server more carefully:
  a spawn, a learned path, a drop chance, a quest's XP or a class trainer
  needs two players, and a player counts only once established: first seen
  3 days before their newest recording, 20 chunks sent, and real play
  (recordings on 3 different days, 2 hours in all, with positions and kills;
  `minContributorDays`, `minContributorChunks`, `minContributorPlayDays`,
  `minContributorHours`, `minContributorPos` and `minContributorKills` in
  `data/recordings/config.json`). Players registered from the same network
  on the same day count as one, and so does one player on many installs.
  Each needs 10 kills of their own behind a drop chance. Drop chances, quest
  XP and the calibration's kill pace are the median of each player's own
  value, so one player farming for hours can't pull them.
- `forge record import` of a file someone sent in needs `--vouch <name>` (it
  counts as that player) or `--anonymize` (it only fills gaps).
- `forge record pull` keeps each contributor's recordings apart, so nobody
  can overwrite another player's by reusing their install id, and removes
  the recordings of contributors who deleted their data or were blocked.
- `forge build --deathskips` (and `forge sim route|shared|widen --deathskips`,
  off by default) plans deathskips: through level 10, a leg may die at a camp
  of mobs within 400 yards and go on from the graveyard the game sends that
  death to, where that beats the leg by 30 seconds. The world build has the
  graveyard table for it (each faction's graveyards, the zones linked to them
  and their Spirit Healers), and the guides write each one as a `die` step.
- Routes: no straight walk across the sea. A leg the walk store has no walk for, beyond the store's pair radius (4000 yd), goes by flight paths, docks, boats and walks between them instead of a straight line that may cross water or mountains; it is asked of the walk store next build. Sardor Isle (Feathermoon Stronghold) is its own walk region for the Alliance, reached by the Forgotten Coast boat or the flight path, never walked to (c13 Human walked 5841 yd from Dustwallow to Feathermoon and 4299 yd from the Emerald Sanctuary to Everlook).
- Routes: a training stop at a town without a trainer for some of the race's
  classes is charged their share of the trip to one, so the route prefers
  towns that train every class.
- A routes stage that dies part way (out of memory, a reboot, a kill) is
  resumed by the next `forge build` with the same inputs: each start's
  finished search is kept as soon as it is done, the free search saves its
  members every 2 minutes and the edit descent its edits, all under
  `out/.forge/routes-resume/` for the stage's key, and a rerun goes on from
  them to the same routes an uninterrupted run makes. `forge sim route`
  does the same beside its `--out` file. Checkpoints of other inputs or of
  another forge binary are never read.
- A writer or judge change no longer searches every route again: the routes
  stage keeps its finished searches in `out/.forge/routes-search/` under a
  key of what the search reads and the planner's own code (a hash of
  forge-sim and the crates it is built from, not the forge binary), and
  reuses them, running only the check on the written guides again. The log
  names the searches it reused. A finished search now keeps its hub batches,
  so a route finished from it undoes them under the written check as the
  search itself does.

The key walk (`files_under`) now visits each real directory once and in sorted order. A link
back up the tree (`data/sources/sources -> data/sources`) made it walk ~40 levels of copies and
hash them under a different set each build, so the data, world and routes keys never matched.
- The routes stage's passes after the search use the machine: every start's
  guides' order at once, a faction's shared models and written routes at once,
  and the written check writes and judges a faction's starts at once, the two
  factions side by side (at most 5 starts' writers and judge walks at once);
  the guides stage writes its starts the same way. The canonical start's run,
  the shared guides' ways and the walk store are made once per faction and
  waited for by the other starts. Same routes, written trees and findings,
  byte for byte; c17's routes stage from its saved search: 1340 s on 1.2
  cores to 958 s on 2.4 cores.
- The route planner sees more of the hand-ins a guide walks past: the walk
  between a flight and a boat (Gadgetzan's flight master to the Steamwheedle
  dock) counts as walked, a shared route counts every start's own hand-ins
  (the Skyborne's and the Dwarves', not only the Human's), and the written
  check's findings in a start's own guides before the shared part (Elwynn,
  Durotar, Zephras Isle) go back to that start's route too.
- A quest left ready at a town the route visits several times now moves to
  the first visit where it could be done (Ratchet's WANTED: Baron Longshore),
  not the last one, where the earlier visits still passed it.
- The route check's `walked-past` no longer counts a hand-in as ready before its
  work is done when the guide writes that work as a `buy` or an untagged
  `collect` of the quest's item (Soothing Spices, Southshore Stout, the
  Encrypted Twilight Texts), as a `talk` the quest data does not list (Coming
  to Terms), or not at all (the cloth donations): such a quest waits for the
  line, or is never said to be ready. A flight or a hearth between two goals no
  longer reads as a straight walk past the NPCs between them: the walk starts
  where it lands (the flight master, the inn), and a death passes no one.
- The walks stage uses the machine: the hybrid's two passes (our grid's and
  Leffe's maps') run side by side, a band's routes for all its danger tables
  at once, and the walks document's bands are assembled, merged and written on
  threads. A walk store is read as its file lays it out (no table built) and
  written back only when it gained answers. Leffe's decoded maps get 4,096 MB
  in the walks stage (2,048 MB decoded each piece about nine times over), and
  threads asking for a piece being decoded wait for it instead of decoding it
  again. Same walks files and stores, byte for byte; c15's walks on c16's
  world: 296 s to 141 s on 12 threads, a round's second walks pass (70 new
  pairs) 106 s to 47 s.
- Class training: a training stop no longer drops a class whose trainer is not
  in town because some later stop exists; it is left out only when the next
  stop comes within four levels of the class's last training, else the line
  sends it to its nearest trainer (Horde Druids and Paladins went untrained
  from 39.5 to 51 and 47). v1's trip for classes the route's stops have no
  trainer for (the Dwarf Shamans' tram to Ironforge) is kept.
- v1's training behind its own `level` line (the level-20 ranks) waits for the
  route's training at that level and is written with it, instead of a guide
  early; a class detour hands a quest in once (the Warlocks' 876, written
  twice).
- A class accept a level or less above the route, in a guide that does not
  pass its zone again at that level, is written where it is behind a `level`
  line, not carried into another band (the Druids' Cat Form from Darkshore to
  the Hinterlands). A step's `level` line gates only accepts it covers; the
  step's hand-ins go before such a gate.
- A hand-in moved after its item, when its NPC is in another zone the guide
  passes later anyway, goes there (the Shamans' Brine after the Ashenvale
  fountain). A step waiting on a quest v1 takes in an earlier step keeps its own
  step and `when` (the rare Gold Pickup Schedule and Manhunt), and a class
  accept only moves to a step of the route's own lines.
- The route check has a `training-gap` warning: a class's walk with more than
  four levels between trainings.
- A v1 step in a zone the route's walk crosses, near where the walk enters it,
  is done on the walk at that crossing: the Warlocks' Takar the Seer in the
  Barrens on the walk from Theramore to Thousand Needles, not a trip back from
  the Mirage Raceway by way of Stonetalon.
- v1's class steps at the place of the route's step that leaves town by tram,
  boat or zeppelin go after that step's work, with the way out a step of its
  own after them: the Dwarf Paladins' Ironforge steps after "The Deeprun Tram"
  (flight path, training, Magni), not before it and back to Gryth.
- A class's v1 step with no pass of the route through its zone goes right
  after its v1 step before (when only the route's added quests are written
  since): the Shamans' Ironforge training and the Night Elf Druids' flight to
  Sentinel Hill straight after the Stormwind stop, not after Theocritus in
  Elwynn (Rev15A1 B1, B2).
- Classes away on a detour come back only to a step of theirs: the Shamans in
  Ironforge are not walked to the other classes' Goldshire training (B3).
- Classes away in a city with their trainer train there before the route's
  training stop, which leaves them out, as does the route's way to it: the
  Rogues in Stormwind at the end of Duskwood, not walked to Goldshire (B4).
- A city's class trainer within 500 yd of the route's training stop counts as
  there (Orgrimmar's Hunter, Mage, Priest, Shaman and Warrior trainers no longer
  get trips of their own "to Orgrimmar"), and a kept class's own trip names the
  stop's town as the place without its trainer, not the zone (Razor Hill, not
  Durotar, which has Mai'ah).
- A class's training step closing a guide (the Druids' Darnassus training
  after Rut'theran Village) stays at the end of that guide, not carried into
  the next one to its first named line (Felwood, after the Emerald Sanctuary).
- v1's training line the route trains by in another city counts its quests
  the route takes elsewhere (or leaves out) as done, so the route's own city
  trains: Stormwind at 57.9 for v1's Ironforge step, for the classes with a
  trainer there; the Shamans train at the route's Ironforge stop right after.
- Classes away train per class where their trainer is: the Rogues in Stormwind
  even when they share a detour with the Shamans off to Ironforge.
- The guide writer keeps a town visit in one piece: a class step or a v1 step
  the route does not take, far from the town, goes after the visit instead of
  between two stops there; a guide is not cut inside one town visit; a flight
  path or bind learnt on arrival goes in the town loop, at the step nearest its
  NPC; a buy is written where the route buys, not with the hand-in it is for.
- A class's flight out and back with nothing done in between is not written;
  nor is v1's step that only learns a flight path the route does not go for; a
  flight path learnt in one guide is not learnt again in the next.
- v1's bare `collect` of an item one of the route's quests asks for is tagged
  with that quest; a guide's comment block is written once per guide.
- Shared route: a start's own guide before the shared chain that the route
  leaves with no line keeps only its class steps (Orc and Troll's Barrens
  guide); a shared guide a start plays in its own part becomes its own guide
  (Night Elves' Darkshore); a start's own level or training event keeps its own
  target instead of taking another start's.
- A start's class step under its level is not held or deferred into the
  shared guides (where it was lost): it stays in the start's guide behind a
  `level` line (the Dwarf Paladins' Tome of Divinity). A class line beside
  another audience's same line is only dropped as a duplicate when both are
  for the same characters; a class list and a race list share characters.
- Class and field steps go to the town or seed step they belong to: Perrine's
  Chest at the Scarlet camp, the Warriors' scales right after Far Watch; the
  Undercity counts as here from the Ruins of Lordaeron. A class accept ahead
  of a prerequisite handed in in a later guide moves there with its chain.
- A Druid's way to Moonglade is its teleport, written `goto` to where it lands
  labelled "Cast Teleport: Moonglade" (`forge judge` reads a teleport goto as
  no walk). Class lists in a start guide name only the classes its races play.
- A start's arrival at the shared chain takes its class steps before
  everyone's way in with it (the Night Elf Warriors' Stormwind step no longer
  cuts off everyone's boat); a quest the shared order never accepts is for the
  starts that carry it in (Telf's Call of Fire for Tauren Shamans only); route
  fixes' `after` rules hold inside a hub visit; a class's run of steps stays
  in v1's order when it is written right after its previous step.
- No walk for everyone is written to a v1 step of nothing but optional lines
  or quests the route does not take (The Collector, Manhunt).
- A shared guide a start plays in its own part (the Night Elves' Darkshore)
  comes before the join guide in the chain the writer cuts by, so its lines
  (the Auberdine accepts) are not written into the join guide the start does
  not keep.
- Fewer trips back and forth in the written guides: classes away rejoin
  where the route goes on (not where it left from) and not at all when they
  are already there; a class or race step between two lines at one NPC, or a
  riding trainer's step mid-visit, goes after the visit (v1's travel for
  everyone stays in place); a class trip for some races' lines only is theirs;
  the same way for two races is not merged ahead of one race's own flight.
- A way step for everyone into a zone where the next step is only for those
  on a quest (`when onquest`) goes into that step: the others no longer walk
  out to Forest Song and back to Talrendis Point.
- A class's own way no longer takes its race's other classes' travel away:
  the Orc Hunters, Rogues and Warriors keep the zeppelin to the Undercity
  the Orc Shamans' way replaced for them alone. `only` lists are read one
  way by the writer and the judge.
- A training stop whose classes train at v1's own training steps writes its
  way there before those steps, in their guide, not again for everyone after
  them (the Kargath to Orgrimmar flight and zeppelin at the head of Dustwallow).
- A class's own step standing beside the NPC of a quest it carries, ready,
  hands it in there (the Orc Warlocks' Gan'rul trip and Neeru Fireblade);
  a class's own hand-in at a later visit, its ender beside where the class
  took it, is handed in there (the Skyborne Rogues' and Warriors' notes on
  Zephras Isle).

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
