<script lang="ts" setup>
defineProps({
  text: {
    type: String,
    required: true,
  },
});
</script>

<template>
  <button class="item">
    <span class="box" />
    <span class="text">{{ text }}</span>
  </button>
</template>

<style lang="scss" scoped>
.item {
  $height: 38px;

  display: flex;
  justify-content: space-between;
  align-items: center;
  height: $height;
  width: 100%;
  background-color: white;

  border: {
    top: none;
    left: none;
    right: none;
    bottom: 1px solid #1198fb;
  }

  text-align: left;

  .box {
    $length: 14px;
    display: inline-block;
    width: $length;
    height: $length;
    background: #ffffff;
    border: 1px solid #59b9ff;
    margin: {
      top: ($height - $length) / 2;
      bottom: ($height - $length) / 2;
      right: 13px;
      left: 7px;
    }
  }

  .text {
    font-family: "Inter", sans-serif;
    color: #504d4d;
    font: {
      style: normal;
      weight: 400;
      size: 16px;
    }

    display: inline-block;
    line-height: $height;
    flex-grow: 1;
  }
}
</style>
