#!/usr/bin/env bash
# Nightly backup of the ingest database, run on the Docker host from the deploying user's
# crontab (README.md, "Backups"):
#
#   45 3 * * * $HOME/polestar-ingest/services/ingest/backup.sh >> $HOME/backups/polestar/backup.log 2>&1
#
# The server makes a consistent online copy, scrubbed of the day's network salt and compacted,
# gzipped and mode 600, into its /backup mount (the host folder INGEST_BACKUP_MOUNT, which the
# server's uid may write to). This script fetches it with `docker cp` (the file is the server
# uid's alone), checks it, encrypts it (gpg, AES256, with the passphrase in
# BACKUP_PASSPHRASE_FILE) into $BACKUP_DIR, copies it off the box with rclone when BACKUP_REMOTE
# is set (a new object per night; the bucket's own lifecycle rule expires them), and keeps the newest 7 here. The plain copy in the mount is
# removed however the script ends. Settings come from the deploy folder's .env:
#
#   INGEST_BACKUP_MOUNT      required: the host folder compose mounts at /backup
#   BACKUP_PASSPHRASE_FILE   required: encrypt with this passphrase
#   BACKUP_DIR               default $HOME/backups/polestar
#   BACKUP_REMOTE            optional: rclone destination, e.g. remote:bucket/polestar-ingest
#   BACKUP_MIN_FREE_MB       default 1024: free space both folders keep beyond a backup
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
min_free_mb="$(setting BACKUP_MIN_FREE_MB)"
min_free_mb="${min_free_mb:-1024}"
if [ -z "$mount" ]; then
	echo "set INGEST_BACKUP_MOUNT in $env_file (the host folder mounted at /backup)" >&2
	exit 1
fi
if [ -z "$passphrase_file" ] || [ ! -r "$passphrase_file" ]; then
	echo "set BACKUP_PASSPHRASE_FILE in $env_file to a readable passphrase file (backups are always encrypted)" >&2
	exit 1
fi
keep=7

# Free MiB on the filesystem holding $1.
free_mb() { df -Pm "$1" | awk 'NR == 2 { print $4 }'; }

umask 077
stamp="$(date -u +%Y-%m-%dT%H%M%SZ)"
name="ingest-$stamp.sqlite.gz"
incoming="$mount/$name"
out="$dir/$name.gpg"
trap 'rm -f "$incoming" "$out.part"' EXIT

if [ "$(free_mb "$mount")" -lt "$min_free_mb" ]; then
	echo "$mount: under $min_free_mb MiB free, no backup" >&2
	exit 1
fi
# The server refuses too when its folder lacks room for two copies of the database.
docker exec polestar-ingest /polestar-ingest backup "/backup/$name"
fetch() { docker cp "polestar-ingest:/backup/$name" - | tar -xO; }
size=$(fetch | wc -c)
if [ "$size" -lt 200 ]; then
	echo "backup too small ($size bytes)" >&2
	exit 1
fi
if [ "$(free_mb "$dir")" -lt $(( size / 1048576 + min_free_mb )) ]; then
	echo "$dir: under $(( size / 1048576 + min_free_mb )) MiB free, no backup" >&2
	exit 1
fi
fetch | gzip -t

pattern='ingest-*.sqlite.gz.gpg'
fetch | gpg --batch --yes --symmetric --cipher-algo AES256 --passphrase-file "$passphrase_file" --output "$out.part"
mv "$out.part" "$out"
rm -f "$incoming"
chmod 600 "$out"

# A new object per night, never overwritten. The remote expires old ones itself (a lifecycle
# rule; an object lock keeps them from being deleted early), so nothing is deleted from here.
if [ -n "$remote" ]; then
	rclone copyto "$out" "$remote/$name.gpg" --immutable --quiet
fi

# The newest $keep here (the names sort by date).
find "$dir" -maxdepth 1 -name "$pattern" -printf '%f\n' | sort | head -n "-$keep" | while read -r old; do
	rm -f "$dir/$old"
done

echo "$(date -u +%FT%TZ) ok $out $(stat -c %s "$out") bytes${remote:+, copied to $remote}"
