import Vue from 'vue'
import Router from 'vue-router'
import store from '../store'

Vue.use(Router)

import SearchView from '../views/SearchView.vue'
import FeedView from '../views/FeedView.vue'
import StandaloneActivityView from '../views/StandaloneActivityView.vue'
import DeputePageView from '../views/DeputePageView.vue'

const router = new Router({
    mode: 'history',
    routes: [
        {path: '/search', component: SearchView},
        {path: '/feed', component: FeedView, beforeEnter: function(to, from, next){
            next(store.state.auth.token ? undefined : '/search')
        }},
        {path: '/depute/:actorId', component: DeputePageView},
        {path: '/activity/:actorId/:objectId', component: StandaloneActivityView},
        {path: '*', redirect: '/feed'}
    ]
})

export default router;
