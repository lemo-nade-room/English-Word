<script setup lang="ts">
import { RouterView, useRouter } from "vue-router";

const router = useRouter();
const transitionRoot = () => router.push("/");
</script>

<template>
  <img
    alt="English Word Logo"
    class="logo"
    src="@/assets/logo.png"
    @click="transitionRoot"
  />
  <RouterView class="view" />
</template>

<style lang="scss" scoped>
.logo {
  display: block;
  position: absolute;
  left: 19px;
  top: 21px;
  width: 42px;
  height: 42px;
}
</style>
