<template lang="html">
    <div>
        <div v-if="depute">
            <h1>{{ depute.displayName }}</h1>

            <img :src="depute.image.url" :alt="depute.displayName">

            <div>
                <span v-if="depute.partiPolitique">Parti politique: {{ depute.partiPolitique.libelle }}</span>
                <br>
                <span v-if="depute.groupePolitique">Groupe politique: {{ depute.groupePolitique.libelle }}</span>
                <br>
                Date naissance: {{ depute.dateNaissance | date('L') }}
            </div>

            <button class="mdl-button" @click="follow()" v-if="!depute.followed">Suivre</button>
            <button class="mdl-button" @click="unfollow()" v-if="depute.followed">Se désabonner</button>
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
