<script lang="ts">
	// The toasts at the foot of the main column: they rise in, stack, and
	// leave the way they came; hovering holds them.
	import { flip } from 'svelte/animate';
	import { dismiss, hold, toasts } from '../lib/toast.svelte';
	import { rise } from '../lib/motion';
	import Glyph from './Glyph.svelte';

	const GLYPH = { success: 'check', warning: 'info', info: 'info' } as const;
	const COLOR = { success: 'var(--success)', warning: 'var(--warning)', info: 'var(--textDim)' } as const;
</script>

<div class="toaster" role="status" aria-live="polite" onpointerenter={() => hold(true)} onpointerleave={() => hold(false)}>
	{#each toasts as t (t.id)}
		<div class="toast" class:warning={t.kind === 'warning'} in:rise={{ y: 12, duration: 280 }} out:rise={{ y: 8, duration: 160 }} animate:flip={{ duration: 220 }}>
			<span class="mark"><Glyph name={GLYPH[t.kind]} size={14} color={COLOR[t.kind]} /></span>
			<p class="selectable">{t.text}</p>
			<button class="icon-btn" aria-label="Dismiss" onclick={() => dismiss(t.id)}><Glyph name="close" size={12} /></button>
		</div>
	{/each}
</div>

<style>
	.toaster {
		position: absolute;
		right: var(--s5);
		bottom: var(--s5);
		z-index: 30;
		display: flex;
		flex-direction: column;
		align-items: flex-end;
		gap: var(--s2);
		width: min(380px, calc(100% - 2 * var(--s5)));
		pointer-events: none;
	}
	.toast {
		display: flex;
		align-items: flex-start;
		gap: 10px;
		width: 100%;
		padding: 10px 6px 10px 12px;
		background: var(--panel);
		border: 1px solid var(--border);
		box-shadow: var(--shadowWindow);
		pointer-events: auto;
	}
	.toast.warning {
		border-color: rgba(250, 191, 77, 0.35);
	}
	.mark {
		display: grid;
		place-items: center;
		width: 14px;
		height: 18px;
	}
	p {
		flex: 1;
		margin: 0;
		font-size: 12px;
		line-height: 18px;
		color: var(--text);
	}
	.icon-btn {
		width: 22px;
		height: 22px;
		margin-top: -2px;
	}
</style>
