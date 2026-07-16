<script setup lang="ts">
import type { HTMLAttributes } from "vue"
import { cn } from "@/lib/utils"

const props = defineProps<{
  class?: HTMLAttributes["class"],
  href: string,
  text: string
}>()
</script>

<template>
  <a
    :href="href"
    :class="cn(
      'flex items-center gap-1',
      'hover:underline',
      'leading-7 text-base font-medium',
      props.class,
    )"
    target="_blank"
  >
    <slot />
    <span>{{ text }}</span>
  </a>
</template>
