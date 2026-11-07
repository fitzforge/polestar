# Polestar: Mob Markers

A companion to Polestar: marks every spawn point of the mobs your active quests need on the world map and minimap, in Polestar's own look, its skull on its medallion.

- **One colour per quest**: the skull's colour tells you which quest a mob is for.
- **One ring per mob**: when a quest needs several kinds of mob, a coloured ring around the marker tells them apart.
- **Legend** on the world map lists each quest and how many spawns it has; hover a row to highlight its markers, and expand it to see its mobs.
- Hover a marker for the mob, its quest and what it drops.

## Requirements

- Polestar: the skull and medallion art comes from it.
- LibForeverData: the spawn data.

## Usage

- `/mobmarkers` or `/pmm`: rebuild the markers and print what was found on the current map.
- `/pmm config`: open its options in Polestar's (Map, Guide & quests, Mob spawns).
- `/pmm preview`: for testing, mark 20 of your faction's quests for the zone the world map shows instead of your quest log; off again with `/pmm preview` or a reload.

## Options

In Polestar's options window: Map, Guide & quests, Mob spawns. The markers and legend hide while Polestar's guide is hidden.

- Show on the world map and/or the minimap, and the world map legend.
- Only Polestar's current step (on by default): mark just the quests the guide step you're on works on, instead of your whole quest log.
- Colour palettes for quests and for mobs, including a colour-blind safe one.
- Marker sizes for the world map and the minimap.
- Medallion opacity, and skull & ring opacity.
