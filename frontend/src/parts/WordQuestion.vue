<script lang="ts" setup>
defineProps({
  quiz: {
    type: String,
    required: true,
  },
  answer: {
    type: String,
    required: true,
  },
});
</script>

<template>
  <div class="question">
    <span class="quiz text">{{ quiz }}</span>
    <span class="line" />
    <span class="answer text">{{ answer }}</span>
  </div>
</template>

<style lang="scss" scoped>
.question {
  width: 100%;
  height: 70px;

  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: center;

  .line {
    display: block;
    width: 100%;
    height: 1px;
    border: 1px solid #1198fb;
  }

  .text {
    font: {
      family: "Inter", serif;
      style: normal;
      weight: 400;
      size: 20px;
    }
    line-height: 24px;

    &.quiz {
      color: #504d4d;
    }

    &.answer {
      color: #eb6f6f;
    }
  }
}
</style>
