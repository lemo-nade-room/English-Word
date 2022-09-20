<script setup lang="ts">
import { RouterView, useRouter } from "vue-router";
import Axios from "axios";
import * as token from "@/connect/token";

const router = useRouter();

const axios = Axios.create({
  baseURL: "http://" + import.meta.env.VITE_API,
});

const setToken = (value: string) => {
  token.set(value);
  console.log(token.get());
  axios.defaults.headers.common["Authorization"] = `Bearer ${token.get()}`;
  console.log(axios.defaults.headers.common);
};

setToken(token.get() ?? "");

const transitionRoot = () => router.push("/");
</script>

<template>
  <img
    alt="English Word Logo"
    class="logo"
    src="@/assets/logo.png"
    @click="transitionRoot"
  />
  <suspense>
    <RouterView class="view" @token="setToken" :axios="axios" />
  </suspense>
</template>

<style lang="scss" scoped>
.logo {
  display: block;
  position: absolute;
  left: 19px;
  top: 21px;
  width: 42px;
  height: 42px;
  z-index: 10;
}
</style>
