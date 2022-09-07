<script lang="ts" setup>
defineProps({
  placeholder: {
    type: String,
    default: undefined,
  },
});
</script>

<template>
  <textarea
    class="text"
    autocapitalize="none"
    :placeholder="placeholder"
  ></textarea>
</template>

<style lang="scss" scoped>
.text {
  width: 100%;
  border: 1px solid #34c2ff;
  box-shadow: 0 4px 4px rgba(0, 0, 0, 0.25);
  border-radius: 19px;
  padding: 20px;

  font: {
    family: "Inter", serif;
    style: normal;
    weight: 400;
    size: 14px;
  }
  line-height: 17px;
  color: black;

  &::placeholder {
    color: #9c9a9a;
  }
}
</style>
