<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import WordQuestion from "@/parts/WordQuestion.vue";
import SwipeBackground from "@/components/background/swipe/SwipeBackground.vue";

const t = (a: string) => console.log(a);
</script>

<template>
  <div class="study">
    <SwipeBackground />
    <TitleHeader text="All My Love" />
    <WordQuestion class="question" quiz="phenomenon" answer="現象" />
  </div>
</template>

<style lang="scss" scoped>
.study {
  width: 100%;
  height: 100%;

  .question {
    position: absolute;
    width: 80%;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
  }
}
</style>
