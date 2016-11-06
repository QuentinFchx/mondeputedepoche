<template lang="html">
    <div>
        <div>
            <h1>Dernières actualités</h1>
            <button class="mdl-button" v-on:click="refresh()">Refresh</button>
        </div>
        <div>
            <ol class="feed">
                <li v-for="activity in $store.state.feed.activities">
                    <activity-view :activity="activity"></activity-view>
                </li>
            </ol>
            <infinite-loading :on-infinite="loadMore" ref="infiniteLoading"></infinite-loading>
        </div>
    </div>
</template>

<script>
    import ActivityView from '../components/ActivityView.vue'
    import InfiniteLoading from 'vue-infinite-loading';
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
                this.$store.dispatch('GET_FEED', {before}).then(activities =>{
                    const complete = !activities.length
                    this.$refs.infiniteLoading.$emit(complete ? '$InfiniteLoading:complete' : '$InfiniteLoading:loaded');
                });
            }
        },
        components: {
            ActivityView, InfiniteLoading
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
