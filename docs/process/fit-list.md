# The fit decisions list

Every feature pull request and every idea issue gets the maintainer's yes,
no or later within three days ([CONTRIBUTING.md, "Before you build a
feature"](../../CONTRIBUTING.md#before-you-build-a-feature)). The triage
round prepares those decisions on one list a week, so the maintainer reads
each one in a minute and answers in his own words. Whoever fills the list
never answers for him: no decline, close, "not planned" or "not in this
release" goes on a contribution until he has said so about that one.

## When it is filled

- **Every triage round** adds what is new since the last one: feature pull
  requests opened, idea issues (the "Feature request" form, the
  `enhancement` label) and #suggestions posts that became issues.
- **Once a week** a new list starts. Anything unanswered carries over to the
  top of the new one with its age.
- **Day 2 of 3.** An entry not answered by the second day after it opened is
  marked **due** and raised with the maintainer directly, so the three days
  hold.
- **Laters coming due.** When a release is being planned, every "later:
  <that release>" from earlier lists comes back on the list as a "due" entry:
  it is a yes for that release now, or the maintainer says what changed.

## The list

One file a week, `fit-<year>-W<week>.md`, kept with the maintainer's notes.
What contributors see is the answer on their pull request or issue, posted
in the maintainer's words, never the list.

```markdown
# Fit decisions, week <week> (<first day> to <last day>)

Answer each with yes (release), no, or later (release), and a line in your
words for the author if you like.

## Due (opened 2+ days ago)

### #<N> <title> (<author>, pull request, opened <date>, due <date>)

- **What it adds:** what a player sees or presses, in one or two lines.
- **Scope:** guide / route / arrow (fits) or new window / game / data set /
  integration (later by default), and why.
- **Size:** files and folders touched, a new addon folder or saved setting,
  memory or start-up cost if it has one, what it adds to keep up.
- **Related:** earlier decisions, other pull requests or issues on the same
  thing, an idea issue it came from.
- **Questions for you:** what only the maintainer can decide (where it goes,
  default on or off).
- **Code state:** not reviewed (review starts after a yes); safety read
  done or not.
- **Answer:** <yes 0.x / no / later 0.x>, <your words>
- **Posted:** <link to the comment>, <date>

## New since last round

(the same entry for each)

## Answered this week

| # | Title | Author | Answer | Posted |
|---|---|---|---|---|

## Laters coming due

| # | Title | Later for | Asked again |
|---|---|---|---|
```

## After the answer

- **Yes:** the entry names the release, and the pull request or issue gets
  that release's milestone. The pull request gets its review from here
  (CONTRIBUTING.md, "How a pull request is reviewed"); an idea issue says
  so in its answer, so anyone can build it.
- **No:** the maintainer's words are posted as they are, with thanks. Where
  it fits, he may suggest the author's own addon.
- **Later:** posted with the release it names. The pull request or issue
  stays open with that release's milestone and comes back when that
  release is planned.
