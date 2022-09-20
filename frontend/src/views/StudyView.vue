<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import WordQuestion from "@/parts/WordQuestion.vue";
import SwipeBackground from "@/components/background/swipe/SwipeBackground.vue";
import ScoreStatus from "@/parts/ScoreStatus.vue";
</script>

<template>
  <div class="study">
    <SwipeBackground />
    <TitleHeader text="All My Love" />
    <ScoreStatus class="status" sum="60" count="14" ratio="80" />
    <WordQuestion class="question" quiz="phenomenon" answer="現象" />
  </div>
</template>

<style lang="scss" scoped>
.study {
  width: 100%;
  height: 100%;

  .status {
    position: absolute;
    top: 104px;
    right: 16px;
  }

  .question {
    position: absolute;
    width: 80%;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
  }
}
</style>
