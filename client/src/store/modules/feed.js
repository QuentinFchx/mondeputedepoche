import Vue from 'vue';

const state = {
    activities: []
}

const mutations = {
    SET_ACTIVITIES: (state, activities)=>{
        state.activities = activities
    },
    ADD_ACTIVITIES: (state, activities)=>{
        state.activities = state.activities.concat(activities)
    }
}

const actions = {
    GET_FEED: ({commit}, params)=>{
        return Vue.http.get("/api/feed", {params})
        .then(res => res.json())
        .then(({data}) => {
            commit("ADD_ACTIVITIES", data)
            return data
        })
    },
    RESET_FEED: ({commit})=>{
        commit("SET_ACTIVITIES", [])
    },
    FETCH_ACTIVITY: ({commit}, payload)=>{
        return Vue.http.get(`/api/activity/${payload.actorId}/${payload.objectId}`)
        .then(res => res.json())
        .then(({data}) => data)
    }
}

const getters = {
    lastActivity(state){
        return state.activities[state.activities.length - 1]
    }
}

export default {
    state,
    mutations,
    actions,
    getters
}
