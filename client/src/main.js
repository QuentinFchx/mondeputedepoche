import Vue from 'vue'
import App from './App.vue'
import { sync } from 'vuex-router-sync'
import router from './router'
import store from './store'
import './http'

sync(store, router)

import dateFilter from './filters/dateFilter'
Vue.filter('date', dateFilter)

const app = new Vue({
    router,
    store,
    ...App
})

app.$mount('#app')


import moment from 'moment'
moment.locale('fr')
