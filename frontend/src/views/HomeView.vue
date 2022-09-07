<script setup lang="ts">
import PlusButton from "@/components/buttons/PlusButton.vue";
import TitleList from "@/components/lists/TitleList.vue";

interface EnglishWordTitle {
  id: string;
  title: string;
}
const titles: EnglishWordTitle[] = [
  { id: crypto.randomUUID(), title: "Center of The Earth" },
  { id: crypto.randomUUID(), title: "Joel on Software" },
  { id: crypto.randomUUID(), title: "Clean Architecture" },
  { id: crypto.randomUUID(), title: "Stay here with me" },
];
</script>

<template>
  <div class="home">
    <PlusButton class="plus" />
    <TitleList class="list" :titles="titles" />
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
