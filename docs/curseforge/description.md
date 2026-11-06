![Polestar: leveling guides for World of Warcraft: Forever](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/images/banner.png)

# Routes that make sense.

**Polestar is a free, open-source guide addon for World of Warcraft: Forever.** Every race from 1 to 60, a guide window that keeps up with you, and an arrow that walks real paths. Every step is one you would pick yourself, with nothing pointless in between.

## What's new in 0.3.3

*   **A calmer guide window:** one person at a time, finished goals fold away, and the window stops at half the screen.
*   **Only your steps:** another class's or race's steps are never shown or counted.
*   **Along the way** sits under the steps you walk to, and says until which step.
*   **Nearby services** finds the nearest vendor by what it sells, general goods and the nearest mailbox.
*   **Quest log cleanup** from the guide window's menu, now with grey quests.
*   **Group play** on by default with party members who also run Polestar.

***

## The arrow walks real paths

Around cliffs, through town gates, into caves and onto boats. The arrow follows the path worked out for every step, with the distance and the time left, and the step ticks off when you arrive.

![The arrow leading out of Auberdine along the walking path to the Blackwood furbolgs: the distance counts down, the arrow turns at the corners, says Arrived, and the step ticks off](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/arrow-walk.gif)

## A guide window that stays calm

The person to talk to now shows in full; everyone after them waits on one line. Finished people fold away, and every trip is timed: walks, flights, boats and your Hearthstone, waits included.

![The guide window in Auberdine: Terenthis's goals tick off, he folds into one done line, and Sentinel Glynda Nal'Shea moves up](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/guide-fold.gif)

![The guide window's Journey: go to Stormwind, walk to the boat, take the boat to Auberdine with its average wait, then hand in Plagued Lands](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/journey.png)

## Only your steps

A Druid's Moonglade trip never shows up for a Mage. The window counts and pages only your own steps, and work you can do on the way sits under the steps you walk to.

## Nearby services

The nearest vendor, repair, innkeeper, flight master, trainer or mailbox, one click from the guide window. The arrow names who you are walking to.

![Nearby services in the guide window: Vendor, then Nearest, and the arrow turns to the nearest vendor and names him](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/nearby.gif)

## Every guide in one place

Leveling for every race and start, class quests, professions, reputations, mounts, pets and exploration. Open a guide in its own tab and keep your place in the others.

![The guide menu: Browse, pick Westfall, Open in new tab, and Westfall is open in tab 2](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/picker.gif)

## Lookup, Dungeons and Rares

Lookup answers "how do I get that?" for any item, mount, recipe, quest, NPC or rare. Dungeons lists every quest with its chain and rewards, and Rares tells you when one shows up.

![Lookup searching swift: guides, mounts and items, with the Swift Ram selected](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/lookup.jpg)

## A tidy quest log

Quests the route no longer needs, and grey ones that give no XP, in one list. Abandon asks the game first. Open it from the guide window's menu.

![Make room in your quest log: six grey Elwynn quests and one the route never hands in, each with Abandon](https://raw.githubusercontent.com/fitzforge/polestar/main/docs/curseforge/media/questlog.png)

## Play together

With friends who also run Polestar, the step waits until everyone has what they need, the arrow leads to what they still need, and a Share button offers a quest someone is missing. Friends without Polestar see nothing.

## Quality of life

*   **Items a quest still needs** are marked in your bags and kept from selling.
*   **XP per hour and time to level,** with a heads-up when a class quest opens.
*   **Gear advice** on tooltips and quest rewards.
*   **Your look:** skins, colour schemes, compact or transparent windows, and every window works with a gamepad.
*   **Every language** the game ships, with names as your game shows them.

***

## Getting started

1. **Install** with the [Polestar Client](https://polestar.guide/client) or the CurseForge app, then restart the game completely.
2. **Open the guide menu** with `/polestar guides` (a welcome opens on each new character too).
3. **Pick your start** and follow the arrow. Goals tick off by themselves as you play.

Installing by hand: unzip into `World of Warcraft/_forever_/Interface/AddOns/` so the Polestar folders sit directly inside it, and restart the game. Delete the old Polestar folders before an update.

## FAQ

**How do I close a guide tab?**  
Point at the tab in the guide window and click its ×. In the guide menu's Home, each Continue card has one too.

**How do I clean up my quest log?**  
Open the guide window's ⋯ menu and choose Clean up quest log, or type `/polestar questlog`.

**Which commands are there?**  
`/polestar` shows the guide window, `/polestar guides` opens the guide menu, `/polestar options` holds every setting, `/polestar near vendor` points at the nearest vendor, and `/polestar help` lists the rest.

**A step is wrong. How do I report it?**  
Click the bug button on the guide window (or type `/polestar report`), copy the report, and post it on the [Polestar Discord](https://discord.gg/vMbee6F2e9) or as a [GitHub issue](https://github.com/fitzforge/polestar/issues).

**How do recordings help, and how do I opt out?**  
The optional Polestar Recorder notes what happens as you play, with no character, realm or account names, and the Polestar Client sends it so the routes can be fixed from real play. Stop sharing in the Client at any time, or don't install the Recorder.

***

## Links

*   **Discord:** [Polestar | Leveling Guides](https://discord.gg/vMbee6F2e9)
*   **Website:** [polestar.guide](https://polestar.guide)
*   **Source code:** [github.com/fitzforge/polestar](https://github.com/fitzforge/polestar)
*   **Changelog:** [what's new](https://github.com/fitzforge/polestar/blob/main/CHANGELOG.md)
*   **Write your own guides:** [community guides explained](https://github.com/fitzforge/polestar/blob/main/docs/GUIDE_PACKS.md)

## Support Polestar

Polestar is free and stays free, with no ads and nothing locked. If it saves you some hours on the way to 60, you can [buy me a coffee on Ko-fi](https://ko-fi.com/0xfitz). Reports, guides and translations help just as much.

## Licence and credits

Free and open source under the [GNU GPL, version 3](https://github.com/fitzforge/polestar/blob/main/LICENSE). The walking paths use Leffe's navigation maps and Polestar's own, with a router that started from Cillian Berragan's [Shortest Path Forever](https://github.com/cjber/shortest-path-forever), used with his kind permission. Every data source is credited with its licence in [THIRD_PARTY.md](https://github.com/fitzforge/polestar/blob/main/THIRD_PARTY.md). No game art ships with Polestar; the pictures show the game (© Blizzard Entertainment).

_World of Warcraft is a trademark of Blizzard Entertainment. Polestar is a community project, not affiliated with or endorsed by Blizzard._
