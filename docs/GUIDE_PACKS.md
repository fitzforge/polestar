# Community guides

A community addon is someone else's guides for Polestar. The first half of
this page is for players; the second half is for people who want to write
their own.

## For players

### What a community addon is

- A community addon is a separate addon, made by someone who is not part of
  Polestar.
- Its guides are that person's own. They are not Polestar's leveling routes,
  and Polestar does not test or vouch for them.
- Polestar does not ship, host or recommend any community addon. You only
  see one if you install it yourself.
- A community addon adds guides. It never replaces Polestar's guides or
  another community addon's.

### Telling a community addon from Polestar's own addons

In the game's AddOns list, Polestar has one entry in the Quests category.
Open it and you see Polestar's own addons and the community addons you have
installed, side by side.

- **Polestar's own addons** are Polestar Guides and the addons that carry
  Polestar's data (Polestar Quest Database, Polestar Item Data, Polestar
  Codex), plus Polestar Recorder for guide authors. Each lists Polestar as
  its author.
- **A community addon** built with Polestar's tools is titled "Polestar
  Community:" and its own name, such as "Polestar Community: Emberway
  Routes". One built before Polestar used that name reads "Polestar Pack:"
  until its author rebuilds it; Polestar reads both. Point at it and the
  tooltip shows its version and a line such as "Community addon for Polestar
  by Ashka", unless its author wrote a line of their own.

### Installing a community addon

1. Install Polestar first: a community addon does nothing without it.
2. Download it from wherever its author publishes it, such as CurseForge,
   Wago or the author's own site. Its page there should say that it needs
   Polestar.
3. Install it like any addon: with your addon app, or by unzipping it into
   the game's `Interface/AddOns` folder, next to the `Polestar` folders.
4. Restart the game. After the first install, `/reload` is enough when it
   updates.

### Where its guides show

Open the guide menu (`/polestar guides`). Below Polestar's own categories is
a heading, **Community guides**, with one entry per community addon: its
title and its author. Each guide's details say who wrote it, as "By <author>
· <title> <version> · <licence>".

Polestar suggests the next guide from its own guides. To have suggestions
come from a community addon instead, pick it under **Suggest guides from** in
Options > Community guides. Polestar's guides still fill in wherever the
community addon has nothing for your character.

### Turning a community addon on or off

Options > Community guides (`/polestar packs`) lists every community addon
you have installed, with its author, version, licence and website. The
switch on its row shows or hides its guides at once, without a reload. To
remove one for good, delete its folder or uninstall it in your addon app.

If a community addon cannot run, its row says why. If it has problems, the
row says how many, with **Show** to read them and **Copy report** to copy
them for the author.

### Who supports a community addon

Its author. Report wrong steps and other problems in a community addon to
its author, where they publish it, not to Polestar. The Community guides
page shows its website when the author gave one, and **Copy report** gives
you the details to send.

### A word on safety

A community addon is an addon like any other, and the game runs it like any
other. Install community addons only from authors you trust, and from the
place the author publishes them.

## For authors

### Your own guides, on Polestar's tools

If you write leveling guides, you can use everything Polestar uses for its
own:

- the guide format: plain text `.guide` files
  ([GUIDE_FORMAT.md](GUIDE_FORMAT.md), on one page in
  [GUIDE_CHEATSHEET.md](GUIDE_CHEATSHEET.md));
- the compiler, which fills in quest titles, givers and coordinates from the
  reference data;
- `lint`, which checks every guide, and `playtest`, which plays each one to
  the end in the real addon without the game;
- in the game, Polestar's guide engine, its waypoint arrow and its markers
  on the map.

Publish the result as your own addon, on the addon sites, in the shape
Polestar expects. Players install it next to Polestar and your guides appear
in Polestar's guide menu under **Community guides**, with your name on them.

### From an empty folder to a published community addon

```sh
git clone https://github.com/fitzforge/polestar.git
cd polestar
npm link               # puts `polestar` on your PATH
polestar data build    # the reference data every guide command reads
polestar doctor        # checks the setup and prints the fix for anything missing
cd ..                  # your pack goes beside the clone, not inside it
polestar new my-pack   # asks for the id, title, author and licence
cd my-pack
polestar dev --play    # lint and build on every save, with the browser playground
```

1. **`polestar new`** writes the pack: `pack.json`, an example guide, a
   README for your players and the `LICENSE` you chose. In a clone of the
   public repository it also writes a GitHub workflow that checks every push.
2. **Write your guides** in the `.guide` files. `polestar find <text>`
   prints quest, NPC and place lines ready to paste; in the game,
   `/polestar where` prints where you stand. An AI assistant can help you
   draft guides from your own material:
   [PACKS.md, "With an AI assistant"](PACKS.md#with-an-ai-assistant) says
   how, and why every id it writes needs checking. The pack `new` writes
   carries a skill for coding agents, polestar-guide-pack, with the
   workflow and the guide format on one page.
3. **Check them.** `polestar lint` checks every guide, and
   `polestar playtest` plays each one to the end in the real addon, for
   each race that can reach it and each class it has steps for.
4. **Try them in the game.** `polestar install` builds the pack and copies
   it into the game's AddOns folder; restart the game the first time.
5. **Build the release.** `polestar pack` writes
   `dist/<folder>-<version>.zip`.
6. **Publish it** as a new addon project on CurseForge, Wago or GitHub.
   On CurseForge and Wago, mark Polestar as a required dependency so the
   addon app installs it with your pack. With the template's workflow, a
   version tag on GitHub builds the zip and attaches it to a release.
7. **Update it**: raise `version` in `pack.json`, run `polestar pack` again
   and upload the new zip.

### What a pack holds

A community addon is built from a pack: a folder with a `pack.json` and
`.guide` files. You write two things:

- `pack.json`: the pack's `id`, `title`, `author`, `version` and `license`,
  all required, and optionally a `website`, a `source` (where the guides come
  from, in your words), a `notes` line for the AddOns list and a `folder`
  name.
- your `.guide` files.

`polestar compile` (run for you by `dev`, `install` and `pack`) writes the
addon from them: the TOC, `Pack.lua` with your credits, `Guides.lua` with
the compiled guides, `MapFrames.lua`, and the licence files. Do not edit
these by hand: rebuild instead. [PACK_FORMAT.md](PACK_FORMAT.md) has every
line of them.

The TOC places your community addon in the AddOns list for you: titled
"Polestar Community: <your title>", under Polestar's entry in the Quests
category, with the line "Community addon for Polestar by <author>" unless you
write your own `notes`. Community addons built before this name read
"Polestar Pack:" until you rebuild; Polestar reads both.
Polestar's own menus show your title as you wrote it.

### What the tools require

These are checked. `lint` reports them, and `compile`, `install` and `pack`
stop until they are fixed:

- `id`, `title`, `author`, `version` and `license` in `pack.json`. The id is
  2 to 32 lower-case letters, digits or hyphens, and not one Polestar
  reserves. A title and an author name are at most 64 characters.
- Every guide id starts with your pack id and a slash (`ashka-emberway/...`).
- The addon folder is not named `Polestar` and does not start with
  `Polestar_`. By default it is `PolestarPack_` and your title
  (`PolestarPack_EmberwayRoutes`).
- A `website`, when you give one, starts with `https://` or `http://`.
- A `next` line hands over only to a guide that exists, is for the same
  faction, and that the characters of your guide can follow.

`lint` also warns while `LICENSE` still holds the placeholder line `new`
writes for a licence it has no text for.

### What we ask of you

These are not checked by any tool. They are what players need to tell your
community addon apart and to reach you:

- **A name that says whose it is.** Pick a title of your own that cannot be
  mistaken for Polestar's own addons (the tools put "Polestar Community:"
  before it in the AddOns list), and say on your addon page that it is a
  community addon for Polestar. If you write your own `notes`, keep it
  clear that the community addon is yours and for Polestar.
- **Your name as author** (required), the name players will look for.
- **A version** you raise with every release (required by the tools).
- **A website or support link** in `website`, so the Community guides page
  shows players where to report problems. Say the same on your addon page and in
  your README.
- **A licence of your choice** for your guides. Polestar's
  [LICENSE-EXCEPTION.md](../LICENSE-EXCEPTION.md) lets you publish a
  community addon built by its compiler, including the reference data the compiler puts in
  it, under any terms you like.
- **Your own guide text.** Do not copy text from Polestar's own guides into
  your pack. The licence exception does not cover it. Handing over to one of
  Polestar's guides with `next` is fine: that points to the guide, it does
  not copy it.
- **Support for your pack.** Players are told to report problems in a pack
  to its author, so answer them there.

### More

[PACKS.md](PACKS.md) is the full handbook: setup on each system, the four
ways to write guides (by playing, from the simulator, by hand, with an AI
assistant), testing, publishing, updating after a game patch, and every
message the tools or the game can show, with its fix.

Questions, or a pack to show? Players and authors meet on the
[Polestar Discord](https://discord.gg/vMbee6F2e9).
