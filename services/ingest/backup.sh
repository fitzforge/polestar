#!/usr/bin/env bash
# Nightly backup of the ingest database, run on the Docker host from the deploying user's
# crontab (README.md, "Backups"):
#
#   45 3 * * * $HOME/polestar-ingest/services/ingest/backup.sh >> $HOME/backups/polestar/backup.log 2>&1
#
# The server makes a consistent online copy, gzipped, into its /backup mount (the host folder
# INGEST_BACKUP_MOUNT, which the server's uid may write to). This script then encrypts it (gpg, AES256, with the
# passphrase in BACKUP_PASSPHRASE_FILE) or, without one, keeps it as plain gzip, mode 600, in
# $BACKUP_DIR; copies it off the box with rclone when BACKUP_REMOTE is set; and keeps the newest
# 7 here and 7 days of them there. Settings come from the deploy folder's .env:
#
#   INGEST_BACKUP_MOUNT      required: the host folder compose mounts at /backup
#   BACKUP_DIR               default $HOME/backups/polestar
#   BACKUP_PASSPHRASE_FILE   optional: encrypt with this passphrase
#   BACKUP_REMOTE            optional: rclone destination, e.g. remote:bucket/polestar-ingest
#
# Any failing step exits non-zero, so the log shows it.
set -euo pipefail

here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
env_file="$here/.env"
setting() { { grep -E "^$1=" "$env_file" 2>/dev/null || true; } | tail -n 1 | cut -d= -f2-; }
dir="$(setting BACKUP_DIR)"
dir="${dir:-$HOME/backups/polestar}"
passphrase_file="$(setting BACKUP_PASSPHRASE_FILE)"
remote="$(setting BACKUP_REMOTE)"
mount="$(setting INGEST_BACKUP_MOUNT)"
if [ -z "$mount" ]; then
	echo "set INGEST_BACKUP_MOUNT in $env_file (the host folder mounted at /backup)" >&2
	exit 1
fi
keep=7

umask 077
stamp="$(date -u +%Y-%m-%dT%H%M%SZ)"
name="ingest-$stamp.sqlite.gz"
incoming="$mount/$name"

docker exec polestar-ingest /polestar-ingest backup "/backup/$name"
size=$(stat -c %s "$incoming")
if [ "$size" -lt 200 ]; then
	echo "backup too small ($size bytes)" >&2
	exit 1
fi
gzip -t "$incoming"

if [ -n "$passphrase_file" ]; then
	out="$dir/$name.gpg"
	gpg --batch --yes --symmetric --cipher-algo AES256 --passphrase-file "$passphrase_file" --output "$out" "$incoming"
	pattern='ingest-*.sqlite.gz.gpg'
else
	out="$dir/$name"
	install -m 600 "$incoming" "$out"
	pattern='ingest-*.sqlite.gz'
fi
rm -f "$incoming"
chmod 600 "$out"

if [ -n "$remote" ]; then
	rclone copy "$out" "$remote/" --quiet
	rclone delete "$remote/" --include "$pattern" --min-age "${keep}d" --quiet
fi

# The newest $keep here (the names sort by date).
find "$dir" -maxdepth 1 -name "$pattern" -printf '%f\n' | sort | head -n "-$keep" | while read -r old; do
	rm -f "$dir/$old"
done

echo "$(date -u +%FT%TZ) ok $out $(stat -c %s "$out") bytes${remote:+, copied to $remote}"
