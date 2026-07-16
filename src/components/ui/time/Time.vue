<script setup lang="ts">
import { onMounted, onUnmounted, ref } from 'vue';

const props = defineProps<{
  timezone?: string;
}>();

const date = ref({
  day: '',
  hours: '00',
  minutes: '00',
  seconds: '00',
  tzName: '',
  gmtOffset: ''
});

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
  date.value = {
  
    day: now.toLocaleString('default', { 
      weekday: 'long', day: 'numeric', month: 'long', year: 'numeric', 
      timeZone: targetTimezone 
    }),
    hours: now.toLocaleString('default', { hour: '2-digit', hour12: false, timeZone: targetTimezone }),
    minutes: now.toLocaleString('default', { minute: '2-digit', timeZone: targetTimezone }).padStart(2, '0'),
    seconds: now.toLocaleString('default', { second: '2-digit', timeZone: targetTimezone }).padStart(2, '0'),
    tzName: targetTimezone,
    gmtOffset: getGmtOffset(targetTimezone)
  };

  timerId = setTimeout(startClock, 1000);
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
    <h2
      class="scroll-m-20 text-4xl font-semibold tracking-tight align-middle transition-colors flex items-baseline justify-center gap-2">
      <span class="w-10">{{ date.hours }}</span>
      <svg class="animate-pulse h-[0.6em] w-[0.2em]" viewBox="0 0 10 30" fill="currentColor">
        <circle cx="5" cy="8" r="4" />
        <circle cx="5" cy="22" r="4" />
      </svg>
      <span class="w-10">{{ date.minutes }}</span>
      <svg class="animate-pulse h-[0.6em] w-[0.2em]" viewBox="0 0 10 30" fill="currentColor">
        <circle cx="5" cy="8" r="4" />
        <circle cx="5" cy="22" r="4" />
      </svg>
      <span class="w-10">{{ date.seconds }}</span>
    </h2>
  </div>
  <p class="text-[0.6rem] text-muted-foreground text-center pt-2">
    {{ date.gmtOffset }} {{ date.tzName }}
  </p>
</template>