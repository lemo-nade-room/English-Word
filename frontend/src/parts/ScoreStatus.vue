<script lang="ts" setup>
defineProps({
  sum: {
    type: Number,
    required: true,
  },
  count: {
    type: Number,
    required: true,
  },
  ratio: {
    type: Number,
    required: true,
  },
});
</script>

<template>
  <div class="status">
    <span class="text">{{ count }}/{{ sum }}</span>
    <span class="text"> {{ ratio }}%</span>
  </div>
</template>

<style lang="scss" scoped>
.status {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  align-items: end;
  height: 61px;
  width: 70px;

  .text {
    width: 55px;
    height: 24px;
    left: 304px;
    top: 104px;

    text-align: right;

    font-family: "Inter", sans-serif;
    font-style: normal;
    font-weight: 400;
    font-size: 20px;
    line-height: 24px;

    color: #747373;
  }
}
</style>
