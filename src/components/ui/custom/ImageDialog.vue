<script setup lang="ts">
import { cn } from "@/lib/utils";
import { Image } from "@lucide/vue";
import { Card, CardContent } from "@/components/ui/card";
import { Dialog, DialogContent, DialogTrigger } from "@/components/ui/dialog";

defineProps<{
  images: string[]
}>();

</script>

<template>
  <Dialog>
    <DialogTrigger as-child>
      <Card 
        :class="cn('ring-[#FF91A4] shadow-[4px_4px_0px_0px_var(--card),8px_8px_0px_0px_#FF91A4] p-0 m-0 w-fit cursor-pointer',
          'hover:bg-[radial-gradient(circle_at_center,#FFD3DA_1px,transparent_1px),radial-gradient(circle_at_center,#FFD3DA_1px,transparent_1px)]',
          'hover:[background-size:10px_10px] hover:[background-position:0_0,5px_5px] hover:animate-[scroll-diagonal_4s_linear_infinite]',
        )"
      >
        <CardContent class="flex items-center gap-2 py-2 px-3">
          <Image />
          <p class="scroll-m-20 text-base font-semibold tracking-tight">Images</p>
        </CardContent>
      </Card>
    </DialogTrigger>
    <DialogContent class="min-w-4xl">
      <div class="flex gap-4 overflow-x-auto snap-x snap-mandatory scrollbar-thin py-2">
        <div 
          v-for="(val, idx) in images" 
          :key="idx" 
          class="min-w-full snap-center shrink-0"
        >
          <img :src="val" alt="" class="w-[52rem] aspect-video object-cover object-left" />
        </div>
      </div>
    </DialogContent>
  </Dialog>
</template>