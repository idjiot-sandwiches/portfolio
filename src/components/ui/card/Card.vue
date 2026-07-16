<script setup lang="ts">
import type { HTMLAttributes } from "vue"
import { cn } from "@/lib/utils"

const props = defineProps<{
  class?: HTMLAttributes["class"]
}>()
</script>

<template>
  <div
    data-slot="card"
    :class="
      cn(
        'group/card flex flex-col gap-(--card-spacing) overflow-hidden rounded-xl bg-card py-(--card-spacing) text-sm text-card-foreground ring-2',
        'ring-foreground [--card-spacing:--spacing(4)] has-data-[slot=card-footer]:pb-0 has-[>img:first-child]:pt-0 data-[size=sm]:[--card-spacing:--spacing(3)]',
        'data-[size=sm]:has-data-[slot=card-footer]:pb-0 *:[img:first-child]:rounded-t-xl *:[img:last-child]:rounded-b-xl',
        'shadow-[4px_4px_0px_0px_var(--card),8px_8px_0px_0px_var(--card-foreground)]',
        'hover:ring-[#FF91A4] hover:shadow-[4px_4px_0px_0px_var(--card),8px_8px_0px_0px_#FF91A4] transition duration-200 ease-in-out',
        props.class,
      )
    "
  >
    <slot />
  </div>
</template>
