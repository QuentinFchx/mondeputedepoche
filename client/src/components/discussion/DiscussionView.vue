<template lang="html">
    <div>
        <intervention-view v-for="intervention in interventions"
            :intervention="intervention"
            :from-pov="intervenantIsPOV(intervention.intervenant)"></intervention-view>
    </div>
</template>

<script>
import InterventionView from './InterventionView.vue'

export default {
    props: ['interventions', 'pov'],
    components: {
        InterventionView
    },
    methods: {
        intervenantIsPOV(intervenant) {
            return intervenant && intervenant.id == this.pov.id
        }
    }
}
</script>

<style lang="scss" scoped>

</style>
