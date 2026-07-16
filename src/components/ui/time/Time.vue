<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue';

const props = defineProps<{
  timezone?: string;
  text: string;
}>();

const curr = new Date();
const date = ref(setValue(curr, props.timezone));
let timerId: ReturnType<typeof setTimeout> | null = null;

function getGmtOffset(tz: string | undefined): string {
  try {
    const tzString = new Date().toLocaleString('en-US', { timeZone: tz });
    const targetDate = new Date(tzString);
    const utcDate = new Date(new Date().toLocaleString('en-US', { timeZone: 'UTC' }));

    const diffMs = targetDate.getTime() - utcDate.getTime();
    const totalMinutes = Math.round(diffMs / 60000);

    const sign = totalMinutes >= 0 ? '+' : '-';
    const hours = Math.floor(Math.abs(totalMinutes) / 60).toString().padStart(2, '0');

    return `GMT${sign}${hours}`;
  } catch {
    return 'GMT+00';
  }
}

function startClock() {
  const now = new Date();
  const targetTimezone = props.timezone || Intl.DateTimeFormat().resolvedOptions().timeZone;
  date.value = setValue(now, targetTimezone);
  timerId = setTimeout(startClock, 1000);
}

function setValue(d: Date, tz: string | undefined) {
  return {
    day: d.toLocaleString('default', {
      weekday: 'long', day: 'numeric', month: 'long', year: 'numeric',
      timeZone: tz
    }),
    hours: d.toLocaleString('default', { hour: '2-digit', hour12: false, timeZone: tz }),
    minutes: d.toLocaleString('default', { minute: '2-digit', timeZone: tz }).padStart(2, '0'),
    seconds: d.toLocaleString('default', { second: '2-digit', timeZone: tz }).padStart(2, '0'),
    tzName: tz,
    gmtOffset: getGmtOffset(tz)
  }
}

onMounted(() => {
  startClock();
});

onUnmounted(() => {
  if (timerId) {
    clearTimeout(timerId);
  }
});

</script>

<template>
  <div class="text-center">
    <p class="uppercase text-[0.6rem] tracking-wide text-left pb-1">
      {{ text }} - <span class="text-[0.6rem] text-muted-foreground text-center pt-2 capitalize">{{ date.gmtOffset }} {{
        date.tzName }}</span>
    </p>
    <h2
      class="scroll-m-20 text-5xl font-semibold tracking-tight align-middle transition-colors flex items-baseline justify-center gap-2 font-mono">
      <span class="w-13">{{ date.hours }}</span>
      <svg class="animate-pulse h-[0.6em] w-[0.2em]" viewBox="0 0 10 30" fill="currentColor">
        <circle cx="5" cy="8" r="4" />
        <circle cx="5" cy="22" r="4" />
      </svg>
      <span class="w-13">{{ date.minutes }}</span>
      <svg class="animate-pulse h-[0.6em] w-[0.2em]" viewBox="0 0 10 30" fill="currentColor">
        <circle cx="5" cy="8" r="4" />
        <circle cx="5" cy="22" r="4" />
      </svg>
      <span class="w-13">{{ date.seconds }}</span>
    </h2>
  </div>
</template>