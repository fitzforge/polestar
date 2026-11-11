# Versioning: what a skin can rely on

The Skin API is versioned so a skin written today keeps working on the
Polestars of next year, and so a skin can use a newer feature where it
exists without breaking where it does not. This page says what the numbers
mean, what Polestar promises to keep, and what it does not.

## The two mechanisms

**`Theme.API_VERSION`** is a whole number, `1` in Polestar 0.3.7. A spec may
say which version it was written for with `api = 1`. Polestar refuses a spec
whose `api` is higher than its own (`needs Skin API 2; this Polestar has 1
(update Polestar)`), and accepts any lower or equal one. The number rises
**only when a spec written for an older version would no longer mean the
same thing**: a field renamed, a token's meaning changed, a painter's
arguments reordered. It does not rise for additions.

**Capabilities** are named features: `Theme.HasCapability("surfaces.pin")`,
`Theme.Capabilities()`. Everything added to the API after version 1 arrives
as a new capability on the same version. A skin tests for the capability it
needs and leaves that part out where it is missing; the rest of the spec is
accepted as before.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local spec = { api = 1, name = "Forward", addon = ADDON, base = "halo" }
-- Imagine a later Polestar adds a "surfaces.minimap" painter: use it only there.
if Theme.HasCapability("surfaces.minimap") then
	spec.paint = { minimap = function(frame, base, kit) base(frame) end }
end
assert(Theme.RegisterSkin("ver-forward", spec))
```

Note the two cannot be mixed up: a spec field Polestar does not know is
refused as `unknown field`, so a skin that *unconditionally* uses a newer
field on an older Polestar is refused, cleanly, with the field's name, and
the player sees Polestar's own look. Guard new fields behind
`HasCapability`, or raise `api` so the refusal says "update Polestar".

## What is covered by the version

Within one `API_VERSION`, these keep their meaning and shape:

- `RegisterScheme` and `RegisterSkin`: their arguments, every documented
  spec field, the `ok, message` return, and that a refusal registers
  nothing.
- The **ids** rule, and that ids are first come, first served.
- Every **token name** in the [reference](reference.md#tokens) and what it
  stands for. The *default colour* behind a token may be tuned between
  releases (Polestar's own palettes are design work), so a skin that wants a
  precise colour sets the token rather than relying on the default.
- The **font roles** and their meaning (not their exact default sizes).
- The **surface kinds**, the painter signature `function(frame, base, kit)`,
  the frame marks (`psBare`, `psBgAlpha`, `psBgColor`, `psNoBorder`,
  `psGuide`, `psLight`, `psTextButton`, `psFocused`, `psSelected`), and the
  **paint kit**'s functions and arguments.
- The **hooks** `arrow(frame, style)` and `pin(pin)`, and when they are
  called; `guideTitle(nav, parts)` and the parts it names, where
  `surfaces.guideTitle` is offered.
- `onApply(id)`, `onLeave(id)`, and when they are called.
- The **legibility** floors (7:1 and 4.5:1), the correction behaviour and
  `strict`.
- The **run-time error** behaviour: pcall, one note, off for the session,
  the saved choice kept.
- The reading functions `Color`, `Accent`, `Wash`, `Hex`, `Palette`,
  `PaletteFor`, `Media`, `SkinMedia`, `Icon`, `SkinId`, `SkinKey`,
  `SkinScheme`, `SkinArrowStyle`, `SkinMapIcons`, `GameSkin`, `SchemeKey`,
  `SkinChoices`, `SchemeChoices`, `SkinInfo`, `SchemeInfo`, `HasCapability`,
  `Capabilities`, `DrawSkinCard`, `DrawSchemeCard`.
- The wording of refusal messages may be improved; their *substance* (which
  check failed) stays, and the `ok` boolean is what code should branch on.

## What is not covered

- The **fields on a pin frame** (`pin.icon`, `pin.medal`...) and anything
  else a hook reaches *inside* the frame it is given. Version 1 promises the
  frame and the call; the parts are Polestar's internals until a capability
  names them.
- **Other `Theme` functions** (`Refresh`, `OnChanged`, `Skin`, `Repaint`,
  `Font`, `Border`, `Band`, `Metric`, `FontSpec`...). They are public within
  Polestar and stable in practice, and a skin may use them, but check they
  exist and expect them to move with Polestar's own needs.
- The exact **list of frames** painted as each kind, and which kinds exist
  in Polestar's windows: Polestar adds windows and controls in every
  release. New frames of a known kind are painted by your painter for that
  kind, which is the point of painting by kind. A new *kind* comes with a
  new `surfaces.<kind>` capability.
- **Polestar's own palettes, media and sizes**: what your skin inherits from
  its base may change as Polestar's design does. A skin that sets a token,
  font or texture keeps it.
- `Theme.Palette()`'s **extra keys** that are not tokens (`arrow`,
  `arrowNear`, `arrowText`, `arrowNearText`, `scheme`, `skin`, `skinId`).
- Anything reached by digging into frames Polestar did not hand you
  (global frame names, `frame.psSkin`'s contents, texture layers the base
  painters use). The paint kit is the supported way to share a frame with
  the base.

## Deprecation

When something covered above has to change:

1. The change ships first as an **addition**: a new field, token or
   capability beside the old one, documented in the reference and in the
   changelog under "For guide authors" (the section skin API changes share
   until they get one of their own). The old one keeps working.
2. The old one is marked deprecated in the reference, with the replacement
   and the release that introduced it. Polestar may write a line to its
   debug log when a spec uses it (`/polestar debug`), never to the player's
   chat: a working skin stays silent.
3. It is removed only with a rise of `API_VERSION`, and then a spec that
   says `api = <old>` is still accepted for at least the next minor release
   line (`0.x`), translated or ignored as documented, so players on an
   unmaintained skin are not left on Polestar's own look overnight.

Nothing in version 1 is deprecated.

## Checking versions from a skin

Three layers, cheapest first:

```lua
local ADDON = ...
local Theme = Polestar and Polestar.Theme
-- 1. Is there a Skin API at all? (Polestar 0.3.6 and older: no.)
if not (Theme and Theme.RegisterSkin) then return end
-- 2. Is it a version this file understands? (Only ever higher than you expect.)
if Theme.API_VERSION > 1 then
	-- Still fine: version 1 specs keep working within a higher version until
	-- the deprecation window closes. Say so in debug output if you like.
end
-- 3. Which optional pieces are there?
local hasPin = Theme.HasCapability("surfaces.pin")
assert(type(hasPin) == "boolean")
```

Polestar's own version is at `C_AddOns.GetAddOnMetadata("Polestar",
"Version")` (or `GetAddOnMetadata` on older clients), but prefer the API
version and capabilities: they say what the code can do rather than when it
shipped.

## Where changes are announced

- `CHANGELOG.md` in the repository, and the release notes on GitHub: skin
  API changes are listed with the version and capability they add.
- The [reference](reference.md) is kept to the shipping Polestar; a
  capability's row says the release it arrived in once there is more than
  one.
