import Vue from 'vue'
import VueResource from 'vue-resource'
import store from '../store'

Vue.use(VueResource)

Vue.http.interceptors.push((request, next) => {
    const token = store.state.auth.token
    if(token) request.headers.append("Authorization", `Bearer ${token}`)
    next()
});
