<template lang="html">
    <div>
        <div>
            <span>A posé</span>
            <span v-if="activity.object.type == 'QG'">une question au gouvernement</span>
            <span v-if="activity.object.type == 'QE'">une question écrite</span>
            <span v-if="activity.object.type == 'QOSD'">une question orale sans débat</span>
        </div>
        <span>Rubrique: {{ activity.object.indexation.rubrique }}</span>
        <span>Analyses: {{ activity.object.indexation.analyses }}</span>

        <discussion-view :interventions="activity.object.interventions" :pov="activity.actor"></discussion-view>
    </div>
</template>

<script>
import DiscussionView from '../discussion/DiscussionView.vue'
export default {
    props: ['activity'],
    components: {
        DiscussionView
    }
}
</script>
