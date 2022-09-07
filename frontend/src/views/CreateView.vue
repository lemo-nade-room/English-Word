<script lang="ts" setup>
import ShortInput from "@/components/inputs/ShortInput.vue";
import SubmitButton from "@/components/buttons/SubmitButton.vue";
import LongSentenceInput from "@/components/inputs/LongSentenceInput.vue";
</script>

<template>
  <div class="create">
    <div class="form">
      <ShortInput width="240px" height="42px" placeholder="新規 英単語帳名" />
      <SubmitButton />
    </div>
    <LongSentenceInput class="text" placeholder="英文 任意" />
  </div>
</template>

<style lang="scss" scoped>
.create {
  width: 100%;
  height: 100%;
  padding: {
    top: 82px;
    left: 43px;
    right: 43px;
    bottom: 40px;
  }

  display: flex;
  flex-direction: column;
  justify-content: space-between;

  .text {
    flex-grow: 1;
  }

  .form {
    display: flex;
    justify-content: space-between;
    margin-bottom: 26px;
  }
}
</style>
