#!/usr/bin/env bash
# Prints the updater's latest.json for a release: latest-json.sh <dir> <version> <download base URL>
# <dir> holds the signed installers (each with its `tauri signer sign` .sig beside it).
#
# tauri-plugin-updater looks for `{os}-{arch}-{bundle}` first, then `{os}-{arch}`, where the
# bundle is the one the running copy was installed from (the bundler writes it into the binary:
# appimage, deb, msi, nsis, app). It installs what it downloads as that bundle: a .deb copy runs
# `dpkg -i` on it (through pkexec) and refuses anything that is not a .deb with "invalid updater
# binary format". So every bundle we ship needs its own key pointing at its own file; the plain
# `linux-x86_64` falls back to the AppImage, which a .deb copy cannot install (0.1.0 to 0.1.4
# had no deb keys, and their .deb installs could not update).
set -euo pipefail
dir="${1:?usage: latest-json.sh <dir> <version> <download base URL>}"
version="${2:?usage: latest-json.sh <dir> <version> <download base URL>}"
base="${3:?usage: latest-json.sh <dir> <version> <download base URL>}"

one() { # the one file matching a pattern, signed
	local f=("$dir"/$1)
	[ -f "${f[0]}" ] || { echo "::error::no $1 to put in latest.json" >&2; exit 1; }
	[ -f "${f[0]}.sig" ] || { echo "::error::$(basename "${f[0]}") has no .sig" >&2; exit 1; }
	jq -n --arg url "$base/$(basename "${f[0]}")" --rawfile sig "${f[0]}.sig" '{signature: $sig, url: $url}'
}

appimage="$(one '*_amd64.AppImage')"
appimage_arm="$(one '*_aarch64.AppImage')"
deb="$(one '*_amd64.deb')"
deb_arm="$(one '*_arm64.deb')"
msi="$(one '*_x64_*.msi')"
mac="$(one '*.app.tar.gz')"

jq -n --arg version "$version" --arg date "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
	--argjson appimage "$appimage" --argjson appimage_arm "$appimage_arm" \
	--argjson deb "$deb" --argjson deb_arm "$deb_arm" \
	--argjson msi "$msi" --argjson mac "$mac" \
	'{version: $version, notes: "", pub_date: $date, platforms: {
		"linux-x86_64": $appimage, "linux-x86_64-appimage": $appimage, "linux-x86_64-deb": $deb,
		"linux-aarch64": $appimage_arm, "linux-aarch64-appimage": $appimage_arm, "linux-aarch64-deb": $deb_arm,
		"windows-x86_64": $msi, "windows-x86_64-msi": $msi, "windows-x86_64-nsis": $msi,
		"windows-aarch64": $msi, "windows-aarch64-msi": $msi, "windows-aarch64-nsis": $msi,
		"darwin-aarch64": $mac, "darwin-x86_64": $mac, "darwin-aarch64-app": $mac, "darwin-x86_64-app": $mac}}'
