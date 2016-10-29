import Vue from 'vue'

const state = {
    followed: []
}

const mutations = {
    SET_FOLLOWED: (state, deputes)=>{
        state.followed = deputes
    }
}

const actions = {
    SEARCH_DEPUTE: ({commit}, query)=>{
        return Vue.http.get("/api/search", {params: {query}})
        .then(res => res.json())
        .then(res => commit("SET_SEARCH_RESULTS", res.data))
    },
    FETCH_FOLLOWED: ({commit})=>{
        return Vue.http.get("/api/followed")
        .then(res => res.json())
        .then(res => commit("SET_FOLLOWED", res.data))
    },
    FOLLOW_DEPUTE: ({commit, dispatch}, deputeId)=>{
        return Vue.http.post(`/api/follow/${deputeId}`)
        .then(()=>{
            dispatch('FETCH_FOLLOWED')
        })
    },
    UNFOLLOW_DEPUTE: ({commit, dispatch}, deputeId)=>{
        return Vue.http.post(`/api/unfollow/${deputeId}`)
        .then(()=>{
            dispatch('FETCH_FOLLOWED')
        })
    },
    FETCH_DEPUTE: ({commit}, query)=>{
        return Vue.http.get(`/api/deputes/${query.actorId}`)
        .then(res => res.json())
        .then(res => res.data)
    }
}

export default {
    state,
    mutations,
    actions
}
