<script lang="ts">
	// A summary as fact rows: what the play adds up to, in players' words.
	import { count, distance, duration } from '../lib/format';
	import type { Summary } from '../lib/types';
	import Glyph from './Glyph.svelte';

	let { summary }: { summary: Summary } = $props();

	const facts = $derived([
		{ glyph: 'hourglass', label: 'Play recorded', value: duration(summary.seconds) },
		{ glyph: 'icon-goto', label: 'Distance travelled', value: distance(summary.distanceYards) },
		{ glyph: 'icon-accept', label: 'Quests accepted', value: count(summary.questsAccepted) },
		{ glyph: 'icon-turnin', label: 'Quests turned in', value: count(summary.questsTurnedIn) },
		{ glyph: 'icon-kill', label: 'Creatures killed', value: count(summary.kills) },
		{ glyph: 'search', label: 'Kinds of creature seen', value: count(summary.uniqueCreatures) },
		{ glyph: 'icon-collect', label: 'Things looted', value: count(summary.lootWindows) },
		{ glyph: 'icon-vendor', label: 'Vendors visited', value: count(summary.vendors) },
		{ glyph: 'icon-level', label: 'Trainers visited', value: count(summary.trainers) },
		{ glyph: 'flag', label: 'Flight masters', value: count(summary.flightmasters) },
	]);
</script>

<div class="rows">
	{#each facts as fact (fact.label)}
		<div class="row">
			<Glyph name={fact.glyph} color="var(--textDim)" />
			<span class="label">{fact.label}</span>
			<span class="value num">{fact.value}</span>
		</div>
	{/each}
</div>
