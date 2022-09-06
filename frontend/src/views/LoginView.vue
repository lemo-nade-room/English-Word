<script lang="ts" setup>
import ShortInput from "@/components/inputs/ShortInput.vue";
import GoButton from "@/components/buttons/GoButton.vue";
</script>

<template>
  <div class="login">
    <ShortInput class="input-id" placeholder="ID" />
    <ShortInput
      class="input-password"
      type="password"
      placeholder="パスワード"
    />
    <GoButton class="btn" />
  </div>
</template>

<style lang="scss" scoped>
.login {
  margin-top: 164px;
  width: 100vw;
  height: 203px;

  display: flex;
  flex-direction: column;
  align-items: center;

  .input-password {
    margin-top: 29px;
  }

  .btn {
    margin-top: 44px;
  }
}
</style>
