<script setup lang="ts">
import PlusButton from "@/components/buttons/PlusButton.vue";
import TitleList from "@/components/lists/TitleList.vue";
</script>

<template>
  <div class="home">
    <PlusButton class="plus" />
    <TitleList class="list" />
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
  padding: {
    top: 120px;
    left: 35px;
    right: 35px;
    bottom: 100px;
  }
}
</style>
