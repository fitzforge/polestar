#!/usr/bin/env bash
# Sends each installer in a directory to VirusTotal and prints a Markdown section linking every
# file's report, for the release notes. Usage: VT_API_KEY=... virustotal.sh <dir>
# The key is a free one shared with polestar.guide's guide scanner (4 requests a minute, 500 a
# day in all), so this stays light: a hash lookup first, an upload only for a file VirusTotal
# hasn't seen, and one request every 16 s. Files over 32 MB (the AppImages) go through the
# large-file upload URL. The links name each file by SHA-256, so they open the report even while
# a scan is still running.
set -euo pipefail
dir="${1:?usage: virustotal.sh <dir>}"
: "${VT_API_KEY:?VT_API_KEY is not set}"
api=https://www.virustotal.com/api/v3
small=$((32 * 1024 * 1024))
first=1
vt() { # one request, spaced out
	[ "$first" = 1 ] || sleep 16
	first=0
	curl -sS -H "x-apikey: $VT_API_KEY" "$@"
}

shopt -s nullglob
files=("$dir"/*.exe "$dir"/*.msi "$dir"/*.dmg "$dir"/*.AppImage "$dir"/*.deb)
[ ${#files[@]} -gt 0 ] || { echo "no installers in $dir" >&2; exit 1; }

echo "## Virus scans"
echo
echo "Every download was checked on [VirusTotal](https://www.virustotal.com) when it was released:"
echo
echo "| File | SHA-256 | Report |"
echo "|---|---|---|"
json="$dir/virustotal.json" # for polestar.guide: each installer's hash and report, attached to the release
echo '[]' > "$json"
for f in "${files[@]}"; do
	name="$(basename "$f")"
	sha="$(sha256sum "$f" | cut -d' ' -f1)"
	jq --arg file "$name" --arg sha256 "$sha" --arg report "https://www.virustotal.com/gui/file/$sha" \
		'. + [{file: $file, sha256: $sha256, report: $report}]' "$json" > "$json.tmp" && mv "$json.tmp" "$json"
	known="$(vt -o /dev/null -w '%{http_code}' "$api/files/$sha")"
	if [ "$known" = 404 ]; then
		url="$api/files"
		if [ "$(stat -c %s "$f")" -gt "$small" ]; then
			url="$(vt -f "$api/files/upload_url" | jq -er .data)"
		fi
		vt -f -F "file=@$f" "$url" >/dev/null
		echo "uploaded $name" >&2
	elif [ "$known" = 200 ]; then
		echo "already known: $name" >&2
	else
		echo "VirusTotal answered $known for $name" >&2
		exit 1
	fi
	echo "| \`$name\` | \`$sha\` | [VirusTotal](https://www.virustotal.com/gui/file/$sha) |"
done
