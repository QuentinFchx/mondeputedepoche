<template lang="html">
    <div>
        <activity-header-view :activity="activity"></activity-header-view>
        <div class="">
            <component v-bind:is="activity.verb" :activity="activity"></component>
        </div>
    </div>
</template>

<script>
import ActivityHeaderView from './activities/ActivityHeaderView.vue'
import VoteScrutinActivityView from './activities/VoteScrutinActivityView.vue'
import PoseQuestionActivityView from './activities/PoseQuestionActivityView.vue'

export default {
    props: ['activity'],
    components: {
        ActivityHeaderView,
        vote_scrutin: VoteScrutinActivityView,
        pose_question: PoseQuestionActivityView
    }
};
</script>

<style lang="scss" scoped>
    @import '../styles/vars.scss';
</style>
