<template lang="html">
    <div>
        <div>
            A déposé l'amendement suivant:
            <a v-bind:href="activity.object.attachments[0].url" target="_blank">
                <i class="material-icons">link</i>
            </a>
        </div>
        <div v-html="activity.object.corps.dispositif"></div>
    </div>
</template>

<script>
export default {
    props: ['activity']
}
</script>
