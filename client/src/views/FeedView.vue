<template lang="html">
    <div>
        <div>
            <h1>Dernières actualités</h1>
            <button v-on:click="refresh()">Refresh</button>
        </div>
        <div>
            <ol class="feed">
                <li v-for="activity in $store.state.feed.activities">
                    <activity-view :activity="activity"></activity-view>
                </li>
            </ol>
            <button v-on:click="loadMore()">Load More</button>
        </div>
    </div>
</template>

<script>
    import ActivityView from '../components/ActivityView.vue'
    import moment from 'moment'

    export default {
        methods: {
            refresh(){
                this.$store.dispatch('RESET_FEED')
                this.loadMore()
            },
            loadMore(){
                const lastActivity = this.$store.getters.lastActivity
                const before = moment((lastActivity || {}).published).format('YYYY-MM-DD')
                this.$store.dispatch('GET_FEED', {before});
            }
        },
        created(){
            if(this.$store.state.feed.activities.length === 0) this.loadMore();
        },
        components: {
            ActivityView
        }
    };
</script>

<style lang="scss" scoped>
    .feed {
        padding: 0 10px;
        list-style-type: none;

        > li {
            margin-bottom: 50px;
        }
    }
</style>
