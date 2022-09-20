import { createRouter, createWebHistory } from "vue-router";
import HomeView from "../views/HomeView.vue";
import LoginView from "@/views/LoginView.vue";
import CreateView from "@/views/CreateView.vue";
import ModeView from "@/views/ModeView.vue";
import EditView from "@/views/EditView.vue";
import StudyView from "@/views/StudyView.vue";
import ResultView from "@/views/ResultView.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: HomeView,
    },
    {
      path: "/login",
      name: "login",
      component: LoginView,
    },
    {
      path: "/create",
      name: "create",
      component: CreateView,
    },
    {
      path: "/mode",
      name: "mode",
      component: ModeView,
    },
    {
      path: "/edit",
      name: "edit",
      component: EditView,
    },
    {
      path: "/study",
      name: "study",
      component: StudyView,
    },
    {
      path: "/result",
      name: "result",
      component: ResultView,
    },
  ],
});

export default router;
