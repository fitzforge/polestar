# Skin API: gaps and rough edges (version 2, Polestar 0.3.8)

What a skin author runs into that the API does not cover, does
inconsistently, or that the documentation and the code disagree on. First
found while writing [docs/skins](README.md) and running every snippet
against the API's preview (version 1); kept current with version 2, the one
Polestar 0.3.8 ships. Each item says what happens, why it matters to an
author, and a suggested fix, or that it is done and how. Items marked
**decision** need the maintainer or Fitz, not just code.

## Tokens that are accepted but ignored

1. **`windowBorder` on every base: done.** `resolve` and `resolveSkin` now
   take a skin's `windowBorder` token in the "else" branch: the player's
   border colour, else the accent border (`ui.borderAccent`), else the
   skin's `windowBorder`, else `windowEdge` or `border`. Before, the token
   was accepted and never reached the palette. The reference documents the
   new order.
2. **`accentLine`, `padSelect`, `chipAccent`, `inputBg` on the `polestar`
   base: done.** `resolve` derives them from the accent and `shade` only
   when the skin does not give its own; a skin's value now stands on every
   base.
3. **A scheme accepted the game looks' tokens: done.** A scheme may give the
   grounds, the text ladder, Dusk's extras and the subject colours; any
   other token (a wash, a role, `bgBottom`, `windowEdge`...) is refused as
   "belongs to a skin, not a scheme".

## Hooks reach too little

4. **The arrow hook's parts: done.** The hook gets a third argument, the
   arrow's parts by name (`dial`, `body`, `glow`, `dart`, `dartEdge`,
   `ring`, `halo`, `distance`, `label`, `eta`, `timer`, `travel`;
   capability `arrow.parts`), and a skin may bring its own dart and edge
   (`media.dart`, `media.dartEdge`) and the arrow's light (`glow` token).
5. **The pin hook's parts: done.** The hook gets the pin's parts by name
   (`fill`, `rim`, `icon`, `backdrop`, `ring`, `glow`, `edge`, `text`,
   `medallion`, `dashed`; `pin.parts`) and its kind (`"pin"`, `"mark"`), and
   a skin may bring the pin's disc and rim (`media.pinFill`, `media.pinRim`)
   and colour them (`pinFill`, `pinRing`). The pin frame's other fields stay
   internal.

## Lifecycle

6. **No re-registration in a session.** A second `RegisterSkin` with the
   same id is refused as taken, even from the same addon, so every change
   while developing means `/reload`. Fine for players, slow for authors.
   Suggested: allow re-registration **from the same `addon`** (replace the
   spec, repaint), or a `Theme.UpdateSkin(id, spec)` behind a capability
   `skins.update`. Low priority; the reference documents the reload loop.
7. **`onLeave` runs once after a skin fails: documented.** The behaviour is
   kept (it lets the skin hide its own frames); `docs/SKINS-API.md` no
   longer says that nothing of a broken skin runs again.
8. **A refused registration was silent for the player: done.** When the
   player's saved `ui.skin` names the refused skin, Polestar prints one chat
   line, once, naming the skin, its addon and the reason, so a report
   reaches the author. A refused skin nobody chose stays silent.

## Messages

9. **`author` / `version` over 40 characters: done.** "must be a string of
   40 characters at most".
10. **`fontSizes.<role>` outside 6-40: done.** "must be a number from 6 to
    40".
11. **A scheme's legibility refusal naming a subject colour: done.** When
    the colour that fails is one the scheme left to Polestar, the message
    names the ground: "panelAlt is too light for Polestar's subject colours
    (dungeon reads 1.1:1, needs 4.5:1)". A scheme may also give its own
    subject colours now.

## Settings window

12. **The accent's source label says "Polestar gold" while a registered
    scheme's or skin's `accent` is in use** (`Polestar_Options/UI/Looks/Theme.lua`,
    the `source` of `ui.accent`). Still open. Fix: when
    `SCHEME_INFO[key].accent` or the live skin's `accent` token supplied the
    colour, show the scheme's or skin's name.
13. **Per-skin settings: partly done.** `variants` cover the common case
    (one design in several versions: a light and a dark one, another base,
    another accent): Polestar draws a card per variant under the skin's
    card, stores the pick per skin (`ui.skinVariants.<id>`) and repaints.
    Free settings (a glow on or off) stay the skin's own: a saved variable
    and an entry in the guide window's menu (`guideMenu`), as the recipes
    show. **Decision**: whether Polestar should host other addons' free
    settings at all (a shape for a later capability `skins.options`: an
    `options` list in the spec, stored under `ui.skinOptions.<id>.<key>`,
    read through `Theme.SkinOption(key)`, drawn as rows under the skin
    card).

## Documentation and policy

14. **Licence statement for skins: done.** LICENSE-EXCEPTION.md has a "Skin
    addons" permission (GPL-3.0 section 7): an addon that changes Polestar's
    look only through the documented Skin API may be licensed as its author
    chooses; copying or modifying Polestar's code, and Polestar's own art
    and fonts, stay under their licences. The example addon is CC0-1.0 so its
    code can be copied freely. The publishing page points at the section.
15. **The deprecation window is written by the docs, not by the code or a
    maintainer decision.** [versioning.md](versioning.md) says an old `api`
    stays accepted "for at least the next minor release line" after
    `API_VERSION` rises. Nothing is deprecated in version 2 and a version 1
    spec works unchanged, so the promise costs nothing today, but it is a
    promise: **decision** to confirm or change before 0.3.8 ships the docs.
16. **`docs/SKINS-API.md` and `docs/skins/` overlapped: done.**
    SKINS-API.md is now a short landing page (what the API is, a quick
    start, where each page is, and the comparison with another addon's skin
    API) pointing into `docs/skins/`, so the two cannot drift.
17. **Theme functions a skin needs were outside the version promise: done.**
    Under the capability `theme.functions`, `Refresh`, `OnChanged`, `Skin`,
    `Repaint`, `Font`, `Border`, `Band` and `TintArt` are part of it; the
    rest (`Metric`, `FontSpec`...) stay Polestar's own.

## Smaller notes

18. `media` paths and `font` file paths are not checked for existence (the
    client has no API for it). Documented; nothing to do beyond telling
    authors what a missing file looks like.
19. **`SchemeChoices()` entries carry `author` now: done**, as
    `SkinChoices()` entries do.
20. `Theme.Color(unknownToken)` answers the `text` colour rather than
    raising. Good for robustness; documented, since a typo in a painter
    shows as white rather than an error.
21. **The example addon's TOC version: done.** It carries Polestar's release
    version, as every folder's TOC does (a release check holds them to it);
    its specs say `version = "2.0"`, the example's own.
22. **The example's moonline is one pixel: done.** It uses
    `Theme.Pixel(frame)`, as the recipes do where a pixel is meant.

## Found with version 2

23. **The preview cards and the presets load with the settings window.**
    `DrawSkinCard`, `DrawSchemeCard` and the preset functions moved to the
    settings window's own folder (`Polestar_Options`), which loads the first
    time the settings open, so a player who never opens them carries none of
    it. A skin addon with a picker of its own has to load that folder first
    (`C_AddOns.LoadAddOn("Polestar_Options")`, out of combat) or check the
    functions exist; the reference says so. Suggested, if one appears: keep
    it so, documented, rather than move the cards back into every login.
24. **The resolver's answer is not measured for legibility.** A resolver
    answers at paint time, after registration, so its tokens never pass the
    contrast check; on the `polestar` base the run-time guard still moves
    the grounds, on the other bases nothing does. Suggested: measure the
    resolver's palette once per answer and note a shortfall in the debug
    log, without refusing (a resolver cannot be refused after the fact).
25. **The quest's own level is not on a goal row.** A dense row (count,
    level, distance on each goal) can read the count (`progress`) and where
    it is (`map`, `x`, `y`) from the goal the `guideRow` hook gets, and the
    level range of the spot chosen (`lvl`) for kill and collect goals, but
    not the quest's level. Suggested: add the compiled quest level to the
    step view's goal (the Engine has it as the guide's `qlvl`), documented
    with the other fields.
