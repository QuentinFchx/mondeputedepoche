<template lang="html">
    <div>
        <intervention-view v-for="intervention in filteredInterventions"
            :intervention="intervention"
            :from-pov="intervenantIsPOV(intervention.intervenant)"></intervention-view>
        <mdl-button icon @click.native="expanded = true" v-if="!expanded">
            <i class="material-icons">expand_more</i>
        </mdl-button>
    </div>
</template>

<script>
import InterventionView from './InterventionView.vue'

export default {
    props: ['interventions', 'pov'],
    data: ()=>{
        return {
            expanded: false
        }
    },
    components: {
        InterventionView
    },
    methods: {
        intervenantIsPOV(intervenant) {
            return intervenant && intervenant.id == this.pov.id
        }
    },
    computed: {
        filteredInterventions(){
            if(this.expanded) return this.interventions

            const firstIntervention = this.interventions.find(intervention => this.intervenantIsPOV(intervention.intervenant))

            const lightFirstIntervention = Object.assign({}, firstIntervention)
            let wordsCount = 0
            lightFirstIntervention.parts = lightFirstIntervention.parts.filter(part => {
                if(part.type != "text") return false
                if(wordsCount > 40) return false
                wordsCount += part.content.split(' ').length
                return true
            })

            return [lightFirstIntervention]
        }
    }
}
</script>

<style lang="scss" scoped>

</style>
