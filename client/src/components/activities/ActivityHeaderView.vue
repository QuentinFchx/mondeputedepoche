<template lang="html">
    <div class="header">
        <img :src="activity.actor.image.url" :alt="activity.actor.displayName" />
        <router-link :to="deputeUri" class="actor">{{ activity.actor.displayName }}</router-link>
        <router-link :to="activityUri">{{ activity.published | date('ll') }}</router-link>
    </div>
</template>

<script>
export default {
    props: ['activity'],
    computed: {
        activityUri: function(){
            return `/activity/${this.activity.actor.id}/${this.activity.object.id}`
        },
        deputeUri: function(){
            return `/depute/${this.activity.actor.id}`
        }
    }
}
</script>

<style lang="scss" scoped>
    .header {
        display: flex;
        padding: 5px 0;
        align-items: center;
        justify-content: space-between;
    }

    img {
        margin-right: 5px;
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
    }

    .actor {
        flex: 2;
    }
</style>
