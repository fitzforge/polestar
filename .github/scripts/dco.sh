#!/usr/bin/env bash
# Checks that every commit of pull request $PR in $REPO carries a DCO sign-off
# ("Signed-off-by: Name <email>") matching its author by name or email.
# Merge commits and bot authors are exempt. Needs gh (GH_TOKEN) and jq.
# Used by .github/workflows/dco.yml; run it by hand with REPO=owner/name PR=N.
set -euo pipefail
: "${REPO:?}" "${PR:?}"

commits=$(gh api --paginate "repos/$REPO/pulls/$PR/commits" --jq '.[] | @base64')
bad=0 total=0
while IFS= read -r row; do
	[[ -z $row ]] && continue
	c=$(printf '%s' "$row" | base64 -d)
	sha=$(jq -r '.sha[0:9]' <<<"$c")
	parents=$(jq '.parents | length' <<<"$c")
	login=$(jq -r '.author.login // ""' <<<"$c")
	name=$(jq -r '.commit.author.name' <<<"$c")
	email=$(jq -r '.commit.author.email' <<<"$c")
	subject=$(jq -r '.commit.message | split("\n")[0]' <<<"$c")
	total=$((total + 1))
	if ((parents > 1)) || [[ $login == *"[bot]" ]]; then continue; fi
	ok=0
	while IFS= read -r line; do
		so_name=$(sed -E 's/^Signed-off-by:[[:space:]]*(.*[^[:space:]])[[:space:]]*<[^>]*>.*$/\1/' <<<"$line")
		so_email=$(sed -E 's/^.*<([^>]*)>.*$/\1/' <<<"$line")
		if [[ ${so_email,,} == "${email,,}" || ${so_name,,} == "${name,,}" ]]; then ok=1; break; fi
	done < <(jq -r '.commit.message' <<<"$c" | grep -E '^Signed-off-by:[[:space:]]*[^<]+<[^>]+>' || true)
	if ((ok == 0)); then
		bad=$((bad + 1))
		echo "::error::Commit $sha (\"$subject\") by $name has no sign-off matching its author."
	fi
done <<<"$commits"

if ((bad > 0)); then
	cat <<EOF

$bad of $total commit(s) lack a sign-off. Each commit needs a line
  Signed-off-by: Your Name <you@example.com>
matching its author, which records that you wrote it or have the right to
submit it under the project's licence (https://developercertificate.org).

To add it to every commit of this branch and update the pull request:
  git rebase --signoff origin/next
  git push --force-with-lease

From now on, commit with: git commit -s
EOF
	{
		echo "### Sign-off missing"
		echo
		echo "$bad of $total commit(s) lack a \`Signed-off-by:\` line. Fix: \`git rebase --signoff origin/next && git push --force-with-lease\`; then commit with \`git commit -s\`. See CONTRIBUTING.md, \"Sign-off\"."
	} >>"${GITHUB_STEP_SUMMARY:-/dev/null}"
	exit 1
fi
echo "All $total commit(s) signed off."
