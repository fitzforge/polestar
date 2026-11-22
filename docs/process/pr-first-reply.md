# The first reply on a new pull request

Every pull request someone outside the team opens gets one reply from the
bot, so the contribution rules (CONTRIBUTING.md, "Before you build a
feature") reach people before they spend more work, not after.

## When it is posted

- On `pull_request_target` `opened` (drafts too), into any base branch.
- Once per pull request: the comment carries the marker
  `<!-- polestar:first-reply -->`, and a pull request that already has a
  comment with it gets no second one (reopened, edited, run again by hand).
- Not on pull requests from the team (author association `OWNER`, `MEMBER`
  or `COLLABORATOR`, as `tools/discord-bot/lib/known.js` counts the team)
  or from bots (Dependabot, the bot's own account).
- Like `pr-links.yml`, it reads the pull request only as text from the API
  and never checks out or runs its code.

## The text

Posted as it stands: everything between the `reply:start` and `reply:end`
lines, which the workflow reads from the base branch when it runs, so a
change to the text here needs no workflow change. `@<author>` is replaced
by the pull request's author.

```markdown
<!-- reply:start -->
<!-- polestar:first-reply -->
Thanks for this, @<author>! How it goes from here:

- **A fix** (a bug, a wrong step, a translation) goes straight to review.
  If it fixes an issue, put `Fixes #N` in the description, one line per
  issue, so it shows on the issue.
- **A feature** (something Polestar doesn't do yet) first gets the
  maintainer's answer on whether it fits: yes, no, or later with the
  release named. That answer comes within three days, before any technical
  review, so nobody asks you for changes on something that might not go
  in. Please hold off on more work on it until then.

Polestar is a leveling guide and its arrow. Features that make the guide,
the route or the arrow better go in; new windows, games, data sets and
integrations are later by default and need the maintainer's yes. Only the
maintainer turns down a contribution; reviews from anyone else are about
the code.

Next time you have an idea, open an issue or post it in #suggestions on
the [Polestar Discord](https://discord.gg/polestar) first: idea first,
pull request after the yes. The full rules are in
[CONTRIBUTING.md, "Before you build a feature"](https://github.com/fitzforge/polestar/blob/next/CONTRIBUTING.md#before-you-build-a-feature).
<!-- reply:end -->
```
