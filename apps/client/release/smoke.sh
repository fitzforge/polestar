#!/usr/bin/env bash
# The launch test: smoke.sh <client binary or AppImage> [seconds, default 15]
# Starts a built Polestar Client once with POLESTAR_SMOKE (src-tauri/src/smoke.rs) on a virtual
# display (xvfb-run, when there is no display or it is set to use one) and a throwaway HOME, and
# exits with the client's status: 0 when the window loaded and showed no fault, else non-zero.
set -euo pipefail

app=$(realpath "$1")
seconds=${2:-15}
home=$(mktemp -d)
trap 'rm -rf "$home"' EXIT

run=()
if [ -z "${DISPLAY:-}${WAYLAND_DISPLAY:-}" ] || [ -n "${SMOKE_XVFB:-}" ]; then
	run=(xvfb-run -a -s "-screen 0 1280x800x24")
	unset WAYLAND_DISPLAY
fi
# An AppImage on a runner without FUSE unpacks itself and runs from there.
env -u XDG_CONFIG_HOME -u XDG_DATA_HOME -u XDG_CACHE_HOME \
	HOME="$home" POLESTAR_SMOKE="$seconds" APPIMAGE_EXTRACT_AND_RUN=1 \
	timeout $((seconds + 60)) "${run[@]}" "$app"
