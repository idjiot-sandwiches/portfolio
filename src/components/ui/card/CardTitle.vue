<script setup lang="ts">
import type { HTMLAttributes } from "vue"
import { cn } from "@/lib/utils"

const props = defineProps<{
  class?: HTMLAttributes["class"]
}>()
</script>

<template>
  <h3
    data-slot="card-title"
    :class="cn('leading-none scroll-m-20 text-xl font-semibold tracking-tight', props.class)"
  >
    <slot />
  </h3>
</template>
