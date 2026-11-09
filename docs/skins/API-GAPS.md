# Skin API: gaps and rough edges (version 1, Polestar 0.3.7)

What a skin author runs into that the API does not cover, does
inconsistently, or that the documentation and the code disagree on. Found
while writing [docs/skins](README.md) and running every snippet against
`Theme.lua` (feat/settings-window). Each item says what happens, why it
matters to an author, and a suggested fix. Items marked **decision** need
the maintainer or Fitz, not just code.

## Tokens that are accepted but ignored

1. **`windowBorder` is a no-op on every base.** `resolve` and `resolveSkin`
   both end with `out.windowBorder = <player colour> or <accent> or
   copy(out.windowEdge or out.border)`, so a skin's `windowBorder` token
   never reaches the palette, yet `RegisterSkin` accepts it. Docs say "the
   player's setting wins", which reads as "else yours". Fix: either let the
   skin's token stand in the "else" branch (before `windowEdge`/`border`),
   or refuse the token in a spec as `belongs to the player`. The reference
   documents the current behaviour as "ignored on every base".
2. **`accentLine`, `padSelect`, `chipAccent`, `inputBg` are ignored on the
   `polestar` base** (overwritten from the accent and `shade` at the end of
   `resolve`), but honoured on `halo`, `hearth` and the game looks. Fix:
   `if not s.tokens.accentLine then out.accentLine = ... end` for the four,
   or document them as derived-only on the house style. Reference says
   "ignored on this base" today.
3. **A scheme accepts the game looks' tokens** (`bgBottom`, `skyBottom`,
   `windowEdge`, `frameEdge`, `frameEdgeDark`, `titleLine`) without
   complaint, though nothing on the house style reads them. Every other
   skin-only token is refused as "belongs to a skin". Fix: refuse these too
   (add them to the scheme check), for consistency and to catch typos.

## Hooks reach too little

4. **The arrow hook gets a frame with no reachable parts.** `Arrow.lua`
   keeps the dial, dart, glow, ring and texts in a local table `D`; the hook
   receives `PolestarNavArrow` only, so a skin can overlay the arrow but not
   restyle it (change the dart's texture, retint the distance text). The
   docs promised "the arrow's frame"; that is kept, but an author who wants
   a custom arrow has no way. Suggested: expose a read-mostly table of parts
   on the frame (`frame.psParts = { dial, dart, dartEdge, glow, ring,
   distText, labelText, etaText }`), documented, under a capability such as
   `arrow.parts`; or a `media.arrow` / `media.dart` texture slot, which
   covers the common case ("my own arrow art") without exposing internals.
5. **The pin hook's frame has fields, but they are internal.** `pin.icon`,
   `pin.medal`, `pin.mark`, `pin.ring2`, `pin.glow`, `pin.edge`, `pin.text`,
   `pin.fill`, `pin.ring`, `pin.back` exist and work, but no capability
   names them, so a skin that uses them is on unversioned ground. The
   reference lists them as "not part of the versioned API". Suggested: name
   the stable subset under `surfaces.pin` (or `pin.parts`), and keep the
   rest private.

## Lifecycle

6. **No re-registration in a session.** A second `RegisterSkin` with the
   same id is refused as taken, even from the same addon, so every change
   while developing means `/reload`. Fine for players, slow for authors.
   Suggested: allow re-registration **from the same `addon`** (replace the
   spec, repaint), or a `Theme.UpdateSkin(id, spec)` behind a capability
   `skins.update`. Low priority; the reference documents the reload loop.
7. **`onLeave` runs once after a skin fails.** `failSkin` sets `FAILED[id]`,
   `Refresh` → `switchSkin` then calls the failed skin's `onLeave` under
   pcall. Sensible (it lets the skin hide its own frames), but
   `docs/SKINS-API.md` says "Nothing of a broken skin runs again that
   session." One of the two should change; the new reference documents the
   actual behaviour. **Decision**: keep the `onLeave` call (recommended) and
   fix the sentence in SKINS-API.md.
8. **A refused registration is silent for the player.** Only the debug log
   and the return value say why; a player whose skin addon is broken sees
   Polestar's look and no skin in the picker, with nothing to tell the
   author. The example addon prints refusals itself, and the docs tell
   authors to. Optional: one chat line from Polestar on a refusal when the
   saved `ui.skin` names that id (the player chose it and it is missing),
   naming the addon.

## Messages

9. **`author` / `version` over 40 characters say "must be a string."** The
   limit is real (`textField`), the message does not mention it. Fix: "must
   be a string of 40 characters at most".
10. **`fontSizes.<role>` outside 6-40 says "has the wrong type."** Fix: "must
    be a number from 6 to 40".
11. **A scheme's legibility refusal can name a subject colour the author
    cannot change** (`dungeon on panelAlt reads 1.1:1`): the subject
    colours are fixed for schemes. The message is correct but puzzling.
    Suggested: for schemes, phrase it as "panelAlt is too light for
    Polestar's subject colours (dungeon reads 1.1:1, needs 4.5:1)".

## Settings window

12. **The accent's source label says "Polestar gold" while a registered
    scheme's or skin's `accent` is in use** (`UI/Looks/Theme.lua`, the
    `source` of `ui.accent`: EllesmereUI or "Polestar gold"). Fix: when
    `SCHEME_INFO[key].accent` or the live skin's `accent` token supplied
    the colour, show the scheme's / skin's name.
13. **No per-skin settings.** A skin addon that wants a toggle (a variant,
    a glow on/off) has only its own slash command or frame; the picker shows
    `desc` and `addon`, nothing more. Known and documented as "not in
    version 1". Suggested shape for a later capability `skins.options`: a
    `options = { { key, label, kind = "toggle"|"choice", values?, default } }`
    list in the spec, stored by Polestar under `ui.skinOptions.<id>.<key>`,
    read through `Theme.SkinOption(key)` in painters, drawn as rows under the
    skin card. **Decision**: whether Polestar should host other addons'
    settings at all.

## Documentation and policy

14. **Licence statement for skins: done.** LICENSE-EXCEPTION.md now has a
    "Skin addons" permission (GPL-3.0 section 7): an addon that changes
    Polestar's look only through the documented Skin API may be licensed as
    its author chooses; copying or modifying Polestar's code, and Polestar's
    own art and fonts, stay under their licences. The example addon is
    CC0-1.0 so its painter can be copied freely. The publishing page points
    at the section.
15. **The deprecation window is written by the docs, not by the code or a
    maintainer decision.** [versioning.md](versioning.md) says an old `api`
    stays accepted "for at least the next minor release line" after
    `API_VERSION` rises. That is a reasonable promise and costs nothing
    today, but it is a promise: **decision** to confirm or change before
    0.3.7 ships the docs.
16. **`docs/SKINS-API.md` and `docs/skins/` overlap.** The old page is
    reference plus walkthrough plus rationale on one page; the new folder
    splits it and adds getting-started, versioning, publishing, recipes and
    this list. Suggested: keep SKINS-API.md as a short landing page (the
    quick start and the comparison table) pointing into `docs/skins/`, or
    fold it entirely and leave a redirect line, so the two cannot drift.
    This branch adds a pointer at its top and leaves its content as is.
17. **Theme functions a skin will want are outside the version promise**:
    `Refresh`, `OnChanged`, `Skin`, `Repaint`, `Font`, `Border`, `Band`,
    `Metric`, `FontSpec`. A skin with its own frames needs at least
    `Refresh` and `OnChanged`. Suggested: bless `Refresh` and `OnChanged`
    (and `Skin`/`Font` for an addon's own frames) under a capability
    `theme.hooks` so they are documented as stable.

## Smaller notes

18. `media` paths and `font` file paths are not checked for existence (the
    client has no API for it). Documented; nothing to do beyond telling
    authors what a missing file looks like.
19. `SchemeChoices()` entries carry `desc` but not `author`;
    `SkinChoices()` carry both. Harmless; align for symmetry.
20. `Theme.Color(unknownToken)` answers the `text` colour rather than
    raising. Good for robustness; documented, since a typo in a painter
    shows as white rather than an error.
21. The example addon's TOC says `## Version: 0.3.5`; it registers
    `version = "1.0"` in its specs. Cosmetic; bump the TOC with the release.
22. The old SKINS-API.md walkthrough says the Moonlit painter adds a
    "one-pixel line"; the code sets `SetHeight(1)` in units, not pixels
    (`Theme.Pixel` would make it one pixel). The new recipes use
    `Theme.Pixel(frame)` where a pixel is meant.
