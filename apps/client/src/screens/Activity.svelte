<script lang="ts">
	import { app } from '../lib/app.svelte';
	import { api } from '../lib/backend';
	import { bytes, date, when } from '../lib/format';
	import { msg, t, tn } from '../lib/i18n.svelte';
	import { rise } from '../lib/motion';
	import type { ActivityEntry, Snapshot } from '../lib/types';
	import PageHeader from '../components/PageHeader.svelte';
	import Glyph from '../components/Glyph.svelte';
	import Emblem from '../components/Emblem.svelte';

	let { snapshot }: { snapshot: Snapshot } = $props();

	let entries = $state<ActivityEntry[] | null>(null);
	let open = $state<number | null>(null);

	// Reload whenever the status moves on (a new upload lands in the log), an addon changes, or a guide does.
	$effect(() => {
		void snapshot.status.lastUpload;
		void snapshot.status.kind;
		void snapshot.addons.products.map((p) => p.installed).join();
		void snapshot.community.packs.map((p) => `${p.status}:${p.installed}`).join();
		api.activity().then((list) => (entries = list));
	});

	/** What happened to an addon or guide, done and failed; `{name}` is it and its version. */
	const VERB: Record<string, [string, string]> = {
		install: [msg('Installed {name}'), msg("Couldn't install {name}")],
		update: [msg('Updated {name}'), msg("Couldn't update {name}")],
		repair: [msg('Repaired {name}'), msg("Couldn't repair {name}")],
		uninstall: [msg('Removed {name}'), msg("Couldn't remove {name}")],
		restored: [msg('Restored {name}'), msg("Couldn't restore {name}")],
	};
	const clock = (ms: number) => date(ms, { hour: '2-digit', minute: '2-digit' });
	const named = (e: ActivityEntry) => `${e.product ?? ''}${e.version ? ` ${e.version}` : ''}`;

	/** When a batch that failed went through after all (the next upload after it). */
	function sentAgain(i: number): string | null {
		if (!entries) return null;
		for (let j = i - 1; j >= 0; j--) if (entries[j].kind === 'upload') return clock(entries[j].at);
		return null;
	}

	/** The community site turned a guide off or removed it; `message` is its reason, not a failure. */
	const revoked = (e: ActivityEntry) => e.kind === 'disabled' || e.kind === 'removed';
	const glyph = (e: ActivityEntry) => (e.product ? 'layers' : e.kind === 'deleted' ? 'close' : e.kind === 'failed' ? 'plug' : 'qol-upgrade');
	const expand = (e: ActivityEntry) => (e.kind !== 'failed' && e.rejected.length > 0) || !!e.message;
</script>

<PageHeader title={t('Activity')} subtitle={`${t('Every upload and addon change on this PC, newest first.')} ${t('The last 500 are kept, on this PC only.')}`} />

<div class="body">
	<div class="column">
		{#if entries && entries.length === 0}
			<div class="empty" in:rise>
				<div class="watermark" aria-hidden="true"><Emblem size={168} /></div>
				<span class="halo"><Glyph name="compact" size={36} color="var(--accent)" /></span>
				<h3>{t('Nothing yet')}</h3>
				<p class="note">{t("Addon installs and updates show up here, and so does each upload once you share your play: every time the game saves the Recorder's file (when you log out or type /reload).")}</p>
			</div>
		{:else if entries}
			<div class="list" role="list">
				{#each entries as entry, i (entry.at + ':' + i)}
					{@const expandable = expand(entry)}
					{@const again = entry.kind === 'failed' ? sentAgain(i) : null}
					<div class="entry" class:open={open === i} role="listitem" style:--i={i}>
						<button class="line" class:expandable disabled={!expandable} onclick={() => (open = open === i ? null : i)} aria-expanded={expandable ? open === i : undefined}>
							<span class="kind"><Glyph name={glyph(entry)} size={14} color={entry.kind === 'failed' || entry.message || revoked(entry) ? 'var(--warning)' : entry.product ? 'var(--textDim)' : 'var(--accent)'} /></span>
							<span class="what">
								{#if entry.kind === 'deleted'}
									{t('Your data was deleted from the server')}
								{:else if revoked(entry)}
									{entry.kind === 'disabled' ? t('{name} turned off by the community site', { name: named(entry) }) : t('{name} removed by the community site', { name: named(entry) })}
								{:else if entry.kind === 'restored' && !entry.message}
									{t('{name} restored', { name: named(entry) })}
								{:else if entry.product}
									{t(VERB[entry.kind][entry.message ? 1 : 0], { name: named(entry) })}
								{:else}
									{entry.kind === 'failed' ? t('Tried to share {size} of play', { size: bytes(entry.bytes) }) : t('Shared {size} of play', { size: bytes(entry.bytes) })}
									<span class="muted small" title={entry.account ? t('From the {account} account folder', { account: entry.account }) : undefined}>· {tn('{count} event', '{count} events', entry.records)}</span>
								{/if}
							</span>
							<span class="when num muted">{when(entry.at, app.now)}</span>
							<span class="result">
								{#if entry.kind === 'deleted'}
									<span class="chip">{t('Fresh start')}</span>
								{:else if entry.kind === 'disabled'}
									<span class="chip warning">{t('Turned off')}</span>
								{:else if entry.kind === 'removed'}
									<span class="chip danger">{t('Removed')}</span>
								{:else if entry.product}
									{#if entry.message}<span class="chip warning">{t('Failed')}</span>{:else}<span class="chip">{entry.kind === 'restored' ? t('Guide') : t('Addon')}</span>{/if}
								{:else if entry.kind === 'failed'}
									<span class="chip warning">{again ? t('Not delivered · sent again {time}', { time: again }) : t('Not delivered yet')}</span>
								{:else}
									{#if entry.rejected.length}
										<span class="chip warning">{tn('{count} skipped', '{count} skipped', entry.rejected.length)}</span>
									{:else if entry.duplicate.length && !entry.accepted.length}
										<span class="chip" title={t('The server already had it: nothing is stored twice')}>{t('Already there')}</span>
									{:else}
										<span class="chip success">{t('Received')}</span>
									{/if}
								{/if}
								<span class="chev" aria-hidden="true">{#if expandable}<Glyph name="chevron-down" size={12} color="var(--textDim)" />{/if}</span>
							</span>
						</button>
						{#if open === i}
							<div class="detail" in:rise={{ y: 4, duration: 180 }}>
								{#if entry.message}<p class="note selectable">{entry.message}</p>{/if}
								{#if entry.kind !== 'failed' && entry.rejected.length}
									<p class="note">{tn("The server couldn't read one part of this upload and skipped it.", "The server couldn't read {count} parts of this upload and skipped them.", entry.rejected.length)} {t('Everything else arrived; there is nothing for you to do.')}</p>
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
	/* Wraps rather than cutting a line short: German and Russian say it at length. */
	.what {
		min-width: 0;
		padding: 6px 0;
		overflow-wrap: break-word;
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
