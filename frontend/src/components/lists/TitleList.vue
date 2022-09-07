<script lang="ts" setup>
import TitleItem from "./items/TitleItem.vue";
</script>

<template>
  <div class="list">
    <TitleItem text="Center of The Earth" />
    <TitleItem text="Joel on Software" />
  </div>
</template>

<style lang="scss" scoped>
.list {
  width: 100%;
  height: 100%;
  overflow: scroll;
}
</style>
