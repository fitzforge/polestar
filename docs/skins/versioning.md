# Versioning: what a skin can rely on

The Skin API is versioned so a skin written today keeps working on the
Polestars of next year, and so a skin can use a newer feature where it
exists without breaking where it does not. This page says what the numbers
mean, what Polestar promises to keep, and what it does not.

## The two mechanisms

**`Theme.API_VERSION`** is a whole number, `2` in Polestar 0.3.8, the first
release with the Skin API. Version 1 was the API's preview while 0.3.7 was
in development; a spec written for it (`api = 1`, or no `api` at all)
registers and paints on version 2 as it did. A spec may say which version it
was written for with `api = 2`. Polestar refuses a spec whose `api` is
higher than its own (`needs Skin API 3; this Polestar has 2 (update
Polestar)`), and accepts any lower or equal one.

The number went to 2 when the API first shipped, so a skin can say that it
needs what 0.3.8 brought. From here it rises **only when a spec written for
an older version would no longer mean the same thing**: a field renamed, a
token's meaning changed, a painter's or a hook's arguments reordered. It
does not rise for additions.

**Capabilities** are named features: `Theme.HasCapability("surfaces.pin")`,
`Theme.Capabilities()`. Everything added to the API after version 2 arrives
as a new capability on the same version. A skin tests for the capability it
needs and leaves that part out where it is missing; the rest of the spec is
accepted as before.

```lua
local ADDON = ...
local Theme = Polestar.Theme
local spec = { api = 2, name = "Forward", addon = ADDON, base = "halo" }
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
  spec field (`variants`, `resolve`, `shadow`, `artTint` and `preset`
  included), the `ok, message` return, and that a refusal registers
  nothing.
- The **ids** rule, and that ids are first come, first served.
- Every **token name** in the [reference](reference.md#tokens) and what it
  stands for. The *default colour* behind a token may be tuned between
  releases (Polestar's own palettes are design work), so a skin that wants a
  precise colour sets the token rather than relying on the default.
- The **font roles** and their meaning (not their exact default sizes).
- The **media** keys and what each texture is drawn as.
- The **surface kinds**, the painter signature `function(frame, base, kit)`,
  the frame marks (`psBare`, `psBgAlpha`, `psBgColor`, `psNoBorder`,
  `psGuide`, `psLight`, `psTextButton`, `psFocused`, `psSelected`), and the
  **paint kit**'s functions, arguments and options.
- The **hooks**, each where its capability is offered: their arguments,
  when they are called, the kinds they name, the **parts** they hand over by
  name (`arrow.parts`, `pin.parts`, the cards', toasts' and buttons' parts,
  the tabs' parts, the title's parts), what an answer does (`guideLayout`,
  `guideAnchor`, `guidePlace`), and the names `Theme.GuideParts()` gives.
- The **goal fields** the [reference](reference.md#the-guide-window) lists
  for `guideRow` and `guideRender`.
- The **resolver**'s call, its context fields and its answer.
- **Installed skin addons**: the `## X-Polestar-Skin` line and when
  Polestar loads such an addon.
- `onApply(id)`, `onLeave(id)`, and when they are called.
- The **legibility** floors (7:1 and 4.5:1), the correction behaviour and
  `strict`.
- The **run-time error** behaviour: pcall, one note, off for the session,
  the saved choice kept.
- The reading functions `Color`, `Accent`, `Wash`, `Hex`, `Palette`,
  `PaletteFor`, `SkinToken`, `Media`, `SkinMedia`, `Icon`, `SkinId`,
  `SkinKey`, `SkinScheme`, `SkinArrowStyle`, `SkinMapIcons`, `SkinVariants`,
  `SkinVariant`, `GameSkin`, `SchemeKey`, `SkinChoices`, `SchemeChoices`,
  `SkinInfo`, `SchemeInfo`, `InstalledSkins`, `LoadSkinAddon`,
  `LoadInstalledSkins`, `HasCapability`, `Capabilities`, `SkinSurfaces`,
  `SkinHooks`, `GuideParts`, `DrawSkinCard`, `DrawSchemeCard`, and the
  preset functions.
- With `theme.functions`: `Refresh`, `OnChanged`, `Skin`, `Repaint`, `Font`,
  `Border`, `Band` and `TintArt`
  ([reference](reference.md#other-theme-functions-a-skin-may-use)).
- The wording of refusal messages may be improved; their *substance* (which
  check failed) stays, and the `ok` boolean is what code should branch on.

## What is not covered

- What lies **inside** the frames and parts a hook is handed, beyond the
  names above: the other fields of a pin frame, a part's own children,
  texture layers, how the base drew it. The named parts are promised; the
  rest is Polestar's own.
- **Other `Theme` functions** (`Metric`, `FontSpec`, `SetFontScale`...).
  They are public within Polestar, and a skin may use them, but check they
  exist and expect them to move with Polestar's own needs.
- The exact **list of frames** painted as each kind, and which kinds exist
  in Polestar's windows: Polestar adds windows and controls in every
  release. New frames of a known kind are painted by your painter for that
  kind, which is the point of painting by kind. A new *kind* comes with a
  new `surfaces.<kind>` capability; so does a new hook.
- **Polestar's own palettes, media and sizes**: what your skin inherits from
  its base may change as Polestar's design does. A skin that sets a token,
  font or texture keeps it.
- The other **fields of a goal** in the step view (the Engine's, documented
  for Polestar's own code in `docs/ARCHITECTURE.md`).
- `Theme.Palette()`'s **extra keys** that are not tokens (`arrow`,
  `arrowNear`, `arrowText`, `arrowNearText`, `arrowGlow`, `scheme`, `skin`,
  `skinId`).
- Anything reached by digging into frames Polestar did not hand you
  (global frame names, `frame.psSkin`'s contents, texture layers the base
  painters use). The paint kit is the supported way to share a frame with
  the base.

## Deprecation

When something covered above has to change:

1. The change ships first as an **addition**: a new field, token, hook or
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

Nothing in version 2 is deprecated, and a version 1 spec needs no change.

## Checking versions from a skin

Three layers, cheapest first:

```lua
local ADDON = ...
local Theme = Polestar and Polestar.Theme
-- 1. Is there a Skin API at all? (Polestar 0.3.7 and older: no.)
if not (Theme and Theme.RegisterSkin) then return end
-- 2. Is it the version this file is written for, or a later one?
if Theme.API_VERSION < 2 then return end -- version 1, the preview: none of 0.3.8's additions
-- 3. Which optional pieces are there?
local hasPlace = Theme.HasCapability("surfaces.guidePlace")
assert(type(hasPlace) == "boolean")
```

Polestar's own version is at `C_AddOns.GetAddOnMetadata("Polestar",
"Version")` (or `GetAddOnMetadata` on older clients), but prefer the API
version and capabilities: they say what the code can do rather than when it
shipped.

## Where changes are announced

- `CHANGELOG.md` in the repository, and the release notes on GitHub: skin
  API changes are listed with the version and capability they add.
- The [reference](reference.md) is kept to the shipping Polestar; a
  capability's row says the version it arrived in.
