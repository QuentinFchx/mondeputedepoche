import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

import auth from './modules/auth.js'
import deputes from './modules/deputes.js'
import feed from './modules/feed.js'

export default new Vuex.Store({
    state: {
        searchQuery: '',
        searchResults: []
    },
    modules: {
        auth,
        deputes,
        feed
    },
    actions: {
        RESET({dispatch}){
            dispatch("RESET_FEED")
        }
    },
    mutations: {
        SET_SEARCH(state, query){
            state.searchQuery = query
        },

        SET_SEARCH_RESULTS(state, results){
            state.searchResults = results
        }
    }
})
