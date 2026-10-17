# Security

## Reporting a problem

Report a security problem privately: on GitHub, open the repository's
**Security** tab and choose **Report a vulnerability**. Please don't open a
public issue or post it on Discord, so players are not exposed while it is
being fixed.

Say what you found, which version or commit, and how to see it happen. You
get a reply in the report itself; the fix and a credit (unless you'd rather
not be named) go in the changelog once it ships.

## What counts

- **The addon acting against the player**: mail, trade, the auction house,
  the guild bank, buying or spending without the player asking; chat or
  addon messages sent on its own; anything that runs code it was sent.
- **Community addons, guides and data**: a guide, data or locale file that gets the addon
  to run code, open a link or act for the player.
- **The toolchain**: a command that runs code from a pack, a pull
  request or a downloaded file, or reads or writes outside the repository
  and its data folders.
- **The project's automation**: the GitHub workflows, the Discord bot and
  its tokens.
- **A fake Polestar**: a download that claims to be Polestar or one of its
  addons but is not from this repository's releases or its CurseForge
  project.

A wrong step, a Lua error or a crash is a normal bug: use the issue forms or
Discord (CONTRIBUTING.md).

## Supported versions

The latest release, and `next` before it ships. Fixes go into a patch of the
latest release when they can (docs/RELEASING.md, "Patch releases").
