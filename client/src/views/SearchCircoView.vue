<template lang="html">
    <div>
        <div>
            <form @submit="search($event)">
                <input type="search" name="search" placeholder="CP ou nom" autofocus="true"
                    :value="$store.state.searchQuery"
                    @input="setSearch">
                <button>Search</button>
            </form>
        </div>
        <div>
            <ul>
                <li v-for="depute in $store.state.searchResults">
                    <item-view>
                        <img slot="picture" :src="depute.image.url" :alt="depute.displayName" />
                        <span slot="line">{{depute.displayName}}</span>
                        <button v-on:click="follow(depute.id)">Follow</button>
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
                this.$store.dispatch(this.$store.state.auth.token ? 'FOLLOW' : 'AUTH', deputeId).then(()=>{
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
