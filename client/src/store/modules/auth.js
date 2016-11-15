import Vue from 'vue'

const storageKey = 'token';
const state = {
    token: window.localStorage.getItem(storageKey) || null
}

const mutations = {
    SET_TOKEN: (state, token)=>{
        if(!token) window.localStorage.removeItem(storageKey);
        else window.localStorage.setItem(storageKey, token);
        state.token = token
    }
}

const actions = {
    AUTH: ({commit}, deputeUid)=>{
        return Vue.http.post("/api/auth", {depute_uid: deputeUid})
        .then(res => res.json())
        .then(res => commit("SET_TOKEN", res.token))
    },

    LOG_OUT: ({commit, dispatch})=>{
        commit("SET_TOKEN", null);
        dispatch("RESET")
    }
}

const getters = {
    authed(state){
        return !!state.token
    }
}

export default {
    state,
    mutations,
    actions,
    getters
}
