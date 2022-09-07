<script setup lang="ts">
import PlusButton from "@/components/buttons/PlusButton.vue";
</script>

<template>
  <div class="home">
    <PlusButton class="plus" />
  </div>
</template>

<style lang="scss" scoped>
.home {
  width: 100vw;
  height: 100vh;
  .plus {
    position: absolute;
    right: 21px;
    top: 27px;
  }
}
</style>
