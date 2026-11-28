<script lang="ts">
	// Report a problem (#832), from Settings > About. The player says what went
	// wrong and reads the whole report below it, as it will be sent: the versions,
	// the status, the problems on screen and the recent failures, with account
	// names, the user name, folder paths and tokens replaced (lib/report.ts).
	// Copy report puts it on the clipboard for the Polestar Discord's #bugs; Open on
	// GitHub opens a new issue with it filled in. Polestar Client sends nothing
	// itself. Focus starts in the text box, Tab stays inside, Escape or the scrim
	// closes it, and focus goes back to the button that opened it.
	import { onMount } from 'svelte';
	import { api, message } from '../lib/backend';
	import { fade, rise, swap } from '../lib/motion';
	import { DESC_MAX, issueUrl, ready, reportText } from '../lib/report';
	import { toast } from '../lib/toast.svelte';
	import type { ActivityEntry, Snapshot } from '../lib/types';
	import Band from './Band.svelte';
	import Glyph from './Glyph.svelte';

	let { snapshot, onclose }: { snapshot: Snapshot; onclose: () => void } = $props();

	const DISCORD_URL = 'https://discord.gg/polestar';

	let description = $state('');
	let activity = $state<ActivityEntry[] | null>(null);
	let system = $state<{ os?: string; renderer?: string } | null>(null);
	let copied = $state(false);

	onMount(() => {
		const opener = document.activeElement instanceof HTMLElement ? document.activeElement : null;
		box?.focus();
		api.activity().then(
			(a) => (activity = a),
			() => (activity = []),
		);
		api.diagnostics().then(
			(d) => (system = d),
			() => {},
		);
		return () => opener?.focus();
	});

	const input = $derived({ description, snapshot, activity, system });
	const report = $derived(reportText(input));
	const canSend = $derived(ready(description));

	async function copy() {
		try {
			await navigator.clipboard.writeText(report);
			copied = true;
			setTimeout(() => (copied = false), 1800);
		} catch (e) {
			toast(message(e), 'warning');
		}
	}

	async function openIssue() {
		try {
			await api.openLink(issueUrl(input));
		} catch (e) {
			toast(message(e), 'warning');
		}
	}

	let panel: HTMLElement;
	let box = $state<HTMLTextAreaElement>();

	function keys(e: KeyboardEvent) {
		if (e.key === 'Escape') {
			e.preventDefault();
			onclose();
		} else if (e.key === 'Tab') {
			const items = [...panel.querySelectorAll<HTMLElement>('button:not(:disabled), textarea, [tabindex="0"]')];
			const first = items[0];
			const last = items[items.length - 1];
			if (e.shiftKey && document.activeElement === first) {
				e.preventDefault();
				last?.focus();
			} else if (!e.shiftKey && document.activeElement === last) {
				e.preventDefault();
				first?.focus();
			}
		}
	}
</script>

<svelte:window onkeydown={keys} />

<div class="scrim" role="presentation" onclick={onclose} transition:fade={{ duration: 200 }}></div>
<div class="sheet" role="dialog" aria-modal="true" aria-labelledby="report-title" bind:this={panel} in:rise={{ y: 10, duration: 240 }} out:fade={{ duration: 140 }}>
	<Band height={96}>
		<div class="head">
			<span class="mark"><Glyph name="info" size={18} color="var(--accent)" /></span>
			<div class="titles">
				<p class="small dim kind">Polestar Client {snapshot.version}</p>
				<h2 id="report-title">Report a problem</h2>
			</div>
		</div>
	</Band>

	<div class="content">
		<label class="small muted" for="report-what">What went wrong? What did you do, and what did you expect?</label>
		<textarea id="report-what" class="field what" bind:this={box} bind:value={description} maxlength={DESC_MAX} rows="4" spellcheck="true"></textarea>
		<p class="small muted lead">The report, as it will be sent. Account names, your user name, folder paths and tokens are replaced where the client finds them, so read it before you send it.</p>
		<!-- svelte-ignore a11y_no_noninteractive_tabindex -->
		<pre class="report selectable" tabindex="0" aria-label="The report">{report}</pre>
		<p class="note">
			Polestar Client sends nothing itself. Paste the report in the Polestar Discord's #bugs, or open it as an issue on GitHub (a GitHub account is needed).
			<button class="link" onclick={() => api.openLink(DISCORD_URL)}>Get the Discord invite</button>
		</p>
	</div>

	<footer>
		<span class="spacer"></span>
		<button class="btn quiet" onclick={onclose}>Close</button>
		<button class="btn" disabled={!canSend} title={canSend ? undefined : 'Say what went wrong first.'} onclick={openIssue}>Open on GitHub</button>
		<button class="btn primary" disabled={!canSend} title={canSend ? undefined : 'Say what went wrong first.'} onclick={copy}>
			{#if copied}<span class="ok" in:swap><Glyph name="check" size={12} color="currentColor" />Copied</span>{:else}Copy report{/if}
		</button>
	</footer>
</div>

<style>
	.scrim {
		position: fixed;
		inset: 0;
		z-index: 45;
		background: rgba(5, 8, 15, 0.6);
	}
	.sheet {
		position: fixed;
		z-index: 46;
		left: 50%;
		top: 50%;
		width: min(560px, calc(100% - 48px));
		max-height: calc(100% - 48px);
		margin: 0;
		translate: -50% -50%;
		display: flex;
		flex-direction: column;
		background: var(--bg);
		border: 1px solid var(--border);
		box-shadow: var(--shadowWindow);
	}
	.head {
		position: relative;
		display: flex;
		align-items: center;
		gap: var(--s3);
		padding: 26px var(--s5) 0;
	}
	.mark {
		display: grid;
		place-items: center;
		flex: none;
		width: 40px;
		height: 40px;
		background: var(--inset);
		border: 1px solid var(--border);
	}
	.kind {
		margin: 0 0 3px;
	}
	h2 {
		margin: 0;
		font-size: 18px;
		font-weight: 600;
		line-height: 24px;
	}
	.content {
		display: flex;
		flex-direction: column;
		gap: 6px;
		min-height: 0;
		overflow-y: auto;
		padding: var(--s2) var(--s5) var(--s5);
	}
	.content > p {
		margin: 0;
	}
	.what {
		height: auto;
		min-height: 80px;
		padding: 8px 10px;
		resize: vertical;
		font: inherit;
		font-size: 12px;
		line-height: 1.5;
	}
	.lead {
		margin-top: var(--s3) !important;
	}
	.report {
		margin: 0 0 var(--s3);
		max-height: 220px;
		overflow: auto;
		padding: var(--s2) var(--s3);
		background: var(--inset);
		border: 1px solid var(--border);
		font: 500 11px/1.5 ui-monospace, 'SF Mono', 'Cascadia Mono', 'DejaVu Sans Mono', monospace;
		white-space: pre-wrap;
		overflow-wrap: anywhere;
	}
	.ok {
		display: inline-flex;
		align-items: center;
		gap: 6px;
	}
	footer {
		display: flex;
		align-items: center;
		gap: var(--s2);
		height: 56px;
		flex: none;
		padding: 0 var(--s5);
		background: var(--footer);
		border-top: 1px solid var(--border);
	}
	.spacer {
		flex: 1;
	}
</style>
