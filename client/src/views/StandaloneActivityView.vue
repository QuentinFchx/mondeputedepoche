<template lang="html">
    <div class="standalone-activity">
        <activity-view v-if="activity" :activity="activity"></activity-view>
    </div>
</template>

<script>
import ActivityView from '../components/ActivityView.vue'

export default {
    data(){
        return {
            activity: null
        }
    },
    components: {
        ActivityView
    },
    created(){
        this.fetchActivity()
    },
    methods: {
        fetchActivity(){
            this.$store.dispatch('FETCH_ACTIVITY', this.$route.params)
            .then(activity=>{
                this.activity = activity
            })
        }
    }
}
</script>

<style lang="scss" scoped>
    .standalone-activity {
        padding: 10px;
    }
</style>
