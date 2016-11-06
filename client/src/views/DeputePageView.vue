<template lang="html">
    <div>
        <div v-if="depute">
            <h1>{{ depute.displayName }}</h1>
            <img :src="depute.image.url" :alt="depute.displayName">

            <button class="mdl-button" @click="follow()" v-if="!isFollowed">Follow</button>
            <button class="mdl-button" @click="unfollow()" v-if="isFollowed">Unfollow</button>
        </div>
    </div>
</template>

<script>
export default {
    data(){
        return {
            depute: null
        }
    },
    created(){
        this.fetchDepute()
        this.$store.dispatch('FETCH_FOLLOWED')
    },
    computed: {
        isFollowed(){
            return this.$store.state.deputes.followed.some(d => d.id === this.depute.id)
        }
    },
    methods: {
        fetchDepute(){
            this.$store.dispatch('FETCH_DEPUTE', this.$route.params)
            .then(depute => {
                this.depute = depute
            })
        },
        follow(){
            this.$store.dispatch('FOLLOW_DEPUTE', this.depute.id)
            .then(()=>{
                this.$store.dispatch('RESET_FEED')
            })
        },
        unfollow(){
            this.$store.dispatch('UNFOLLOW_DEPUTE', this.depute.id)
            .then(()=>{
                this.$store.dispatch('RESET_FEED')
            })
        }
    }
}
</script>

<style lang="scss">
</style>
