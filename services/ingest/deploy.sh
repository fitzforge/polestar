#!/usr/bin/env bash
# Deploys the committed ingest server to a Docker host over ssh and (re)starts it.
#
#   services/ingest/deploy.sh <ssh-target> [remote-dir] [git-ref]
#   INGEST_HOST=<ssh-target> INGEST_DIR=<remote-dir> services/ingest/deploy.sh
#
# remote-dir defaults to `polestar-ingest` (relative to the ssh user's home), git-ref to HEAD.
# The host's remote-dir holds the sources at their repository paths (services/ingest,
# rust/crates/polestar-recording) and the secrets in remote-dir/.env, which must exist with
# INGEST_MAINTAINER_KEY. A missing INGEST_SECRET is generated into it; it stays chmod 600.
set -euo pipefail
host=${1:-${INGEST_HOST:-}}
dir=${2:-${INGEST_DIR:-polestar-ingest}}
ref=${3:-HEAD}
if [[ -z $host ]]; then
	echo "usage: deploy.sh <ssh-target> [remote-dir] [git-ref]   (or INGEST_HOST, INGEST_DIR)" >&2
	exit 2
fi
cd "$(git rev-parse --show-toplevel)"
git archive --format=tar "$ref" services/ingest rust/crates/polestar-recording | ssh "$host" "dir=$(printf %q "$dir"); $(
	cat <<'REMOTE'
set -eu
test -f "$dir/.env" || { echo "missing $dir/.env (INGEST_MAINTAINER_KEY, INGEST_MIN_BUILD)" >&2; exit 1; }
chmod 600 "$dir/.env"
if ! grep -q '^INGEST_SECRET=.' "$dir/.env"; then
	printf 'INGEST_SECRET=%s\n' "$(head -c 32 /dev/urandom | od -An -v -tx1 | tr -d ' \n')" >> "$dir/.env"
	echo "generated INGEST_SECRET in $dir/.env"
fi
rm -rf "$dir/services" "$dir/rust"
tar -x -C "$dir"
ln -sfn ../../.env "$dir/services/ingest/.env"
cd "$dir/services/ingest"
docker compose up -d --build --remove-orphans
docker compose ps
REMOTE
)"
