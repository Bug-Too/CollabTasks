<script lang="ts">
	import Icon from '@iconify/svelte';
	import { swipe } from 'svelte-gestures';
	let direction: string;
	let count = 0;
	let date = new Date();
	function addDays(date: Date, days: number) {
		var result = new Date(date);
		result.setDate(result.getDate() + days);
		return result;
	}
	function beforeDate(date: Date) {
		return addDays(date, -1);
	}
	function nextDate(date: Date) {
		return addDays(date, 1);
	}
	function getDate(date: Date) {
		return date.getDate();
	}

	function handler(event: CustomEvent) {
		direction = event.detail.direction;
		event.detail.direction === 'left' ? (date = nextDate(date)) : (date = beforeDate(date));
		count++;
	}
	console.log(date.getDate());


	const month = [
		'January',
		'February',
		'March',
		'April',
		'May',
		'June',
		'July',
		'August',
		'September',
		'October',
		'November',
		'December',
	];
	console.log(month[date.getMonth()]);
</script>

<div class="primary-background h-screen pt-16">
	<div class="px-4">
		<div class="flex justify-center">
			<div class="py-5 bg-white rounded-full px-10">
				<h1 class="text-4xl font-bold"><span class="accent-color">{date.getDate()}</span> {month[date.getMonth()]} {date.getFullYear()}</h1>
			</div>
		</div>

		<div class="max-w-2xl mx-auto pt-8">
			<div class="flex justify-between">
				<div class="w-24 h-24 rounded-full bg-white flex justify-center ">
					<Icon icon="mdi:user" color="#FFAFCC" class="w-16 h-16 justify-self-center self-center" />
				</div>
				<div class="flex items-center">
					<span class="text-xl font-bold pr-2"> Board_Name </span>
					<div class="w-24 h-24 rounded-full bg-white flex justify-center">
						<Icon
							icon="fluent:board-20-filled"
							color="#FFAFCC"
							class="w-16 h-16 justify-self-center self-center"
						/>
					</div>
				</div>
			</div>
		</div>
		<!-- Fix this -->
		<div>Before Date Task</div>
		<div>Current Date Task</div>
		<div>Next Date Task</div>
		<div
			use:swipe={{ timeframe: 300, minSwipeDistance: 50, touchAction: 'pan-y' }}
			on:swipe={handler}
			class="max-w-2xl mx-auto bg-white"
		>
			This one <b>swipes only in horizontal directions</b>:
			<span style="color:red;">{direction}{count}</span><br />
			You can scroll vertically as normal. It is due to <b>touchAction: 'pan-y'</b>
		</div>
	</div>
</div>

<style>
	.accent-color {
		color: #f72585;
	}
</style>
