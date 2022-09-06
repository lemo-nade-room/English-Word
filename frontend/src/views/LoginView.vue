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
    <GoButton />
  </div>
</template>

<style lang="scss" scoped>
.login {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: center;
  height: 100vh;
}
</style>
