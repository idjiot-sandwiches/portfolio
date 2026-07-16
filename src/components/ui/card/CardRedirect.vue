<script setup lang="ts">
import type { HTMLAttributes } from "vue"
import { cn } from "@/lib/utils"

const props = defineProps<{
  class?: HTMLAttributes["class"],
  href: string,
  target?: string
}>()
</script>

<template>
  <a
    :href="href"
    :target="target"
    data-slot="card"
    :class="
      cn(
        'group/card flex flex-col gap-(--card-spacing) overflow-hidden rounded-xl bg-card py-(--card-spacing) text-sm text-card-foreground ring-2',
        'ring-foreground [--card-spacing:--spacing(4)] has-data-[slot=card-footer]:pb-0 has-[>img:first-child]:pt-0 data-[size=sm]:[--card-spacing:--spacing(3)]',
        'data-[size=sm]:has-data-[slot=card-footer]:pb-0 *:[img:first-child]:rounded-t-xl *:[img:last-child]:rounded-b-xl',
        'shadow-[4px_4px_0px_0px_var(--card),8px_8px_0px_0px_var(--card-foreground)]',
        'hover:ring-[#FF91A4] hover:shadow-[4px_4px_0px_0px_var(--card),8px_8px_0px_0px_#FF91A4] transition duration-200 ease-in-out',
        'hover:bg-[radial-gradient(circle_at_center,#FFD3DA_1px,transparent_1px),radial-gradient(circle_at_center,#FFD3DA_1px,transparent_1px)]',
        'hover:[background-size:10px_10px] hover:[background-position:0_0,5px_5px] hover:animate-[scroll-diagonal_4s_linear_infinite]',
        props.class,
      )
    "
  >
    <slot />
  </a>
</template>
