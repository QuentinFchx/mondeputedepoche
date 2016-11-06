<template lang="html">
    <div>
        <div>
            <form @submit="search($event)">
                <div class="mdl-textfield mdl-shadow--2dp">
                    <input type="search" name="search" placeholder="Code postal / Nom" autofocus="true"
                        class="mdl-textfield__input"
                        :value="$store.state.searchQuery"
                        @input="setSearch">
                </div>
            </form>
        </div>
        <div>
            <ul class="mdl-list">
                <li v-for="depute in $store.state.searchResults">
                    <item-view>
                        <img slot="picture" :src="depute.image.url" :alt="depute.displayName" class="mdl-list__item-avatar">
                        <span slot="line">{{depute.displayName}}</span>
                        <button class="mdl-button" v-on:click="follow(depute.id)">Follow</button>
                    </item-view>
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
    import ItemView from '../components/ItemView.vue'

    export default {
        methods: {
            search(evt){
                evt.preventDefault()
                if(!this.$store.state.searchQuery) return
                this.$store.dispatch('SEARCH_DEPUTE', this.$store.state.searchQuery);
            },
            setSearch(e){
                this.$store.commit('SET_SEARCH', e.target.value);
            },
            follow(deputeId){
                this.$store.dispatch(this.$store.state.auth.token ? 'FOLLOW_DEPUTE' : 'AUTH', deputeId)
                .then(()=> this.$store.dispatch('RESET_FEED'))
                .then(()=>{
                    this.$router.replace('feed')
                });
            }
        },
        destroyed(){
            this.$store.commit('SET_SEARCH', '');
            this.$store.commit('SET_SEARCH_RESULTS', [])
        },
        components: {
            ItemView
        }
    };
</script>

<style lang="scss" scoped>
    .mdl-textfield {
        width: 100%;
        padding: 10px;
    }
</style>
