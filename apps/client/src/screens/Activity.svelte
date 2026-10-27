<script lang="ts">
	import { app } from '../lib/app.svelte';
	import { api } from '../lib/backend';
	import { bytes, count, plural, when } from '../lib/format';
	import { rise } from '../lib/motion';
	import type { ActivityEntry, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Emblem from '../components/Emblem.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	let entries = $state<ActivityEntry[] | null>(null);
	let open = $state<number | null>(null);

	// Reload whenever the status moves on (a new upload lands in the log) or an addon changes.
	$effect(() => {
		void snapshot.status.lastUpload;
		void snapshot.status.kind;
		void snapshot.addons.products.map((p) => p.installed).join();
		api.activity().then((list) => (entries = list));
	});

	const VERB: Record<string, [string, string]> = {
		install: ['Installed', "Couldn't install"],
		update: ['Updated', "Couldn't update"],
		repair: ['Repaired', "Couldn't repair"],
		uninstall: ['Removed', "Couldn't remove"],
	};
	const clock = new Intl.DateTimeFormat('en-GB', { hour: '2-digit', minute: '2-digit' });

	/** When a batch that failed went through after all (the next upload after it). */
	function sentAgain(i: number): string | null {
		if (!entries) return null;
		for (let j = i - 1; j >= 0; j--) if (entries[j].kind === 'upload') return clock.format(entries[j].at);
		return null;
	}

	const glyph = (e: ActivityEntry) => (e.product ? 'layers' : e.kind === 'deleted' ? 'close' : e.kind === 'failed' ? 'plug' : 'qol-upgrade');
	const expand = (e: ActivityEntry) => (e.kind !== 'failed' && e.rejected.length > 0) || !!e.message;
</script>

<PageHeader title="Activity" subtitle="Every upload and addon change on this PC, newest first. The last 500 are kept, on this PC only." />

<div class="body">
	<div class="column">
		{#if entries && entries.length === 0}
			<div class="empty" in:rise>
				<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
				<span class="halo"><Glyph name="compact" size={36} color="var(--accent)" /></span>
				<h3>Nothing yet</h3>
				<p class="note">Addon installs and updates show up here, and so does each upload once you share your play: every time the game saves the Recorder's file (when you log out or type /reload).</p>
			</div>
		{:else if entries}
			<div class="list" role="list">
				{#each entries as entry, i (entry.at + ':' + i)}
					{@const expandable = expand(entry)}
					{@const again = entry.kind === 'failed' ? sentAgain(i) : null}
					<div class="entry" class:open={open === i} role="listitem" style:--i={i}>
						<button class="line" class:expandable disabled={!expandable} onclick={() => (open = open === i ? null : i)} aria-expanded={expandable ? open === i : undefined}>
							<span class="kind"><Glyph name={glyph(entry)} size={14} color={entry.kind === 'failed' || entry.message ? 'var(--warning)' : entry.product ? 'var(--textDim)' : 'var(--accent)'} /></span>
							<span class="what">
								{#if entry.kind === 'deleted'}
									Your data was deleted from the server
								{:else if entry.product}
									{VERB[entry.kind][entry.message ? 1 : 0]} {entry.product}{entry.version ? ` ${entry.version}` : ''}
								{:else}
									{entry.kind === 'failed' ? 'Tried to share' : 'Shared'} {bytes(entry.bytes)} of play
									<span class="muted small" title={entry.account ? `From the ${entry.account} account folder` : undefined}>· {plural(entry.records, 'event', 'events')}</span>
								{/if}
							</span>
							<span class="when num muted">{when(entry.at, app.now)}</span>
							<span class="result">
								{#if entry.kind === 'deleted'}
									<span class="chip">Fresh start</span>
								{:else if entry.product}
									{#if entry.message}<span class="chip warning">Failed</span>{:else}<span class="chip">Addon</span>{/if}
								{:else if entry.kind === 'failed'}
									<span class="chip warning">{again ? `Not delivered · sent again ${again}` : 'Not delivered yet'}</span>
								{:else}
									{#if entry.rejected.length}
										<span class="chip warning">{count(entry.rejected.length)} skipped</span>
									{:else if entry.duplicate.length && !entry.accepted.length}
										<span class="chip" title="The server already had it: nothing is stored twice">Already there</span>
									{:else}
										<span class="chip success">Received</span>
									{/if}
								{/if}
								<span class="chev" aria-hidden="true">{#if expandable}<Glyph name="chevron-down" size={12} color="var(--textDim)" />{/if}</span>
							</span>
						</button>
						{#if open === i}
							<div class="detail" in:rise={{ y: 4, duration: 180 }}>
								{#if entry.message}<p class="note selectable">{entry.message}</p>{/if}
								{#if entry.kind !== 'failed' && entry.rejected.length}
									<p class="note">The server couldn't read {entry.rejected.length === 1 ? 'one part' : `${entry.rejected.length} parts`} of this upload and skipped {entry.rejected.length === 1 ? 'it' : 'them'}. Everything else arrived; there is nothing for you to do.</p>
									{#each entry.rejected as r, j (j)}
										<p class="small muted selectable reason">{r.reason}</p>
									{/each}
								{/if}
							</div>
						{/if}
					</div>
				{/each}
			</div>
		{/if}
	</div>
</div>

<style>
	.list {
		border-top: 1px solid var(--divider);
	}
	.entry {
		border-bottom: 1px solid var(--divider);
		animation: enter 300ms var(--ease) backwards;
		animation-delay: calc(min(var(--i), 8) * 28ms + 180ms);
	}
	@keyframes enter {
		from {
			opacity: 0;
			transform: translateY(5px);
		}
	}
	.line {
		display: grid;
		grid-template-columns: 20px minmax(0, 1fr) 128px minmax(120px, auto);
		align-items: center;
		gap: var(--s3);
		width: 100%;
		min-height: 44px;
		padding: 0 4px 0 0;
		border: 0;
		background: none;
		text-align: left;
		transition: background-color var(--fast) var(--ease);
	}
	.line:disabled {
		cursor: default;
	}
	.line.expandable {
		cursor: pointer;
	}
	.line.expandable:hover {
		background: var(--hover);
	}
	.kind {
		display: grid;
		place-items: center;
	}
	.what {
		min-width: 0;
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
	}
	.when {
		text-align: right;
		white-space: nowrap;
	}
	.result {
		display: flex;
		align-items: center;
		justify-content: flex-end;
		gap: 6px;
	}
	.chev {
		display: grid;
		place-items: center;
		width: 12px;
		transition: transform var(--base) var(--ease);
	}
	.open .chev {
		transform: rotate(180deg);
	}
	.detail {
		padding: 0 0 var(--s3) 32px;
	}
	.detail p {
		margin: 4px 0 0;
		max-width: 70ch;
	}
	.reason {
		padding-left: 10px;
		border-left: 1px solid var(--border);
	}
	@container (max-width: 560px) {
		.line {
			grid-template-columns: 20px minmax(0, 1fr) auto;
		}
		.when {
			display: none;
		}
	}
	@media (prefers-reduced-motion: reduce) {
		.entry {
			animation: none;
		}
	}
</style>
