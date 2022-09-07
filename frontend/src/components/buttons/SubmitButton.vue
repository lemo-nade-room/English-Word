<template>
  <button class="btn">決定</button>
</template>

<style lang="scss" scoped>
.btn {
  $height: 44px;

  display: block;
  width: 79px;
  height: $height;
  border: none;

  line-height: $height;
  color: white;
  font: {
    family: "Inter", sans-serif;
    style: normal;
    weight: 400;
    size: 20px;
  }
  background: #31b5ff;
  border-radius: 9px;
}
</style>
