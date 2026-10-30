# Polestar Client

A small desktop app for Windows, macOS and Linux that keeps Polestar's
addons for World of Warcraft: Forever installed and up to date, and takes
part in Polestar's crowd recording program: once you agree, it uploads what
the Polestar Recorder writes so Polestar's guides and data get better, and
it shows exactly what it sends before it sends it.

[docs/RECORDING.md](../../docs/RECORDING.md) is the contract the recording
side follows: the record kinds, the SavedVariables layout, the ack file and
the upload API, and the public list of what is never collected.

## What it does

- **Setup** only finds the game: it detects Forever installs (Windows,
  macOS, and Wine, Proton, Lutris, Bottles, Steam and Faugus prefixes on
  Linux; one World of Warcraft folder may hold more than one Forever client,
  each offered on its own) or lets you pick the folder, and says precisely
  what is wrong with a folder that is not Forever. A folder chosen earlier
  that no longer works is said to be so, with why, and the installs found are
  still offered. The client folder chosen (`…/_forever_`) is what Settings
  keeps. Then the Addons page is ready to use.
- **Recording is opt-in.** Until you press "Start sharing" on the Recording
  section's "Help improve Polestar's guides" page (what is shared, what
  never is), nothing is uploaded and the Recorder is not installed for you.
  Settings has "Share my play" to stop again.
- **Addons** lists Polestar, Polestar Recorder and LibForeverData: the
  version installed, the newest release on
  [GitHub](https://github.com/fitzforge/polestar/releases) (Polestar and the
  Recorder from the `v*` releases' `Polestar-<v>.zip` and
  `Polestar_Recorder-<v>.zip`, LibForeverData from `lib-v*`), its changelog,
  and Install, Update, Update all, Repair and Uninstall, each showing how far
  it has got (downloading with the share received, checking, installing). Every download is
  checked against the SHA-256 GitHub publishes for it and against the
  release's `SHA256SUMS`, unpacked into a staging folder, checked for the
  folders it must hold (each with its .toc), and swapped in with the old
  folders kept as a backup until the new ones are in place (a zip over 1 GB
  unpacked, or with a name Windows treats as a device or stream, such as
  `COM1.lua` or `a.lua:x`, is refused whole). If a failed swap can't put
  every old folder back, that backup is kept as
  `AddOns/.polestar-client-backup-<time>` and the message names it; it is
  never wiped by a later install. A product only
  touches its own folders: Polestar's are `Polestar` and the `Polestar_*`
  folders whose .toc says `## Author: Polestar` (an update also removes the
  ones its new release no longer has); never another addon. Updates are
  looked for every 6 hours (off in Settings) and announced in the tray;
  they install by themselves only if you turn that on, and never while the
  game is running. The Stable channel offers releases, Beta pre-releases too.
- **Community** installs Community Guides players publish on
  [polestar.guide](https://polestar.guide): installed guides first, then the
  others, searchable by title and author, each with Install, Update, Remove,
  its changelog and homepage. The list is the site's guide index
  (`/api/v1/packs/index.json`, fetched by ETag with the 6-hourly update
  check), trusted only with its detached ed25519 signature
  (`index.json.sig?for=<id>`) from a key pinned in `src-tauri/src/packs.rs`:
  the SHA-256 of the exact bytes, the signature, an index no older than the
  last one accepted (kept in `packs.json`) and not past its `expires`. Two
  production keys are pinned: `polestar-1` (the live signer) and `polestar-2`
  (held offline for rotation); the signature's `keyId` picks one. The
  development site's key is trusted only by debug builds. A release build
  always takes Community Guides from polestar.guide and sends recordings to
  `https://data.polestar.guide` (`store::DEFAULT_SERVER`), whatever
  `settings.json` says: both addresses can be changed (Settings > Advanced,
  e.g. `http://localhost:3100` for the site) only in a debug build, for
  developing the site or the server. While the community site or the
  recording server is not the default (so only in a debug build), a banner
  says so on every page.
  Each guide in the index has a `uid` (fixed for that guide, never reused),
  a `publisher` (`id` and `handle`), `published` (when this version came
  out, set by the site) and `reviewed` (a moderator approved it). The index
  also lists `revoked` guides: `id`, `uid`, `versions` (exact versions, or
  `"*"` for all) and a `reason` with an `action`. A guide's `download.url`
  must be on the site's own origin (scheme, host and port); a redirect may
  not leave that origin or go from https to http. Server answers are read up
  to 64 KiB, and a `Retry-After` is held to at most 5 minutes (1 day for a
  503). A guide is installed only into a game whose Interface matches the
  guide's `toc` and with Polestar at least its `minPolestar` (otherwise the
  page says why). Its zip must match the index's SHA-256 and size (at most
  20 MB, 100 MB unpacked) and hold only what the guide compiler makes: the
  folders the index lists (`PolestarPack_<id>` and
  `PolestarPack_<id>_<locale>`), each with its `.toc`, the `.lua` files that
  TOC lists, `.tga` and `.blp` pictures and LICENSE/README texts. No `.xml`,
  no `.png`. A TOC may list only the generated files (`Pack.lua`,
  `MapFrames.lua`, `Guides.lua`; in a locale folder `Texts.lua`) and use
  only the generated `## Key:` lines (Interface, Title, Notes, Author,
  Version, Category, Group, Dependencies, LoadOnDemand, X-Polestar-*,
  X-License, X-Website, Title-/Notes-<locale>), so no SavedVariables,
  LoadWith, LoadManagers or AllowLoad. Each TOC says its guide's id
  (`## X-Polestar-Pack: <id>`, locale folders `## X-Polestar-Texts: <id>`).
  A guide writes or removes only folders that don't exist yet or already
  carry its id, swapped in like an addon with a backup; Polestar's own
  folders and every other addon are never touched. At install the client
  pins the guide's uid, publisher and folders (guides installed before this
  pin them on the first check). A different uid under the same id means the
  guide was replaced by another one: it shows as replaced and is only
  installed after you confirm. An update whose publisher or folders changed
  also asks first, naming what changed. Guide updates count in the Addons
  badge; Update all takes only the routine ones. They install by
  themselves only with their own setting, "Update guides automatically"
  (off by default), and then only with the game closed, a day after the
  version was published, and with the same uid, publisher and folders;
  anything else is announced in
  the tray and waits for you. With any guide installed, the 6-hourly check
  fetches the index even when update checks are off (then only for its
  revocations). A guide the site revokes (its id, pinned uid
  and installed version, or every version) is turned off or removed, even
  while the game runs: turned off moves its folders to the data folder's
  `disabled/<id>/` (Restore puts them back, unless it is still revoked);
  removed deletes them. Only the guide's own folders are touched. The tray,
  the guide's page and Activity give the site's reason; a /reload or
  restart makes the game notice. With "Count my guide installs" on (off by
  default) the client tells the site `{pack, version}` after an install,
  nothing else.
- **Links.** polestar.guide's install button opens
  `polestar://install?pack=<id>` (other parameters are ignored). The client
  comes up (a running one gets the link from the new start), opens Community
  on that guide once the intro has handed over, and asks: title, author,
  version, size and the folders it will create, with Install and Cancel. It
  never installs silently; a link it can't use says why. Links are taken one
  sheet at a time (at most one every 3 seconds); the same guide's link while
  its sheet is open is ignored. The scheme is
  registered by the installers on Windows and macOS (and by the client on
  Windows), by the `.deb`'s desktop entry, and by the desktop entry an
  AppImage writes for itself (`MimeType=x-scheme-handler/polestar`, made the
  default in `mimeapps.list` unless another program already is).
- **Recording.** Every 5 seconds the client looks at each account's
  `WTF/Account/<account>/SavedVariables/Polestar_Recorder.lua` (the game
  writes it when you log out or type `/reload`), waits until the file has
  been still for 3 seconds, reads it, replaces your characters' names in its
  text fields with `$N`, drops every line of a record kind it doesn't know
  (it can't check those, so they never leave the PC), and uploads the chunks
  it has not sent yet in requests of at most 2 MiB and 256 chunks. A chunk
  over the server's caps (64 KiB of text or 4096 records) is never sent, and
  never cut short; the log says which. Before its first upload to a server (or when
  the server answers `401 unknown token`) it registers: `POST /v1/register`
  gives a challenge, the client solves its proof of work on every core
  (about 4 million SHA-256 hashes at the default 22 bits, a few seconds;
  Status shows "Setting up"), and the server answers with a token it made.
  It then records in
  `Interface/AddOns/Polestar_Recorder/Ack.lua` the highest chunk the server
  accepted or already had among the ones that request sent, per Recorder
  install, so the addon can free the space. Once the player has turned
  sharing on at least once (`everShared` in `settings.json`), the same file
  carries `PolestarRecorderShare = true|false` (sharing on and not paused),
  written whenever that changes and with every ack: Start sharing is the one
  opt-in, and at the next login (or `/reload`) the Recorder turns itself on
  and says so, unless the player typed `/psrec off` (docs/RECORDING.md "Ack
  file"). **Status** says what it is doing (sharing on, sending, waiting for
  the game to save, can't reach the server and retrying, paused, some data
  skipped and why, or what needs your attention) and what this week's play
  added up to. While a file is still in the old format (schema 1) it offers
  to update the Recorder only when a newer one is published; with the latest
  installed it asks you to log in (or `/reload`) with it, and while no
  published Recorder records the new format yet it says the new one comes
  with the next Polestar update. **Activity** lists every upload and every
  addon change; **What we send** shows the next upload as a summary, event
  by event, and as the raw JSON.
- **Settings** has sharing and pause, the addon update options, start with
  your computer, the game folder, "Delete my data from the server", the
  frame-rate overlay (Ctrl+Shift+F anywhere, or `POLESTAR_FRAME_METER=1`
  from launch, with the last intro's numbers), counting guide installs and,
  in a debug build only, folded away under Advanced, the recording server
  and community site addresses.
- Closing the window keeps it running in the tray (Open, Pause/Resume, Quit).
- **The intro.** The window opens on a starlit intro (`index.html` holds
  its first frame, `src/lib/intro.svelte.ts` plays it) that ends with the
  Polestar star gliding into the app. It plays in full (about 5.5 s) on every
  launch and every time the window comes back from the tray, while Settings >
  General > "Play the full intro every launch" is on (the default); off, the
  first launch of a version plays it in full and later launches a short one.
  A click or any key skips it; started into the tray, it does not play. The
  window is shown once the intro's first frame exists (the page calls
  `window_ready`; `src-tauri/src/launch.rs`), or after 4 s (0.7 s coming back
  from the tray) whatever happens. The log says which intro played, when the
  window was shown and how smoothly the intro ran.
- **The window.** On Linux and Windows it has no system frame: the app draws
  its own title bar (drag anywhere along the top) and window controls
  (minimize, close to the tray). The window is one fixed size, 880×600,
  smaller only where the screen's work area is (`src-tauri/src/window.rs`); macOS keeps its traffic lights over the sidebar. On
  Linux the page is drawn through WebKitGTK's DMA-BUF renderer on the GPU,
  except on NVIDIA drivers older than 560 and machines without a GPU render
  node, where it uses the shared-memory renderer (`src-tauri/src/render.rs`;
  your own `WEBKIT_DISABLE_DMABUF_RENDERER` wins). The log's first line and
  the frame-rate overlay say which. Run as an AppImage, the client adds its
  own `polestar-client.desktop` and icon under `~/.local/share` so the
  taskbar shows its icon on Wayland, and keeps that entry pointing at the
  AppImage.

## On your PC

Everything lives in the app's data folder (Settings > Open data folder):

| File | What |
|---|---|
| `tokens.json` | Per server address, the token that server gave this PC when it registered (64 hex digits), readable only by you. It is sent only to the server that made it; the server stores only its SHA-256. |
| `settings.json` | Consent, pause, the game folder, the server address. |
| `progress.json` | Per Recorder install id: the last chunk sent and the last one the server confirmed. |
| `activity.json` | The last 500 uploads. |
| `sent.jsonl` | The chunks the server accepted in the last 8 days, for the Home page's week. |
| `packs.json` | Per community site (its address normalized: lowercase host, default port dropped, no trailing slash), the last guide index accepted (its bytes, signature and ETag): the Community page works offline, and an older index is never accepted after it. |
| `community.json` | Per installed guide, what it was pinned to at install (uid, publisher, folders), and the guides the site turned off or removed. |

"Delete my data from the server" calls `DELETE /v1/me`, then drops that
server's token, clears `sent.jsonl` and pauses uploads; the next upload
registers again.

## Developing

```sh
pnpm install
pnpm dev            # the window in a browser, backed by src/lib/mock.ts
pnpm tauri dev      # the real app
pnpm build          # type-check and build the frontend
cd src-tauri && cargo clippy --all-targets -- -D warnings
cargo test                                    # the installer's swap, zip-slip and version rules, the proof of work
cargo test -- --ignored live_github           # installs every addon from GitHub into a temp folder
```

In a plain browser `pnpm dev` answers the backend's commands from
`src/lib/mock.ts`; pick a state with `?state=` (`setup`, `setup-two`,
`setup-none`, `setup-problem`, `setup-saved`, `setup-scanning`, `optin`,
`home`, `running`, `registering`, `uploading`, `offline`, `paused`,
`attention`, `empty`); addon installs there run through their phases with
made-up timing. The mock is imported only behind `import.meta.env.DEV`, so it is
not in production builds.

The backend (`src-tauri/`) is its own Cargo project with its own
`Cargo.lock`, and uses the shared library
[`rust/crates/polestar-recording`](../../rust/crates/polestar-recording) by
path. The frontend is Svelte 5 with Vite and TypeScript; it follows
[docs/DESIGN.md](../../docs/DESIGN.md) (the Dusk scheme, one gold accent,
Inter, the starlit band). The glyphs, band and wordmark in
`src/assets/ui/` are PNG copies of the addon's textures in
`addon/Polestar/Media/UI/` (drawn by `tools/media/ui.js`); the Inter fonts
in `src/assets/fonts/` come from `addon/Polestar/Media/Fonts/` (SIL OFL,
`Inter-OFL.txt`). The motion system is in `src/lib/motion.ts` and
DESIGN.md's Motion section.

The app icons in `src-tauri/icons/` are made from `icons/app-icon.svg` (the
brand avatar, `docs/assets/avatar.svg`, on a rounded tile) and, for macOS,
`icons/app-icon-macos.svg` (the same inset to Apple's grid); `tray.png` is
`docs/assets/emblem.svg` at 64px:

```sh
pnpm tauri icon src-tauri/icons/app-icon.svg -o /tmp/icons            # then copy 32x32, 128x128, 128x128@2x, icon.png, icon.ico
pnpm tauri icon src-tauri/icons/app-icon-macos.svg -o /tmp/icons-mac  # then copy icon.icns
rsvg-convert -w 64 -h 64 ../../docs/assets/emblem.svg -o src-tauri/icons/tray.png
```

## Releasing

Set `version` in `package.json`, `src-tauri/Cargo.toml` and
`src-tauri/tauri.conf.json`, then push a tag `client-v<version>`.
[.github/workflows/client.yml](../../.github/workflows/client.yml) builds
every platform and attaches the installers, the updater artifacts and
`latest.json` to a draft release; publishing it makes the update visible to
installed copies, which look for the newest published `client-v*`
release.

The Linux and Windows builds hold no secrets. The signing secrets live only
in the GitHub environment `release`, used by two jobs: the macOS build (the
`APPLE_*` secrets, because signing and notarizing happen during the build)
and the release job, which runs no build code: it signs the updater files
with `tauri signer sign`, writes `latest.json` and creates the draft. The
environment must be set up in the repository's settings (Settings >
Environments > `release`): a required reviewer, and deployment limited to
tags matching `client-v*`. Without that, anyone who can push a tag gets a
signed build.

The updater's private key is not in the repository; its public half is
`plugins.updater.pubkey` in `src-tauri/tauri.conf.json`. CI reads the private
key from the `release` environment's `TAURI_SIGNING_PRIVATE_KEY` and
`TAURI_SIGNING_PRIVATE_KEY_PASSWORD` secrets. A local release build needs the
same two variables:

```sh
TAURI_SIGNING_PRIVATE_KEY="$(cat path/to/updater.key)" \
TAURI_SIGNING_PRIVATE_KEY_PASSWORD=... \
pnpm tauri build --bundles appimage,deb
```
