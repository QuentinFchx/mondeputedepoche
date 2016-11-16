<template lang="html">
    <div>
        <p>
            A voté <span class="vote" :class="[activity.object.vote.type]">{{ activity.object.vote.type }}</span> le scrutin portant sur
            <span>"{{ activity.object.displayName }}"</span>
            <span :class="[activity.object.sort]">({{ activity.object.sort }})</span>
        </p>
        <vote-synthese :synthese="activity.object.synthese"></vote-synthese>
    </div>
</template>

<script>
import VoteSynthese from '../VoteSyntheseView.vue'

export default {
    props: ['activity'],
    components: {
        VoteSynthese
    }
}
</script>

<style lang="scss" scoped>
    @import '../../styles/vars.scss';

    .vote {
        text-transform: uppercase;
    }

    .pour, .adopté {
        color: $green;
    }

    .contre, .rejeté {
        color: $red;
    }
</style>
