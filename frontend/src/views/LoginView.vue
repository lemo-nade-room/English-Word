<script lang="ts" setup>
import ShortInput from "@/components/inputs/ShortInput.vue";
import GoButton from "@/components/buttons/GoButton.vue";
import { computed, ref } from "vue";

const id = ref("");
const password = ref("");

const isImpossible = computed(() => id.value === "" || password.value === "");
</script>

<template>
  <div class="login">
    <ShortInput class="input-id" placeholder="ID" v-model="id" />
    <ShortInput
      class="input-password"
      type="password"
      v-model="password"
      placeholder="パスワード"
    />
    <GoButton class="btn" :disable="isImpossible" />
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
