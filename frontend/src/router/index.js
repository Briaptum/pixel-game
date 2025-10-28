import { createRouter, createWebHistory } from 'vue-router'
import HomePage from '../views/HomePage.vue'
import PlayPage from '../views/PlayPage.vue'
import LevelsPage from '../views/LevelsPage.vue'
import OptionsPage from '../views/OptionsPage.vue'
import SettingsPage from '../views/SettingsPage.vue'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomePage
  },
  {
    path: '/play',
    name: 'Play',
    component: PlayPage
  },
  {
    path: '/levels',
    name: 'Levels',
    component: LevelsPage
  },
  {
    path: '/options',
    name: 'Options',
    component: OptionsPage
  },
  {
    path: '/settings',
    name: 'Settings',
    component: SettingsPage
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
