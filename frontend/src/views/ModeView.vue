<script lang="ts" setup>
import TitleHeader from "@/components/header/TitleHeader.vue";
import SlidePicker from "@/components/picker/SlidePicker.vue";
</script>
<template>
  <div class="mode">
    <TitleHeader text="2 MINUS 1" />

    <div class="pickers">
      <SlidePicker left="英→日" right="日→英" />
      <SlidePicker left="無限ループ" right="1周のみ" />
      <SlidePicker left="ランダム" right="順番" />
    </div>
  </div>
</template>

<style lang="scss" scoped>
.mode {
  width: 100%;
  height: 100%;
  padding: {
    right: 53px;
    left: 53px;
  }

  .pickers {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: relative;
    top: 141px;
    width: 100%;
    height: 126px;
  }
}
</style>
